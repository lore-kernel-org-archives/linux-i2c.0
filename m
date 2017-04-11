From: Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH v4 2/2] i2c: mux: ltc4306: LTC4306 and LTC4305 I2C
 multiplexer/switch
Date: Tue, 11 Apr 2017 10:46:13 +0200
Message-ID: <75c28713-0139-7b6e-f554-fcc4f9e1e040@analog.com>
References: <1491397671-14675-1-git-send-email-michael.hennerich@analog.com>
 <1491397671-14675-2-git-send-email-michael.hennerich@analog.com>
 <CACRpkdbECyEpD7b4OFxwAo6USnK_DGEbASMdTzOO=FQ9BAzRQA@mail.gmail.com>
Reply-To: <michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbECyEpD7b4OFxwAo6USnK_DGEbASMdTzOO=FQ9BAzRQA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 10.04.2017 22:04, Linus Walleij wrote:
> On Wed, Apr 5, 2017 at 3:07 PM,  <michael.hennerich@analog.com> wrote:
>
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
>> This patch adds support for the Analog Devices / Linear Technology
>> LTC4306 and LTC4305 4/2 Channel I2C Bus Multiplexer/Switches.
>> The LTC4306 optionally provides two general purpose input/output pins
>> (GPIOs) that can be configured as logic inputs, opendrain outputs or
>> push-pull outputs via the generic GPIOLIB framework.
>>
>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>
> Okay!

Hi Linus,

Thanks for your review.
Comments below.

>
>> +#include <linux/device.h>
>> +#include <linux/gpio.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/gpio/driver.h>
>
> Why are you including all these?
> Normally a GPIO driver should just include
> <linux/gpio/driver.h>

Well - this driver is also a gpio consumer.
But right I can drop gpio.h, and while gpio/driver.h also includes 
device.h - we don't need it here as well.

>
>> +#include <linux/i2c-mux.h>
>> +#include <linux/i2c.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>
>> +static int ltc4306_gpio_get(struct gpio_chip *chip, unsigned int offset)
>> +{
>> +       struct ltc4306 *data = gpiochip_get_data(chip);
>> +       unsigned int val;
>> +       int ret;
>> +
>> +       ret = regmap_read(data->regmap, LTC_REG_CONFIG, &val);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       return (val & BIT(1 - offset));
>
> Do this:
>
> return !!(val & BIT(1 - offset));
>
> So you clamp the return value to [0,1]

That's what I had in a previous version of the patch.
Then I noticed gpiolib is also doing this.
Anyways I'll add it back.

>
>> +static int ltc4306_gpio_set_config(struct gpio_chip *chip,
>> +                                  unsigned int offset, unsigned long config)
>> +{
>> +       struct ltc4306 *data = gpiochip_get_data(chip);
>> +       unsigned int val;
>> +
>> +       switch (pinconf_to_config_param(config)) {
>> +       case PIN_CONFIG_DRIVE_OPEN_DRAIN:
>> +               val = 0;
>> +               break;
>> +       case PIN_CONFIG_DRIVE_PUSH_PULL:
>> +               val = BIT(4 - offset);
>> +               break;
>> +       default:
>> +               return -ENOTSUPP;
>> +       }
>> +
>> +       return regmap_update_bits(data->regmap, LTC_REG_MODE,
>> +                                 BIT(4 - offset), val);
>> +}
>
> Nice!
>
>> +       data->gpiochip.label = dev_name(dev);
>> +       data->gpiochip.base = -1;
>> +       data->gpiochip.ngpio = data->chip->num_gpios;
>> +       data->gpiochip.parent = dev;
>> +       data->gpiochip.can_sleep = true;
>> +       data->gpiochip.direction_input = ltc4306_gpio_direction_input;
>> +       data->gpiochip.direction_output = ltc4306_gpio_direction_output;
>> +       data->gpiochip.get = ltc4306_gpio_get;
>> +       data->gpiochip.set = ltc4306_gpio_set;
>> +       data->gpiochip.set_config = ltc4306_gpio_set_config;
>> +       data->gpiochip.owner = THIS_MODULE;
>
> Please implement .get_direction().
> This is very helpful to userspace, have you tested to use tools/gpio/*
> from the kernel? Like lsgpio?

Ok - convinced me.

>
> Yours,
> Linus Walleij
>

-- 
Greetings,
Michael

--
Analog Devices GmbH      Otl-Aicher Strasse 60-64      80807 München
Sitz der Gesellschaft München, Registergericht München HRB 40368,
Geschäftsführer: Peter Kolberg, Ali Raza Husain, Eileen Wynne
