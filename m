From: <michael.hennerich@analog.com>
Subject: [PATCH v2] i2c/muxes/i2c-mux-ltc4306: LTC4306 and LTC4305 I2C multiplexer/switch
Date: Wed, 29 Mar 2017 12:15:41 +0200
Message-ID: <1490782541-7832-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, peda@axentia.se, robh+dt@kernel.org, mark.rutland@arm.com, linus.walleij@linaro.org
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>
List-Id: linux-i2c@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

This patch adds support for the Analog Devices / Linear Technology
LTC4306 and LTC4305 4/2 Channel I2C Bus Multiplexer/Switches.
The LTC4306 optionally provides two general purpose input/output pins
(GPIOs) that can be configured as logic inputs, opendrain outputs or
push-pull outputs via the generic GPIOLIB framework.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>

---

Changes since v1:

 - Sort makefile entries
 - Sort driver includes
 - Use proper defines
 - Miscellaneous coding style fixups
 - Rename mux select callback
 - Revise i2c-mux-idle-disconnect handling
 - Add ENABLE GPIO handling on error and device removal.
 - Remove surplus of_match_device call.
---
 .../devicetree/bindings/i2c/i2c-mux-ltc4306.txt    |  61 ++++
 MAINTAINERS                                        |   8 +
 drivers/i2c/muxes/Kconfig                          |  10 +
 drivers/i2c/muxes/Makefile                         |   1 +
 drivers/i2c/muxes/i2c-mux-ltc4306.c                | 367 +++++++++++++++++++++
 5 files changed, 447 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
 create mode 100644 drivers/i2c/muxes/i2c-mux-ltc4306.c

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
new file mode 100644
index 0000000..1e98c6b
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
@@ -0,0 +1,61 @@
+* Linear Technology / Analog Devices I2C bus switch
+
+Required Properties:
+
+  - compatible: Must contain one of the following.
+    "lltc,ltc4305", "lltc,ltc4306"
+  - reg: The I2C address of the device.
+
+  The following required properties are defined externally:
+
+  - Standard I2C mux properties. See i2c-mux.txt in this directory.
+  - I2C child bus nodes. See i2c-mux.txt in this directory.
+
+Optional Properties:
+
+  - enable-gpios: Reference to the GPIO connected to the enable input.
+  - i2c-mux-idle-disconnect: Boolean; if defined, forces mux to disconnect all
+    children in idle state. This is necessary for example, if there are several
+    multiplexers on the bus and the devices behind them use same I2C addresses.
+  - gpio-controller: Marks the device node as a GPIO Controller.
+  - #gpio-cells: Should be two.  The first cell is the pin number and
+	the second cell is used to specify flags.
+	See ../gpio/gpio.txt for more information.
+  - ltc,downstream-accelerators-enable: Enables the rise time accelerators
+	on the downstream port.
+  - ltc,upstream-accelerators-enable: Enables the rise time accelerators
+	on the upstream port.
+
+Example:
+
+	ltc4306: i2c-mux@4a {
+		compatible = "lltc,ltc4306";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x4a>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			eeprom@50 {
+				compatible = "at,24c02";
+				reg = <0x50>;
+			};
+		};
+
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			eeprom@50 {
+				compatible = "at,24c02";
+				reg = <0x50>;
+			};
+		};
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index c776906..9a27a19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7698,6 +7698,14 @@ S:	Maintained
 F:	Documentation/hwmon/ltc4261
 F:	drivers/hwmon/ltc4261.c
 
+LTC4306 I2C MULTIPLEXER DRIVER
+M:	Michael Hennerich <michael.hennerich@analog.com>
+W:	http://ez.analog.com/community/linux-device-drivers
+L:	linux-i2c@vger.kernel.org
+S:	Supported
+F:	drivers/i2c/muxes/i2c-mux-ltc4306.c
+F:	Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
+
 LTP (Linux Test Project)
 M:	Mike Frysinger <vapier@gentoo.org>
 M:	Cyril Hrubis <chrubis@suse.cz>
diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
index 10b3d17..f501b3b 100644
--- a/drivers/i2c/muxes/Kconfig
+++ b/drivers/i2c/muxes/Kconfig
@@ -30,6 +30,16 @@ config I2C_MUX_GPIO
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-mux-gpio.
 
+config I2C_MUX_LTC4306
+	tristate "LTC LTC4306/5 I2C multiplexer"
+	select GPIOLIB
+	help
+	  If you say yes here you get support for the LTC LTC4306 or LTC4305
+	  I2C mux/switch devices.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-mux-ltc4306.
+
 config I2C_MUX_PCA9541
 	tristate "NXP PCA9541 I2C Master Selector"
 	help
diff --git a/drivers/i2c/muxes/Makefile b/drivers/i2c/muxes/Makefile
index 9948fa4..ff7618c 100644
--- a/drivers/i2c/muxes/Makefile
+++ b/drivers/i2c/muxes/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_I2C_ARB_GPIO_CHALLENGE)	+= i2c-arb-gpio-challenge.o
 obj-$(CONFIG_I2C_DEMUX_PINCTRL)		+= i2c-demux-pinctrl.o
 
 obj-$(CONFIG_I2C_MUX_GPIO)	+= i2c-mux-gpio.o
+obj-$(CONFIG_I2C_MUX_LTC4306)	+= i2c-mux-ltc4306.o
 obj-$(CONFIG_I2C_MUX_MLXCPLD)	+= i2c-mux-mlxcpld.o
 obj-$(CONFIG_I2C_MUX_PCA9541)	+= i2c-mux-pca9541.o
 obj-$(CONFIG_I2C_MUX_PCA954x)	+= i2c-mux-pca954x.o
diff --git a/drivers/i2c/muxes/i2c-mux-ltc4306.c b/drivers/i2c/muxes/i2c-mux-ltc4306.c
new file mode 100644
index 0000000..c15a8a4
--- /dev/null
+++ b/drivers/i2c/muxes/i2c-mux-ltc4306.c
@@ -0,0 +1,367 @@
+/*
+ * Linear Technology LTC4306 and LTC4305 I2C multiplexer/switch
+ *
+ * Copyright (C) 2017 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ *
+ * Based on: i2c-mux-pca954x.c
+ *
+ * Datasheet: http://cds.linear.com/docs/en/datasheet/4306.pdf
+ */
+
+#include <linux/device.h>
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio/driver.h>
+#include <linux/i2c-mux.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/slab.h>
+
+#define LTC4305_MAX_NCHANS 2
+#define LTC4306_MAX_NCHANS 4
+
+#define LTC_REG_STATUS	0x0
+#define LTC_REG_CONFIG	0x1
+#define LTC_REG_MODE	0x2
+#define LTC_REG_SWITCH	0x3
+
+#define LTC_DOWNSTREAM_ACCL_EN BIT(6)
+#define LTC_UPSTREAM_ACCL_EN BIT(7)
+
+#define LTC_GPIO_ALL_INPUT	0xC0
+
+enum ltc_type {
+	ltc_4305,
+	ltc_4306,
+};
+
+struct chip_desc {
+	u8 nchans;
+	u8 num_gpios;
+};
+
+struct ltc4306 {
+	struct i2c_client *client;
+	struct gpio_desc *en_gpio;
+	struct gpio_chip gpiochip;
+	const struct chip_desc *chip;
+	u8 regs[LTC_REG_SWITCH + 1];
+};
+
+/* Provide specs for the PCA954x types we know about */
+static const struct chip_desc chips[] = {
+	[ltc_4305] = {
+		.nchans = LTC4305_MAX_NCHANS,
+	},
+	[ltc_4306] = {
+		.nchans = LTC4306_MAX_NCHANS,
+		.num_gpios = 2,
+	},
+};
+
+static int ltc4306_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct ltc4306 *data = gpiochip_get_data(chip);
+	int ret = 0;
+
+	if (gpiochip_line_is_open_drain(chip, offset) ||
+	    (data->regs[LTC_REG_MODE] & BIT(7 - offset))) {
+		/* Open Drain or Input */
+		ret = i2c_smbus_read_byte_data(data->client, LTC_REG_CONFIG);
+		if (ret < 0)
+			return ret;
+
+		return !!(ret & BIT(1 - offset));
+	} else {
+		return !!(data->regs[LTC_REG_CONFIG] & BIT(5 - offset));
+	}
+}
+
+static void ltc4306_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			     int value)
+{
+	struct ltc4306 *data = gpiochip_get_data(chip);
+
+	if (value)
+		data->regs[LTC_REG_CONFIG] |= BIT(5 - offset);
+	else
+		data->regs[LTC_REG_CONFIG] &= ~BIT(5 - offset);
+
+	i2c_smbus_write_byte_data(data->client, LTC_REG_CONFIG,
+				  data->regs[LTC_REG_CONFIG]);
+}
+
+static int ltc4306_gpio_direction_input(struct gpio_chip *chip,
+					unsigned int offset)
+{
+	struct ltc4306 *data = gpiochip_get_data(chip);
+
+	data->regs[LTC_REG_MODE] |= BIT(7 - offset);
+
+	return i2c_smbus_write_byte_data(data->client, LTC_REG_MODE,
+					 data->regs[LTC_REG_MODE]);
+}
+
+static int ltc4306_gpio_direction_output(struct gpio_chip *chip,
+					 unsigned int offset, int value)
+{
+	struct ltc4306 *data = gpiochip_get_data(chip);
+
+	ltc4306_gpio_set(chip, offset, value);
+	data->regs[LTC_REG_MODE] &= ~BIT(7 - offset);
+
+	return i2c_smbus_write_byte_data(data->client, LTC_REG_MODE,
+					 data->regs[LTC_REG_MODE]);
+}
+
+static int ltc4306_gpio_set_config(struct gpio_chip *chip,
+				   unsigned int offset, unsigned long config)
+{
+	struct ltc4306 *data = gpiochip_get_data(chip);
+
+	switch (pinconf_to_config_param(config)) {
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		data->regs[LTC_REG_MODE] &= ~BIT(4 - offset);
+		break;
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		data->regs[LTC_REG_MODE] |= BIT(4 - offset);
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	return i2c_smbus_write_byte_data(data->client, LTC_REG_MODE,
+					 data->regs[LTC_REG_MODE]);
+}
+
+static int ltc4306_gpio_init(struct ltc4306 *data)
+{
+	if (!data->chip->num_gpios)
+		return 0;
+
+	data->gpiochip.label = dev_name(&data->client->dev);
+	data->gpiochip.base = -1;
+	data->gpiochip.ngpio = data->chip->num_gpios;
+	data->gpiochip.parent = &data->client->dev;
+	data->gpiochip.can_sleep = true;
+	data->gpiochip.direction_input = ltc4306_gpio_direction_input;
+	data->gpiochip.direction_output = ltc4306_gpio_direction_output;
+	data->gpiochip.get = ltc4306_gpio_get;
+	data->gpiochip.set = ltc4306_gpio_set;
+	data->gpiochip.set_config = ltc4306_gpio_set_config;
+	data->gpiochip.owner = THIS_MODULE;
+
+	/* gpiolib assumes all GPIOs default input */
+	data->regs[LTC_REG_MODE] |= LTC_GPIO_ALL_INPUT;
+	i2c_smbus_write_byte_data(data->client, LTC_REG_MODE,
+				  data->regs[LTC_REG_MODE]);
+
+	return devm_gpiochip_add_data(&data->client->dev,
+				      &data->gpiochip, data);
+}
+
+/*
+ * Write to chip register. Don't use i2c_transfer()/i2c_smbus_xfer()
+ * as they will try to lock the adapter a second time.
+ */
+static int ltc4306_reg_write(struct i2c_adapter *adap,
+			     struct i2c_client *client, u8 reg, u8 val)
+{
+	int ret;
+
+	if (adap->algo->master_xfer) {
+		struct i2c_msg msg;
+		char buf[2];
+
+		msg.addr = client->addr;
+		msg.flags = 0;
+		msg.len = 2;
+		buf[0] = reg;
+		buf[1] = val;
+		msg.buf = buf;
+		ret = __i2c_transfer(adap, &msg, 1);
+	} else {
+		union i2c_smbus_data data;
+
+		data.byte = val;
+		ret = adap->algo->smbus_xfer(adap, client->addr,
+					     client->flags,
+					     I2C_SMBUS_WRITE,
+					     reg,
+					     I2C_SMBUS_BYTE_DATA, &data);
+	}
+
+	return ret;
+}
+
+static int ltc4306_select_mux(struct i2c_mux_core *muxc, u32 chan)
+{
+	struct ltc4306 *data = i2c_mux_priv(muxc);
+	struct i2c_client *client = data->client;
+	u8 regval;
+	int ret = 0;
+
+	regval = BIT(7 - chan);
+
+	/* Only select the channel if its different from the last channel */
+	if (data->regs[LTC_REG_SWITCH] != regval) {
+		ret = ltc4306_reg_write(muxc->parent, client,
+					LTC_REG_SWITCH, regval);
+		data->regs[LTC_REG_SWITCH] = ret < 0 ? 0 : regval;
+	}
+
+	return ret;
+}
+
+static int ltc4306_deselect_mux(struct i2c_mux_core *muxc, u32 chan)
+{
+	struct ltc4306 *data = i2c_mux_priv(muxc);
+	struct i2c_client *client = data->client;
+
+	/* Deselect all channels */
+	data->regs[LTC_REG_SWITCH] = 0;
+
+	return ltc4306_reg_write(muxc->parent, client,
+				 LTC_REG_SWITCH, data->regs[LTC_REG_SWITCH]);
+}
+
+static const struct i2c_device_id ltc4306_id[] = {
+	{ "ltc4305", ltc_4305 },
+	{ "ltc4306", ltc_4306 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ltc4306_id);
+
+static const struct of_device_id ltc4306_of_match[] = {
+	{ .compatible = "lltc,ltc4305", .data = &chips[ltc_4305] },
+	{ .compatible = "lltc,ltc4306", .data = &chips[ltc_4306] },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ltc4306_of_match);
+
+static int ltc4306_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
+	struct device_node *of_node = client->dev.of_node;
+	bool idle_disconnect_dt = false;
+	struct i2c_mux_core *muxc;
+	struct ltc4306 *data;
+	int num, ret;
+
+	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -ENODEV;
+
+	if (of_node) {
+		idle_disconnect_dt =
+		of_property_read_bool(of_node,
+				      "i2c-mux-idle-disconnect");
+	}
+
+	muxc = i2c_mux_alloc(adap, &client->dev,
+			     LTC4306_MAX_NCHANS, sizeof(*data), 0,
+			     ltc4306_select_mux, idle_disconnect_dt ?
+			     ltc4306_deselect_mux : NULL);
+	if (!muxc)
+		return -ENOMEM;
+	data = i2c_mux_priv(muxc);
+
+	i2c_set_clientdata(client, muxc);
+	data->client = client;
+
+	/* Enable the mux if an enable GPIO is specified. */
+	data->en_gpio = devm_gpiod_get_optional(&client->dev, "enable",
+						GPIOD_OUT_HIGH);
+	if (IS_ERR(data->en_gpio))
+		return PTR_ERR(data->en_gpio);
+
+	/*
+	 * Write the mux register at addr to verify
+	 * that the mux is in fact present. This also
+	 * initializes the mux to disconnected state.
+	 */
+	if (i2c_smbus_write_byte_data(client, LTC_REG_SWITCH, 0) < 0) {
+		dev_warn(&client->dev, "probe failed\n");
+		ret = -ENODEV;
+		goto gpio_default;
+	}
+
+	if (of_node) {
+		data->chip = of_device_get_match_data(&client->dev);
+
+		if (of_property_read_bool(of_node,
+					  "ltc,downstream-accelerators-enable"))
+			data->regs[LTC_REG_CONFIG] |= LTC_DOWNSTREAM_ACCL_EN;
+
+		if (of_property_read_bool(of_node,
+					  "ltc,upstream-accelerators-enable"))
+			data->regs[LTC_REG_CONFIG] |= LTC_UPSTREAM_ACCL_EN;
+
+		if (i2c_smbus_write_byte_data(client, LTC_REG_CONFIG,
+					      data->regs[LTC_REG_CONFIG]) < 0) {
+			dev_warn(&client->dev, "probe failed\n");
+			ret = -ENODEV;
+			goto gpio_default;
+		}
+	} else {
+		data->chip = &chips[id->driver_data];
+	}
+
+	ret = ltc4306_gpio_init(data);
+	if (ret < 0)
+		goto gpio_default;
+
+	/* Now create an adapter for each channel */
+	for (num = 0; num < data->chip->nchans; num++) {
+		ret = i2c_mux_add_adapter(muxc, 0, num, 0);
+		if (ret) {
+			dev_err(&client->dev,
+				"failed to register multiplexed adapter %d\n",
+				num);
+			goto add_adapter_failed;
+		}
+	}
+
+	dev_info(&client->dev,
+		 "registered %d multiplexed busses for I2C switch %s\n",
+		 num, client->name);
+
+	return 0;
+
+add_adapter_failed:
+	i2c_mux_del_adapters(muxc);
+gpio_default:
+	gpiod_direction_input(data->en_gpio);
+	return ret;
+}
+
+static int ltc4306_remove(struct i2c_client *client)
+{
+	struct i2c_mux_core *muxc = i2c_get_clientdata(client);
+	struct ltc4306 *data = i2c_mux_priv(muxc);
+
+	i2c_mux_del_adapters(muxc);
+	gpiod_direction_input(data->en_gpio);
+
+	return 0;
+}
+
+static struct i2c_driver ltc4306_driver = {
+	.driver		= {
+		.name	= "ltc4306",
+		.of_match_table = of_match_ptr(ltc4306_of_match),
+	},
+	.probe		= ltc4306_probe,
+	.remove		= ltc4306_remove,
+	.id_table	= ltc4306_id,
+};
+
+module_i2c_driver(ltc4306_driver);
+
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
+MODULE_DESCRIPTION("Linear Technology LTC4306, LTC4305 I2C mux/switch driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
