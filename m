From: Shinya Kuribayashi <skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 01/10] i2c-designware: Allow mixed endianness accesses
Date: Thu, 10 Feb 2011 00:34:54 +0900
Message-ID: <4D52B41E.5040006@pobox.com>
References: <1296699608-13227-1-git-send-email-dirk.brandewie@gmail.com>
 <1296699608-13227-2-git-send-email-dirk.brandewie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1296699608-13227-2-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alan.cox-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 02/03/2011 11:19 AM, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> @@ -283,13 +305,27 @@ static u32 i2c_dw_scl_lcnt(u32 ic_clk, u32 tLOW, u32 tf, int offset)
>   * This function is called during I2C init function, and in case of timeout at
>   * run time.
>   */
> -static void i2c_dw_init(struct dw_i2c_dev *dev)
> +static int i2c_dw_init(struct dw_i2c_dev *dev)
>  {
>  	u32 input_clock_khz = clk_get_rate(dev->clk) / 1000;
>  	u32 ic_con, hcnt, lcnt;
> +	u32 reg;
> +
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

In the original Jean's patch, this 'swab' detection was done early in
dw_i2c_probe() funtion, but this patch moved it to i2c_dw_init(), and
therefore the function prototype of i2c_dw_init() also changed.

I agree with that change itself, so let's make it a separate patch.

- it would be nice that such hardware probing/initialization routines
  are consolidated in one place,

- swab detection using the IC_COMP_TYPE register must be performed
  prior to any other register accesses,

- i2c_dw_init() function prototype is also changed to notify
  dw_i2c_probe() of "Unknown Synopsys component type" error.

  Shinya
