From: Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH v4 2/2] i2c: mux: ltc4306: LTC4306 and LTC4305 I2C
 multiplexer/switch
Date: Tue, 11 Apr 2017 11:29:03 +0200
Message-ID: <b565b940-e5d9-04da-dcd8-887848bb1af4@analog.com>
References: <1491397671-14675-1-git-send-email-michael.hennerich@analog.com>
 <1491397671-14675-2-git-send-email-michael.hennerich@analog.com>
 <a5127934-863a-64d6-88e6-b8119035baf9@axentia.se>
 <376f970f-9e0f-1d44-3813-93691c849b83@analog.com>
 <67c557ae-f094-9fe4-d2f3-d7a2af2df9ca@axentia.se>
Reply-To: <michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <67c557ae-f094-9fe4-d2f3-d7a2af2df9ca@axentia.se>
Sender: linux-gpio-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, linus.walleij@linaro.org
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 06.04.2017 22:03, Peter Rosin wrote:
> On 2017-04-06 13:31, Michael Hennerich wrote:
>> On 06.04.2017 10:39, Peter Rosin wrote:

Hi Peter,

again - thanks for your review.
Comments below.

>>>> +static const struct regmap_config ltc4306_regmap_config = {
>>>> +	.reg_bits = 8,
>>>> +	.val_bits = 8,
>>>> +	.max_register = LTC_REG_SWITCH,
>>>> +	.volatile_reg = ltc4306_is_volatile_reg,
>>>> +	.cache_type = REGCACHE_RBTREE,
>>>
>>> Did you consider REGCACHE_FLAT? There are very few registers and no hole
>>> in the map, and maintaining a tree seems like total overkill.
>>
>> There is no reason to use REGCACHE_FLAT, in our case it will be a single
>> node.
>
> Ok, so that makes me wonder what need REGCACHE_FLAT satisfies? To me,
> a flat regmap seems like a perfect fit here. Oh well...

https://lkml.org/lkml/2012/12/19/172

It's not worth arguing - if you prefer FLAT - then it's FLAT
While it's still round :-)


>>>> +static int ltc4306_gpio_init(struct ltc4306 *data)
>>>> +{
>>>> +	struct device *dev = regmap_get_device(data->regmap);
>>>> +
>>>> +	if (!data->chip->num_gpios)
>>>> +		return 0;
>>>> +
>>>> +	data->gpiochip.label = dev_name(dev);
>>>> +	data->gpiochip.base = -1;
>>>> +	data->gpiochip.ngpio = data->chip->num_gpios;
>>>> +	data->gpiochip.parent = dev;
>>>> +	data->gpiochip.can_sleep = true;
>>>> +	data->gpiochip.direction_input = ltc4306_gpio_direction_input;
>>>> +	data->gpiochip.direction_output = ltc4306_gpio_direction_output;
>>>
>>> I'm missing a get_direction op?
>>
>> No - its purely optional - the vast majority of gpiochips don't
>> implement it.
>>
>> linux/drivers/gpio$ grep -lr --include \*.c get_direction | wc
>>       36      36     523
>> linux/drivers/gpio$ grep -Lr --include \*.c get_direction | wc
>>      101     101    1461
>
> Ok, but while optional, why not provide it? The implementation would
> be about as simple as ltc4306_gpio_get, no?

ok - convinced me.


I'll send version 5 shortly.


-- 
Greetings,
Michael

--
Analog Devices GmbH      Otl-Aicher Strasse 60-64      80807 München
Sitz der Gesellschaft München, Registergericht München HRB 40368,
Geschäftsführer: Peter Kolberg, Ali Raza Husain, Eileen Wynne
