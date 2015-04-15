From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/4] parport: modify parport subsystem to use devicemodel
Date: Wed, 15 Apr 2015 11:27:46 +0300
Message-ID: <20150415082746.GI10964@mwanda>
References: <1429084124-2271-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1429084124-2271-2-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1429084124-2271-2-git-send-email-sudipm.mukherjee@gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: devel@driverdev.osuosl.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Willy Tarreau <willy@meta-x.org>, Jean Delvare <jdelvare@suse.de>
List-Id: linux-i2c@vger.kernel.org

Sorry, I still haven't done a proper review.

On Wed, Apr 15, 2015 at 01:18:41PM +0530, Sudip Mukherjee wrote:
> +struct pardevice *
> +parport_register_dev(struct parport *port, const char *name,
> +		     int (*pf)(void *), void (*kf)(void *),
> +		     void (*irq_func)(void *), int flags,
> +		     void *handle, struct parport_driver *drv)
> +{
> +	struct pardevice *tmp;

"tmp" is inaccurate.  It's not a tmp variable.  Use par_dev or
something.


> +	int ret;
> +	char *devname;
> +
> +	if (port->physport->flags & PARPORT_FLAG_EXCL) {
> +		/* An exclusive device is registered. */
> +		pr_debug("%s: no more devices allowed\n",
> +			 port->name);
> +		return NULL;
> +	}
> +
> +	if (flags & PARPORT_DEV_LURK) {
> +		if (!pf || !kf) {
> +			pr_info("%s: refused to register lurking device (%s) without callbacks\n",
> +				port->name, name);
> +			return NULL;
> +		}
> +	}
> +
> +	if (!try_module_get(port->ops->owner))
> +		return NULL;
> +
> +	parport_get_port(port);
> +
> +	tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
> +	if (!tmp) {
> +		pr_warn("%s: memory squeeze, couldn't register %s.\n",
> +			port->name, name);

Don't print warnings on kmalloc() failure.

> +		goto out;

out is a bad label name.  Use err_put_port or something descriptive.

> +	}
> +
> +	tmp->state = kmalloc(sizeof(*tmp->state), GFP_KERNEL);

I think kzalloc() is better here.  That way if the ->init_state()
functions don't set it, then we know it's zeroed out.

> +	if (!tmp->state) {
> +		pr_warn("%s: memory squeeze, couldn't register %s.\n",
> +			port->name, name);
> +		goto out_free_pardevice;
> +	}
> +
> +	tmp->name = name;

I wonder who frees this name variable.  My concern is that it gets
freed before we are done using it or something.  (I have not looked at
the details).

> +	tmp->port = port;
> +	tmp->daisy = -1;
> +	tmp->preempt = pf;
> +	tmp->wakeup = kf;
> +	tmp->private = handle;

handle sounds like a function pointer.  It should be private_data.

> +	tmp->flags = flags;
> +	tmp->irq_func = irq_func;
> +	tmp->waiting = 0;
> +	tmp->timeout = 5 * HZ;
> +
> +	tmp->dev.parent = &port->ddev;
> +	devname = kstrdup(name, GFP_KERNEL);

kstrdup() can fail.

> +	dev_set_name(&tmp->dev, "%s", name);
> +	tmp->dev.driver = &drv->driver;
> +	tmp->dev.release = free_pardevice;
> +	tmp->devmodel = true;
> +	ret = device_register(&tmp->dev);
> +	if (ret)
> +		goto out_free_all;

out_free_all is a bad label name.  It should be free_state.  Except the
most recently allocated resource is devname.  It should be
goto free_devname.  The beauty of labeling things this way is that you
only have to read back a few lines to see what is being freed.

> +
> +	/* Chain this onto the list */
> +	tmp->prev = NULL;

Not really needed because this was allocated with kzalloc(), of course.
But sometimes people like to say things twice for documentation so
that's also fine.

> +	/*
> +	 * This function must not run from an irq handler so we don' t need
> +	 * to clear irq on the local CPU. -arca
> +	 */
> +	spin_lock(&port->physport->pardevice_lock);
> +
> +	if (flags & PARPORT_DEV_EXCL) {
> +		if (port->physport->devices) {
> +			spin_unlock(&port->physport->pardevice_lock);
> +			pr_debug("%s: cannot grant exclusive access for device %s\n",
> +				 port->name, name);
> +			goto out_free_dev;

			goto err_put_dev;

> +		}
> +		port->flags |= PARPORT_FLAG_EXCL;
> +	}
> +
> +	tmp->next = port->physport->devices;
> +	wmb();	/*
> +		 * Make sure that tmp->next is written before it's
> +		 * added to the list; see comments marked 'no locking
> +		 * required'
> +		 */
> +	if (port->physport->devices)
> +		port->physport->devices->prev = tmp;
> +	port->physport->devices = tmp;
> +	spin_unlock(&port->physport->pardevice_lock);
> +
> +	init_waitqueue_head(&tmp->wait_q);
> +	tmp->timeslice = parport_default_timeslice;
> +	tmp->waitnext = NULL;
> +	tmp->waitprev = NULL;
> +
> +	/*
> +	 * This has to be run as last thing since init_state may need other
> +	 * pardevice fields. -arca
> +	 */
> +	port->ops->init_state(tmp, tmp->state);
> +	if (!test_and_set_bit(PARPORT_DEVPROC_REGISTERED, &port->devflags)) {
> +		port->proc_device = tmp;
> +		parport_device_proc_register(tmp);
> +	}

I don't understand this test_and_set_bit() condition.  It's weird to me
that parport_register_dev() succeeds even though we haven't called
parport_device_proc_register(tmp).

> +
> +	return tmp;

Put a blank line here.

> +out_free_dev:
> +	put_device(&tmp->dev);
> +out_free_all:
> +	kfree(tmp->state);
> +out_free_pardevice:
> +	kfree(tmp);
> +out:
> +	parport_put_port(port);
> +	module_put(port->ops->owner);
> +
> +	return NULL;
> +}
> +

regards,
dan carpenter
