From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 01/15] i2c/busses: Add Device Tree support to the Nomadik I2C driver
Date: Fri, 4 May 2012 20:02:20 +0000
Message-ID: <201205042002.20943.arnd@arndb.de>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org> <1336155805-18554-2-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1336155805-18554-2-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Friday 04 May 2012, Lee Jones wrote:
> +static const struct nmk_i2c_controller *
> +nmk_i2c_find_pdata_from_compatible(struct device_node *np)
> +{
> +       /*
> +        * The u8500 is currently our only user. As more SoCs are added,
> +        * search for the correct value set using of_machine_is_compatible
> +        * and return a 'struct nmk_i2c_controller *' which contains the
> +        * correct information for the given SoC, whilst leaving u8500_i2c
> +        * as the default/fall-back value set.
> +        */
> +       return &u8500_i2c;
> +}

Why not just put this pointer ...

> +static const struct of_device_id nmk_gpio_match[] = {
> +       { .compatible = "st,nomadik-i2c", },
> +       {}
> +};

into the .data field after the .compatible match, and make it more specific
to the soc, i.e.

static const struct of_device_id nmk_gpio_match[] = {
	{ .compatible = "st-ericsson,u8500-i2c", .data = &u8500_i2c },
	{ .compatible = "st,nomadik-i2c", .data = &default_i2c_controller },
};

	Arnd
