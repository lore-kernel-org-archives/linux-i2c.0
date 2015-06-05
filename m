From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v2] i2c: busses: i2c-bcm2835: limits cdiv to allowed values
Date: Thu, 04 Jun 2015 21:10:21 -0600
Message-ID: <5571131D.7060100@wwwdotorg.org>
References: <1432895204-19924-1-git-send-email-linux_wi@tinag.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432895204-19924-1-git-send-email-linux_wi-ADq4ffItWIY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Silvan Wicki <linux_wi-ADq4ffItWIY@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 05/29/2015 04:26 AM, Silvan Wicki wrote:
> Adds: make sure bits 16-31 of DIV register are always 0
> Adds: assume minimal divider of 2 if divider resulted in 0
>       (bcm2835 sets divider to 32768 if cdiv is set to 0)
> 
> See page 33/34 of BCM2835-ARM-Peripherals.pdf for the DIV register.
> https://www.raspberrypi.org/wp-content/uploads/2012/02/BCM2835-ARM-Peripherals.pdf

> diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c

> @@ -252,12 +255,22 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
>  
>  	divider = DIV_ROUND_UP(clk_get_rate(i2c_dev->clk), bus_clk_rate);
>  	/*
> +	 * Divider results in 0 by extremely high bus_clk_rate values
> +	 * such as bus_clk_rate >= 4044967297 and core_clock = 250MHz.
> +	 * In such a case assume the minimal possible divider since
> +	 * bcm2835 chip sets divisor internally to 32768 if cdiv is 0.
> +	 */

I would rephrase that as:

	/*
	 * A divider of0 results in extremely high bus_clk_rate values
	 * such as bus_clk_rate >= 4044967297 with core_clock = 250MHz.
	 * In such a case assume the minimal possible divider, since
	 * bcm2835 chip sets divisor internally to 32768 if cdiv is 0.
	 */

> +	if (divider < BCM2835_I2C_CDIV_MIN)
> +		divider = BCM2835_I2C_CDIV_MIN;

This seems reasonable; if the calculated divider is too small, then it
means we can't run the clock that fas. Running it more slowly loses some
performance, but should work fine. I might suggest a dev_info() or
dev_dbg() here.

> +	/*
>  	 * Per the datasheet, the register is always interpreted as an even
>  	 * number, by rounding down. In other words, the LSB is ignored. So,
>  	 * if the LSB is set, increment the divider to avoid any issue.
>  	 */
>  	if (divider & 1)
>  		divider++;
> +	if (divider > BCM2835_I2C_CDIV_MAX)
> +		divider = BCM2835_I2C_CDIV_MAX;

I think this should be an error. If the calculated divider is too large,
it means we want to run the clock slower than we can. If we run the
clock faster than requested, the clock rate might exceed the attached
I2C devices' capabilities (otherwise, why would we want such a slow
clock?). As such, I'd suggest a dev_err() here, and to fail the probe()
by returning an error.

I'd echo Eric's question: I'm curious whether this patch solves a
real-world problem, or if you found it by code inspection?
