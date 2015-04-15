From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4] parport: modify parport subsystem to use devicemodel
Date: Wed, 15 Apr 2015 21:43:34 +0530
Message-ID: <20150415161334.GA5106@sudip-PC>
References: <1429084124-2271-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1429084124-2271-2-git-send-email-sudipm.mukherjee@gmail.com>
 <20150415133115.GG21491@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150415133115.GG21491-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Willy Tarreau <willy-859RlTSWH48dnm+yROfE0A@public.gmane.org>, One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 15, 2015 at 03:31:15PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 15, 2015 at 01:18:41PM +0530, Sudip Mukherjee wrote:
> > @@ -29,6 +31,7 @@
<snip>
> > +struct bus_type parport_bus_type = {
> > +	.name           = "parport",
> > +};
> > +EXPORT_SYMBOL(parport_bus_type);
> 
> They bus type shouldn't need to be exported, unless something is really
> wrong.  Why did you do this?
I was thinking why it was needed but i saw the same for pci_bus_type,
i2c_bus_type and spi_bus_type and i blindly followed. :(
> 
> > +
<snip>
> > +int __parport_register_drv(struct parport_driver *drv,
> > +			   struct module *owner, const char *mod_name)
> > +{
> > +	struct parport *port;
> > +	int ret, err = 0;
> > +	bool attached = false;
> 
> You shouldn't need to track attached/not attached with the driver model,
> that's what it is there for to handle for you.
this attach is different from the driver model. The driver when it calls
prport_register_drv(), it will again call back a function which was called
attach, so i named the variable as attached. but i guess the name is
misleading, i will rename it in v2.
> 
> > +
> > +	if (list_empty(&portlist))
> > +		get_lowlevel_driver();
> 
> what does this call do?
if parport_pc is not loaded it does a request_module, and the
documentation says to add "alias parport_lowlevel parport_pc"
in /etc/modprobe.d directory. parport_pc will actually register the
ports, so if that module is not loaded then the system is not yet
having any parallel port registered.
> 
<snip>
> > +			err = ret;
> > +	}
> > +	if (attached)
> > +		list_add(&drv->list, &drivers);
> 
> Why all of this?  You shouldn't need your own matching anymore, the
> driver core does it for you when you register the driver, against the
> devices you have already registered, if any.
ok. I will remove. actully, I have copied the old function and just
added the device-model specific parts to it, and I thought after we have
a working model then we can remove these parts which will not be needed.
> 
> 
<snip>
> > +		list_del(&tmp->full_list);
> > +		kfree(tmp);
> > +		return NULL;
> 
> Please read the kerneldoc comments for device_register(), you can't
> clean things up this way if device_register() fails :(
oops.. sorry, i read that and did that while unregistering the device,
but here the old habit of kfree came ... :(
> 
<snip>
> >  	tmp->prev = NULL;
> > @@ -630,6 +703,133 @@ parport_register_device(struct parport *port, const char *name,
> >  	return NULL;
> >  }
> >  
> > +void free_pardevice(struct device *dev)
> > +{
> > +}
> 
> empty free functions are a huge red flag.  So much so the kobject
> documentation in the kernel says I get to make fun of anyone who tries
> to do this.  So please don't do this :)
yeahh, i remember reading it, but when i got the stackdump, that went
out of my head. working with the device-mode for the first time, so i
guess it can be excused. :)
> 
> 
> > +struct pardevice *
> > +parport_register_dev(struct parport *port, const char *name,
> > +		     int (*pf)(void *), void (*kf)(void *),
> > +		     void (*irq_func)(void *), int flags,
> > +		     void *handle, struct parport_driver *drv)
> 
> I think you need a structure, what's with all of the function pointers?
ok. that will keep the code tidy.
> 
> > +	tmp->waiting = 0;
> > +	tmp->timeout = 5 * HZ;
> > +
> > +	tmp->dev.parent = &port->ddev;
> > +	devname = kstrdup(name, GFP_KERNEL);
> > +	dev_set_name(&tmp->dev, "%s", name);
> 
> Why create devname and name here in different ways?
I was experimenting and finally forgot to remove devname. sorry.
> 
> > +	tmp->dev.driver = &drv->driver;
> > +	tmp->dev.release = free_pardevice;
> > +	tmp->devmodel = true;
> > +	ret = device_register(&tmp->dev);
> > +	if (ret)
> > +		goto out_free_all;
> 
> Again, wrong error handling.
will fix it.
> 
> 
> > +	/* Chain this onto the list */
<snip>
> > +	if (port->physport->devices)
> > +		port->physport->devices->prev = tmp;
> > +	port->physport->devices = tmp;
> > +	spin_unlock(&port->physport->pardevice_lock);
> 
> This whole list of device management seems odd, is it really still
> needed with the conversion to the new model?
like i said before, I have not removed anything from the function.
> 
> 
> >  		return;
> >  	}
> > +	if (dev->devmodel)
> > +		device_release_driver(&dev->dev);
> >  
> >  #ifdef CONFIG_PARPORT_1284
> >  	/* If this is on a mux port, deselect it. */
> > @@ -1022,6 +1235,7 @@ EXPORT_SYMBOL(parport_remove_port);
> >  EXPORT_SYMBOL(parport_register_driver);
> >  EXPORT_SYMBOL(parport_unregister_driver);
> >  EXPORT_SYMBOL(parport_register_device);
> > +EXPORT_SYMBOL(parport_register_dev);
> 
> checkpatch doesn't like you putting this here :)
oops... missed that.
I will send in a v2, better I will send to u and Dan and ofcourse lkml
as RFC. After the final version of RFC is approved then I will send the
patch for applying.

regards
sudip

> thanks,
> 
> greg k-h
