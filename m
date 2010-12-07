From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-algo-bit: Refactor adapter registration
Date: Tue, 7 Dec 2010 11:51:31 +0000
Message-ID: <20101207115131.GM20097@trinity.fluff.org>
References: <20101207110631.6222cfed@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20101207110631.6222cfed-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Dec 07, 2010 at 11:06:31AM +0100, Jean Delvare wrote:
> Use a function pointer to decide whether to call i2c_add_adapter or
> i2c_add_numbered_adapter. This makes the code more compact than the
> current strategy of having the common code in a separate function.

ok, how about changing i2c_add_numbered_adapter to take a -1 to mean
assign bus number automatically? or something similar?
 
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/i2c/algos/i2c-algo-bit.c |   21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
> 
> --- linux-2.6.37-rc5.orig/drivers/i2c/algos/i2c-algo-bit.c	2010-12-07 10:13:49.000000000 +0100
> +++ linux-2.6.37-rc5/drivers/i2c/algos/i2c-algo-bit.c	2010-12-07 11:02:38.000000000 +0100
> @@ -600,7 +600,8 @@ static const struct i2c_algorithm i2c_bi
>  /*
>   * registering functions to load algorithms at runtime
>   */
> -static int i2c_bit_prepare_bus(struct i2c_adapter *adap)
> +static int __i2c_bit_add_bus(struct i2c_adapter *adap,
> +			     int (*add_adapter)(struct i2c_adapter *))
>  {
>  	struct i2c_algo_bit_data *bit_adap = adap->algo_data;
>  
> @@ -614,30 +615,18 @@ static int i2c_bit_prepare_bus(struct i2
>  	adap->algo = &i2c_bit_algo;
>  	adap->retries = 3;
>  
> -	return 0;
> +	return add_adapter(adap);
>  }
>  
>  int i2c_bit_add_bus(struct i2c_adapter *adap)
>  {
> -	int err;
> -
> -	err = i2c_bit_prepare_bus(adap);
> -	if (err)
> -		return err;
> -
> -	return i2c_add_adapter(adap);
> +	return __i2c_bit_add_bus(adap, i2c_add_adapter);
>  }
>  EXPORT_SYMBOL(i2c_bit_add_bus);
>  
>  int i2c_bit_add_numbered_bus(struct i2c_adapter *adap)
>  {
> -	int err;
> -
> -	err = i2c_bit_prepare_bus(adap);
> -	if (err)
> -		return err;
> -
> -	return i2c_add_numbered_adapter(adap);
> +	return __i2c_bit_add_bus(adap, i2c_add_numbered_adapter);
>  }
>  EXPORT_SYMBOL(i2c_bit_add_numbered_bus);
>  
> 
> 
> -- 
> Jean Delvare
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
