From: "Du, Wenkai" <wenkai.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] i2c-designware: Mask interrupts during i2c controller
 enable
Date: Fri, 4 Apr 2014 18:20:39 +0000
Message-ID: <7286EAF50D3F4E4AADE7FEECEBF8B5A537A70F8B@ORSMSX109.amr.corp.intel.com>
References: <7286EAF50D3F4E4AADE7FEECEBF8B5A537A70E1F@ORSMSX109.amr.corp.intel.com>
 <20140404181613.GB19349@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140404181613.GB19349-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Westerberg, Mika" <mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Mika,

In current driver implementation, I2c controller is enabled, then disabled every time inside i2c_dw_xfer. So I think the interrupt masking should be done inside i2c_dw_xfer_init, where the controller is enabled.

i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
{
...
	/* start the transfers */
	i2c_dw_xfer_init(dev);
...
	/*
	 * We must disable the adapter before unlocking the &dev->lock mutex
	 * below. Otherwise the hardware might continue generating interrupts
	 * which in turn causes a race condition with the following transfer.
	 * Needs some more investigation if the additional interrupts are
	 * a hardware bug or this driver doesn't handle them correctly yet.
	 */
	__i2c_dw_enable(dev, false);
...
}


Thanks,
Wenkai



-----Original Message-----
From: Westerberg, Mika 
Sent: Friday, April 04, 2014 11:16 AM
To: Du, Wenkai
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Wolfram Sang; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: Re: [PATCH] i2c-designware: Mask interrupts during i2c controller enable

On Fri, Apr 04, 2014 at 08:05:23PM +0300, Du, Wenkai wrote:
> diff --git a/drivers/i2c/busses/i2c-designware-core.c 
> b/drivers/i2c/busses/i2c-designware-core.c
> index 14c4b30..71a3fa9 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -417,6 +417,9 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
>  	 */
>  	dw_writel(dev, msgs[dev->msg_write_idx].addr | ic_tar, DW_IC_TAR);
>  
> +	/* disable interrupts */
> +	i2c_dw_disable_int(dev);
> +

Please move this to i2c_dw_init() as I previously commented. This can only happen once the controller comes out of reset (either boot, or resume from system sleep).

>  	/* Enable the adapter */
>  	__i2c_dw_enable(dev, true);
>  
> --
> 1.7.9.5
