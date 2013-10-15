From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] i2c: Fix modalias for ACPI enumerated I2C devices
Date: Tue, 15 Oct 2013 13:48:29 -0700
Message-ID: <20131015204829.GA5212@kroah.com>
References: <1381414669-26115-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1381754856.2034.34.camel@rzhang1-mobl4>
 <1381837484.2080.66.camel@rzhang1-mobl4>
 <12043671.FjbAvIiH5B@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <12043671.FjbAvIiH5B-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Oct 15, 2013 at 10:37:02PM +0200, Rafael J. Wysocki wrote:
> On Tuesday, October 15, 2013 07:44:44 PM Zhang Rui wrote:
> > On Mon, 2013-10-14 at 20:47 +0800, Zhang Rui wrote:
> > > On Mon, 2013-10-14 at 14:18 +0300, Jarkko Nikula wrote:
> > > > On 10/14/2013 12:23 PM, Zhang Rui wrote:
> > > > > Hi,
> > > > >
> > > > > On Thu, 2013-10-10 at 17:17 +0300, Jarkko Nikula wrote:
> > > > >> There is a minor fault about ACPI enumerated I2C devices with their modalias
> > > > >> attribute. Now modalias is set by device instance not by hardware ID.
> > > > >> For example "i2c:INTABCD:00", "i2c:INTABCD:01" etc.
> > > > >>
> > > > >> This means each device instance gets different modalias which does match
> > > > >> with generated modules.alias. Currently this is not problem as matching can
> > > > >> happen also with "acpi:INTABCD" modalias.
> > > > >>
> > > > > IMO, this is not the proper fix for the modalias problem because ACPI
> > > > > enumerated I2C device may have compatible ids.
> > > > > Instead, we should export all the compatible ids as the modules alias of
> > > > > the ACPI enumerated I2C device.
> > > > >
> > > > > can you please take a look at the patch I sent out earlier?
> > > > > https://patchwork.kernel.org/patch/3034991/
> > > > > https://patchwork.kernel.org/patch/3035041/
> > > > > https://patchwork.kernel.org/patch/3035021/
> > > > I see. This makes sense as it avoids that same device has two different 
> > > > modaliases from both acpi and other subsystem.
> > > > 
> > > > How about modalias nodes in sysfs, should they also reflect what is 
> > > > matching uvent?
> > > > 
> > > good catch, will fix "modalias" as well in next version.
> > 
> > Hi,
> > 
> > I have a question about the device "uevent" and "modalias" sysfs
> > attributes.
> > what is the relationship between these two?
> > Am I right to say that, if there is the "MODALIAS" field in uevent file,
> > this field must be consistent with the content in "modalias" attribute?

Well, if it isn't, it's pretty pointless, right?

> > I checked the code in drivers/base/platform.c,
> > static ssize_t modalias_show(struct device *dev, struct device_attribute
> > *a,
> >                              char *buf)
> > {
> >         struct platform_device  *pdev = to_platform_device(dev);
> >         int len = snprintf(buf, PAGE_SIZE, "platform:%s\n", pdev->name);
> > 
> >         return (len >= PAGE_SIZE) ? (PAGE_SIZE - 1) : len;
> > }
> > 
> > static int platform_uevent(struct device *dev, struct kobj_uevent_env
> > *env)
> > {
> >         struct platform_device  *pdev = to_platform_device(dev);
> >         int rc;
> > 
> >         /* Some devices have extra OF data and an OF-style MODALIAS */
> >         rc = of_device_uevent_modalias(dev, env);
> >         if (rc != -ENODEV)
> >                 return rc;
> > 
> >         add_uevent_var(env, "MODALIAS=%s%s", PLATFORM_MODULE_PREFIX,
> >                         pdev->name);
> >         return 0;
> > }
> > 
> > This means that the OF-style MODALIAS is not shown in "modalias" sysfs
> > attribute.
> > is this a bug?
> 
> I would consider that as a bug, but I'm not sure what the recommended practice
> is.  Greg?

I have no idea how the OF stuff is working, and honestly, I really have
no wish to ever know anything about it.  Especially when it comes to
platform devices/drivers, something that I personally hate and wish
would be deleted.

So go ask the OF maintainers/developers, this is their domain :)

sorry,

greg k-h
