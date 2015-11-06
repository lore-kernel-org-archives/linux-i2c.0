From: "Yu, Xiangliang" <Xiangliang.Yu@amd.com>
Subject: RE: [PATCH 1/1] I2C: designware: fix IO timeout issue for AMD
 controller
Date: Fri, 6 Nov 2015 09:11:35 +0000
Message-ID: <1C99EED8F51BBC41A8F1E645B51245F41AE8AAF2@scybexdag03.amd.com>
References: <1446726884-30558-1-git-send-email-Xiangliang.Yu@amd.com>
 <20151105135216.GN1509@lahna.fi.intel.com>
 <1C99EED8F51BBC41A8F1E645B51245F41AE8AA50@scybexdag03.amd.com>
 <563C6BF7.3080406@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <563C6BF7.3080406@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Xue, Ken" <Ken.Xue@amd.com>, "Wan, Vincent" <Vincent.Wan@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Wang, Annie" <Annie.Wang@amd.com>, "Li, Tony" <Tony.Li@amd.com>
List-Id: linux-i2c@vger.kernel.org

> -----Original Message-----
> From: Jarkko Nikula [mailto:jarkko.nikula@linux.intel.com]
> Sent: Friday, November 06, 2015 5:00 PM
> To: Yu, Xiangliang; Mika Westerberg
> Cc: andriy.shevchenko@linux.intel.com; wsa@the-dreams.de; linux-
> i2c@vger.kernel.org; linux-kernel@vger.kernel.org; Xue, Ken; Wan, Vincent;
> Huang, Ray; Wang, Annie; Li, Tony
> Subject: Re: [PATCH 1/1] I2C: designware: fix IO timeout issue for AMD
> controller
> 
> On 06.11.2015 06:34, Yu, Xiangliang wrote:
> >> -----Original Message-----
> >> From: Mika Westerberg [mailto:mika.westerberg@linux.intel.com]
> >>> --- a/drivers/i2c/busses/i2c-designware-core.c
> >>> +++ b/drivers/i2c/busses/i2c-designware-core.c
> >>> @@ -783,6 +783,9 @@ irqreturn_t i2c_dw_isr(int this_irq, void
> >>> *dev_id)
> >>>
> >>>   	stat = i2c_dw_read_clear_intrbits(dev);
> >>
> >> What if the status changes right here, before you go and mask the
> interrupt?
> > Have no effect, because i2c controller can't trigger next interrupt.
> >
> Does it mean possible lost interrupt too? I guess it can be debugged by
> placing a few ms long mdelay() between clearing and masking.
> 

The interrupt will not be lost if status bits change before masking interrupt.

> How frequent is this timeout? I guess lost interrupt is somehow nearly
> related to clearing, masking and unmasking if that cycle helps. One thing that
> comes to my mind is masking needed and could plain unmasking be also a
> working workaround?

Quite frequently.

> 
> Have you tried to print DW_IC_INTR_STAT, DW_IC_INTR_MASK and
> DW_IC_RAW_INTR_STAT when timeout occurs? E.g. just after printing the
> timeout out error in i2c_dw_xfer(). Probably good in i2c_dw_isr() too if if
> doesn't produce too much data and make debugging impossible.
> 

Yes, I have tried to print these status. I have confirmed the issue with hardware engineer. 
