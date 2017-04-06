From: Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH v4 2/2] i2c: mux: ltc4306: LTC4306 and LTC4305 I2C
 multiplexer/switch
Date: Thu, 6 Apr 2017 13:31:20 +0200
Message-ID: <376f970f-9e0f-1d44-3813-93691c849b83@analog.com>
References: <1491397671-14675-1-git-send-email-michael.hennerich@analog.com>
 <1491397671-14675-2-git-send-email-michael.hennerich@analog.com>
 <a5127934-863a-64d6-88e6-b8119035baf9@axentia.se>
Reply-To: <michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <a5127934-863a-64d6-88e6-b8119035baf9@axentia.se>
Sender: linux-gpio-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, linus.walleij@linaro.org
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 06.04.2017 10:39, Peter Rosin wrote:
> Hi Michael,
>
> I would still like to hear from someone with more gpio experience.

I'll ping Linus.

>
> Anyway, from my point of view, there's just a few minor things left,
> with comments inline as usual.
>
> Thanks for you patience!

Thanks for review.

>
> Cheers,
> peda
>
> On 2017-04-05 15:07, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
>> This patch adds support for the Analog Devices / Linear Technology
>> LTC4306 and LTC4305 4/2 Channel I2C Bus Multiplexer/Switches.
>> The LTC4306 optionally provides two general purpose input/output pins
>> (GPIOs) that can be configured as logic inputs, opendrain outputs or
>> push-pull outputs via the generic GPIOLIB framework.
>>
>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>>
>> ---
>>
>> Changes since v1:
>>
>>  - Sort makefile entries
>>  - Sort driver includes
>>  - Use proper defines
>>  - Miscellaneous coding style fixups
>>  - Rename mux select callback
>>  - Revise i2c-mux-idle-disconnect handling
>>  - Add ENABLE GPIO handling on error and device removal.
>>  - Remove surplus of_match_device call.
>>
>> Changes since v2:
>>
>>  - Stop double error reporting (i2c_mux_add_adapter)
>>  - Change subject
>>  - Split dt bindings to separate patch
>>
>> Changes since v3:
>>
>>  - Change subject and add spaces
>>  - Convert to I2C_MUX_LOCKED
>>  - Convert to regmap
>>  - Remove local register cache
>>  - Restore previous ENABLE GPIO handling
>>  - Initially pulse ENABLE low
>>  - Eliminate i2c client struct in driver state structure
>>  - Simplify error return path
>>  - Misc minor cleanups
>> ---
>>  MAINTAINERS                         |   8 +
>>  drivers/i2c/muxes/Kconfig           |  11 ++
>>  drivers/i2c/muxes/Makefile          |   1 +
>>  drivers/i2c/muxes/i2c-mux-ltc4306.c | 310 ++++++++++++++++++++++++++++++++++++
>>  4 files changed, 330 insertions(+)
>>  create mode 100644 drivers/i2c/muxes/i2c-mux-ltc4306.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index c776906..9a27a19 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7698,6 +7698,14 @@ S:	Maintained
>>  F:	Documentation/hwmon/ltc4261
>>  F:	drivers/hwmon/ltc4261.c
>>
>> +LTC4306 I2C MULTIPLEXER DRIVER
>> +M:	Michael Hennerich <michael.hennerich@analog.com>
>> +W:	http://ez.analog.com/community/linux-device-drivers
>> +L:	linux-i2c@vger.kernel.org
>> +S:	Supported
>> +F:	drivers/i2c/muxes/i2c-mux-ltc4306.c
>> +F:	Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
>> +
>>  LTP (Linux Test Project)
>>  M:	Mike Frysinger <vapier@gentoo.org>
>>  M:	Cyril Hrubis <chrubis@suse.cz>
>> diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
>> index 10b3d17..41153b4 100644
>> --- a/drivers/i2c/muxes/Kconfig
>> +++ b/drivers/i2c/muxes/Kconfig
>> @@ -30,6 +30,17 @@ config I2C_MUX_GPIO
>>  	  This driver can also be built as a module.  If so, the module
>>  	  will be called i2c-mux-gpio.
>>
>> +config I2C_MUX_LTC4306
>> +	tristate "LTC LTC4306/5 I2C multiplexer"
>> +	select GPIOLIB
>> +	select REGMAP_I2C
>> +	help
>> +	  If you say yes here you get support for the LTC LTC4306 or LTC4305
>
> This reads a bit funny, and I think you should just spell out the
> first LTC? But perhaps not in the tristate above though, depending
> on how long it gets?

Ok - I rename LTC -> Analog Devices

>
>> +	  I2C mux/switch devices.
>> +
>> +	  This driver can also be built as a module.  If so, the module
>> +	  will be called i2c-mux-ltc4306.
>> +
>>  config I2C_MUX_PCA9541
>>  	tristate "NXP PCA9541 I2C Master Selector"
>>  	help
>> diff --git a/drivers/i2c/muxes/Makefile b/drivers/i2c/muxes/Makefile
>> index 9948fa4..ff7618c 100644
>> --- a/drivers/i2c/muxes/Makefile
>> +++ b/drivers/i2c/muxes/Makefile
>> @@ -6,6 +6,7 @@ obj-$(CONFIG_I2C_ARB_GPIO_CHALLENGE)	+= i2c-arb-gpio-challenge.o
>>  obj-$(CONFIG_I2C_DEMUX_PINCTRL)		+= i2c-demux-pinctrl.o
>>
>>  obj-$(CONFIG_I2C_MUX_GPIO)	+= i2c-mux-gpio.o
>> +obj-$(CONFIG_I2C_MUX_LTC4306)	+= i2c-mux-ltc4306.o
>>  obj-$(CONFIG_I2C_MUX_MLXCPLD)	+= i2c-mux-mlxcpld.o
>>  obj-$(CONFIG_I2C_MUX_PCA9541)	+= i2c-mux-pca9541.o
>>  obj-$(CONFIG_I2C_MUX_PCA954x)	+= i2c-mux-pca954x.o
>> diff --git a/drivers/i2c/muxes/i2c-mux-ltc4306.c b/drivers/i2c/muxes/i2c-mux-ltc4306.c
>> new file mode 100644
>> index 0000000..7d34434
>> --- /dev/null
>> +++ b/drivers/i2c/muxes/i2c-mux-ltc4306.c
>> @@ -0,0 +1,310 @@
>> +/*
>> + * Linear Technology LTC4306 and LTC4305 I2C multiplexer/switch
>> + *
>> + * Copyright (C) 2017 Analog Devices Inc.
>> + *
>> + * Licensed under the GPL-2.
>> + *
>> + * Based on: i2c-mux-pca954x.c
>> + *
>> + * Datasheet: http://cds.linear.com/docs/en/datasheet/4306.pdf
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/gpio.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/gpio/driver.h>
>> +#include <linux/i2c-mux.h>
>> +#include <linux/i2c.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>> +
>> +#define LTC4305_MAX_NCHANS 2
>> +#define LTC4306_MAX_NCHANS 4
>> +
>> +#define LTC_REG_STATUS	0x0
>> +#define LTC_REG_CONFIG	0x1
>> +#define LTC_REG_MODE	0x2
>> +#define LTC_REG_SWITCH	0x3
>> +
>> +#define LTC_DOWNSTREAM_ACCL_EN	BIT(6)
>> +#define LTC_UPSTREAM_ACCL_EN	BIT(7)
>> +
>> +#define LTC_GPIO_ALL_INPUT	0xC0
>> +#define LTC_SWITCH_MASK		0xF0
>> +
>> +enum ltc_type {
>> +	ltc_4305,
>> +	ltc_4306,
>> +};
>> +
>> +struct chip_desc {
>> +	u8 nchans;
>> +	u8 num_gpios;
>> +};
>> +
>> +struct ltc4306 {
>> +	struct regmap *regmap;
>> +	struct gpio_chip gpiochip;
>> +	const struct chip_desc *chip;
>> +};
>> +
>> +static const struct chip_desc chips[] = {
>> +	[ltc_4305] = {
>> +		.nchans = LTC4305_MAX_NCHANS,
>> +	},
>> +	[ltc_4306] = {
>> +		.nchans = LTC4306_MAX_NCHANS,
>> +		.num_gpios = 2,
>> +	},
>> +};
>> +
>> +static bool ltc4306_is_volatile_reg(struct device *dev, unsigned int reg)
>> +{
>> +	return (reg == LTC_REG_CONFIG) ? true : false;
>> +}
>> +
>> +static const struct regmap_config ltc4306_regmap_config = {
>> +	.reg_bits = 8,
>> +	.val_bits = 8,
>> +	.max_register = LTC_REG_SWITCH,
>> +	.volatile_reg = ltc4306_is_volatile_reg,
>> +	.cache_type = REGCACHE_RBTREE,
>
> Did you consider REGCACHE_FLAT? There are very few registers and no hole
> in the map, and maintaining a tree seems like total overkill.

There is no reason to use REGCACHE_FLAT, in our case it will be a single 
node.

>
>> +};
>> +
>> +static int ltc4306_gpio_get(struct gpio_chip *chip, unsigned int offset)
>> +{
>> +	struct ltc4306 *data = gpiochip_get_data(chip);
>> +	unsigned int val;
>> +	int ret;
>> +
>> +	ret = regmap_read(data->regmap, LTC_REG_CONFIG, &val);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return (val & BIT(1 - offset));
>
> The outer parentheses do not add anything, and I think they might remain
> from when you just removed a double negation at some point. But is it
> good practice to indicate "high" with anything other than one? Sure, the
> gpiolib function that wraps the ->get() op does the !! dance for you,
> but even so, every single one of the half dozen random gpio providers I
> looked at had code to coerce the value to 0/1 (or error). Which makes me
> think you should also have it. And the gpio_chip documentation on ->get()
> agrees with me...

I'll restore the double negations.

>
>> +}
>> +
>> +static void ltc4306_gpio_set(struct gpio_chip *chip, unsigned int offset,
>> +			     int value)
>> +{
>> +	struct ltc4306 *data = gpiochip_get_data(chip);
>> +
>> +	regmap_update_bits(data->regmap, LTC_REG_CONFIG, BIT(5 - offset),
>> +			   value ? BIT(5 - offset) : 0);
>> +}
>> +
>> +static int ltc4306_gpio_direction_input(struct gpio_chip *chip,
>> +					unsigned int offset)
>> +{
>> +	struct ltc4306 *data = gpiochip_get_data(chip);
>> +
>> +	return regmap_update_bits(data->regmap, LTC_REG_MODE,
>> +				  BIT(7 - offset), BIT(7 - offset));
>> +}
>> +
>> +static int ltc4306_gpio_direction_output(struct gpio_chip *chip,
>> +					 unsigned int offset, int value)
>> +{
>> +	struct ltc4306 *data = gpiochip_get_data(chip);
>> +
>> +	ltc4306_gpio_set(chip, offset, value);
>> +	return regmap_update_bits(data->regmap, LTC_REG_MODE,
>> +				  BIT(7 - offset), 0);
>> +}
>> +
>> +static int ltc4306_gpio_set_config(struct gpio_chip *chip,
>> +				   unsigned int offset, unsigned long config)
>> +{
>> +	struct ltc4306 *data = gpiochip_get_data(chip);
>> +	unsigned int val;
>> +
>> +	switch (pinconf_to_config_param(config)) {
>> +	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
>> +		val = 0;
>> +		break;
>> +	case PIN_CONFIG_DRIVE_PUSH_PULL:
>> +		val = BIT(4 - offset);
>> +		break;
>> +	default:
>> +		return -ENOTSUPP;
>> +	}
>> +
>> +	return regmap_update_bits(data->regmap, LTC_REG_MODE,
>> +				  BIT(4 - offset), val);
>> +}
>> +
>> +static int ltc4306_gpio_init(struct ltc4306 *data)
>> +{
>> +	struct device *dev = regmap_get_device(data->regmap);
>> +
>> +	if (!data->chip->num_gpios)
>> +		return 0;
>> +
>> +	data->gpiochip.label = dev_name(dev);
>> +	data->gpiochip.base = -1;
>> +	data->gpiochip.ngpio = data->chip->num_gpios;
>> +	data->gpiochip.parent = dev;
>> +	data->gpiochip.can_sleep = true;
>> +	data->gpiochip.direction_input = ltc4306_gpio_direction_input;
>> +	data->gpiochip.direction_output = ltc4306_gpio_direction_output;
>
> I'm missing a get_direction op?

No - its purely optional - the vast majority of gpiochips don't 
implement it.

linux/drivers/gpio$ grep -lr --include \*.c get_direction | wc
      36      36     523
linux/drivers/gpio$ grep -Lr --include \*.c get_direction | wc
     101     101    1461
>
>> +	data->gpiochip.get = ltc4306_gpio_get;
>> +	data->gpiochip.set = ltc4306_gpio_set;
>> +	data->gpiochip.set_config = ltc4306_gpio_set_config;
>> +	data->gpiochip.owner = THIS_MODULE;
>> +
>> +	/* gpiolib assumes all GPIOs default input */
>> +	regmap_write(data->regmap, LTC_REG_MODE, LTC_GPIO_ALL_INPUT);
>> +
>> +	return devm_gpiochip_add_data(dev, &data->gpiochip, data);
>> +}
>> +
>> +static int ltc4306_select_mux(struct i2c_mux_core *muxc, u32 chan)
>> +{
>> +	struct ltc4306 *data = i2c_mux_priv(muxc);
>> +
>> +	return regmap_update_bits(data->regmap, LTC_REG_SWITCH,
>> +				  LTC_SWITCH_MASK, BIT(7 - chan));
>
> Since the bits outside the mask are ignored for writes, I'd go with
> regmap_write. Especially since those bits are volatile, which admittedly
> will not have much impact until there is a need to read those volatile
> bits outside the mask. But still.

Yes they are volatile - but not declared as such.
So regmap cache just ignores them.
And we totally ignore these RONLY status bits, too.
regmap_write() will always write and ignore the cache, while 
regmap_update_bits() uses the cached value.

Are these callbacks guaranteed to be never called with the same CHAN 
sequentially? if yes - use regmap_write() otherwise its more efficient 
to use regmap_update_bits().

>
>> +}
>> +
>> +static int ltc4306_deselect_mux(struct i2c_mux_core *muxc, u32 chan)
>> +{
>> +	struct ltc4306 *data = i2c_mux_priv(muxc);
>> +
>> +	return regmap_update_bits(data->regmap, LTC_REG_SWITCH,
>> +				  LTC_SWITCH_MASK, 0);
>
> Dito.
>
>> +}
>> +
>> +static const struct i2c_device_id ltc4306_id[] = {
>> +	{ "ltc4305", ltc_4305 },
>> +	{ "ltc4306", ltc_4306 },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, ltc4306_id);
>> +
>> +static const struct of_device_id ltc4306_of_match[] = {
>> +	{ .compatible = "lltc,ltc4305", .data = &chips[ltc_4305] },
>> +	{ .compatible = "lltc,ltc4306", .data = &chips[ltc_4306] },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, ltc4306_of_match);
>> +
>> +static int ltc4306_probe(struct i2c_client *client,
>> +			 const struct i2c_device_id *id)
>> +{
>> +	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
>> +	struct device_node *of_node = client->dev.of_node;
>> +	struct i2c_mux_core *muxc;
>> +	struct ltc4306 *data;
>> +	struct gpio_desc *gpio;
>> +	bool idle_disc = false;
>> +	int num, ret;
>> +
>> +	if (of_node)
>> +		idle_disc = of_property_read_bool(of_node,
>> +						  "i2c-mux-idle-disconnect");
>> +
>> +	muxc = i2c_mux_alloc(adap, &client->dev,
>> +			     LTC4306_MAX_NCHANS, sizeof(*data),
>
> Hmmm, I didn't see this before, but if you do some more rearranging, it
> should be possible to replace LTC4306_MAX_NCHANS with data->chip->nchans
> and reduce resource waste for ltc4305. But it's just storage for two
> pointers which is really really minor... Feel free to ignore.
>
> But you want to set a good example, right :-)
>
>> +			     I2C_MUX_LOCKED, ltc4306_select_mux,
>> +			     idle_disc ? ltc4306_deselect_mux : NULL);
>> +	if (!muxc)
>> +		return -ENOMEM;
>> +	data = i2c_mux_priv(muxc);
>> +
>> +	i2c_set_clientdata(client, muxc);
>> +
>> +	data->regmap = devm_regmap_init_i2c(client, &ltc4306_regmap_config);
>> +	if (IS_ERR(data->regmap)) {
>> +		ret = PTR_ERR(data->regmap);
>> +		dev_err(&client->dev, "Failed to allocate register map: %d\n",
>> +			ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Reset and enable the mux if an enable GPIO is specified. */
>> +	gpio = devm_gpiod_get_optional(&client->dev, "enable", GPIOD_OUT_LOW);
>> +	if (IS_ERR(gpio))
>> +		return PTR_ERR(gpio);
>> +
>> +	if (gpio) {
>> +		udelay(1);
>> +		gpiod_set_value(gpio, 1);
>> +	}
>> +
>> +	/*
>> +	 * Write the mux register at addr to verify
>> +	 * that the mux is in fact present. This also
>> +	 * initializes the mux to disconnected state.
>> +	 */
>> +	if (regmap_write(data->regmap, LTC_REG_SWITCH, 0) < 0) {
>> +		dev_warn(&client->dev, "probe failed\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (of_node) {
>> +		unsigned int val = 0;
>> +
>> +		data->chip = of_device_get_match_data(&client->dev);
>> +
>> +		if (of_property_read_bool(of_node,
>> +					  "ltc,downstream-accelerators-enable"))
>> +			val |= LTC_DOWNSTREAM_ACCL_EN;
>> +
>> +		if (of_property_read_bool(of_node,
>> +					  "ltc,upstream-accelerators-enable"))
>> +			val |= LTC_UPSTREAM_ACCL_EN;
>> +
>> +		if (regmap_write(data->regmap, LTC_REG_CONFIG, val) < 0)
>> +			return -ENODEV;
>> +	} else {
>> +		data->chip = &chips[id->driver_data];
>> +	}
>> +
>> +	ret = ltc4306_gpio_init(data);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* Now create an adapter for each channel */
>> +	for (num = 0; num < data->chip->nchans; num++) {
>> +		ret = i2c_mux_add_adapter(muxc, 0, num, 0);
>> +		if (ret) {
>> +			i2c_mux_del_adapters(muxc);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	dev_info(&client->dev,
>> +		 "registered %d multiplexed busses for I2C switch %s\n",
>> +		 num, client->name);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ltc4306_remove(struct i2c_client *client)
>> +{
>> +	struct i2c_mux_core *muxc = i2c_get_clientdata(client);
>> +
>> +	i2c_mux_del_adapters(muxc);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct i2c_driver ltc4306_driver = {
>> +	.driver		= {
>> +		.name	= "ltc4306",
>> +		.of_match_table = of_match_ptr(ltc4306_of_match),
>> +	},
>> +	.probe		= ltc4306_probe,
>> +	.remove		= ltc4306_remove,
>> +	.id_table	= ltc4306_id,
>> +};
>> +
>> +module_i2c_driver(ltc4306_driver);
>> +
>> +MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
>> +MODULE_DESCRIPTION("Linear Technology LTC4306, LTC4305 I2C mux/switch driver");
>> +MODULE_LICENSE("GPL v2");
>>
>
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Otl-Aicher Strasse 60-64      80807 München
Sitz der Gesellschaft München, Registergericht München HRB 40368,
Geschäftsführer: Peter Kolberg, Ali Raza Husain, Eileen Wynne
