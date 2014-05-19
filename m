From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [Patch V2 9/9] I2C/ACPI: Add CONFIG_I2C_ACPI config
Date: Mon, 19 May 2014 22:23:12 +0200
Message-ID: <5242415.8zZ5y8lb01@vostro.rjw.lan>
References: <1398147855-9868-1-git-send-email-tianyu.lan@intel.com> <20140519084944.GH2067@lahna.fi.intel.com> <5379D28F.1020200@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5379D28F.1020200-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, awilliam-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Monday, May 19, 2014 05:44:47 PM Lan Tianyu wrote:
> On 05/19/2014 04:49 PM, Mika Westerberg wrote:
> > On Sat, May 17, 2014 at 07:48:34PM +0200, Wolfram Sang wrote:
> >> On Tue, Apr 29, 2014 at 11:16:09AM +0300, Mika Westerberg wrote:
> >>> On Mon, Apr 28, 2014 at 10:27:48PM +0800, Lan Tianyu wrote:
> >>>> This patch is to add CONFIG_I2C_ACPI. Current there is a race between
> >>>> removing I2C ACPI operation region and ACPI AML code accessing.
> >>>> So make i2c core built-in if CONFIG_I2C_ACPI is set.
> >>>>
> >>>> Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> >>>> ---
> >>>>   drivers/i2c/Kconfig  | 17 ++++++++++++++++-
> >>>>   drivers/i2c/Makefile |  2 +-
> >>>>   include/linux/i2c.h  |  2 +-
> >>>>   3 files changed, 18 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
> >>>> index 7b7ea32..c670d49 100644
> >>>> --- a/drivers/i2c/Kconfig
> >>>> +++ b/drivers/i2c/Kconfig
> >>>> @@ -2,7 +2,9 @@
> >>>>   # I2C subsystem configuration
> >>>>   #
> >>>>
> >>>> -menuconfig I2C
> >>>> +menu "I2C support"
> >>>> +
> >>>> +config I2C
> >>>>   	tristate "I2C support"
> >>>>   	select RT_MUTEXES
> >>>>   	---help---
> >>>> @@ -21,6 +23,17 @@ menuconfig I2C
> >>>>   	  This I2C support can also be built as a module.  If so, the module
> >>>>   	  will be called i2c-core.
> >>>>
> >>>> +config I2C_ACPI
> >>>> +	bool "I2C ACPI support"
> >>>> +	select I2C
> >>>> +	depends on ACPI
> >>>> +	default y
> >>>> +	help
> >>>> +	  Say Y here if you want to enable I2C ACPI function. ACPI table
> >>>> +	  provides I2C slave devices' information to enumerate these devices.
> >>>> +	  This option also allows ACPI AML code to access I2C slave devices
> >>>> +	  via I2C ACPI operation region to fulfill ACPI method.
> >>>
> >>> I would prefer something like:
> >>>
> >>> Say Y here if you want to enable ACPI I2C support. This includes support
> >>> for automatic enumeration of I2C slave devices and support for ACPI I2C
> >>> Operation Regions. Operation Regions allow firmware (BIOS) code to
> >>> access I2C slave devices, such as smart batteries through an I2C host
> >>> controller driver.
> >>>
> >>> But it is really up to you so,
> >>>
> >>> Reviewed-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> >>
> >> How does this fit into the context of
> >> 55e71edb81b2b45273e7b284cce13ff24bde846f ("i2c: move ACPI helpers into
> >> the core")?
> >
> > With that commit we moved ACPI code to live inside I2C module (given
> > that it was compiled as a module). However, you still can remove that
> > module from userspace.
> >
> > With this patch we make sure that the I2C core can't be removed if you
> > have ACPI enabled. This prevents the potential race.
> >
> 
> Yes, these are the two patches' purposes. Thanks Mika's explanation. If you 
> like, I can merge them into one patch.

I think that would be easier to follow.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
