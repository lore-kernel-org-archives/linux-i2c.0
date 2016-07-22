From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: i801: use IS_ENABLED() instead of checking for
 built-in or module
Date: Fri, 22 Jul 2016 12:00:31 +0200
Message-ID: <20160722120031.7a160b6d@endymion>
References: <1469117461-14764-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38328 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753788AbcGVKAf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 22 Jul 2016 06:00:35 -0400
In-Reply-To: <1469117461-14764-1-git-send-email-javier@osg.samsung.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

On Thu, 21 Jul 2016 12:11:01 -0400, Javier Martinez Canillas wrote:
> The IS_ENABLED() macro checks if a Kconfig symbol has been enabled either
> built-in or as a module, use that macro instead of open coding the same.
> 
> Using the macro makes the code more readable by helping abstract away some
> of the Kconfig built-in and module enable details.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
>  drivers/i2c/busses/i2c-i801.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index 68cec6128ac0..5ef9b733d153 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -98,8 +98,7 @@
>  #include <linux/platform_data/itco_wdt.h>
>  #include <linux/pm_runtime.h>
>  
> -#if (defined CONFIG_I2C_MUX_GPIO || defined CONFIG_I2C_MUX_GPIO_MODULE) && \
> -		defined CONFIG_DMI
> +#if IS_ENABLED(CONFIG_I2C_MUX_GPIO) && defined CONFIG_DMI
>  #include <linux/gpio.h>
>  #include <linux/i2c-mux-gpio.h>
>  #endif
> @@ -255,8 +254,7 @@ struct i801_priv {
>  	int len;
>  	u8 *data;
>  
> -#if (defined CONFIG_I2C_MUX_GPIO || defined CONFIG_I2C_MUX_GPIO_MODULE) && \
> -		defined CONFIG_DMI
> +#if IS_ENABLED(CONFIG_I2C_MUX_GPIO) && defined CONFIG_DMI
>  	const struct i801_mux_config *mux_drvdata;
>  	struct platform_device *mux_pdev;
>  #endif
> @@ -1133,8 +1131,7 @@ static void __init input_apanel_init(void) {}
>  static void i801_probe_optional_slaves(struct i801_priv *priv) {}
>  #endif	/* CONFIG_X86 && CONFIG_DMI */
>  
> -#if (defined CONFIG_I2C_MUX_GPIO || defined CONFIG_I2C_MUX_GPIO_MODULE) && \
> -		defined CONFIG_DMI
> +#if IS_ENABLED(CONFIG_I2C_MUX_GPIO) && defined CONFIG_DMI
>  static struct i801_mux_config i801_mux_config_asus_z8_d12 = {
>  	.gpio_chip = "gpio_ich",
>  	.values = { 0x02, 0x03 },

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
