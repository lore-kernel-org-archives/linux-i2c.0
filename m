From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: PNX4008: fix i2c-pnx.c build errors
Date: Fri, 20 Nov 2009 14:21:29 +0000
Message-ID: <20091120142128.GE4808@trinity.fluff.org>
References: <20091120135932.GA16920@n2100.arm.linux.org.uk> <f639bcd4278415ccf72dbc3b602670ac4dab040d.1258725164.git.rmk+kernel@arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f639bcd4278415ccf72dbc3b602670ac4dab040d.1258725164.git.rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Nov 20, 2009 at 11:03:29AM +0000, Russell King - ARM Linux wrote:
> ... caused by a missing include.

hi, thought this was fixed by the last fix set I sent which went in post
2.6.32-rc8.
 
> Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-pnx.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
> index 6ff6c20..3ae5647 100644
> --- a/drivers/i2c/busses/i2c-pnx.c
> +++ b/drivers/i2c/busses/i2c-pnx.c
> @@ -22,6 +22,7 @@
>  #include <mach/hardware.h>
>  #include <asm/irq.h>
>  #include <asm/uaccess.h>
> +#include <mach/i2c.h>
>  
>  #define I2C_PNX_TIMEOUT		10 /* msec */
>  #define I2C_PNX_SPEED_KHZ	100
> -- 
> 1.6.2.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
