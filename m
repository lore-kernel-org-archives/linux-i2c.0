From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 2.6.27-rc3] tps65010: vibrator hookup to gpiolib
Date: Mon, 18 Aug 2008 11:19:42 +0200
Message-ID: <20080818111942.528f12a4@hyperion.delvare>
References: <200808180024.32954.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200808180024.32954.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Mon, 18 Aug 2008 00:24:32 -0700, David Brownell wrote:
> From: Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> All the tps6501{0,1,2,3,4} chips have a signal for hooking up with
> a vibrator (for non-auditory cell phone "ring") ... expose that as
> one more (output-only) GPIO.
> 
> [ dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org: comments; list tps65014 too ]
> 
> Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> ---
>  drivers/i2c/chips/tps65010.c |   12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> --- a/drivers/i2c/chips/tps65010.c	2008-07-25 12:28:08.000000000 -0700
> +++ b/drivers/i2c/chips/tps65010.c	2008-08-18 00:22:48.000000000 -0700
> @@ -456,14 +456,17 @@ static irqreturn_t tps65010_irq(int irq,
>  
>  /* offsets 0..3 == GPIO1..GPIO4
>   * offsets 4..5 == LED1/nPG, LED2 (we set one of the non-BLINK modes)
> + * offset 6 == vibrator motor driver
>   */
>  static void
>  tps65010_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
>  {
>  	if (offset < 4)
>  		tps65010_set_gpio_out_value(offset + 1, value);
> -	else
> +	else if (offset < 6)
>  		tps65010_set_led(offset - 3, value ? ON : OFF);
> +	else
> +		tps65010_set_vib(value);
>  }
>  
>  static int
> @@ -477,8 +480,10 @@ tps65010_output(struct gpio_chip *chip, 
>  		if (!(tps->outmask & (1 << offset)))
>  			return -EINVAL;
>  		tps65010_set_gpio_out_value(offset + 1, value);
> -	} else
> +	} else if (offset < 6)
>  		tps65010_set_led(offset - 3, value ? ON : OFF);
> +	else
> +		tps65010_set_vib(value);
>  
>  	return 0;
>  }
> @@ -646,7 +651,7 @@ static int tps65010_probe(struct i2c_cli
>  		tps->chip.get = tps65010_gpio_get;
>  
>  		tps->chip.base = board->base;
> -		tps->chip.ngpio = 6;
> +		tps->chip.ngpio = 7;
>  		tps->chip.can_sleep = 1;
>  
>  		status = gpiochip_add(&tps->chip);
> @@ -675,6 +680,7 @@ static const struct i2c_device_id tps650
>  	{ "tps65011", TPS65011 },
>  	{ "tps65012", TPS65012 },
>  	{ "tps65013", TPS65013 },
> +	{ "tps65014", TPS65011 },	/* tps65011 charging at 6.5V max */
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, tps65010_id);

Applied, thanks. I'm a bit worried that Marek's Signed-off-by is
missing though.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
