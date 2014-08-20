From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] I2C/ACPI: Fix possible ZERO_SIZE_PTR pointer
 dereferencing error.
Date: Wed, 20 Aug 2014 13:18:14 +0300
Message-ID: <20140820101814.GC1660@lahna.fi.intel.com>
References: <1407810818-33672-1-git-send-email-Li.Xiubo@freescale.com>
 <20140819150355.GD15371@katana>
 <20140819151604.GU1660@lahna.fi.intel.com>
 <20140819153808.GE15371@katana>
 <20140819154555.GW1660@lahna.fi.intel.com>
 <53F4638F.5070704@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53F4638F.5070704-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Zheng, Lv" <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Aug 20, 2014 at 04:59:59PM +0800, Lan Tianyu wrote:
> On 08/19/2014 11:48 PM, Mika Westerberg wrote:
> >On Tue, Aug 19, 2014 at 10:38:08AM -0500, Wolfram Sang wrote:
> >>On Tue, Aug 19, 2014 at 06:16:49PM +0300, Mika Westerberg wrote:
> >>>On Tue, Aug 19, 2014 at 10:03:55AM -0500, Wolfram Sang wrote:
> >>>>On Tue, Aug 12, 2014 at 10:33:38AM +0800, Xiubo Li wrote:
> >>>>>Since we cannot make sure the 'data_len' will always be none zero
> >>>>>here, and then if 'data_len' equals to zero, the kzalloc() will
> >>>>>return ZERO_SIZE_PTR, which equals to ((void *)16).
> >>>>
> >>>>I assume the read request with length == 0 comes from a broken BIOS?
> >>>
> >>>I'm also interested. Does this trigger in a real system?
> >>
> >>Even if not now, we should consider potentially broken BIOSes, or? Which
> >>extends the question to: Do we need even more sanity checks when taking
> >>broken BIOSes into account?
> >
> >Typically ACPICA has done this work for us (e.g it fixes things upfront so
> >that we get sane data). I'm not sure if it does that for I2C Operation
> >Regions, though (that's why I'm asking if it happens in a real system or is
> >this more like a theoretical possibility).
> >
> >Tianyu, any comments?
> >
> 
> Sorry for later response due to leave home today. acpi_gsb_i2c_read_bytes()
> dedicates for GenericSerialBus Read/Write N Bytes protocol(ACPI Spec
> 5.5.2.4.5.3.8). Bios wants to read N Bytes when uses this protocol and the
> length specified by Bios should be greater than 1. If the Bios specified 0
> bytes, the associated function(E,G read battery info) would be totally unusable.
> I think such Bios can't pass through Windows certification:). From this point, I
> think the check is not necessary.
> 
> If you still thought this maybe happen, I think it makes more sense to add the
> check length in the ACPICA. Because ACPICA will allocate a data buffer for I2C
> ACPI operation region access before call the callback. The buffer length will be
> result of protocol head length plus data length. If data length is 0 and this
> means the access will be invalid and ACPICA should ignore it or produce a warning.
> 

Thanks Tianyu for the clarification.

So Wolfram, up to you -- in principle this check is not needed but it
doesn't do any harm either.
