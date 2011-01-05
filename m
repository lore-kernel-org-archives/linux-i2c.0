From: Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 3/6] i2c/pxa2xx: Add PCI support for PXA I2C controller
Date: Wed, 5 Jan 2011 15:08:34 -0800
Message-ID: <20110105230834.GA26399@suse.de>
References: <1294246263-31960-1-git-send-email-bigeasy@linutronix.de>
 <1294246263-31960-4-git-send-email-bigeasy@linutronix.de>
 <20110105230342.GO8638@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110105230342.GO8638-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jan 05, 2011 at 11:03:42PM +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 05, 2011 at 05:51:00PM +0100, Sebastian Andrzej Siewior wrote:
> > +static void plat_dev_release(struct device *dev)
> > +{
> > +	struct ce4100_i2c_device *sd = container_of(dev,
> > +			struct ce4100_i2c_device, pdev.dev);
> > +
> > +	of_device_node_put(&sd->pdev.dev);
> > +}
> > +static int add_i2c_device(struct pci_dev *dev, int bar,
> > +		struct ce4100_i2c_device *sd)
> > +{
> > +	struct platform_device *pdev = &sd->pdev;
> > +	struct i2c_pxa_platform_data *pdata = &sd->pdata;
> ...
> > +	pdev->name = "ce4100-i2c";
> > +	pdev->dev.release = plat_dev_release;
> > +	pdev->dev.parent = &dev->dev;
> > +
> > +	pdev->dev.platform_data = pdata;
> > +	pdev->resource = sd->res;
> ...
> > +static int __devinit ce4100_i2c_probe(struct pci_dev *dev,
> > +		const struct pci_device_id *ent)
> > +{
> > +	sds = kzalloc(sizeof(*sds), GFP_KERNEL);
> > +	if (!sds)
> > +		goto err_mem;
> > +
> > +	pci_set_drvdata(dev, sds);
> > +
> > +	for (i = 0; i < ARRAY_SIZE(sds->sd); i++) {
> > +		ret = add_i2c_device(dev, i, &sds->sd[i]);
> > +		if (ret) {
> > +			while (--i >= 0)
> > +				platform_device_unregister(&sds->sd[i].pdev);
> ...
> > +static void __devexit ce4100_i2c_remove(struct pci_dev *dev)
> ...
> > +	for (i = 0; i < ARRAY_SIZE(sds->sd); i++)
> > +		platform_device_unregister(&sds->sd[i].pdev);
> > +
> > +	pci_disable_device(dev);
> > +	kfree(sds);
> > +}
> 
> I see we're still repeating the same mistakes with lifetime rules of
> sysfs objects.
> 
> Any struct device which has been registered into the device model can
> remain indefinitely live after it's been unregistered (by, eg, if
> userspace holds a reference to it via sysfs.)

Actually this race is almost not possible these days with the rework
that Tejun did on sysfs, so it's not easy to test for this anymore.

> Only once the release method has been called is it safe to give up the
> memory backing it - and that also goes for the code comprising the
> function implementing the release.

Yes.

> This effectively prevents modules having release functions in them -
> while you can put module use count manipulation in to prevent unloading,
> it effectively prevents the module from being unloaded until you've
> unbound the device.
> 
> I think you should be trying to use the platform_device_alloc()
> interfaces here, rather than trying to reinvent them.  The only issue I
> see with that is the of_device_node_put() call.  Maybe OF/DT/device model
> people can provide some pointers?  Adding Greg for the device model
> maintainer view.

Don't reinvent functions that the core already provides, that's not a
good idea.

Sebastian, why didn't those functions work for you?

thanks,

greg k-h
