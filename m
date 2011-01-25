From: Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 7/9] i2c-designware: Allow mixed endianness accesses
Date: Tue, 25 Jan 2011 11:45:20 +0900
Message-ID: <4D3E3940.1060403@renesas.com>
References: <1295033256-30077-1-git-send-email-dirk.brandewie@gmail.com>
 <1295033256-30077-8-git-send-email-dirk.brandewie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1295033256-30077-8-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 1/15/2011 4:27 AM, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Allows CPUs of a given endianness to access a dw controller of a different
> endianness. Endianncess difference is detected at run time through the dw
> component type register.
> 
> This is the hand application of a patch set by Jean-Hugues Deschenes
> applied at the sugestion of Shinya Kuribayashi
> 
> Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> CC: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-designware-core.c |  116 +++++++++++++++++++-----------
>  drivers/i2c/busses/i2c-designware-core.h |    9 ++-
>  drivers/i2c/busses/i2c-designware-pci.c  |    4 +-
>  drivers/i2c/busses/i2c-designware-plat.c |    5 +-
>  4 files changed, 89 insertions(+), 45 deletions(-)
> 

Here Dirk-san makes an improvement against a proposed patch from Jean;
moving the component type cheking routines from _probe() function
into i2c_dw_init().  I'd propose to make it as separate patch(es).

> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
> index 6723f9e..746b4bb 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -137,16 +156,29 @@ u32 i2c_dw_scl_lcnt(u32 ic_clk, u32 tLOW, u32 tf, int offset)
>   * This function is called during I2C init function, and in case of timeout at
>   * run time.
>   */
> -void
> +int
>  i2c_dw_init(struct dw_i2c_dev *dev)
>  {
>  	u32 input_clock_khz;
>  	u32 hcnt, lcnt;
> -
> +	u32 reg;
>  	input_clock_khz = i2c_dw_clk_get_rate(dev);
>  
> +	/* Configure register endianess access */
> +	reg = dw_readl(dev, DW_IC_COMP_TYPE);
> +	if (reg == ___constant_swab32(DW_IC_COMP_TYPE_VALUE)) {
> +		dev->swab = 1;
> +		reg = ___constant_swab32(DW_IC_COMP_TYPE_VALUE);
> +	}
> +
> +	if (reg != DW_IC_COMP_TYPE_VALUE) {
> +		dev_err(dev->dev, "Unknown Synopsys component type: "
> +			"0x%08x\n", reg);
> +		return -ENODEV;
> +	}
> +
>  	/* Disable the adapter */
> -	writel(0, dev->base + DW_IC_ENABLE);
> +	dw_writel(dev, 0, DW_IC_ENABLE);
>  
>  	/* set standard and fast speed deviders for high/low periods */
>  

Two changes are combined into one patch, while they're separate in
the original Jean's patch.  I'd like to see Jean-san's patches as-is
as far as possible.
-- 
Shinya Kuribayashi
Renesas Electronics
