From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 3/7] i2c: export bit-banging algo functions
Date: Mon, 27 Feb 2012 23:20:40 +0100
Message-ID: <20120227232040.0476d508@endymion.delvare>
References: <1329255445-6312-1-git-send-email-daniel.vetter@ffwll.ch>
	<1329255445-6312-3-git-send-email-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1329255445-6312-3-git-send-email-daniel.vetter-/w4YWyX8dFk@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>
Cc: Intel Graphics Development <intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, DRI Development <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Daniel,

Sorry for the late reply.

On Tue, 14 Feb 2012 22:37:21 +0100, Daniel Vetter wrote:
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

You could use the pre_xfer and post_xfer hooks together with a shared
mutex to solve the problem. But I agree its much cleaner to expose a
single adapter in the first place.

If you need to hot-switch between hardware and bit-banged I2C, I suggest
that you lock the bus while doing so, to avoid switching while a
transaction is in progress. This can be achieved with
i2c_lock_adapter() and i2c_unlock_adapter().

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

I have no problem with this in the principle. In the details, I don't
understand why you don't simply export i2c_bit_algo? This is one fewer
export and should serve the same purpose - even allowing faster
initializations in some cases.

Looking a bit more to the i2c-algo-bit code, I also notice that
bypassing i2c_bit_add_bus() means you'll miss some of its features,
namely bus testing, default retries value and warning on non-compliant
buses. While none of these are mandatory, it may make sense to export a
new function i2c_bit_add_numbered_bus() which would call
__i2c_bit_add_bus() with no callback function. If you do that, you may
not have to export anything else.

I leave it up to you which way you want to implement it, all are fine
with me, and we can always change later if more use cases show up which
would work better with a different implementation.

-- 
Jean Delvare
