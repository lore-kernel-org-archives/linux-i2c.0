From: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Subject: Re: [PATCH 3/7] i2c: export bit-banging algo functions
Date: Mon, 27 Feb 2012 18:27:27 +0100
Message-ID: <20120227172727.GH4866@phenom.ffwll.local>
References: <1329255445-6312-1-git-send-email-daniel.vetter@ffwll.ch>
 <1329255445-6312-3-git-send-email-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1329255445-6312-3-git-send-email-daniel.vetter-/w4YWyX8dFk@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Intel Graphics Development <intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: DRI Development <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

Can you please review and if you don't have any objectsion, ack this patch
for merging through drm-intel-next? Imo that's the easiest way to merge
this series.

Thanks, Daniel

On Tue, Feb 14, 2012 at 10:37:21PM +0100, Daniel Vetter wrote:
> i915 has a hw i2c controller (gmbus) but for a bunch of stupid reasons
> we need to be able to fall back to the bit-banging algo on gpio pins.
> 
> The current code sets up a 2nd i2c controller for the same i2c bus using
> the bit-banging algo. This has a bunch of issues, the major one being
> that userspace can directly access this fallback i2c adaptor behind
> the drivers back.
> 
> But we need to frob a few registers before and after using fallback
> gpio bit-banging, so this horribly fails.
> 
> The new plan is to only set up one i2c adaptor and transparently fall
> back to bit-banging by directly calling the xfer function of the bit-
> banging algo in the i2c core.
> 
> To make that possible, export the 2 i2c algo functions.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>
> ---
>  drivers/i2c/algos/i2c-algo-bit.c |   12 +++++++-----
>  include/linux/i2c-algo-bit.h     |    4 ++++
>  2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
> index 525c734..ec1651a 100644
> --- a/drivers/i2c/algos/i2c-algo-bit.c
> +++ b/drivers/i2c/algos/i2c-algo-bit.c
> @@ -531,8 +531,8 @@ static int bit_doAddress(struct i2c_adapter *i2c_adap, struct i2c_msg *msg)
>  	return 0;
>  }
>  
> -static int bit_xfer(struct i2c_adapter *i2c_adap,
> -		    struct i2c_msg msgs[], int num)
> +int i2c_bit_xfer(struct i2c_adapter *i2c_adap,
> +		 struct i2c_msg msgs[], int num)
>  {
>  	struct i2c_msg *pmsg;
>  	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
> @@ -598,21 +598,23 @@ bailout:
>  		adap->post_xfer(i2c_adap);
>  	return ret;
>  }
> +EXPORT_SYMBOL(i2c_bit_xfer);
>  
> -static u32 bit_func(struct i2c_adapter *adap)
> +u32 i2c_bit_func(struct i2c_adapter *adap)
>  {
>  	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL |
>  	       I2C_FUNC_SMBUS_READ_BLOCK_DATA |
>  	       I2C_FUNC_SMBUS_BLOCK_PROC_CALL |
>  	       I2C_FUNC_10BIT_ADDR | I2C_FUNC_PROTOCOL_MANGLING;
>  }
> +EXPORT_SYMBOL(i2c_bit_func);
>  
>  
>  /* -----exported algorithm data: -------------------------------------	*/
>  
>  static const struct i2c_algorithm i2c_bit_algo = {
> -	.master_xfer	= bit_xfer,
> -	.functionality	= bit_func,
> +	.master_xfer	= i2c_bit_xfer,
> +	.functionality	= i2c_bit_func,
>  };
>  
>  /*
> diff --git a/include/linux/i2c-algo-bit.h b/include/linux/i2c-algo-bit.h
> index 4f98148..cdd6336 100644
> --- a/include/linux/i2c-algo-bit.h
> +++ b/include/linux/i2c-algo-bit.h
> @@ -47,6 +47,10 @@ struct i2c_algo_bit_data {
>  	int timeout;		/* in jiffies */
>  };
>  
> +int i2c_bit_xfer(struct i2c_adapter *i2c_adap,
> +		 struct i2c_msg msgs[], int num);
> +u32 i2c_bit_func(struct i2c_adapter *adap);
> +
>  int i2c_bit_add_bus(struct i2c_adapter *);
>  int i2c_bit_add_numbered_bus(struct i2c_adapter *);
>  
> -- 
> 1.7.7.5
> 

-- 
Daniel Vetter
Mail: daniel-/w4YWyX8dFk@public.gmane.org
Mobile: +41 (0)79 365 57 48
