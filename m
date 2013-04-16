From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v5 1/3] i2c: mux: Add i2c-arb-gpio-challenge 'mux' driver
Date: Tue, 16 Apr 2013 11:36:33 +0200
Message-ID: <20130416093633.GC16978@the-dreams.de>
References: <1363192583-26363-1-git-send-email-dianders@chromium.org>
 <1365543270-10736-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1365543270-10736-1-git-send-email-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, yuvaraj.cd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, girish.shivananjappa-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, bhushan.r-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sreekumar.c-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, prashanth.g-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Doug,

On Tue, Apr 09, 2013 at 02:34:28PM -0700, Doug Anderson wrote:
> The i2c-arb-gpio-challenge driver implements an I2C arbitration scheme
> where masters need to claim the bus with a GPIO before they can start
> a transcation.  This should generally only be used when standard I2C
> multimaster isn't appropriate for some reason (errata/bugs).
> 
> This driver is based on code that Simon Glass added to the i2c-s3c2410
> driver in the Chrome OS kernel 3.4 tree.  The current incarnation as a
> mux driver is as suggested by Grant Likely.  See
> <https://patchwork.kernel.org/patch/1877311/> for some history.
> 
> Signed-off-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Reviewed-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Mostly good, except for some documentation updates.

> diff --git a/Documentation/devicetree/bindings/i2c/i2c-arb-gpio-challenge.txt b/Documentation/devicetree/bindings/i2c/i2c-arb-gpio-challenge.txt
> new file mode 100644
> index 0000000..726e099
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-arb-gpio-challenge.txt
> @@ -0,0 +1,80 @@
> +GPIO-based I2C Arbitration
> +==========================
> +This uses GPIO lines to arbitrate who is the master of an I2C bus in a
> +multimaster situation.

"uses GPIO lines and a challange & response mechanism" or something like
that. There might be other GPIO based arbitrations in the future (though
I hope there won't).

> +
> +In many cases using GPIOs to arbitrate is not needed and a design can use
> +the standard I2C multi-master rules.  Using GPIOs is generally useful in
> +the case where there is a device on the bus that has errata and/or bugs
> +that makes standard multimaster mode not feasible.

I like this paragraph!

...

> +- their-claim-gpios: The GPIOs that the other sides use the claim the bus.
> +  Note that some implementations may only support a single other master.

Stronger? "Currently, only one other master is supported"?

...

> diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
> index 0be5b83..ab4dcaf 100644
> --- a/drivers/i2c/muxes/Kconfig
> +++ b/drivers/i2c/muxes/Kconfig
> @@ -5,6 +5,17 @@
>  menu "Multiplexer I2C Chip support"
>  	depends on I2C_MUX
>  
> +config I2C_ARB_GPIO_CHALLENGE
> +	tristate "GPIO-based I2C arbitration"
> +	depends on GENERIC_GPIO && OF
> +	help
> +	  If you say yes to this option, support will be included for an
> +	  I2C multimaster arbitration scheme using GPIOs where masters have
> +	  to claim the bus by asserting a GPIO.

"callenge & response"?

...

> diff --git a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
> new file mode 100644
> index 0000000..bda020a
> --- /dev/null
> +++ b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
> @@ -0,0 +1,252 @@
> +/*
> + * GPIO-based I2C Arbitration

"callenge & response"?

...

> + *
> + * Copyright (C) 2012 Google, Inc
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/kernel.h>
> +#include <linux/i2c.h>
> +#include <linux/i2c-mux.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/of_i2c.h>
> +#include <linux/of_gpio.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +
> +/**
> + * struct i2c_arbitrator_data - Driver data for I2C arbitrator
> + *
> + * @parent: Parent adapter
> + * @child: Child bus
> + * @our_gpio: GPIO we'll use to claim.
> + * @our_gpio_release: 0 if active high; 1 if active low; AKA if the GPIO ==
> + *   this then consider it released.
> + * @their_gpio: GPIO that the other side will use to claim.
> + * @their_gpio_release: 0 if active high; 1 if active low; AKA if the GPIO ==
> + *   this then consider it released.
> + * @slew_delay_us: microseconds to wait for a GPIO to go high.
> + * @wait_retry_us: we'll attempt another claim after this many microseconds.
> + * @wait_free_us: we'll give up after this many microseconds.
> + */
> +
> +struct i2c_arbitrator_data {
> +	struct i2c_adapter *parent;
> +	struct i2c_adapter *child;
> +

No empty line.

> +	int		our_gpio;
> +	int		our_gpio_release;
> +	int		their_gpio;
> +	int		their_gpio_release;
> +	unsigned int	slew_delay_us;
> +	unsigned int	wait_retry_us;
> +	unsigned int	wait_free_us;
> +};

Single space as indentaion after "int".

Other than that, looks fine to me.

Thanks!
