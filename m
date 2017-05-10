From: Phil Reid <preid@electromag.com.au>
Subject: Re: RFC: i2c designware gpio recovery
Date: Wed, 10 May 2017 15:12:14 +0800
Message-ID: <4a84d6b1-2bba-6f01-8286-49661ef45576@electromag.com.au>
References: <2259005.m0altzP21Z@dabox> <1658050.mjbUFfzRWa@virgo>
 <610c93db-c272-1055-fc82-b749110996b4@electromag.com.au>
 <1966782.aCEMFj2YWU@virgo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anchovy3.45ru.net.au ([203.30.46.155]:50756 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751551AbdEJHMU (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 10 May 2017 03:12:20 -0400
In-Reply-To: <1966782.aCEMFj2YWU@virgo>
Content-Language: en-AU
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Tim Sander <tim@krieglstein.org>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

G'day Tim,

Sorry for the delay in looking at this.
My device is currently running a 4.9 kernel and I had to backport the cahnges to the driver
to get things running with your patch.

In general the code works and the bus recovers now.
I've been using the i2c gpio bus driver because the dw wouldn't do recovery.
But this looks alot nicer.


On 4/05/2017 03:04, Tim Sander wrote:
>>>>> So i took a look into the device tree file socfpga.dtsi and found that
>>>>> the
>>>>> reset lines where not defined (although available in the corresponding
>>>>> reset manager). Is there a reason for this? Other components are
>>>>> connected.
>>>>
>>>> There's a few thing like that where the bootloader has been expected to
>>>> setup the resets etc.
>>>
>>> Yes, but if the resets are not connected in the device tree, the linux
>>> drivers are not going to use them?
>>
>> Yes, so they should be added. I don't think we should assume the bootloader
>> sets things up. But that doesn't seem to have been the assumption with the
>> Alter SOC's.
> I will prepare a patch for this.
> 
>>>>> However with the patch below my previously sent patch works!
>>>>>
>>>>> If there is interest in would cleanup the patch and send it in for
>>>>> mainlining. I think the most unacceptable part would be this line:
>>>>> +       ret = gpio_request_one(bri->scl_gpio, //GPIOF_OPEN_DRAIN |
>>>>> My gpio drivers refuse to work as output as they have no open drain
>>>>> mode.
>>>>> So i wonder how to get this solved in a clean manner.
>>>>
>>>> I thought the gpio system would emulate open drain by switching the pin
>>>> between an input and output driven low in this case. How are you
>>>> configuring the GPIO's in the FPGA?
>>>
>>> I don't switch to GPIO mode. As the I2C logic is only pulling active low,
>>> i only do a wired and with the gpio (implemented in the fpga) port output
>>> on the output enable line for the SCL output.  SDA is only an additional
>>> input for the second in fpga gpio port.
>>>
>>> A picture should make it a clearer:
>>>
>>> gpio scl--\
>>> i2c   scl --&---i2c mode output pin (configured as fpga loan)
>>>
>>> In my case the original i2c pins where occupied by some other logic
>>> conflicting so the i2c pins had to be shifted to some other pins using
>>> fpga logic. So it was just a matter of adding a two port gpio port.
>>
>> I think I understand. What soft core gpio controller are you using?
> I am using the standard altera fpga gpios.
> 


I dug into things a little and found the following init function works without requiring modification to the core.
The GPIO config (open drain or not etc) can be put in the device tree.

static int i2c_dw_get_scl(struct i2c_adapter *adap)
{
	struct platform_device *pdev = to_platform_device(&adap->dev);
	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
	return gpiod_get_value_cansleep(dev->gpio_scl);
}

static void i2c_dw_set_scl(struct i2c_adapter *adap, int val)
{
	struct platform_device *pdev = to_platform_device(&adap->dev);
	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
	gpiod_set_value_cansleep(dev->gpio_scl, val);
}

static int i2c_dw_get_sda(struct i2c_adapter *adap)
{
	struct platform_device *pdev = to_platform_device(&adap->dev);
	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
	return gpiod_get_value_cansleep(dev->gpio_sda);
}

static int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev, struct i2c_adapter *adap)
{
	struct i2c_bus_recovery_info *rinfo = &dev->rinfo;

	dev->gpio_scl = devm_gpiod_get_optional(dev->dev, "scl", GPIOD_OUT_HIGH);
	if (IS_ERR_OR_NULL(dev->gpio_scl))
		return PTR_ERR(dev->gpio_scl);

	dev->gpio_sda = devm_gpiod_get_optional(dev->dev, "sda", GPIOD_IN);
	if (IS_ERR_OR_NULL(dev->gpio_sda))
		return PTR_ERR(dev->gpio_sda);

	rinfo->scl_gpio	= desc_to_gpio(dev->gpio_scl);
	rinfo->sda_gpio = desc_to_gpio(dev->gpio_sda);
	rinfo->set_scl  = i2c_dw_set_scl;
	rinfo->get_scl  = i2c_dw_get_scl;
	rinfo->get_sda  = i2c_dw_get_sda;

	rinfo->recover_bus = i2c_generic_scl_recovery;
	rinfo->prepare_recovery = i2c_dw_prepare_recovery;
	rinfo->unprepare_recovery = i2c_dw_unprepare_recovery;
	adap->bus_recovery_info = rinfo;

	dev_info(dev->dev,
		"adapter: %s running with gpio recovery mode! scl:%i sda:%i \n",
		adap->name, rinfo->scl_gpio, rinfo->sda_gpio);

	return 0;
};

A small modification to the i2c-core could be done in i2c_init_recovery to allow:
	rinfo->recover_bus == i2c_generic_scl_recovery
when scl_gpio is also set and fallback to using the core set / get scl / sda calls
Which would remove the need for the above i2c_dw_* functions.
I wouldn't think that would cause any problems.



-- 
Regards
Phil Reid

ElectroMagnetic Imaging Technology Pty Ltd
Development of Geophysical Instrumentation & Software
www.electromag.com.au

3 The Avenue, Midland WA 6056, AUSTRALIA
Ph: +61 8 9250 8100
Fax: +61 8 9250 7100
Email: preid@electromag.com.au
