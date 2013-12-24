From: Peter Wu <lekensteyn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: How should dev_[gs]et_drvdata be used?
Date: Tue, 24 Dec 2013 10:44:26 +0100
Message-ID: <2910437.enNBv05CR4@al>
References: <20130123174204.00463f98@endymion.delvare> <1716344.EUMSGCAAKK@al> <1387849869.30327.201.camel@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387849869.30327.201.camel-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Martin Mokrejs <mmokrejs-08dBlVkRsZWoiTQjSSYKZesEoJ4y9sgM@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Monday 23 December 2013 18:51:09 Alex Williamson wrote:
> > It does:
> > 
> > int device_private_init(struct device *dev)
> > {
> >         dev->p = kzalloc(sizeof(*dev->p), GFP_KERNEL);
> >         if (!dev->p)
> >                 return -ENOMEM;
> >         dev->p->device = dev; 
> >         klist_init(&dev->p->klist_children, klist_children_get,
> >                    klist_children_put);
> >         INIT_LIST_HEAD(&dev->p->deferred_probe);
> >         return 0;
> > }
> > 
> > and if it doesn't, then I must be missing something in this non-obvious
> > code. I scanned the interwebs and Documentation/, but could not really
> > find a great example on how this is supposed to work. The dev_set_drvdata
> > function existed since Linus moved to git.
> 
> You're missing that device_private_init() is only called if (!dev->p).
> It's a one time initializer and after that we only set the driver_data.

Yes I am aware of that, the question is about the memory that got allocated
in vfio_group_create_device().

I think I have found the answer. The "dev" device is passed from the PCI
layer, that will probably take care of freeing the resources when the
device is gone. Is this view correct?

Thanks for your replies!

Peter

> > > Also, the code referenced is kfree'ing a struct vfio_device, not the
> > > struct device.  VFIO uses the drvdata to provide a back pointer to the
> > > vfio specific structure, which also includes a pointer to the struct
> > > device.  We obviously want to clear drvdata when the vfio specific
> > > structure is being released.
> > 
> > Ah, I see. "device->dev" is not freed, but "device". And the data is
> > cleared for "device->dev". Thanks for correcting.
> > 
> > Clear examples of how to use dev_{s,g}et_drvdata correctly in i2c is
> > still wanted. I stepped in it yesterday, i2c seems to have its own
> > way to register new devices. More specifically, how can the memory
> > associated with dev_set_drvdata be free'd on error paths if the
> > device is not registered with device_register (as is done in the
> > probe function of the i801 i2c driver)?
