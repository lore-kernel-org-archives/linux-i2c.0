From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: davinci: remove useless mach/hardware include
Date: Thu, 25 Jul 2013 15:10:19 +0530
Message-ID: <51F0F283.5080900@ti.com>
References: <1374712099-32095-1-git-send-email-santosh.shilimkar@ti.com> <1374712099-32095-2-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1374712099-32095-2-git-send-email-santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thursday 25 July 2013 05:58 AM, Santosh Shilimkar wrote:
> This driver no longer uses definitions from mach/hardware.h.
> On the other hand, including this header breaks this driver
> on non-davinci platforms which don't have such a header.
> 
> Fix it.
> 
> Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>

Acked-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>

One minor nit:

> ---
>  drivers/i2c/busses/i2c-davinci.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> index fa55605..ddaa2a3 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -41,7 +41,6 @@
>  #include <linux/of_i2c.h>
>  #include <linux/of_device.h>
>  

You can now remove this empty line too.

Thanks,
Sekhar

> -#include <mach/hardware.h>
>  #include <linux/platform_data/i2c-davinci.h>
>  
>  /* ----- global defines ----------------------------------------------- */
> 
