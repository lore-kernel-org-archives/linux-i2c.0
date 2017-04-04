From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2] i2c/muxes/i2c-mux-ltc4306: LTC4306 and LTC4305 I2C
 multiplexer/switch
Date: Tue, 4 Apr 2017 11:28:23 +0200
Message-ID: <b5838bae-8108-1a0e-5234-d14cb5e95e52@axentia.se>
References: <1490782541-7832-1-git-send-email-michael.hennerich@analog.com>
 <0d4c068f-d909-64be-421d-4500da7ebd4c@axentia.se>
 <e0027ff7-948e-60f1-a492-72ab4a67605f@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <e0027ff7-948e-60f1-a492-72ab4a67605f@analog.com>
Sender: linux-gpio-owner@vger.kernel.org
To: michael.hennerich@analog.com, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, linus.walleij@linaro.org
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

*snip* *snip*

>>> +static int ltc4306_gpio_get(struct gpio_chip *chip, unsigned int offset)
>>> +{
>>> +	struct ltc4306 *data = gpiochip_get_data(chip);
>>> +	int ret = 0;
>>> +
>>> +	if (gpiochip_line_is_open_drain(chip, offset) ||
>>> +	    (data->regs[LTC_REG_MODE] & BIT(7 - offset))) {
>>
>> I wonder about this open-coded register cache. So, gpio people, is there
>> a guarantee from gpiolib that only one gpio_chip operation is in flight
>> concurrently? Because I don't see any evidence of that. With that in
>> mind, I think some locking is needed?
> 
> I thought there is a per chip mutex in the gpiolib. But I can't find 
> anything like this either. Since these two gpios can be used from 
> different internal or external users. The locking seem to be needed.
> 
> This gets us back to the regmap option. I did a quick grep, and 9 out of 
> 205 drivers using regmap i2c, also use i2c_smbus... concurrently.
> 
> grep -Rl regmap_init_i2c ./drivers  | xargs grep -l i2c_smbus_ | grep "\.c"
> 
> Mostly to work around non uniform transfer layouts.

I see three options.

1. Go with regmap and convert to mux-locked. Then the unlocked i2c-xfer
becomes an ordinary i2c-xfer (or smbus, whatever). This will result in
the cleanest code.

2. Go with regmap and stay parent-locked. Then hook into the regmap
locking as is done in one of the drivers that have worked around similar
problems with regmap and parent-locked i2c-mux interactions:

drivers/media/dvb-frontends/rtl2830.c
drivers/media/dvb-frontends/m88ds3103.c

This will probably work, but you'd need to add a number of extra helper
functions.

3. Exclude register 3 from regmap and only use regmap for the other
registers. This will be a bit ugly and ad-hoc, will need clear comments
on what is going on and why it is safe etc. And I want to see it before
I accept it. And it might not be my call to begin with, because TBH, it
sounds a bit disgusting...

> I'll check with Mark Brown on this topic.

Ok, might be a good idea...

>>> +
>>> +add_adapter_failed:
>>> +	i2c_mux_del_adapters(muxc);
>>> +gpio_default:
>>> +	gpiod_direction_input(data->en_gpio);
>>
>> This was actually not what I had in mind when I asked about it in v1, and
>> this looks a bit strange. You have no way of knowing if the pin was
>> configured as input when probe was called, and I don't see code like this
>> all over the place. Maybe it's is ok to not disable the chip over
>> suspend/resume, I was just asking because it looked a bit strange to grab
>> a pin and then forget about it. Now that I think about it some more, it's
>> probably ok to do just that since it is perhaps not possible to make the
>> chip draw less power by deasserting enable, but what do I know?
> 
> GPIOs are assumed by default inputs. So if you want to undo the actions 
> in probe. The logical consequence is to move them back to inputs, and 
> let the external PULL-UP or PULL-DOWN on the ENABLE decide what happens. 
> I would also prefer to leave it enabled, so that the GPIOs can retain

My point is that I do not see any probe functions undoing gpio configs.
Why bother in this case? Or are other probe functions really doing this?
I actually didn't check, but I haven't stumbled over it previously and
at least think I would have noticed...

> it's last state. Well I think the device draws a bit less power when 
> disabled. But we don't support runtime PM anyways.

It might not be safe to reset the gpio pins over a suspend/resume depending
on what they are used for, so it is probably a bad idea to go there. Sorry
for bringing the whole issue up and muddying the waters...

Cheers,
peda

