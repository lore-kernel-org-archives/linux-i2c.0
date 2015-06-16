From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [Patch v2] driver/clk/clk-si5338: Add common clock framework
 driver for si5338
Date: Tue, 16 Jun 2015 10:21:37 +0200
Message-ID: <1434442897.2069.66.camel@x220>
References: <1434388051-23814-1-git-send-email-yorksun@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434388051-23814-1-git-send-email-yorksun@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: York Sun <yorksun@freescale.com>
Cc: mturquette@baylibre.com, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Guenter Roeck <linux@roeck-us.net>, Andrey Filippov <andrey@elphel.com>
List-Id: linux-i2c@vger.kernel.org

One question and a few nits follow.

On Mon, 2015-06-15 at 10:07 -0700, York Sun wrote:
> SI5338 is a programmable clock generator. It has 4 sets of inputs,
> PLL, multisynth and dividers to make 4 outputs. This driver splits
> them into multiple clocks to comply with common clock framework.
> 
> See Documentation/devicetree/bindings/clock/silabs,si5338.txt for
> details.
> 
> Signed-off-by: York Sun <yorksun@freescale.com>
> CC: Mike Turquette <mturquette@linaro.org>

Apparently that's now mturquette@baylibre.com .

> CC: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> CC: Guenter Roeck <linux@roeck-us.net>
> CC: Andrey Filippov <andrey@elphel.com>

> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig

>  config COMMON_CLK
> -	bool
> +	tristate "Common Clock"
>  	select HAVE_CLK_PREPARE
>  	select CLKDEV_LOOKUP
>  	select SRCU

Why? The commit explanation doesn't mention this. Did you use an unclean
tree? If not, you just created over a dozen of new modules:
    $ git grep -nw CONFIG_COMMON_CLK -- "*Makefile*"
    arch/arm/mach-mmp/Makefile:13:ifeq ($(CONFIG_COMMON_CLK), )
    arch/arm/mach-shmobile/Makefile:21:ifndef CONFIG_COMMON_CLK
    arch/powerpc/platforms/512x/Makefile:4:obj-$(CONFIG_COMMON_CLK) += clock-commonclk.o
    drivers/clk/Makefile:4:obj-$(CONFIG_COMMON_CLK) += clk.o
    drivers/clk/Makefile:5:obj-$(CONFIG_COMMON_CLK) += clk-divider.o
    drivers/clk/Makefile:6:obj-$(CONFIG_COMMON_CLK) += clk-fixed-factor.o
    drivers/clk/Makefile:7:obj-$(CONFIG_COMMON_CLK) += clk-fixed-rate.o
    drivers/clk/Makefile:8:obj-$(CONFIG_COMMON_CLK) += clk-gate.o
    drivers/clk/Makefile:9:obj-$(CONFIG_COMMON_CLK) += clk-mux.o
    drivers/clk/Makefile:10:obj-$(CONFIG_COMMON_CLK)        += clk-composite.o
    drivers/clk/Makefile:11:obj-$(CONFIG_COMMON_CLK)        += clk-fractional-divider.o
    drivers/clk/Makefile:12:obj-$(CONFIG_COMMON_CLK)        += clk-gpio-gate.o
    drivers/clk/Makefile:14:obj-$(CONFIG_COMMON_CLK)        += clk-conf.o
    drivers/clk/Makefile:59:ifeq ($(CONFIG_COMMON_CLK), y)
    drivers/clk/samsung/Makefile:5:obj-$(CONFIG_COMMON_CLK) += clk.o clk-pll.o
    drivers/gpu/drm/msm/Makefile:53:msm-$(CONFIG_COMMON_CLK) += mdp/mdp4/mdp4_lvds_pll.o
    drivers/sh/Makefile:5:ifneq ($(CONFIG_COMMON_CLK),y)

> +config COMMON_CLK_SI5338
> +	tristate "Clock driver for SiLabs 5338"
> +	depends on I2C
> +	select REGMAP_I2C
> +	select RATIONAL
> +	---help---
> +	  This driver supports Silicon Labs 5338 programmable clock generators,
> +	  using common clock framework. It needs parent clock as input(s).
> +	  Internal clocks are registered with unique names in case multiple
> +	  devices exist. See devicetree/bindings/clock/silabs,si5338.txt
> +	  under Documentation for details.

> --- /dev/null
> +++ b/drivers/clk/clk-si5338.c

> +unsigned long si5338_divrefclk_recalc_rate(struct clk_hw *hw,
> +					   unsigned long parent_rate)
> +{
> +	[...]
> +}

Can't this be made static? It compiles cleanly with static too. Is there
some subtle issue I'm missing?

> +static const struct clk_ops si5338_divrefclk_ops = {
> +	.recalc_rate = si5338_divrefclk_recalc_rate,
> +};

> +unsigned long si5338_divfbclk_recalc_rate(struct clk_hw *hw,
> +					   unsigned long parent_rate)
> +{
> +	[...]
> +}

Ditto.

> +static const struct clk_ops si5338_divfbclk_ops = {
> +	.recalc_rate = si5338_divfbclk_recalc_rate,
> +};

> --- /dev/null
> +++ b/include/dt-bindings/clock/clk-si5338.h

> +#ifndef _DT_BINDINGS_CLK_DSI5338_H
> +#define _DT_BINDINGS_CLK_DSI5338_H

(I spotted a D that looks odd here.)

And git am whines:
    new blank line at EOF.

Thanks,


Paul Bolle
