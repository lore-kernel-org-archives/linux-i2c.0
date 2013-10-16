From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] i2c: Fix modalias for ACPI enumerated I2C devices
Date: Tue, 15 Oct 2013 17:10:03 -0700
Message-ID: <20131016001003.GA12492@kroah.com>
References: <1381414669-26115-1-git-send-email-jarkko.nikula@linux.intel.com>
 <3125784.Lc8ATpWH6J@vostro.rjw.lan>
 <20131015233143.GA28114@kroah.com>
 <2766730.3Wpbhyx1zD@vostro.rjw.lan>
 <CACxGe6v3JHLKHqBXux=1mgm227S2dLafaqohKvzqsw1uo6tHyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACxGe6v3JHLKHqBXux=1mgm227S2dLafaqohKvzqsw1uo6tHyA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Mailing List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Oct 16, 2013 at 01:04:02AM +0100, Grant Likely wrote:
> On Wed, Oct 16, 2013 at 12:47 AM, Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org> wrote:
> > On Tuesday, October 15, 2013 04:31:43 PM Greg Kroah-Hartman wrote:
> >> On Tue, Oct 15, 2013 at 11:24:01PM +0200, Rafael J. Wysocki wrote:
> >> > On Tuesday, October 15, 2013 01:48:29 PM Greg Kroah-Hartman wrote:
> >> > > On Tue, Oct 15, 2013 at 10:37:02PM +0200, Rafael J. Wysocki wrote:
> >> > > > On Tuesday, October 15, 2013 07:44:44 PM Zhang Rui wrote:
> >> > > > > On Mon, 2013-10-14 at 20:47 +0800, Zhang Rui wrote:
> >> > > > > > On Mon, 2013-10-14 at 14:18 +0300, Jarkko Nikula wrote:
> >> > > > > > > On 10/14/2013 12:23 PM, Zhang Rui wrote:
> >> > > > > > > > Hi,
> >> > > > > > > >
> >> > > > > > > > On Thu, 2013-10-10 at 17:17 +0300, Jarkko Nikula wrote:
> >> > > > > > > >> There is a minor fault about ACPI enumerated I2C devices with their modalias
> >> > > > > > > >> attribute. Now modalias is set by device instance not by hardware ID.
> >> > > > > > > >> For example "i2c:INTABCD:00", "i2c:INTABCD:01" etc.
> >> > > > > > > >>
> >> > > > > > > >> This means each device instance gets different modalias which does match
> >> > > > > > > >> with generated modules.alias. Currently this is not problem as matching can
> >> > > > > > > >> happen also with "acpi:INTABCD" modalias.
> >> > > > > > > >>
> >> > > > > > > > IMO, this is not the proper fix for the modalias problem because ACPI
> >> > > > > > > > enumerated I2C device may have compatible ids.
> >> > > > > > > > Instead, we should export all the compatible ids as the modules alias of
> >> > > > > > > > the ACPI enumerated I2C device.
> >> > > > > > > >
> >> > > > > > > > can you please take a look at the patch I sent out earlier?
> >> > > > > > > > https://patchwork.kernel.org/patch/3034991/
> >> > > > > > > > https://patchwork.kernel.org/patch/3035041/
> >> > > > > > > > https://patchwork.kernel.org/patch/3035021/
> >> > > > > > > I see. This makes sense as it avoids that same device has two different
> >> > > > > > > modaliases from both acpi and other subsystem.
> >> > > > > > >
> >> > > > > > > How about modalias nodes in sysfs, should they also reflect what is
> >> > > > > > > matching uvent?
> >> > > > > > >
> >> > > > > > good catch, will fix "modalias" as well in next version.
> >> > > > >
> >> > > > > Hi,
> >> > > > >
> >> > > > > I have a question about the device "uevent" and "modalias" sysfs
> >> > > > > attributes.
> >> > > > > what is the relationship between these two?
> >> > > > > Am I right to say that, if there is the "MODALIAS" field in uevent file,
> >> > > > > this field must be consistent with the content in "modalias" attribute?
> >> > >
> >> > > Well, if it isn't, it's pretty pointless, right?
> >> > >
> >> > > > > I checked the code in drivers/base/platform.c,
> >> > > > > static ssize_t modalias_show(struct device *dev, struct device_attribute
> >> > > > > *a,
> >> > > > >                              char *buf)
> >> > > > > {
> >> > > > >         struct platform_device  *pdev = to_platform_device(dev);
> >> > > > >         int len = snprintf(buf, PAGE_SIZE, "platform:%s\n", pdev->name);
> >> > > > >
> >> > > > >         return (len >= PAGE_SIZE) ? (PAGE_SIZE - 1) : len;
> >> > > > > }
> >> > > > >
> >> > > > > static int platform_uevent(struct device *dev, struct kobj_uevent_env
> >> > > > > *env)
> >> > > > > {
> >> > > > >         struct platform_device  *pdev = to_platform_device(dev);
> >> > > > >         int rc;
> >> > > > >
> >> > > > >         /* Some devices have extra OF data and an OF-style MODALIAS */
> >> > > > >         rc = of_device_uevent_modalias(dev, env);
> >> > > > >         if (rc != -ENODEV)
> >> > > > >                 return rc;
> >> > > > >
> >> > > > >         add_uevent_var(env, "MODALIAS=%s%s", PLATFORM_MODULE_PREFIX,
> >> > > > >                         pdev->name);
> >> > > > >         return 0;
> >> > > > > }
> >> > > > >
> >> > > > > This means that the OF-style MODALIAS is not shown in "modalias" sysfs
> >> > > > > attribute.
> >> > > > > is this a bug?
> >> > > >
> >> > > > I would consider that as a bug, but I'm not sure what the recommended practice
> >> > > > is.  Greg?
> >> > >
> >> > > I have no idea how the OF stuff is working, and honestly, I really have
> >> > > no wish to ever know anything about it.  Especially when it comes to
> >> > > platform devices/drivers, something that I personally hate and wish
> >> > > would be deleted.
> 
> <digress>Greg, I've heard you say that a lot, but regardless of what
> platform devices/drivers were originally designed for, it is pretty
> much exactly what we need for non-discoverable memory mapped busses.
> I've yet to heard a viable alternative proposed. I've heard the
> proposal of creating new bus types and new driver binding to that bus
> type for each variant of a non-discoverable memory mapped bus, but I
> think it is a non-starter. There are too many combinations. What
> /might/ work to replace the platform_bus_type would be to have a
> mechanism for drivers to transparently bind to multiple bus types, but
> then I suspect that it will end up looking an awful lot like the
> existing platform_bus_type.
> 
> Probably worth discussing over beer next week</digress>

I think we have a whole session about this at the ARM summit next week,
and if someone wants to bring beer into it, that will make me happy!
