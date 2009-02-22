From: Russell King <rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH] i2c: Make sure i2c_algo_bit_data.timeout is HZ-independent
Date: Sun, 22 Feb 2009 12:03:56 +0000
Message-ID: <20090222120356.GA20820@flint.arm.linux.org.uk>
References: <20090222125005.75b2d661@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090222125005.75b2d661-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lennert Buytenhek <kernel-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org>, Len Sorensen <lsorense-1wCw9BSqJbv44Nm34jS7GywD8/FfD2ys@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, Feb 22, 2009 at 12:50:05PM +0100, Jean Delvare wrote:
> i2c_algo_bit_data.timeout is supposed to be in jiffies, so drivers
> should use set this value in terms of HZ.
> 
> Ultimately I think this field should be discarded in favor of
> i2c_adapter.timeout, but that's left for a future patch.
> 
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

Thanks.

Acked-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>

> Cc: Lennert Buytenhek <kernel-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org>
> Cc: Len Sorensen <lsorense-1wCw9BSqJbv44Nm34jS7GywD8/FfD2ys@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-acorn.c   |    2 +-
>  drivers/i2c/busses/i2c-ixp2000.c |    2 +-
>  drivers/i2c/busses/scx200_i2c.c  |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> --- linux-2.6.29-rc5.orig/drivers/i2c/busses/scx200_i2c.c	2009-02-22 12:32:33.000000000 +0100
> +++ linux-2.6.29-rc5/drivers/i2c/busses/scx200_i2c.c	2009-02-22 12:32:45.000000000 +0100
> @@ -76,7 +76,7 @@ static struct i2c_algo_bit_data scx200_i
>  	.getsda		= scx200_i2c_getsda,
>  	.getscl		= scx200_i2c_getscl,
>  	.udelay		= 10,
> -	.timeout	= 100,
> +	.timeout	= HZ,
>  };
>  
>  static struct i2c_adapter scx200_i2c_ops = {
> --- linux-2.6.29-rc5.orig/drivers/i2c/busses/i2c-acorn.c	2009-02-22 12:32:33.000000000 +0100
> +++ linux-2.6.29-rc5/drivers/i2c/busses/i2c-acorn.c	2009-02-22 12:32:45.000000000 +0100
> @@ -79,7 +79,7 @@ static struct i2c_algo_bit_data ioc_data
>  	.getsda		= ioc_getsda,
>  	.getscl		= ioc_getscl,
>  	.udelay		= 80,
> -	.timeout	= 100
> +	.timeout	= HZ,
>  };
>  
>  static struct i2c_adapter ioc_ops = {
> --- linux-2.6.29-rc5.orig/drivers/i2c/busses/i2c-ixp2000.c	2009-02-22 12:32:33.000000000 +0100
> +++ linux-2.6.29-rc5/drivers/i2c/busses/i2c-ixp2000.c	2009-02-22 12:32:45.000000000 +0100
> @@ -114,7 +114,7 @@ static int ixp2000_i2c_probe(struct plat
>  	drv_data->algo_data.getsda = ixp2000_bit_getsda;
>  	drv_data->algo_data.getscl = ixp2000_bit_getscl;
>  	drv_data->algo_data.udelay = 6;
> -	drv_data->algo_data.timeout = 100;
> +	drv_data->algo_data.timeout = HZ;
>  
>  	strlcpy(drv_data->adapter.name, plat_dev->dev.driver->name,
>  		sizeof(drv_data->adapter.name));
> 
> 
> -- 
> Jean Delvare

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
