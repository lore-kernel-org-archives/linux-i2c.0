From: Michael Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: clock driver
Date: Wed, 27 May 2015 10:30:55 -0700
Message-ID: <20150527173055.22384.74368@quantum>
References: <5564C58B.9050400@freescale.com> <20150526223829.GA26454@roeck-us.net>
 <55650DBA.5000304@freescale.com> <5565108D.2020502@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5565108D.2020502-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, andrey-MoRZu3FOBbXQT0dZR+AlfA@public.gmane.org, sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rabeeh-UBr1pzP51AyaMJb+Lgu22Q@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Quoting York Sun (2015-05-26 17:32:13)
> Michael,
> 
> Can you give me some guidance here?
> 
> 
> On 05/26/2015 05:20 PM, York Sun wrote:
> > 
> > 
> > On 05/26/2015 03:38 PM, Guenter Roeck wrote:
> >> On Tue, May 26, 2015 at 12:12:11PM -0700, York Sun wrote:
> >>> Linux experts,
> >>>
> >>> I have rewritten a driver for Silicon Labs SI5338 programmable clock chip. The
> >>> original driver was written by Andrey (CC'ed), but was floatingn outside of the
> >>> kernel. The driver was written to use sysfs as the interface, not the common
> >>> clock framework. I wonder if I have to rewrite the driver following common clock
> >>> framework. One concern is to support a feature to accept ClockBuilder (TM)
> >>> output on sysfs. I don't see sysfs support on common clock framework. Please
> >>> correct me if I am wrong.

Can you give me a link to some info about ClockBuilder?

> >>>
> >>> If not using common clock framework is acceptable, I would like to send a RFC
> >>> patch for review.
> >>>
> >> My original driver for si570 was rejected because it didn't support the clock
> >> framework, so you might face an uphill battle.
> >>
> >> SI provides a document for SI5338 describing how to configure it without
> >> using clockbuilder [1]. Can that be used to implement generic code which
> >> doesn't need clockbuilder ?
> >>
> > 
> > The driver is capable to handle the user's input and enable the clocks. Removing
> > the support of importing is a step back. At least it is a feature I am using. I
> > believe Andrey also used this feature when the driver was first drafted.
> > 
> > That being said, my application relies on setting multiple clock chips on a PCIe
> > device. That means I cannot put the configuration into device tree. There may be
> > a way to fill device tree, but I am not ready to explore yet. Without a sysfs
> > interface, can I change the configuration for each clock?

CCF does not have any dependency on DeviceTree. Zero. If you don't want
to use DT, then that is great! The ARM community has chosen DT, and the
ARM community by and large uses CCF in Linux. But there is no
requirement to use DT if you want to use CCF.

Regarding sysfs, I really need to understand what interfaces you want
from sysfs. Can you provide a link to the ClockBuilder(TM) stuff?

It is certainly possible for you to create sysfs entries in your clock
driver. Depending on what you want to do, there may be no need to
involve the framework in this stuff. Do you think you can keep your
sysfs stuff localized in your driver?

> > 
> > I also found COMMON_CLK is a bool, not tristate. It is only selected by others.
> > Is there a reason for doing so? My current platform (P1022DS) doesn't have
> > CONFIG_COMMON_CLK enabled.
> > 
> 
> If converting my driver to common clock framework, I need to find a way to
> configure the clocks without recompiling the kernel. I will have about 30 clock
> chips (with different frequency) on multiple PCIe cards.

Sure. Let's figure out your requirements and decide if we can make CCF
work for you. I think we can.

I know that the Beagle Bone folks have been looking at modifying DT
blobs and changing them/loading them at run-time. That might be
interesting for your on-the-fly clock configuration.

If you don't like DT then perhaps you can export your sysfs clock stuff
via your clock driver, instead of the framework?

Regards,
Mike

> 
> York
