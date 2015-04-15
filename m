From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/4] parport: modify parport subsystem to use devicemodel
Date: Wed, 15 Apr 2015 11:33:59 +0300
Message-ID: <20150415083359.GJ10964@mwanda>
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

On Wed, Apr 15, 2015 at 01:18:41PM +0530, Sudip Mukherjee wrote:
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
> +
> +struct pardevice *
> +parport_register_dev(struct parport *port, const char *name,
> +		     int (*pf)(void *), void (*kf)(void *),
> +		     void (*irq_func)(void *), int flags,
> +		     void *handle, struct parport_driver *drv)


The difference between parport_register_device() and
parport_register_dev() isn't clear from the name.

regards,
dan carpenter
