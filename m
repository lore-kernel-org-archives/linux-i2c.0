From: Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH] i2c/muxes/i2c-mux-ltc4306: LTC4306 and LTC4305 I2C
 multiplexer/switch
Date: Mon, 27 Mar 2017 13:07:42 +0200
Message-ID: <ae039eba-7487-f0ad-156f-da72a1d62b04@analog.com>
References: <1490278978-28357-1-git-send-email-michael.hennerich@analog.com>
 <5e4b224d-4dba-e183-4eda-d68f57faff7e@axentia.se>
Reply-To: <michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-sn1nam02on0042.outbound.protection.outlook.com ([104.47.36.42]:58659
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752054AbdC0LJE (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 27 Mar 2017 07:09:04 -0400
In-Reply-To: <5e4b224d-4dba-e183-4eda-d68f57faff7e@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, linus.walleij@linaro.org
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org

On 24.03.2017 09:01, Peter Rosin wrote:
> On 2017-03-23 15:22, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
>> This patch adds support for the Analog Devices / Linear Technology
>> LTC4306 and LTC4305 4/2 Channel I2C Bus Multiplexer/Switches.
>> The LTC4306 optionally provides two general purpose input/output pins
>> (GPIOs) that can be configured as logic inputs, opendrain outputs or
>> push-pull outputs via the generic GPIOLIB framework.

Hi Peter,

Thanks for your review.

>
> Hmmm, I'm not sure if it is ok to implement a gpio provider outside of
> drivers/gpio like this? Should it be done with MFD, or is that just
> adding needless complexity?

Its not uncommon to have these small gpiochips inside the driver which 
implements the primary function. Linus is on the To list to add his review.

>
> I also wonder if you have thought about implementing support for
> alerts? And do you need recovery if things get stuck? I see timeout
> bits and failure to connect bits in the register map...

The irq_chip handling the ALERTs will be added in future. However I 
don't think the chip internal timeout handling will be exposed. I would 
assume the parent adapter handles timeouts on the connected downstream 
ports.

>
>>
>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>> ---
>>  .../devicetree/bindings/i2c/i2c-mux-ltc4306.txt    |  61 ++++
>>  MAINTAINERS                                        |   8 +
>>  drivers/i2c/muxes/Kconfig                          |  10 +
>>  drivers/i2c/muxes/Makefile                         |   1 +
>>  drivers/i2c/muxes/i2c-mux-ltc4306.c                | 365 +++++++++++++++++++++
>>  5 files changed, 445 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
>>  create mode 100644 drivers/i2c/muxes/i2c-mux-ltc4306.c
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
>> new file mode 100644
>> index 0000000..1e98c6b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
>> @@ -0,0 +1,61 @@
>> +* Linear Technology / Analog Devices I2C bus switch
>> +
>> +Required Properties:
>> +
>> +  - compatible: Must contain one of the following.
>> +    "lltc,ltc4305", "lltc,ltc4306"
>> +  - reg: The I2C address of the device.
>> +
>> +  The following required properties are defined externally:
>> +
>> +  - Standard I2C mux properties. See i2c-mux.txt in this directory.
>> +  - I2C child bus nodes. See i2c-mux.txt in this directory.
>> +
>> +Optional Properties:
>> +
>> +  - enable-gpios: Reference to the GPIO connected to the enable input.
>> +  - i2c-mux-idle-disconnect: Boolean; if defined, forces mux to disconnect all
>> +    children in idle state. This is necessary for example, if there are several
>> +    multiplexers on the bus and the devices behind them use same I2C addresses.
>> +  - gpio-controller: Marks the device node as a GPIO Controller.
>> +  - #gpio-cells: Should be two.  The first cell is the pin number and
>> +	the second cell is used to specify flags.
>> +	See ../gpio/gpio.txt for more information.
>> +  - ltc,downstream-accelerators-enable: Enables the rise time accelerators
>> +	on the downstream port.
>> +  - ltc,upstream-accelerators-enable: Enables the rise time accelerators
>> +	on the upstream port.
>> +
>> +Example:
>> +
>> +	ltc4306: i2c-mux@4a {
>> +		compatible = "lltc,ltc4306";
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		reg = <0x4a>;
>> +
>> +		gpio-controller;
>> +		#gpio-cells = <2>;
>> +
>> +		i2c@0 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <0>;
>> +
>> +			eeprom@50 {
>> +				compatible = "at,24c02";
>> +				reg = <0x50>;
>> +			};
>> +		};
>> +
>> +		i2c@1 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <1>;
>> +
>> +			eeprom@50 {
>> +				compatible = "at,24c02";
>> +				reg = <0x50>;
>> +			};
>> +		};
>> +	};
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
>> index 10b3d17..f501b3b 100644
>> --- a/drivers/i2c/muxes/Kconfig
>> +++ b/drivers/i2c/muxes/Kconfig
>> @@ -30,6 +30,16 @@ config I2C_MUX_GPIO
>>  	  This driver can also be built as a module.  If so, the module
>>  	  will be called i2c-mux-gpio.
>>
>> +config I2C_MUX_LTC4306
>> +	tristate "LTC LTC4306/5 I2C multiplexer"
>> +	select GPIOLIB
>> +	help
>> +	  If you say yes here you get support for the LTC LTC4306 or LTC4305
>> +	  I2C mux/switch devices.
>> +
>> +	  This driver can also be built as a module.  If so, the module
>> +	  will be called i2c-mux-ltc4306.
>> +
>>  config I2C_MUX_PCA9541
>>  	tristate "NXP PCA9541 I2C Master Selector"
>>  	help
>> diff --git a/drivers/i2c/muxes/Makefile b/drivers/i2c/muxes/Makefile
>> index 9948fa4..a452d09 100644
>> --- a/drivers/i2c/muxes/Makefile
>> +++ b/drivers/i2c/muxes/Makefile
>> @@ -7,6 +7,7 @@ obj-$(CONFIG_I2C_DEMUX_PINCTRL)		+= i2c-demux-pinctrl.o
>>
>>  obj-$(CONFIG_I2C_MUX_GPIO)	+= i2c-mux-gpio.o
>>  obj-$(CONFIG_I2C_MUX_MLXCPLD)	+= i2c-mux-mlxcpld.o
>> +obj-$(CONFIG_I2C_MUX_LTC4306)	+= i2c-mux-ltc4306.o
>
> Keep the list sorted, please.
>
>>  obj-$(CONFIG_I2C_MUX_PCA9541)	+= i2c-mux-pca9541.o
>>  obj-$(CONFIG_I2C_MUX_PCA954x)	+= i2c-mux-pca954x.o
>>  obj-$(CONFIG_I2C_MUX_PINCTRL)	+= i2c-mux-pinctrl.o
>> diff --git a/drivers/i2c/muxes/i2c-mux-ltc4306.c b/drivers/i2c/muxes/i2c-mux-ltc4306.c
>> new file mode 100644
>> index 0000000..f0fd4d1
>> --- /dev/null
>> +++ b/drivers/i2c/muxes/i2c-mux-ltc4306.c
>> @@ -0,0 +1,365 @@
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
>> +#include <linux/i2c.h>
>> +#include <linux/i2c-mux.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/gpio.h>
>> +#include <linux/gpio/driver.h>
>> +#include <linux/gpio/consumer.h>
>
> Sort the includes, please.
>
>> +
>> +#define LTC4306_MAX_NCHANS 4
>
> Why not a define for LTC4305_MAX_NCHANS as well?
>
>> +
>> +#define LTC_REG_STATUS	0x0
>> +#define LTC_REG_CONFIG	0x1
>> +#define LTC_REG_MODE	0x2
>> +#define LTC_REG_SWITCH	0x3
>> +
>> +#define LTC_DOWNSTREAM_ACCL_EN BIT(6)
>> +#define LTC_UPSTREAM_ACCL_EN BIT(7)
>> +
>> +#define LTC_GPIO_ALL_INPUT	0xC0
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
>> +	struct i2c_client *client;
>> +	struct gpio_chip gpiochip;
>> +	const struct chip_desc *chip;
>> +
>> +	u8 deselect;
>> +	u8 regs[LTC_REG_SWITCH + 1];
>
> Feels like a generic register cache, can you use regmap?

Regmap could do this and it may work. But to my knowledge it's not 
recommended to mix regmap with direct smbus or direct adaptor transactions.

>
>> +};
>> +
>> +/* Provide specs for the PCA954x types we know about */
>> +static const struct chip_desc chips[] = {
>> +	[ltc_4305] = {
>> +		.nchans = 2,
>> +	},
>> +	[ltc_4306] = {
>> +		.nchans = LTC4306_MAX_NCHANS,
>> +		.num_gpios = 2,
>> +	},
>> +};
>> +
>> +static int ltc4306_gpio_get(struct gpio_chip *chip, unsigned int offset)
>> +{
>> +	struct ltc4306 *data = gpiochip_get_data(chip);
>> +	int ret = 0;
>> +
>> +	if (gpiochip_line_is_open_drain(chip, offset) ||
>> +		(data->regs[LTC_REG_MODE] & BIT(7 - offset))) {
>
> Alignment should match open parenthesis.
>
>> +		/* Open Drain or Input */
>> +		ret = i2c_smbus_read_byte_data(data->client, LTC_REG_CONFIG);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		return !!(ret & BIT(1 - offset));
>> +	} else {
>> +		return !!(data->regs[LTC_REG_CONFIG] & BIT(5 - offset));
>> +	}
>> +}
>> +
>> +static void ltc4306_gpio_set(struct gpio_chip *chip, unsigned int offset,
>> +			     int value)
>> +{
>> +	struct ltc4306 *data = gpiochip_get_data(chip);
>> +
>> +	if (value)
>> +		data->regs[LTC_REG_CONFIG] |= BIT(5 - offset);
>> +	else
>> +		data->regs[LTC_REG_CONFIG] &= ~BIT(5 - offset);
>> +
>> +
>
> Please don't use multiple blank lines.
>
>> +	i2c_smbus_write_byte_data(data->client, LTC_REG_CONFIG,
>> +				 data->regs[LTC_REG_CONFIG]);
>
> Alignment should match open parenthesis.
>
>> +}
>> +
>> +static int ltc4306_gpio_direction_input(struct gpio_chip *chip,
>> +					unsigned int offset)
>> +{
>> +	struct ltc4306 *data = gpiochip_get_data(chip);
>> +
>> +	data->regs[LTC_REG_MODE] |= BIT(7 - offset);
>> +
>> +	return i2c_smbus_write_byte_data(data->client, LTC_REG_MODE,
>> +					 data->regs[LTC_REG_MODE]);
>> +}
>> +
>> +static int ltc4306_gpio_direction_output(struct gpio_chip *chip,
>> +					 unsigned int offset, int value)
>> +{
>> +	struct ltc4306 *data = gpiochip_get_data(chip);
>> +
>> +	ltc4306_gpio_set(chip, offset, value);
>> +	data->regs[LTC_REG_MODE] &= ~BIT(7 - offset);
>> +
>> +	return i2c_smbus_write_byte_data(data->client, LTC_REG_MODE,
>> +					 data->regs[LTC_REG_MODE]);
>> +}
>> +
>> +static int ltc4306_gpio_set_config(struct gpio_chip *chip,
>> +				   unsigned int offset, unsigned long config)
>> +{
>> +	struct ltc4306 *data = gpiochip_get_data(chip);
>> +
>> +	switch (pinconf_to_config_param(config)) {
>> +	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
>> +		data->regs[LTC_REG_MODE] &= ~BIT(4 - offset);
>> +		break;
>> +	case PIN_CONFIG_DRIVE_PUSH_PULL:
>> +		data->regs[LTC_REG_MODE] |= BIT(4 - offset);
>> +		break;
>> +	default:
>> +		return -ENOTSUPP;
>> +	}
>> +
>> +	return i2c_smbus_write_byte_data(data->client, LTC_REG_MODE,
>> +					 data->regs[LTC_REG_MODE]);
>> +}
>> +
>> +static int ltc4306_gpio_init(struct ltc4306 *data)
>> +{
>> +	if (!data->chip->num_gpios)
>> +		return 0;
>> +
>> +	data->gpiochip.label = dev_name(&data->client->dev);
>> +	data->gpiochip.base = -1;
>> +	data->gpiochip.ngpio = data->chip->num_gpios;
>> +	data->gpiochip.parent = &data->client->dev;
>> +	data->gpiochip.can_sleep = true;
>> +	data->gpiochip.direction_input = ltc4306_gpio_direction_input;
>> +	data->gpiochip.direction_output = ltc4306_gpio_direction_output;
>> +	data->gpiochip.get = ltc4306_gpio_get;
>> +	data->gpiochip.set = ltc4306_gpio_set;
>> +	data->gpiochip.set_config = ltc4306_gpio_set_config;
>> +	data->gpiochip.owner = THIS_MODULE;
>> +
>> +	/* gpiolib assumes all GPIOs default input */
>> +	data->regs[LTC_REG_MODE] |= LTC_GPIO_ALL_INPUT;
>> +	i2c_smbus_write_byte_data(data->client, LTC_REG_MODE,
>> +					 data->regs[LTC_REG_MODE]);
>
> Alignment should match open parenthesis.
>
>> +
>> +	return devm_gpiochip_add_data(&data->client->dev,
>> +				      &data->gpiochip, data);
>> +}
>> +
>> +/*
>> + * Write to chip register. Don't use i2c_transfer()/i2c_smbus_xfer()
>> + * as they will try to lock the adapter a second time.
>> + */
>> +static int ltc4306_reg_write(struct i2c_adapter *adap,
>> +			     struct i2c_client *client, u8 reg, u8 val)
>> +{
>> +	int ret;
>> +
>> +	if (adap->algo->master_xfer) {
>> +		struct i2c_msg msg;
>> +		char buf[2];
>> +
>> +		msg.addr = client->addr;
>> +		msg.flags = 0;
>> +		msg.len = 2;
>> +		buf[0] = reg;
>> +		buf[1] = val;
>> +		msg.buf = buf;
>> +		ret = __i2c_transfer(adap, &msg, 1);
>> +	} else {
>> +		union i2c_smbus_data data;
>> +
>> +		data.byte = val;
>> +		ret = adap->algo->smbus_xfer(adap, client->addr,
>> +					     client->flags,
>> +					     I2C_SMBUS_WRITE,
>> +					     reg,
>> +					     I2C_SMBUS_BYTE_DATA, &data);
>> +	}
>> +
>> +	return ret;
>> +}
>
> You have selected to go parent-locked, but you can get rid of the above
> workaround if you go mux-locked. See Documentation/i2c/i2c-topology for
> how these differ. Overall, since you do have the GPIO possibility, I think
> you are closing some possibilities by going parent-locked. Those GPIOs
> will more easily get locked out if you build a complex tree involving
> these muxes, when the mux is parent-locked.
>
> But on the other hand, mux-locked doesn't work everywhere either, the person
> who needs mux-locked can add that option if you don't want to...

For now we stay parent-locked.

>
>> +static int ltc4306_select_chan(struct i2c_mux_core *muxc, u32 chan)
>> +{
>> +	struct ltc4306 *data = i2c_mux_priv(muxc);
>> +	struct i2c_client *client = data->client;
>> +	u8 regval;
>> +	int ret = 0;
>> +
>> +	regval = BIT(7 - chan);
>> +
>> +	/* Only select the channel if its different from the last channel */
>> +	if (data->regs[LTC_REG_SWITCH] != regval) {
>> +		ret = ltc4306_reg_write(muxc->parent, client,
>> +					LTC_REG_SWITCH, regval);
>> +		data->regs[LTC_REG_SWITCH] = ret < 0 ? 0 : regval;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int ltc4306_deselect_mux(struct i2c_mux_core *muxc, u32 chan)
>> +{
>> +	struct ltc4306 *data = i2c_mux_priv(muxc);
>> +	struct i2c_client *client = data->client;
>> +
>> +	if (!(data->deselect & BIT(chan)))
>> +		return 0;
>> +
>> +	/* Deselect active channel */
>> +	data->regs[LTC_REG_SWITCH] = 0;
>> +
>> +	return ltc4306_reg_write(muxc->parent, client,
>> +				 LTC_REG_SWITCH, data->regs[LTC_REG_SWITCH]);
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
>> +	bool idle_disconnect_dt = false;
>> +	struct gpio_desc *gpio;
>> +	struct i2c_mux_core *muxc;
>> +	struct ltc4306 *data;
>> +	const struct of_device_id *match;
>> +	int num, ret;
>> +
>> +	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE_DATA))
>> +		return -ENODEV;
>> +
>> +	muxc = i2c_mux_alloc(adap, &client->dev,
>> +			     LTC4306_MAX_NCHANS, sizeof(*data), 0,
>> +			     ltc4306_select_chan, ltc4306_deselect_mux);
>
> Where's the symmetry in ..._chan for select and ..._mux for deselect?
>
>> +	if (!muxc)
>> +		return -ENOMEM;
>> +	data = i2c_mux_priv(muxc);
>> +
>> +	i2c_set_clientdata(client, muxc);
>> +	data->client = client;
>> +
>> +	/* Enable the mux if a enable GPIO is specified. */
>
> s/ a / an /
>
>> +	gpio = devm_gpiod_get_optional(&client->dev, "enable", GPIOD_OUT_HIGH);
>> +	if (IS_ERR(gpio))
>> +		return PTR_ERR(gpio);
>
> Should you not use this pin later as well? In suspend/resume if you add
> handling for that?

My assumption was that freed GPIOs return to input.
This doesn't seem to be the case. I'll configure the enable GPIO to 
INPUT on error and removal. This way an external PULL-UP or PULL-DOWN 
defines the expected behavior, since a HIGH->LOW transition may also 
reset the chip.

>
>> +
>> +	/* Write the mux register at addr to verify
>> +	 * that the mux is in fact present. This also
>> +	 * initializes the mux to disconnected state.
>> +	 */
>
> Multi-line comments should start with a /* on its own line.
>
>> +	if (i2c_smbus_write_byte_data(client, LTC_REG_SWITCH, 0) < 0) {
>> +		dev_warn(&client->dev, "probe failed\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	match = of_match_device(of_match_ptr(ltc4306_of_match), &client->dev);
>
> Just call of_device_get_match_data() directly.

I'll move of_device_get_match_data() into the of_node clause below.

>
>> +	if (match)
>> +		data->chip = of_device_get_match_data(&client->dev);
>> +	else
>> +		data->chip = &chips[id->driver_data];
>> +
>> +	if (of_node) {
>> +		idle_disconnect_dt =
>> +			of_property_read_bool(of_node,
>> +					      "i2c-mux-idle-disconnect");
>> +		if (of_property_read_bool(of_node,
>> +					  "ltc,downstream-accelerators-enable"))
>> +			data->regs[LTC_REG_CONFIG] |= LTC_DOWNSTREAM_ACCL_EN;
>> +
>> +		if (of_property_read_bool(of_node,
>> +					  "ltc,upstream-accelerators-enable"))
>> +			data->regs[LTC_REG_CONFIG] |= LTC_UPSTREAM_ACCL_EN;
>> +
>> +		if (i2c_smbus_write_byte_data(client, LTC_REG_CONFIG,
>> +					      data->regs[LTC_REG_CONFIG]) < 0) {
>> +			dev_warn(&client->dev, "probe failed\n");
>> +			return -ENODEV;
>> +		}
>> +	}
>> +
>> +	ret = ltc4306_gpio_init(data);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* Now create an adapter for each channel */
>> +	for (num = 0; num < data->chip->nchans; num++) {
>> +
>
> Blank lines aren't necessary after an open brace.
>
>> +		data->deselect |= idle_disconnect_dt << num;
>
> Either *all* relevant bits are 1 or *all* relevant bits are 0. You
> can get rid of this variable and invoke i2c_mux_alloc with NULL
> instead of ltc4306_deselect_mux when not configured to disconnect
> the mux. You have to delay the mux allocation to later in probe,
> but I don't think it will be too hairy to accomplish that?

Yeah - that's easy.



-- 
Greetings,
Michael

--
Analog Devices GmbH      Otl-Aicher Strasse 60-64      80807 München
Sitz der Gesellschaft München, Registergericht München HRB 40368,
Geschäftsführer: Peter Kolberg, Ali Raza Husain, Eileen Wynne
