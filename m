From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-gpio: Use linux/gpio.h rather than asm/gpio.h
Date: Sat, 4 Feb 2012 17:51:54 +0100
Message-ID: <20120204175154.152c8b05@endymion.delvare>
References: <1328371447-23775-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1328371447-23775-1-git-send-email-broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat,  4 Feb 2012 16:04:07 +0000, Mark Brown wrote:
> Direct inclusion of asm/gpio.h has been deprecated for a while now due
> to the cross platform gpiolib.
> 
> Signed-off-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-gpio.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
> index a651779..3397572 100644
> --- a/drivers/i2c/busses/i2c-gpio.c
> +++ b/drivers/i2c/busses/i2c-gpio.c
> @@ -15,7 +15,7 @@
>  #include <linux/slab.h>
>  #include <linux/platform_device.h>
>  
> -#include <asm/gpio.h>
> +#include <linux/gpio.h>
>  
>  /* Toggle SDA by changing the direction of the pin */
>  static void i2c_gpio_setsda_dir(void *data, int state)

Applied, thanks.

-- 
Jean Delvare
