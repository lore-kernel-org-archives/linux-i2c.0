From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 1/4] i2c: Switch to using gpiod interface for gpio
 bus recovery
Date: Thu, 28 Sep 2017 13:44:43 +0300
Message-ID: <1506595483.16112.137.camel@linux.intel.com>
References: <1504073857-122449-1-git-send-email-preid@electromag.com.au>
         <1504073857-122449-2-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:54990 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752834AbdI1KqR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 28 Sep 2017 06:46:17 -0400
In-Reply-To: <1504073857-122449-2-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, tim@krieglstein.org, linux-i2c@vger.kernel.org

On Wed, 2017-08-30 at 14:17 +0800, Phil Reid wrote:
> Currently the i2c gpio recovery code uses gpio integer interface
> instead of the gpiod. This change switch the core code to use
> the gpiod while still retaining compatibility with the gpio integer
> interface. This will allow individual driver to be updated and tested
> individual to switch to using the gpiod interface.

>  static int i2c_get_gpios_for_recovery(struct i2c_adapter *adap)
> @@ -158,6 +158,7 @@ static int i2c_get_gpios_for_recovery(struct
> i2c_adapter *adap)
>  		dev_warn(dev, "Can't get SCL gpio: %d\n", bri-
> >scl_gpio);
>  		return ret;
>  	}
> +	bri->scl_gpiod = gpio_to_desc(bri->scl_gpio);
>  
>  	if (bri->get_sda) {
>  		if (gpio_request_one(bri->sda_gpio, GPIOF_IN, "i2c-
> sda")) {
> @@ -167,6 +168,7 @@ static int i2c_get_gpios_for_recovery(struct
> i2c_adapter *adap)
>  			bri->get_sda = NULL;
>  		}
>  	}

> +	bri->sda_gpiod = gpio_to_desc(bri->sda_gpio);

Shouldn't it be inside conditional?

>  	return ret;
>  }
> @@ -175,10 +177,13 @@ static void i2c_put_gpios_for_recovery(struct
> i2c_adapter *adap)
>  {
>  	struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
>  
> -	if (bri->get_sda)
> +	if (bri->get_sda) {
>  		gpio_free(bri->sda_gpio);
> +		bri->sda_gpiod = NULL;
> +	}
>  
>  	gpio_free(bri->scl_gpio);
> +	bri->scl_gpiod = NULL;

Can we go other way around, i.e. put descriptors and assign plain
integers to something like -ENOENT?

>  }


> +	if ((bri->scl_gpiod) &&

Redundant parens.

> +	    (bri->recover_bus == i2c_generic_scl_recovery)) {

Ditto, though here it might be slightly better to read.

> +		bri->get_scl = get_scl_gpio_value;
> +		bri->set_scl = set_scl_gpio_value;
> +		if (bri->sda_gpiod)
> +			bri->get_sda = get_sda_gpio_value;
> +		return;
> +	}

>  	int scl_gpio;
>  	int sda_gpio;
> +	struct gpio_desc *scl_gpiod;
> +	struct gpio_desc *sda_gpiod;

I think we even could get rid of plain integers completely.
In case some call needs it we can derive it still from the descriptor.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
