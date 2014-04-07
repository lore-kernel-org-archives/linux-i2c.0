From: "Du, Wenkai" <wenkai.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] i2c-designware: Mask interrupts during i2c controller
 enable
Date: Mon, 7 Apr 2014 16:48:02 +0000
Message-ID: <7286EAF50D3F4E4AADE7FEECEBF8B5A537A72207@ORSMSX109.amr.corp.intel.com>
References: <7286EAF50D3F4E4AADE7FEECEBF8B5A537A70E1F@ORSMSX109.amr.corp.intel.com>
 <20140404181613.GB19349@intel.com>
 <7286EAF50D3F4E4AADE7FEECEBF8B5A537A70F8B@ORSMSX109.amr.corp.intel.com>
 <20140404184232.GC19349@intel.com>
 <7286EAF50D3F4E4AADE7FEECEBF8B5A537A71351@ORSMSX109.amr.corp.intel.com>
 <20140405061316.GF19349@intel.com>
 <20140406185818.3aaca03d@alan.etchedpixels.co.uk>
 <20140407090403.GG19349@intel.com>
 <20140407154252.6b8f0f7e@alan.etchedpixels.co.uk>
 <20140407151107.GL19349@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140407151107.GL19349-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Westerberg, Mika" <mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> -----Original Message-----
> From: Westerberg, Mika
> Sent: Monday, April 07, 2014 8:11 AM
> To: One Thousand Gnomes
> Cc: Du, Wenkai; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Wolfram Sang; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH] i2c-designware: Mask interrupts during i2c controller enable
> 
> 
> Do you think we can fix it with adding a dummy read right after write to the mask register, like
> the snippet below?
> 
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-
> core.c
> index 14c4b30d4ccc..ff9090381d8b 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -535,6 +535,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
>  		intr_mask = 0;
> 
>  	dw_writel(dev, intr_mask,  DW_IC_INTR_MASK);
> +	dw_readl(dev, DW_IC_INTR_MASK);
>  }
> 

I have tried this read back earlier during debugging, it didn't help. You can confirm yourself as well.

On the ISR code execution path, here is the list to my understanding:

1. TX abort: this path masks all interrupt by writing 0 to interrupt mask register;
2. RX full: this path doesn't do anything on masking interrupts;
3. TX empty: this path only mask TX empty under certain conditions; it doesn't mask other interrupt sources;
4. i2c STOP condition: this path call complete() to finish the transfer; it doesn't do anything on masking interrupts;

The above analysis agrees with the debug logs: most of interrupts are left unmasked in original code when i2c core is being enabled.

I think we want all interrupts masked when enabling HW. This will ensure the required 25us core turn on delay being respected. Also there could be spurious interrupts when HW is being turned on that should be ignored.
