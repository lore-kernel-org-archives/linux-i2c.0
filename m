From: Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V3 2/4] drivers/i2c/busses/i2c-at91.c: add new driver
Date: Wed, 09 Nov 2011 10:58:15 +1100
Message-ID: <4EB9C217.1010100@gmail.com>
References: <cover.1320753142.git.n.voss@weinmann.de> <7bdd6b456b0e055441cb25634c8cb6d483718f6c.1320753142.git.n.voss@weinmann.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7bdd6b456b0e055441cb25634c8cb6d483718f6c.1320753142.git.n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nikolaus Voss <n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 08/11/11 21:49, Nikolaus Voss wrote:

> This driver has the following properties compared to the old driver:
> 1. Support for multiple interfaces.
> 2. Interrupt driven I/O as opposed to polling/busy waiting.
> 3. Support for _one_ repeated start (Sr) condition, which is enough
>    for most real-world applications including all SMBus transfer types.
>    (The hardware does not support issuing arbitrary Sr conditions on the
>     bus.)
> 
> Tested on Atmel G45 with BQ20Z80 battery SMBus client.
> 
> Signed-off-by: Nikolaus Voss <n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>

<snip>

> +	dev->clk = clk_get(&pdev->dev, "twi_clk");
> +	if (IS_ERR(dev->clk)) {
> +		dev_err(&pdev->dev, "no clock defined\n");
> +		rc = -ENODEV;
> +		goto err_free_mem;
> +	}
> +	clk_enable(dev->clk);


There are now dummy clk_prepare/unprepare functions in
include/linux/clk.h, so you should be using them in this driver to
future proof it.

~Ryan
