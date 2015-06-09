From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v4] i2c: busses: i2c-bcm2835: limits cdiv to allowed values
Date: Mon, 08 Jun 2015 19:48:25 -0600
Message-ID: <557645E9.4040700@wwwdotorg.org>
References: <1433614726-1737-1-git-send-email-linux_wi@tinag.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1433614726-1737-1-git-send-email-linux_wi-ADq4ffItWIY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Silvan Wicki <linux_wi-ADq4ffItWIY@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 06/06/2015 12:18 PM, Silvan Wicki wrote:
> Adds: make sure bits 16-31 of DIV register are always 0
> Adds: assume minimal divider of 2 if divider resulted in 0
>       (bcm2835 sets divider to 32768 if cdiv is set to 0)
> 
> See page 33/34 of BCM2835-ARM-Peripherals.pdf for the DIV register.
> https://www.raspberrypi.org/wp-content/uploads/2012/02/BCM2835-ARM-Peripherals.pdf

> diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c

> @@ -252,12 +255,28 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)

> +	if (divider > BCM2835_I2C_CDIV_MAX) {
> +		dev_warn(&pdev->dev,
> +			 "Clock too slow, falling back to min clock speed\n");
> +		divider = BCM2835_I2C_CDIV_MAX;
> +	}
>  	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DIV, divider);

Shouldn't this be an error? i.e. dev_err() not dev_warn(), and return an
error code.

If the divider that's required to reach the requested clock is higher
than the HW can implement, that means the actual clock will be faster
than the requested clock. Presumably there's a reason the specific slow
rate was requested, and if we exceed it, there will be problems.
