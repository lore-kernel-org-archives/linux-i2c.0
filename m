From: lsorense-1wCw9BSqJbv44Nm34jS7GywD8/FfD2ys@public.gmane.org (Lennart Sorensen)
Subject: Re: [PATCH] i2c: Make sure i2c_algo_bit_data.timeout is
	HZ-independent
Date: Mon, 23 Feb 2009 10:00:12 -0500
Message-ID: <20090223150012.GD23244@csclub.uwaterloo.ca>
References: <20090222125005.75b2d661@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090222125005.75b2d661-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Lennert Buytenhek <kernel-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, Feb 22, 2009 at 12:50:05PM +0100, Jean Delvare wrote:
> i2c_algo_bit_data.timeout is supposed to be in jiffies, so drivers
> should use set this value in terms of HZ.
> 
> Ultimately I think this field should be discarded in favor of
> i2c_adapter.timeout, but that's left for a future patch.
> 
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
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

OK.  Well I know the driver has worked for me with both HZ=100 and now
HZ=1000, so making it consistent sounds good to me.  I think a lot of
people thought it was in microseconds or miliseconds.

-- 
Len Sorensen
