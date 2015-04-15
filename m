From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/4] parport: modify parport subsystem to use devicemodel
Date: Wed, 15 Apr 2015 15:31:15 +0200
Message-ID: <20150415133115.GG21491@kroah.com>
References: <1429084124-2271-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1429084124-2271-2-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1429084124-2271-2-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>, Willy Tarreau <willy@meta-x.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, dan.carpenter@oracle.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 15, 2015 at 01:18:41PM +0530, Sudip Mukherjee wrote:
> @@ -29,6 +31,7 @@
>  #include <linux/slab.h>
>  #include <linux/sched.h>
>  #include <linux/kmod.h>
> +#include <linux/device.h>
>  
>  #include <linux/spinlock.h>
>  #include <linux/mutex.h>
> @@ -100,6 +103,11 @@ static struct parport_operations dead_ops = {
>  	.owner		= NULL,
>  };
>  
> +struct bus_type parport_bus_type = {
> +	.name           = "parport",
> +};
> +EXPORT_SYMBOL(parport_bus_type);

They bus type shouldn't need to be exported, unless something is really
wrong.  Why did you do this?

> +
>  /* Call attach(port) for each registered driver. */
>  static void attach_driver_chain(struct parport *port)
>  {
> @@ -157,6 +165,7 @@ int parport_register_driver (struct parport_driver *drv)
>  
>  	if (list_empty(&portlist))
>  		get_lowlevel_driver ();
> +	drv->devmodel = false;
>  
>  	mutex_lock(&registration_lock);
>  	list_for_each_entry(port, &portlist, list)
> @@ -167,6 +176,57 @@ int parport_register_driver (struct parport_driver *drv)
>  	return 0;
>  }
>  
> +/*
> + * __parport_register_drv - register a new parport driver
> + * @drv: the driver structure to register
> + * @owner: owner module of drv
> + * @mod_name: module name string
> + *
> + * Adds the driver structure to the list of registered drivers.
> + * Returns a negative value on error, otherwise 0.
> + * If no error occurred, the driver remains registered even if
> + * no device was claimed during registration.
> + */
> +int __parport_register_drv(struct parport_driver *drv,
> +			   struct module *owner, const char *mod_name)
> +{
> +	struct parport *port;
> +	int ret, err = 0;
> +	bool attached = false;

You shouldn't need to track attached/not attached with the driver model,
that's what it is there for to handle for you.

> +
> +	if (list_empty(&portlist))
> +		get_lowlevel_driver();

what does this call do?

> +
> +	/* initialize common driver fields */
> +	drv->driver.name = drv->name;
> +	drv->driver.bus = &parport_bus_type;
> +	drv->driver.owner = owner;
> +	drv->driver.mod_name = mod_name;
> +	drv->devmodel = true;
> +	ret = driver_register(&drv->driver);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&registration_lock);
> +	list_for_each_entry(port, &portlist, list) {
> +		ret = drv->attach_ret(port, drv);
> +		if (ret == 0)
> +			attached = true;
> +		else
> +			err = ret;
> +	}
> +	if (attached)
> +		list_add(&drv->list, &drivers);

Why all of this?  You shouldn't need your own matching anymore, the
driver core does it for you when you register the driver, against the
devices you have already registered, if any.


> +	mutex_unlock(&registration_lock);
> +	if (!attached) {
> +		driver_unregister(&drv->driver);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(__parport_register_drv);
> +
>  /**
>   *	parport_unregister_driver - deregister a parallel port device driver
>   *	@drv: structure describing the driver that was given to
> @@ -193,11 +253,15 @@ void parport_unregister_driver (struct parport_driver *drv)
>  	list_for_each_entry(port, &portlist, list)
>  		drv->detach(port);
>  	mutex_unlock(&registration_lock);
> +	if (drv->devmodel)
> +		driver_unregister(&drv->driver);
>  }
>  
> -static void free_port (struct parport *port)
> +static void free_port(struct device *dev)
>  {
>  	int d;
> +	struct parport *port = to_parport_dev(dev);
> +
>  	spin_lock(&full_list_lock);
>  	list_del(&port->full_list);
>  	spin_unlock(&full_list_lock);
> @@ -223,8 +287,9 @@ static void free_port (struct parport *port)
>  
>  struct parport *parport_get_port (struct parport *port)
>  {
> -	atomic_inc (&port->ref_count);
> -	return port;
> +	struct device *dev = get_device(&port->ddev);
> +
> +	return to_parport_dev(dev);
>  }
>  
>  /**
> @@ -237,11 +302,7 @@ struct parport *parport_get_port (struct parport *port)
>  
>  void parport_put_port (struct parport *port)
>  {
> -	if (atomic_dec_and_test (&port->ref_count))
> -		/* Can destroy it now. */
> -		free_port (port);
> -
> -	return;
> +	put_device(&port->ddev);
>  }
>  
>  /**
> @@ -281,6 +342,7 @@ struct parport *parport_register_port(unsigned long base, int irq, int dma,
>  	int num;
>  	int device;
>  	char *name;
> +	int ret;
>  
>  	tmp = kzalloc(sizeof(struct parport), GFP_KERNEL);
>  	if (!tmp) {
> @@ -333,6 +395,9 @@ struct parport *parport_register_port(unsigned long base, int irq, int dma,
>  	 */
>  	sprintf(name, "parport%d", tmp->portnum = tmp->number);
>  	tmp->name = name;
> +	tmp->ddev.bus = &parport_bus_type;
> +	tmp->ddev.release = free_port;
> +	dev_set_name(&tmp->ddev, name);
>  
>  	for (device = 0; device < 5; device++)
>  		/* assume the worst */
> @@ -340,6 +405,13 @@ struct parport *parport_register_port(unsigned long base, int irq, int dma,
>  
>  	tmp->waithead = tmp->waittail = NULL;
>  
> +	ret = device_register(&tmp->ddev);
> +	if (ret) {
> +		list_del(&tmp->full_list);
> +		kfree(tmp);
> +		return NULL;

Please read the kerneldoc comments for device_register(), you can't
clean things up this way if device_register() fails :(

> +	}
> +
>  	return tmp;
>  }
>  
> @@ -575,6 +647,7 @@ parport_register_device(struct parport *port, const char *name,
>  	tmp->irq_func = irq_func;
>  	tmp->waiting = 0;
>  	tmp->timeout = 5 * HZ;
> +	tmp->devmodel = false;
>  
>  	/* Chain this onto the list */
>  	tmp->prev = NULL;
> @@ -630,6 +703,133 @@ parport_register_device(struct parport *port, const char *name,
>  	return NULL;
>  }
>  
> +void free_pardevice(struct device *dev)
> +{
> +}

empty free functions are a huge red flag.  So much so the kobject
documentation in the kernel says I get to make fun of anyone who tries
to do this.  So please don't do this :)


> +struct pardevice *
> +parport_register_dev(struct parport *port, const char *name,
> +		     int (*pf)(void *), void (*kf)(void *),
> +		     void (*irq_func)(void *), int flags,
> +		     void *handle, struct parport_driver *drv)

I think you need a structure, what's with all of the function pointers?




> +{
> +	struct pardevice *tmp;
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
> +		goto out;
> +	}
> +
> +	tmp->state = kmalloc(sizeof(*tmp->state), GFP_KERNEL);
> +	if (!tmp->state) {
> +		pr_warn("%s: memory squeeze, couldn't register %s.\n",
> +			port->name, name);
> +		goto out_free_pardevice;
> +	}
> +
> +	tmp->name = name;
> +	tmp->port = port;
> +	tmp->daisy = -1;
> +	tmp->preempt = pf;
> +	tmp->wakeup = kf;
> +	tmp->private = handle;
> +	tmp->flags = flags;
> +	tmp->irq_func = irq_func;
> +	tmp->waiting = 0;
> +	tmp->timeout = 5 * HZ;
> +
> +	tmp->dev.parent = &port->ddev;
> +	devname = kstrdup(name, GFP_KERNEL);
> +	dev_set_name(&tmp->dev, "%s", name);

Why create devname and name here in different ways?

> +	tmp->dev.driver = &drv->driver;
> +	tmp->dev.release = free_pardevice;
> +	tmp->devmodel = true;
> +	ret = device_register(&tmp->dev);
> +	if (ret)
> +		goto out_free_all;

Again, wrong error handling.


> +	/* Chain this onto the list */
> +	tmp->prev = NULL;
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

This whole list of device management seems odd, is it really still
needed with the conversion to the new model?


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
> +
> +	return tmp;
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
>  /**
>   *	parport_unregister_device - deregister a device on a parallel port
>   *	@dev: pointer to structure representing device
> @@ -691,7 +891,10 @@ void parport_unregister_device(struct pardevice *dev)
>  	spin_unlock_irq(&port->waitlist_lock);
>  
>  	kfree(dev->state);
> -	kfree(dev);
> +	if (dev->devmodel)
> +		device_unregister(&dev->dev);
> +	else
> +		kfree(dev);
>  
>  	module_put(port->ops->owner);
>  	parport_put_port (port);
> @@ -774,6 +977,7 @@ int parport_claim(struct pardevice *dev)
>  	struct pardevice *oldcad;
>  	struct parport *port = dev->port->physport;
>  	unsigned long flags;
> +	int ret;
>  
>  	if (port->cad == dev) {
>  		printk(KERN_INFO "%s: %s already owner\n",
> @@ -802,6 +1006,13 @@ int parport_claim(struct pardevice *dev)
>  		}
>  	}
>  
> +	if (dev->devmodel) {
> +		ret = device_attach(&dev->dev);
> +		if (ret != 1) {
> +			return -ENODEV;
> +		}
> +	}
> +
>  	/* Can't fail from now on, so mark ourselves as no longer waiting.  */
>  	if (dev->waiting & 1) {
>  		dev->waiting = 0;
> @@ -926,8 +1137,8 @@ int parport_claim_or_block(struct pardevice *dev)
>  			       dev->port->physport->cad ?
>  			       dev->port->physport->cad->name:"nobody");
>  #endif
> -	}
> -	dev->waiting = 0;
> +	} else if (r == 0)
> +		dev->waiting = 0;
>  	return r;
>  }
>  
> @@ -954,6 +1165,8 @@ void parport_release(struct pardevice *dev)
>  		       "when not owner\n", port->name, dev->name);
>  		return;
>  	}
> +	if (dev->devmodel)
> +		device_release_driver(&dev->dev);
>  
>  #ifdef CONFIG_PARPORT_1284
>  	/* If this is on a mux port, deselect it. */
> @@ -1022,6 +1235,7 @@ EXPORT_SYMBOL(parport_remove_port);
>  EXPORT_SYMBOL(parport_register_driver);
>  EXPORT_SYMBOL(parport_unregister_driver);
>  EXPORT_SYMBOL(parport_register_device);
> +EXPORT_SYMBOL(parport_register_dev);

checkpatch doesn't like you putting this here :)

thanks,

greg k-h
