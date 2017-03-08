From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 04/12] i2c: meson: use full 12 bits for clock divider
Date: Wed, 08 Mar 2017 10:19:38 +0100
Message-ID: <1488964778.2514.9.camel@baylibre.com>
References: <d5f0545a-fb4c-b436-20f5-7df9d10605b1@gmail.com>
         <0ea5a778-8769-50c2-35de-7136b6b407b6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36559 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbdCHJUV (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 8 Mar 2017 04:20:21 -0500
Received: by mail-wm0-f52.google.com with SMTP id n11so109732314wma.1
        for <linux-i2c@vger.kernel.org>; Wed, 08 Mar 2017 01:19:40 -0800 (PST)
In-Reply-To: <0ea5a778-8769-50c2-35de-7136b6b407b6@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-amlogic@lists.infradead.org, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On Wed, 2017-03-08 at 07:44 +0100, Heiner Kallweit wrote:
> The clock divider has 12 bits, splitted into a 10 bit field and a
> 2 bit field. The extra 2 bits aren't used currently.
> 
> Change this to use the full 12 bits and warn if the requested
> frequency is too low.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/i2c/busses/i2c-meson.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
> index 5e243efa..a5764be5 100644
> --- a/drivers/i2c/busses/i2c-meson.c
> +++ b/drivers/i2c/busses/i2c-meson.c
> @@ -35,7 +35,9 @@
>  #define REG_CTRL_STATUS		BIT(2)
>  #define REG_CTRL_ERROR		BIT(3)
>  #define REG_CTRL_CLKDIV_SHIFT	12
> -#define REG_CTRL_CLKDIV_MASK	((BIT(10) - 1) << REG_CTRL_CLKDIV_SHIFT)
> +#define REG_CTRL_CLKDIV_MASK	GENMASK(21, 12)
> +#define REG_CTRL_CLKDIVEXT_SHIFT 28
> +#define REG_CTRL_CLKDIVEXT_MASK	GENMASK(29, 28)
>  
>  #define I2C_TIMEOUT_MS		500
>  
> @@ -136,8 +138,15 @@ static void meson_i2c_set_clk_div(struct meson_i2c *i2c)
>  	unsigned int div;
>  
>  	div = DIV_ROUND_UP(clk_rate, i2c->timings.bus_freq_hz * 4);
> +
> +	/* clock divider has 12 bits */
> +	WARN_ON(div >= (1 << 12));
> +
>  	meson_i2c_set_mask(i2c, REG_CTRL, REG_CTRL_CLKDIV_MASK,
> -			   div << REG_CTRL_CLKDIV_SHIFT);
> +			   (div & GENMASK(9, 0)) << REG_CTRL_CLKDIV_SHIFT);
> +
> +	meson_i2c_set_mask(i2c, REG_CTRL, REG_CTRL_CLKDIVEXT_MASK,
> +			   (div >> 10) << REG_CTRL_CLKDIVEXT_SHIFT);
>  
>  	dev_dbg(i2c->dev, "%s: clk %lu, freq %u, div %u\n", __func__,
>  		clk_rate, i2c->timings.bus_freq_hz, div);

Acked-by: Jerome Brunet <jbrunet@baylibre.com>
