From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c: eg20t: include slab.h for memory allocations
Date: Wed, 2 Feb 2011 22:24:22 +0000
Message-ID: <20110202222422.GX15795@trinity.fluff.org>
References: <1296672461-22822-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1296672461-22822-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Feb 02, 2011 at 07:47:41PM +0100, Wolfram Sang wrote:
> Fixes (with v2.6.38-rc3/parisc/parisc-allmodconfig):
>   src/drivers/i2c/busses/i2c-eg20t.c:720: error: implicit declaration of function 'kzalloc'
>   src/drivers/i2c/busses/i2c-eg20t.c:790: error: implicit declaration of function 'kfree'
> 
> Reported-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>

ok, will pick this one up.

> ---
>  drivers/i2c/busses/i2c-eg20t.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
> index 2e067dd..50ea1f4 100644
> --- a/drivers/i2c/busses/i2c-eg20t.c
> +++ b/drivers/i2c/busses/i2c-eg20t.c
> @@ -29,6 +29,7 @@
>  #include <linux/pci.h>
>  #include <linux/mutex.h>
>  #include <linux/ktime.h>
> +#include <linux/slab.h>
>  
>  #define PCH_EVENT_SET	0	/* I2C Interrupt Event Set Status */
>  #define PCH_EVENT_NONE	1	/* I2C Interrupt Event Clear Status */
> -- 
> 1.7.2.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
