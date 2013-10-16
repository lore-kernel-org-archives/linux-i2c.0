From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH] i2c: Fix modalias for ACPI enumerated I2C devices
Date: Wed, 16 Oct 2013 01:04:02 +0100
Message-ID: <CACxGe6v3JHLKHqBXux=1mgm227S2dLafaqohKvzqsw1uo6tHyA@mail.gmail.com>
References: <1381414669-26115-1-git-send-email-jarkko.nikula@linux.intel.com>
 <3125784.Lc8ATpWH6J@vostro.rjw.lan> <20131015233143.GA28114@kroah.com> <2766730.3Wpbhyx1zD@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <2766730.3Wpbhyx1zD@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <rob.herring@calxeda.com>, Zhang Rui <rui.zhang@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Linux I2C <linux-i2c@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Oct 16, 2013 at 12:47 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday, October 15, 2013 04:31:43 PM Greg Kroah-Hartman wrote:
>> On Tue, Oct 15, 2013 at 11:24:01PM +0200, Rafael J. Wysocki wrote:
>> > On Tuesday, October 15, 2013 01:48:29 PM Greg Kroah-Hartman wrote:
>> > > On Tue, Oct 15, 2013 at 10:37:02PM +0200, Rafael J. Wysocki wrote:
>> > > > On Tuesday, October 15, 2013 07:44:44 PM Zhang Rui wrote:
>> > > > > On Mon, 2013-10-14 at 20:47 +0800, Zhang Rui wrote:
>> > > > > > On Mon, 2013-10-14 at 14:18 +0300, Jarkko Nikula wrote:
>> > > > > > > On 10/14/2013 12:23 PM, Zhang Rui wrote:
>> > > > > > > > Hi,
>> > > > > > > >
>> > > > > > > > On Thu, 2013-10-10 at 17:17 +0300, Jarkko Nikula wrote:
>> > > > > > > >> There is a minor fault about ACPI enumerated I2C devices with their modalias
>> > > > > > > >> attribute. Now modalias is set by device instance not by hardware ID.
>> > > > > > > >> For example "i2c:INTABCD:00", "i2c:INTABCD:01" etc.
>> > > > > > > >>
>> > > > > > > >> This means each device instance gets different modalias which does match
>> > > > > > > >> with generated modules.alias. Currently this is not problem as matching can
>> > > > > > > >> happen also with "acpi:INTABCD" modalias.
>> > > > > > > >>
>> > > > > > > > IMO, this is not the proper fix for the modalias problem because ACPI
>> > > > > > > > enumerated I2C device may have compatible ids.
>> > > > > > > > Instead, we should export all the compatible ids as the modules alias of
>> > > > > > > > the ACPI enumerated I2C device.
>> > > > > > > >
>> > > > > > > > can you please take a look at the patch I sent out earlier?
>> > > > > > > > https://patchwork.kernel.org/patch/3034991/
>> > > > > > > > https://patchwork.kernel.org/patch/3035041/
>> > > > > > > > https://patchwork.kernel.org/patch/3035021/
>> > > > > > > I see. This makes sense as it avoids that same device has two different
>> > > > > > > modaliases from both acpi and other subsystem.
>> > > > > > >
>> > > > > > > How about modalias nodes in sysfs, should they also reflect what is
>> > > > > > > matching uvent?
>> > > > > > >
>> > > > > > good catch, will fix "modalias" as well in next version.
>> > > > >
>> > > > > Hi,
>> > > > >
>> > > > > I have a question about the device "uevent" and "modalias" sysfs
>> > > > > attributes.
>> > > > > what is the relationship between these two?
>> > > > > Am I right to say that, if there is the "MODALIAS" field in uevent file,
>> > > > > this field must be consistent with the content in "modalias" attribute?
>> > >
>> > > Well, if it isn't, it's pretty pointless, right?
>> > >
>> > > > > I checked the code in drivers/base/platform.c,
>> > > > > static ssize_t modalias_show(struct device *dev, struct device_attribute
>> > > > > *a,
>> > > > >                              char *buf)
>> > > > > {
>> > > > >         struct platform_device  *pdev = to_platform_device(dev);
>> > > > >         int len = snprintf(buf, PAGE_SIZE, "platform:%s\n", pdev->name);
>> > > > >
>> > > > >         return (len >= PAGE_SIZE) ? (PAGE_SIZE - 1) : len;
>> > > > > }
>> > > > >
>> > > > > static int platform_uevent(struct device *dev, struct kobj_uevent_env
>> > > > > *env)
>> > > > > {
>> > > > >         struct platform_device  *pdev = to_platform_device(dev);
>> > > > >         int rc;
>> > > > >
>> > > > >         /* Some devices have extra OF data and an OF-style MODALIAS */
>> > > > >         rc = of_device_uevent_modalias(dev, env);
>> > > > >         if (rc != -ENODEV)
>> > > > >                 return rc;
>> > > > >
>> > > > >         add_uevent_var(env, "MODALIAS=%s%s", PLATFORM_MODULE_PREFIX,
>> > > > >                         pdev->name);
>> > > > >         return 0;
>> > > > > }
>> > > > >
>> > > > > This means that the OF-style MODALIAS is not shown in "modalias" sysfs
>> > > > > attribute.
>> > > > > is this a bug?
>> > > >
>> > > > I would consider that as a bug, but I'm not sure what the recommended practice
>> > > > is.  Greg?
>> > >
>> > > I have no idea how the OF stuff is working, and honestly, I really have
>> > > no wish to ever know anything about it.  Especially when it comes to
>> > > platform devices/drivers, something that I personally hate and wish
>> > > would be deleted.

<digress>Greg, I've heard you say that a lot, but regardless of what
platform devices/drivers were originally designed for, it is pretty
much exactly what we need for non-discoverable memory mapped busses.
I've yet to heard a viable alternative proposed. I've heard the
proposal of creating new bus types and new driver binding to that bus
type for each variant of a non-discoverable memory mapped bus, but I
think it is a non-starter. There are too many combinations. What
/might/ work to replace the platform_bus_type would be to have a
mechanism for drivers to transparently bind to multiple bus types, but
then I suspect that it will end up looking an awful lot like the
existing platform_bus_type.

Probably worth discussing over beer next week</digress>

>> > >
>> > > So go ask the OF maintainers/developers, this is their domain :)
>> >
>> > Well, OK.  Whom in particular?
>>
>> The "OPEN FIRMWARE AND FLATTENED DEVICE TREE" entries in MAINTAINERS?
>
> Hmm, that looks like Grant and Rob Herring.
>
> Grant, Rob, do we want the OF-style MODALIAS to be shown in "modalias" sysfs
> attributes of platform devices?

I've not actually had to deal with modutils and modalias on any of the
platforms I've worked with so I've only looked at it superficially.
Yes, that does look like a bug, but Ben would probably have a much
better idea [cc'd].

g.
