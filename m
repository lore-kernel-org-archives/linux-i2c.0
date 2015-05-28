From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] i2c: busses: i2c-bcm2835: limits cdiv to allowed values
Date: Thu, 28 May 2015 14:17:19 -0600
Message-ID: <556777CF.6010808@wwwdotorg.org>
References: <1432283811-22226-1-git-send-email-linux_wi@tinag.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432283811-22226-1-git-send-email-linux_wi-ADq4ffItWIY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "s. wicki" <linux_wi-ADq4ffItWIY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 05/22/2015 02:36 AM, s. wicki wrote:
> fixes:	round down divider instead of incrementing
> adds:	make sure bits 16-31 of cdiv register are always 0
> adds:	assume minimal divider of 2 if divider resulted in 0
> 	(bcm2835 sets divider to 32768 if cdiv is set to 0)

Do you have a reference to a specific document and section? That'd be 
good to include in the commit description for future reference.

> Signed-off-by: s. wicki <linux_wi-ADq4ffItWIY@public.gmane.org>

Using your full name rather than an abbreviation is preferred.

You didn't send this pach to the I2C maintainer so I imagine he won't 
see it and hence it won't be applied.

It'd also be a good idea to send this to the Raspberry Pi mailing list, 
linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XZu6nac5fYnt@public.gmane.org


> diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
> +#define BCM2835_I2C_CDIV_MIN	0x0002
> +#define BCM2835_I2C_CDIV_MAX	0xFFFE
> +#define BCM2835_I2C_CDIV_BITMSK	0xFFFE

>   	divider = DIV_ROUND_UP(clk_get_rate(i2c_dev->clk), bus_clk_rate);
> -	/*
> -	 * Per the datasheet, the register is always interpreted as an even
> -	 * number, by rounding down. In other words, the LSB is ignored. So,
> -	 * if the LSB is set, increment the divider to avoid any issue.
> -	 */
> -	if (divider & 1)
> -		divider++;

The old code used to round the divider up in the case where the LSB was 
set. This ensures that the I2C clock rate is no faster than what was 
requested.

> +	if (divider == 0) {
> +		/*
> +		 * divider results in 0 by extremely high bus_clk_rate values
> +		 * such as bus_clk_rate >= 4044967297 and core_clock = 250MHz.
> +		 * In such a case assume the minimal possible divider since
> +		 * bcm2835 chip sets divisor internally to 32768 if cdiv is 0.
> +		 */
> +		divider = BCM2835_I2C_CDIV_MIN;

What about when divider == 1? Shouldn't that if condition be:

if (divider < BCM2835_I2C_CDIV_MIN)

?

> +	} else {
> +		/* check if divider meets certain bcm2835 specific criterias */
> +		if ((divider & BCM2835_I2C_CDIV_BITMSK) != divider) {
> +			if (divider > BCM2835_I2C_CDIV_MAX)
> +				/*
> +				 * Per the datasheet it must be made sure
> +				 * that bits 16-31 are set to 0. If that is
> +				 * not the case, then set to the maximum
> +				 * allowed value.
> +				 */
> +				divider = BCM2835_I2C_CDIV_MAX;
> +			else
> +				/*
> +				 * Per datasheet the cdiv is always rounded
> +				 * down to an even number. Bitmask takes care
> +				 * of this and clears the LSB
> +				 */

The datasheet describes how the HW interprets the register value (by 
ignoring the LSB). It doesn't say how SW must program the register. In 
other words, SW should round up, to avoid HW rounding down. It's not 
mandatory for SW to round down.

> +				divider &= BCM2835_I2C_CDIV_BITMSK;
> +		}
> +	}
>   	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DIV, divider);
>
>   	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);

I think this would be better as:

if (divider < BCM2835_I2C_CDIV_MIN)
     divider = BCM2835_I2C_CDIV_MIN;
if (divider & 1)
     divider++;
if (divider > BCM2835_I2C_CDIV_MAX)
     divider = BCM2835_I2C_CDIV_MAX;
