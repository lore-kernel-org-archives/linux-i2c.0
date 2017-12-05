From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH 3/6] i2c: add 'set_sda' to bus_recovery_info
Date: Tue, 5 Dec 2017 09:12:10 +0800
Message-ID: <8af3a653-73ca-9914-1874-e247bd42520b@electromag.com.au>
References: <20171204123640.3382-1-wsa+renesas@sang-engineering.com>
 <20171204123640.3382-4-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:56397 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751980AbdLEBMP (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 4 Dec 2017 20:12:15 -0500
In-Reply-To: <20171204123640.3382-4-wsa+renesas@sang-engineering.com>
Content-Language: en-AU
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Claudio Foellmi <claudio.foellmi@ergon.ch>, Andrzej Hajda <a.hajda@samsung.com>, Linus Walleij <linus.walleij@linaro.org>

G'day Wolfram,


On 4/12/2017 20:36, Wolfram Sang wrote:
> This will be needed when we want to create STOP conditions, too, later.
> Create the needed fields and populate them for the GPIO case if the GPIO
> is set to output.
> 
> Cc: Phil Reid <preid@electromag.com.au>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Cc: Claudio Foellmi <claudio.foellmi@ergon.ch>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>   drivers/i2c/i2c-core-base.c | 11 ++++++++++-
>   include/linux/i2c.h         |  4 ++++
>   2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index bb34a5d4113331..f4313801a0aaba 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -27,6 +27,7 @@
>   #include <linux/delay.h>
>   #include <linux/err.h>
>   #include <linux/errno.h>
> +#include <linux/gpio.h>

I thought we weren't supposed to use this any more.
But it's the only place were gpiod_get_direction return flags are defined at present.
+cc Linus W.

>   #include <linux/gpio/consumer.h>
>   #include <linux/i2c.h>
>   #include <linux/i2c-smbus.h>
> @@ -147,6 +148,11 @@ static int get_sda_gpio_value(struct i2c_adapter *adap)
>   	return gpiod_get_value_cansleep(adap->bus_recovery_info->sda_gpiod);
>   }
>   
> +static void set_sda_gpio_value(struct i2c_adapter *adap, int val)
> +{
> +	gpiod_set_value_cansleep(adap->bus_recovery_info->sda_gpiod, val);
> +}
> +
>   /*
>    * We are generating clock pulses. ndelay() determines durating of clk pulses.
>    * We will generate clock with rate 100 KHz and so duration of both clock levels
> @@ -225,8 +231,11 @@ static void i2c_init_recovery(struct i2c_adapter *adap)
>   	if (bri->scl_gpiod && bri->recover_bus == i2c_generic_scl_recovery) {
>   		bri->get_scl = get_scl_gpio_value;
>   		bri->set_scl = set_scl_gpio_value;
> -		if (bri->sda_gpiod)
> +		if (bri->sda_gpiod) {
>   			bri->get_sda = get_sda_gpio_value;
> +			if (gpiod_get_direction(bri->sda_gpiod) == GPIOF_DIR_OUT)
> +				bri->set_sda = set_sda_gpio_value;
> +		}
>   		return;
>   	}
>   
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 8a020617b4e780..c3e402e647791c 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -551,6 +551,9 @@ struct i2c_timings {
>    * @get_sda: This gets current value of SDA line. Optional for generic SCL
>    *      recovery. Populated internally, if sda_gpio is a valid GPIO, for generic
>    *      GPIO recovery.
> + * @set_sda: This sets/clears the SDA line. Optional for generic SCL recovery.
> + *	Populated internally, if sda_gpio is a valid GPIO, for generic GPIO
> + *	recovery.
>    * @prepare_recovery: This will be called before starting recovery. Platform may
>    *	configure padmux here for SDA/SCL line or something else they want.
>    * @unprepare_recovery: This will be called after completing recovery. Platform
> @@ -564,6 +567,7 @@ struct i2c_bus_recovery_info {
>   	int (*get_scl)(struct i2c_adapter *adap);
>   	void (*set_scl)(struct i2c_adapter *adap, int val);
>   	int (*get_sda)(struct i2c_adapter *adap);
> +	void (*set_sda)(struct i2c_adapter *adap, int val);
>   
>   	void (*prepare_recovery)(struct i2c_adapter *);
>   	void (*unprepare_recovery)(struct i2c_adapter *);
> 


-- 
Regards
Phil Reid
