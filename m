From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH] i2c-designware: add i2c gpio recovery option
Date: Thu, 11 May 2017 09:24:37 +0800
Message-ID: <0aafcff1-6970-e99e-5b93-b0877ebf8579@electromag.com.au>
References: <2259005.m0altzP21Z@dabox> <1966782.aCEMFj2YWU@virgo>
 <4a84d6b1-2bba-6f01-8286-49661ef45576@electromag.com.au>
 <32490844.DoY2McpBxU@dabox> <1494421981.16411.7.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1494421981.16411.7.camel@linux.intel.com>
Content-Language: en-AU
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tim Sander <tim@krieglstein.org>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

G'day Andy,

Thanks for the review.

On 10/05/2017 21:13, Andy Shevchenko wrote:
> On Wed, 2017-05-10 at 13:57 +0200, Tim Sander wrote:
>> This patch contains much input from Phil Reid and has been tested
>> on Intel/Altera Cyclone V SOC Hardware with Altera GPIO's for the
>> SCL and SDA GPIO's. I am still a little unsure about the recover
>> in the timeout case (i2c-designware-core.c:770) as i could not
>> test this codepath.
> 
> Since it's not an RFC anymore let me do some comments on the below.
> 
>> @@ -317,6 +317,7 @@ static void i2c_dw_release_lock(struct dw_i2c_dev
>> *dev)
>>                  dev->release_lock(dev);
>>   }
>>   
>> +
>>   /**
>>    * i2c_dw_init() - initialize the designware i2c master hardware
>>    * @dev: device private data
> 
> This doesn't belong to the change.
> 
>> @@ -463,7 +464,12 @@ static int i2c_dw_wait_bus_not_busy(struct
>> dw_i2c_dev *dev)
>>          while (dw_readl(dev, DW_IC_STATUS) & DW_IC_STATUS_ACTIVITY) {
> 
>>                  if (timeout <= 0) {
>>                          dev_warn(dev->dev, "timeout waiting for bus
>> ready\n");
>> -                       return -ETIMEDOUT;
>> +                       i2c_recover_bus(&dev->adapter);
>> +
>> +                       if (dw_readl(dev, DW_IC_STATUS) &
>> DW_IC_STATUS_ACTIVITY)
>> +                               return -ETIMEDOUT;
> 
>> +                       else
> 
> Redundant.
> 
>> +                               return 0;
>>                  }
> 
> Actually I would rather refactor first above function:
> 1) to be do {} while();
> 2) to have invariant condition out of the loop.
> 
>>                  timeout--;
>>                  usleep_range(1000, 1100);
> 
>> @@ -719,9 +725,10 @@ static int i2c_dw_handle_tx_abort(struct
>> dw_i2c_dev *dev)
>>          for_each_set_bit(i, &abort_source, ARRAY_SIZE(abort_sources))
>>                  dev_err(dev->dev, "%s: %s\n", __func__,
>> abort_sources[i]);
>>   
>> -       if (abort_source & DW_IC_TX_ARB_LOST)
>> +       if (abort_source & DW_IC_TX_ARB_LOST) {
>> +               i2c_recover_bus(&dev->adapter);
>>                  return -EAGAIN;
> 
>> -       else if (abort_source & DW_IC_TX_ABRT_GCALL_READ)
>> +       } else if (abort_source & DW_IC_TX_ABRT_GCALL_READ)
>>                  return -EINVAL; /* wrong msgs[] data */
>>          else
> 
> Both else:s are redundant.
> 
> 	if (abort_source & DW_IC_TX_ARB_LOST) {
>                 i2c_recover_bus(&dev->adapter);
>                  return -EAGAIN;
> 	}
> 
>          if (abort_source & DW_IC_TX_ABRT_GCALL_READ)
> ...
> 
> Though I may agree on leaving them here for sake of keeping less lines
> of code.
> 
>>                  return -EIO;
> 
>> +#include <linux/gpio.h>
> 
> I think it should be
> 
> #include <linux/gpio/consumer.h>
> 
>> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
>> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
>> @@ -41,6 +41,7 @@
>>   #include <linux/reset.h>
>>   #include <linux/slab.h>
>>   #include <linux/acpi.h>
> 
>> +#include <linux/of_gpio.h>
> 
> No, please don't.
> 
> In recent code we try to avoid OF/ACPI/platform specific bits if there
> is a common resource provider (and API) for that. GPIO is the case.
> 
>> +void i2c_dw_unprepare_recovery(struct i2c_adapter *adap)
>> +{
> 
>> +}
>> +
>> +
> 
> Remove extra line.
> 
>> +static int i2c_dw_get_scl(struct i2c_adapter *adap)
>> +{
>> +       struct platform_device *pdev = to_platform_device(&adap->dev);
>> +       struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
> 
> struct dw_i2c_dev *dev = i2c_get_adapdata(adap); ?
> 
> Ditto for all occurrences in the code.
> 
>> +
>> +       return gpiod_get_value_cansleep(dev->gpio_scl);
>> +}
> 
>> +static int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev,
>> +                                    struct i2c_adapter *adap)
>> +{
>> +       struct i2c_bus_recovery_info *rinfo = &dev->rinfo;
>> +
>> +       dev->gpio_scl = devm_gpiod_get_optional(dev->dev,
>> +                                               "scl",
>> +                                               GPIOD_OUT_HIGH);
> 
>> +       if (IS_ERR_OR_NULL(dev->gpio_scl))
> 
> This is wrong. You should not use this macro in most cases. And
> especially it breaks the logic behind _optional().
My logic here was that if the gpio is optional return null we return 0.
which is an okay status.
But this breaks if !CONFIG_GPIOLIB, which I keep forgetting. I've never
quite wrapped my head around why that's the case.

But the probe function only bails out if this returns EPROBE_DEFER.
Not sure that's the best approach

> 
>> +               return PTR_ERR(dev->gpio_scl);
>> +
>> +       dev->gpio_sda = devm_gpiod_get_optional(dev->dev, "sda",
>> GPIOD_IN);
> 
>> +       if (IS_ERR_OR_NULL(dev->gpio_sda))
> 
> Ditto.
> 
>> +               return PTR_ERR(dev->gpio_sda);
> 
>> +       rinfo->scl_gpio = desc_to_gpio(dev->gpio_scl);
>> +       rinfo->sda_gpio = desc_to_gpio(dev->gpio_sda);
> 
> Why?!
 From my first attempt, didn't remove it from the example I sent.

We could change i2c_init_recovery to something like the following
then the gpio set / getter could use the default functions.
Not sure the code is completely correct but hopefully you get the concept.

static void i2c_init_recovery(struct i2c_adapter *adap)
{
	struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
	char *err_str;

	if (!bri)
		return;

	if (!bri->recover_bus) {
		err_str = "no recover_bus() found";
		goto err;
	}

	/* bail out if either no gpio or no set/get callback. */
	if (!gpio_is_valid(bri->scl_gpio) && (!bri->set_scl || !bri->get_scl)) {
		if (!gpio_is_valid(bri->scl_gpio))
			err_str = "invalid SCL gpio";
		else
			err_str = "no {get|set}_scl() found";
		goto err;
	}

	if (gpio_is_valid(bri->sda_gpio))
		bri->get_sda = get_sda_gpio_value;

	if (gpio_is_valid(bri->scl_gpio)) {
		bri->get_scl = get_scl_gpio_value;
		bri->set_scl = set_scl_gpio_value;
	}

	return;
  err:
	dev_err(&adap->dev, "Not using recovery: %s\n", err_str);
	adap->bus_recovery_info = NULL;
}



> 
>> +};
> 
>> @@ -285,6 +368,7 @@ static int dw_i2c_plat_probe(struct
>> platform_device *pdev)
>>          adap->class = I2C_CLASS_DEPRECATED;
>>          ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&pdev->dev));
>>          adap->dev.of_node = pdev->dev.of_node;
>> +       snprintf(adap->name, sizeof(adap->name), "Designware i2c
>> adapter");
> 
> It looks like a separate change.
> 
>>   
>> +       r = i2c_dw_init_recovery_info(dev, adap);
>> +       if (r  == -EPROBE_DEFER)
> 
> Remove extra space.
> 
>> +               goto exit_probe;
>> +
>>          r = i2c_dw_probe(dev);
>>          if (r)
>>                  goto exit_probe;
>>   
> 
>> -       return r;
>> +       return 0;
> 
> Doesn't belong to the change.
> 
> Don't change arbitrary typos or do small "improvements" in the change
> which is not about them.
> 


-- 
Regards
Phil Reid
