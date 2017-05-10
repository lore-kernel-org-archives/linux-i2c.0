From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c-designware: add i2c gpio recovery option
Date: Wed, 10 May 2017 16:13:01 +0300
Message-ID: <1494421981.16411.7.camel@linux.intel.com>
References: <2259005.m0altzP21Z@dabox> <1966782.aCEMFj2YWU@virgo>
         <4a84d6b1-2bba-6f01-8286-49661ef45576@electromag.com.au>
         <32490844.DoY2McpBxU@dabox>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:16560 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751323AbdEJNNF (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 10 May 2017 09:13:05 -0400
In-Reply-To: <32490844.DoY2McpBxU@dabox>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Tim Sander <tim@krieglstein.org>, Phil Reid <preid@electromag.com.au>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2017-05-10 at 13:57 +0200, Tim Sander wrote:
> This patch contains much input from Phil Reid and has been tested
> on Intel/Altera Cyclone V SOC Hardware with Altera GPIO's for the 
> SCL and SDA GPIO's. I am still a little unsure about the recover
> in the timeout case (i2c-designware-core.c:770) as i could not
> test this codepath.

Since it's not an RFC anymore let me do some comments on the below.

> @@ -317,6 +317,7 @@ static void i2c_dw_release_lock(struct dw_i2c_dev
> *dev)
>                 dev->release_lock(dev);
>  }
>  
> +
>  /**
>   * i2c_dw_init() - initialize the designware i2c master hardware
>   * @dev: device private data

This doesn't belong to the change.

> @@ -463,7 +464,12 @@ static int i2c_dw_wait_bus_not_busy(struct
> dw_i2c_dev *dev)
>         while (dw_readl(dev, DW_IC_STATUS) & DW_IC_STATUS_ACTIVITY) {

>                 if (timeout <= 0) {
>                         dev_warn(dev->dev, "timeout waiting for bus
> ready\n");
> -                       return -ETIMEDOUT;
> +                       i2c_recover_bus(&dev->adapter);
> +
> +                       if (dw_readl(dev, DW_IC_STATUS) &
> DW_IC_STATUS_ACTIVITY)
> +                               return -ETIMEDOUT;

> +                       else

Redundant.

> +                               return 0;
>                 }

Actually I would rather refactor first above function: 
1) to be do {} while();
2) to have invariant condition out of the loop.

>                 timeout--;
>                 usleep_range(1000, 1100);

> @@ -719,9 +725,10 @@ static int i2c_dw_handle_tx_abort(struct
> dw_i2c_dev *dev)
>         for_each_set_bit(i, &abort_source, ARRAY_SIZE(abort_sources))
>                 dev_err(dev->dev, "%s: %s\n", __func__,
> abort_sources[i]);
>  
> -       if (abort_source & DW_IC_TX_ARB_LOST)
> +       if (abort_source & DW_IC_TX_ARB_LOST) {
> +               i2c_recover_bus(&dev->adapter);
>                 return -EAGAIN;

> -       else if (abort_source & DW_IC_TX_ABRT_GCALL_READ)
> +       } else if (abort_source & DW_IC_TX_ABRT_GCALL_READ)
>                 return -EINVAL; /* wrong msgs[] data */
>         else

Both else:s are redundant.

	if (abort_source & DW_IC_TX_ARB_LOST) {
               i2c_recover_bus(&dev->adapter);
                return -EAGAIN;
	}

        if (abort_source & DW_IC_TX_ABRT_GCALL_READ)
...

Though I may agree on leaving them here for sake of keeping less lines
of code. 

>                 return -EIO;

> +#include <linux/gpio.h>

I think it should be

#include <linux/gpio/consumer.h>

> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -41,6 +41,7 @@
>  #include <linux/reset.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>

> +#include <linux/of_gpio.h>

No, please don't.

In recent code we try to avoid OF/ACPI/platform specific bits if there
is a common resource provider (and API) for that. GPIO is the case. 

> +void i2c_dw_unprepare_recovery(struct i2c_adapter *adap)
> +{

> +}
> +
> +

Remove extra line.

> +static int i2c_dw_get_scl(struct i2c_adapter *adap)
> +{
> +       struct platform_device *pdev = to_platform_device(&adap->dev);
> +       struct dw_i2c_dev *dev = platform_get_drvdata(pdev);

struct dw_i2c_dev *dev = i2c_get_adapdata(adap); ?

Ditto for all occurrences in the code.

> +
> +       return gpiod_get_value_cansleep(dev->gpio_scl);
> +}

> +static int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev,
> +                                    struct i2c_adapter *adap)
> +{
> +       struct i2c_bus_recovery_info *rinfo = &dev->rinfo;
> +
> +       dev->gpio_scl = devm_gpiod_get_optional(dev->dev,
> +                                               "scl",
> +                                               GPIOD_OUT_HIGH);

> +       if (IS_ERR_OR_NULL(dev->gpio_scl))

This is wrong. You should not use this macro in most cases. And
especially it breaks the logic behind _optional().

> +               return PTR_ERR(dev->gpio_scl);
> +
> +       dev->gpio_sda = devm_gpiod_get_optional(dev->dev, "sda",
> GPIOD_IN);

> +       if (IS_ERR_OR_NULL(dev->gpio_sda))

Ditto.

> +               return PTR_ERR(dev->gpio_sda);

> +       rinfo->scl_gpio = desc_to_gpio(dev->gpio_scl);
> +       rinfo->sda_gpio = desc_to_gpio(dev->gpio_sda);

Why?!

> +};

> @@ -285,6 +368,7 @@ static int dw_i2c_plat_probe(struct
> platform_device *pdev)
>         adap->class = I2C_CLASS_DEPRECATED;
>         ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&pdev->dev));
>         adap->dev.of_node = pdev->dev.of_node;
> +       snprintf(adap->name, sizeof(adap->name), "Designware i2c
> adapter");

It looks like a separate change.

>  
> +       r = i2c_dw_init_recovery_info(dev, adap);
> +       if (r  == -EPROBE_DEFER)

Remove extra space.

> +               goto exit_probe;
> +
>         r = i2c_dw_probe(dev);
>         if (r)
>                 goto exit_probe;
>  

> -       return r;
> +       return 0;

Doesn't belong to the change.

Don't change arbitrary typos or do small "improvements" in the change
which is not about them.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
