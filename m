From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Subject: [RFC 1/3] of: Portable Device Tree connector
Date: Fri,  3 Jun 2016 23:37:51 +0300
Message-ID: <1464986273-12039-2-git-send-email-pantelis.antoniou@konsulko.com>
References: <1464986273-12039-1-git-send-email-pantelis.antoniou@konsulko.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464986273-12039-1-git-send-email-pantelis.antoniou@konsulko.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Frank Rowand <frowand.list@gmail.com>, Matt Porter <mporter@konsulko.com>, Koen Kooi <koen@dominion.thruhere.net>, Guenter Roeck <linux@roeck-us.net>, Marek Vasut <marex@denx.de>, Wolfram Sang <wsa@the-dreams.de>, Stephen Boyd <stephen.boyd@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Pantelis Antoniou <panto@antoniou-consulting.com>
List-Id: linux-i2c@vger.kernel.org

Introducing the portable device tree based connector.

It is a method of describing an expansion connector in such a way
that the hardware definition for devices present on the connector
are portable between any board that has a hardware compatible connector.

The connector will maintain the mapping of resources to
actual SoC level resources.

Take for example a simple four pin connector (FPC) which can
be configured as a serial port, an i2c bus or
general purpose gpios.

In connector terms the connector is defined as follows:

FPC: fpc {
	compatible = "extcon,dt-con";
	status = "okay";

	connector {
		#address-cells = <1>;
		#size-cells = <0>;

		P0: p0 {
			reg = <0>;
			gpio = <&gpio0 10>;
		};

		P1: p1 {
			reg = <1>;
			gpio = <&gpio1 8>;
		};

		P2: p2 {
			reg = <2>;
			gpio = <&gpio0 4>;
		};

		P3: p3 {
			reg = <3>;
			gpio = <&gpio2 0>;
		};
	};

};

The 'reg' property contains the address of the connector pin; it's the
pin# from the schematic usually. If the connector contains more than one
physical connectors the address may be of the form
< connector-nr pin-nr>

The gpio property is present when that pin can be configured as a gpio
and points to the real board level gpio chip and gpio number.

Note that the connector node may contain arbitrary properties that
may be used for informational purposes. I.e. a property may be the SoC
pad name that the connector pin is routed from.

&FPC {
	functions {
		gpio {
			gpio-base = <256>;
		};

		uart {
			params {
				#param-cells = <2>;
				generate-pinctrl;

				txd {
					required;
					connector-pin;
				};

				rxd {
					required;
					connector-pin;
				};

			};

			uart0 {
				device = <&uart0>;
				mux@0 {
					txd = <&P0 &uart0_txd>;
					rxd = <&P1 &uart0_rxd_mux0>,
					      <&P3 &uart0_rxd_mux1>;
				};
			};
			uart1 {
				device = <&uart1>;
				mux@0 {
					txd = <&P2 &uart1_txd>;
					rxd = <&P3 &uart1_rxd>;
				};
			};
		};

		i2c {
			params {
				#param-cells = <2>;
				copy-subdevices;
				generate-pinctrl;

				scl {
					required;
					connector-pin;
				};

				sda {
					required;
					connector-pin;
				};

				clock-frequency {
					copy;
				};
			};
			i2c0 {
				device = <&i2c2>;
				mux@0 {
					scl = <&P1 &i2c2_scl>;
					sda = <&P2 &i2c2_sda>;
				};
			};
		};
	};
};

For each function that the connector provides a functions nodes
containing the possible configurations.

For this connector, all four pins can be GPIOs.
Two uarts are routed to the connector.
uart0 with txd at P0 and rxd at either P1 or P3 via a mux option
uart1 with txd at P2 and rxd at P3.
The i2c2 device is routed with scl at P1 and sda at P2.

The parameters node for each function contains a list of the
supported parameters for this function.

For the uart there are two required parameters txd & rxd and the
are defined as connector-pin type.

For the i2c function the two required parameters are scl & sda
while the clock-frequency property will be copied verbatim to
the real hardware i2c device when instantiated.

&FPC {
	plugged {
		compatible = "simple-bus";
		#address-cells = <1>;
		#size-cells = <0>;

		UART {
			compatible = "dtcon-uart";
			status = "okay";
			txd = <0>;
			rxd = <1>;
		};

		LEDS {
			compatible = "simple-bus";
			#address-cells = <1>;
			#size-cells = <0>;

			GPIO_LEDS: gpio_leds {
				compatible = "dtcon-gpio";
				status = "okay";

				gpio-controller;
				#gpio-cells = <2>;

				pin-list = <2>,
					   <3>;
			};

			LEDS {
				compatible = "gpio-leds";
				status = "okay";

				jp0 {
					label = "jp0";
					gpios = <&GPIO_LEDS 0
						GPIO_ACTIVE_HIGH>;
				};
				jp1 {
					label = "jp1";
					gpios = <&GPIO_LEDS 1
						GPIO_ACTIVE_HIGH>;
				};
			};

			LIGHT_I2C {
				compatible = "dtcon-i2c";
				status = "disabled";

				scl = <1>;
				sda = <2>;

				#address-cells = <1>;
				#size-cells = <0>;

				clock-frequency = <100000>;

				/* Ambient light sensor */
				tsl2550@39 {
					compatible = "tsl,tsl2550";
					reg = <0x39>;
					status = "okay";
				};
			};
		};
	};
};

Any activated device nodes in the plugged node will be instantiated.

This example displays two enabled devices and one disabled.

The UART device selects the uart function at pins #0 & #1. The connector
will locate the backend device (uart0) select the right pinctrl by
injecting pinctrl-0 and pinctrl-names properties that are build
dynamically and activates the uart0 device.

The LEDS simple-bus defines a gpio chip forwarder at the two pins (2 & 3)
and creates a LED device using it.

The LIGHT_I2C device is disabled, but if enabled it will activate the
i2c2 real backend device while copying the clock-frequency property and
the ambient light sensor device.

Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
---
 drivers/extcon/Kconfig               |  20 ++
 drivers/extcon/Makefile              |   3 +
 drivers/extcon/extcon-dt-con-gpio.c  | 337 ++++++++++++++++++++++++
 drivers/extcon/extcon-dt-con-proxy.c | 480 ++++++++++++++++++++++++++++++++++
 drivers/extcon/extcon-dt-con.c       | 491 +++++++++++++++++++++++++++++++++++
 drivers/extcon/extcon-dt-con.h       |  93 +++++++
 6 files changed, 1424 insertions(+)
 create mode 100644 drivers/extcon/extcon-dt-con-gpio.c
 create mode 100644 drivers/extcon/extcon-dt-con-proxy.c
 create mode 100644 drivers/extcon/extcon-dt-con.c
 create mode 100644 drivers/extcon/extcon-dt-con.h

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index 3d89e60..a004269 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -35,6 +35,26 @@ config EXTCON_AXP288
 	  Say Y here to enable support for USB peripheral detection
 	  and USB MUX switching by X-Power AXP288 PMIC.
 
+config EXTCON_DT_CON
+	tristate "Device Tree Overlay based connector"
+	depends on OF || COMPILE_TEST
+	depends on OF_OVERLAY
+	help
+	  Say Y here to enable Device Tree Overlay based connector
+
+config EXTCON_DT_CON_PROXY
+	tristate "Device Tree Connector Generic proxy driver"
+	select EXTCONF_DT_CON
+	help
+	  Say Y here to enable Device Tree generic proxy connector driver
+
+config EXTCON_DT_CON_GPIO
+	tristate "Device Tree Connector GPIO proxy driver"
+	depends on GPIOLIB && OF_GPIO
+	select EXTCONF_DT_GPIO
+	help
+	  Say Y here to enable Device Tree GPIO proxy connector driver
+
 config EXTCON_GPIO
 	tristate "GPIO extcon support"
 	depends on GPIOLIB || COMPILE_TEST
diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
index 2a0e4f4..7db472d 100644
--- a/drivers/extcon/Makefile
+++ b/drivers/extcon/Makefile
@@ -6,6 +6,9 @@ obj-$(CONFIG_EXTCON)		+= extcon.o
 obj-$(CONFIG_EXTCON_ADC_JACK)	+= extcon-adc-jack.o
 obj-$(CONFIG_EXTCON_ARIZONA)	+= extcon-arizona.o
 obj-$(CONFIG_EXTCON_AXP288)	+= extcon-axp288.o
+obj-$(CONFIG_EXTCON_DT_CON)	+= extcon-dt-con.o
+obj-$(CONFIG_EXTCON_DT_CON_GPIO)+= extcon-dt-con-gpio.o
+obj-$(CONFIG_EXTCON_DT_CON_PROXY)+= extcon-dt-con-proxy.o
 obj-$(CONFIG_EXTCON_GPIO)	+= extcon-gpio.o
 obj-$(CONFIG_EXTCON_MAX14577)	+= extcon-max14577.o
 obj-$(CONFIG_EXTCON_MAX3355)	+= extcon-max3355.o
diff --git a/drivers/extcon/extcon-dt-con-gpio.c b/drivers/extcon/extcon-dt-con-gpio.c
new file mode 100644
index 0000000..41884ce
--- /dev/null
+++ b/drivers/extcon/extcon-dt-con-gpio.c
@@ -0,0 +1,337 @@
+/*
+ * Copyright (C) 2016 Konsulko Group
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/gpio.h>
+#include <linux/slab.h>
+
+#include "extcon-dt-con.h"
+
+/* format: <gpio-phandle> <gpio-nr> <connector-pin-phandle> */
+#define GPIO_CELLS_NUM	3
+
+struct dtcon_gpio_func_data {
+	struct dtcon_function *function;
+	int gpio_base;
+	int gpio_cells;
+};
+
+/* indexed by gpio number */
+struct dtcon_gpio_pin_data {
+	struct dtcon_pin *dtcp;
+	struct device_node *chip_np;
+	struct gpio_chip *chip;	/* when requested */
+	int hwnum;
+	char *label;
+};
+
+struct dtcon_gpio_data {
+	struct platform_device *pdev;
+	struct gpio_chip chip;
+	struct dtcon_proxy *proxy;
+	struct dtcon_gpio_pin_data *pin_data;
+};
+#define to_dtcon_gpio_data(x) container_of((x), struct dtcon_gpio_data, chip)
+
+/* match when we got the same device node */
+static int dtcon_find_gpiochip(struct gpio_chip *gc, void *data)
+{
+	return gc->of_node == data;
+}
+
+static struct gpio_chip *dtcon_gpio_get_gpiochip(struct dtcon_gpio_data *dtcg,
+		unsigned offset)
+{
+	struct dtcon_gpio_pin_data *pin_data;
+	struct dtcon_pin *dtcp;
+
+	if (offset >= dtcg->chip.ngpio)
+		return NULL;
+
+	pin_data = &dtcg->pin_data[offset];
+	dtcp = pin_data->dtcp;
+
+	return gpiochip_find(pin_data->chip_np, dtcon_find_gpiochip);
+}
+
+static int dtcon_gpio_of_xlate(struct gpio_chip *chip,
+			     struct of_phandle_args *gpiospec,
+			     u32 *flags)
+{
+	struct dtcon_gpio_data *dtcg = to_dtcon_gpio_data(chip);
+	struct device *dev = &dtcg->pdev->dev;
+	struct dtcon_gpio_pin_data *pin_data;
+	struct gpio_chip *gc;
+
+	if (WARN_ON(gpiospec->args_count < chip->of_gpio_n_cells))
+		return -EINVAL;
+
+	if (gpiospec->args[0] >= chip->ngpio)
+		return -EINVAL;
+
+	pin_data = &dtcg->pin_data[gpiospec->args[0]];
+	gc = pin_data->chip;
+
+	dev_dbg(dev, "%s: original:  np=%s args[0]=0x%08x args[1]=0x%08x\n",
+			__func__,
+			of_node_full_name(gpiospec->np),
+			gpiospec->args[0], gpiospec->args[1]);
+
+	dev_dbg(dev, "%s: translate: np=%s hwnum=0x%08x args[1]=0x%08x\n",
+			__func__,
+			of_node_full_name(gc->of_node),
+			pin_data->hwnum, 0);
+
+	/* point to new */
+	gpiospec->np = gc->of_node;
+	gpiospec->args[0] = pin_data->hwnum;
+
+	return -EAGAIN;
+
+}
+
+/* gpio function methods */
+static int dtcon_gpio_function_init(struct dtcon_function *dtcf)
+{
+	struct dtcon_data *dtcd = dtcf->dtcd;
+	struct device *dev = &dtcd->pdev->dev;
+	struct dtcon_gpio_func_data *dtcgf = NULL;
+	int err;
+	u32 num;
+
+	if (!dtcf->np) {
+		dev_err(dev, "No gpio function configuration node\n");
+		return -EINVAL;
+	}
+
+	dtcgf = kzalloc(sizeof(*dtcgf), GFP_KERNEL);
+	if (!dtcgf) {
+		dev_err(dev, "No memory for function data\n");
+		return -ENOMEM;
+	}
+	dtcf->data = dtcgf;
+
+	err = of_property_read_u32(dtcf->np, "gpio-base", &num);
+	if (err) {
+		dev_err(dev, "No gpio-base in function configuration\n");
+		err = -EINVAL;
+		goto err_out;
+	}
+
+	dtcgf->gpio_base = num;
+
+	/* format: <gpio-phandle> <gpio-nr> <connector-pin-phandle> */
+	dtcgf->gpio_cells = GPIO_CELLS_NUM;
+
+	return 0;
+
+err_out:
+	kfree(dtcgf);
+	return err;
+}
+
+static void dtcon_gpio_function_fini(struct dtcon_function *dtcf)
+{
+	struct dtcon_gpio_func_data *dtcgf = dtcf->data;
+
+	kfree(dtcgf);
+}
+
+static int dtcon_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct dtcon_gpio_data *dtcg;
+	struct dtcon_data *dtcd;
+	struct dtcon_function *dtcf;
+	struct dtcon_gpio_func_data *dtcgf;
+	struct dtcon_proxy *proxy;
+	struct dtcon_pin *dtcp;
+	struct dtcon_gpio_pin_data *pin_data;
+	struct of_phandle_args args;
+	const void *pin_regs;
+	int i, err, count, regsz, index;
+
+	if (!np) {
+		dev_err(dev, "No OF configuration node\n");
+		return -EINVAL;
+	}
+
+	count = of_property_count_elems_of_size(np, "pin-list", sizeof(u32));
+	pin_regs = of_get_property(np, "pin-list", NULL);
+	if (count <= 0 || !pin_regs) {
+		dev_err(dev, "Invalid configuration\n");
+		return -EINVAL;
+	}
+
+	dtcg = devm_kzalloc(dev, sizeof(*dtcg), GFP_KERNEL);
+	if (!dtcg) {
+		dev_err(dev, "Failed to allocate device data\n");
+		return -ENOMEM;
+	}
+	dtcg->pdev = pdev;
+
+	proxy = dtcon_proxy_create(pdev, "gpio", dtcon_gpio_function_init);
+	if (IS_ERR(proxy))
+		return PTR_ERR(proxy);
+
+	proxy->data = dtcg;
+	dtcg->proxy = proxy;
+
+	dtcf = dtcg->proxy->dtcf;
+	dtcgf = dtcf->data;
+	dtcd = dtcf->dtcd;
+
+	/* the count must be a multiple of address cell numbers */
+	if ((count % dtcd->connector_address_cells) != 0) {
+		dev_err(dev, "Bad pin-list \n");
+		err = -EINVAL;
+		goto out_destroy_proxy;
+	}
+
+	count /= dtcd->connector_address_cells;
+
+	dtcg->pin_data = devm_kzalloc(dev, sizeof(*dtcg->pin_data) * count,
+			GFP_KERNEL);
+	if (!dtcg->pin_data) {
+		dev_err(dev, "Failed to allocate pin data\n");
+		err = -ENOMEM;
+		goto out_destroy_proxy;
+	}
+
+	/* all methods NULL, we don't use them besides of_xlate */
+
+	dtcg->chip.label = np->name;
+	dtcg->chip.base = dtcgf->gpio_base;
+	dtcg->chip.ngpio = count;
+#ifdef CONFIG_OF_GPIO
+	dtcg->chip.of_gpio_n_cells = 2;
+	dtcg->chip.of_xlate = dtcon_gpio_of_xlate;
+	dtcg->chip.parent = dev;
+	dtcg->chip.of_node = of_node_get(np);
+#endif
+
+	/* request all pins */
+	regsz = sizeof(u32) * dtcd->connector_address_cells;
+	for (i = 0; i < count; i++, pin_regs += regsz) {
+
+		pin_data = &dtcg->pin_data[i];
+
+		dtcp = dtcon_proxy_pin_request(proxy, pin_regs, regsz, 0);
+		if (IS_ERR(dtcp)) {
+			dev_err(dev, "could not request gpio #%d\n", i);
+			err = PTR_ERR(dtcp);
+			goto out_release_pin;
+		}
+
+		pin_data->dtcp = dtcp;
+
+		err = of_parse_phandle_with_fixed_args(dtcp->np, "gpio", 1, 0, &args);
+		if (err) {
+			dev_err(dev, "could not #%d parse gpio property\n", i);
+			goto out_release_pin;
+		}
+		pin_data->chip_np = args.np;
+		pin_data->hwnum = args.args[0];
+
+		pin_data->chip = dtcon_gpio_get_gpiochip(dtcg, i);
+		if (!pin_data->chip) {
+			dev_err(dev, "gpio #%d index #%d not found\n",
+					i, index);
+			/* the other device might not come up yet */
+			err = -EPROBE_DEFER;
+			goto out_release_pin;
+		}
+		pin_data->label = devm_kasprintf(dev, GFP_KERNEL,
+				"%s:%d", np->name, i);
+		if (!pin_data->label) {
+			dev_err(dev, "gpio #%d index #%d label alloc\n",
+					i, index);
+			/* the other device might not come up yet */
+			err = -ENOMEM;
+			goto out_release_pin;
+		}
+
+		dev_dbg(dev, "gpio #%d -> %-8s @ %s\n",
+				i, dtcp->regstr, dtcp->np->name);
+	}
+
+	err = gpiochip_add_data(&dtcg->chip, dtcg);
+	if (err) {
+		dev_err(dev, "Could not register gpio chip %d\n", err);
+		goto out_release_pin;
+	}
+
+	/* advance base */
+	dtcgf->gpio_base += count;
+
+	platform_set_drvdata(pdev, dtcg);
+
+	return 0;
+
+out_release_pin:
+	while (i-- >= 0) {
+		pin_data = &dtcg->pin_data[i];
+		of_node_put(pin_data->chip_np);
+		dtcon_proxy_pin_release(proxy, pin_data->dtcp);
+	}
+
+out_destroy_proxy:
+	dtcon_proxy_destroy(dtcg->proxy, dtcon_gpio_function_fini);
+	return err;
+}
+
+static int dtcon_gpio_remove(struct platform_device *pdev)
+{
+	struct dtcon_gpio_data *dtcg = platform_get_drvdata(pdev);
+	struct dtcon_proxy *proxy = dtcg->proxy;
+	struct dtcon_gpio_pin_data *pin_data;
+	int i;
+
+	for (i = 0; i < dtcg->chip.ngpio; i++) {
+		pin_data = &dtcg->pin_data[i];
+		of_node_put(pin_data->chip_np);
+		dtcon_proxy_pin_release(proxy, pin_data->dtcp);
+	}
+
+	gpiochip_remove(&dtcg->chip);
+	dtcon_proxy_destroy(dtcg->proxy, dtcon_gpio_function_fini);
+	return 0;
+}
+
+static const struct of_device_id dtcon_gpio_of_match[] = {
+	{ .compatible = "dtcon-gpio", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, dtcon_gpio_of_match);
+
+static struct platform_driver dtcon_gpio = {
+	.probe = dtcon_gpio_probe,
+	.remove = dtcon_gpio_remove,
+	.driver = {
+		.name = "dtcon-gpio",
+		.owner = THIS_MODULE,
+		.of_match_table = dtcon_gpio_of_match,
+	}
+};
+
+module_platform_driver(dtcon_gpio);
+MODULE_AUTHOR("Pantelis Antoniou <pantelis.antoniou@konsulko.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/extcon/extcon-dt-con-proxy.c b/drivers/extcon/extcon-dt-con-proxy.c
new file mode 100644
index 0000000..dbbbc0e
--- /dev/null
+++ b/drivers/extcon/extcon-dt-con-proxy.c
@@ -0,0 +1,480 @@
+/*
+ * Copyright (C) 2016 Konsulko Group
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/miscdevice.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/slab.h>
+
+#include "extcon-dt-con.h"
+
+static const struct of_device_id dtcon_proxy_of_match[] = {
+	{ .compatible = "dtcon-uart", .data = "uart" },
+	{ .compatible = "dtcon-i2c",  .data = "i2c"  },
+	{ .compatible = "dtcon-spi",  .data = "spi"  },
+	{},
+};
+MODULE_DEVICE_TABLE(of, dtcon_proxy_of_match);
+
+struct dtcon_proxy_data {
+	struct platform_device *pdev;
+	struct dtcon_proxy *proxy;
+	struct of_changeset ocs;
+	struct device_node *paramsnp;
+	int param_cells;
+};
+
+static int dtcon_proxy_parse_params(struct dtcon_proxy_data *dtcpd)
+{
+	struct device *dev = &dtcpd->pdev->dev;
+	struct dtcon_proxy *proxy = dtcpd->proxy;
+	struct dtcon_function *dtcf = proxy->dtcf;
+	struct device_node *np;
+	struct dtcon_pin *dtcp;
+	const void *value;
+	int err, len;
+	u32 num;
+
+	dtcpd->paramsnp = of_get_child_by_name(dtcf->np, "params");
+
+	/* no parameters? no problem */
+	if (!dtcpd->paramsnp)
+		return -EINVAL;
+
+	/* get number of param cells */
+	if (of_property_read_u32(dtcpd->paramsnp, "#param-cells", &num))
+		num = 2;
+
+	dtcpd->param_cells = num;
+
+	/* iterate over list of parameters */
+	err = 0;
+	for_each_child_of_node(dtcpd->paramsnp, np) {
+		value = of_get_property(dev->of_node, np->name, &len);
+		if (!value) {
+			/* ignore non-required parameter */
+			if (!of_property_read_bool(np, "required"))
+				continue;
+			/* missing required parameter */
+			dev_err(dev, "%s: Missing required parameter %s\n",
+					dtcf->kind, np->name);
+err_out:
+			of_node_put(np);
+			err = -EINVAL;
+			goto out;
+		}
+
+		/* we have a parameter; instantiate it */
+		dev_dbg(dev, "%s: param %s\n", dtcf->kind,
+				np->name);
+
+		/* connector-pin parameter <connector reg address> */
+		if (of_property_read_bool(np, "connector-pin")) {
+			dtcp = dtcon_proxy_pin_request(proxy, value, len, 0);
+			if (!dtcp) {
+				dev_err(dev, "%s: failed to request %s's pin\n",
+						dtcf->kind, np->name);
+				goto err_out;
+			}
+			/* no need to keep dtcp around; it's on proxy's list */
+			dev_info(dev, "%s: %s pin is @%s\n", dtcf->kind,
+					np->name, dtcp->np->name);
+
+			dtcp->param = of_node_get(np);
+			/* need to iterate over the mux options for matches */
+		}
+	}
+out:
+	return err;
+}
+
+static int dtcon_proxy_grade_single(struct dtcon_proxy_data *dtcpd,
+		struct device_node *fnp, struct device_node *devnp,
+		struct device_node *muxnp)
+{
+	struct device *dev = &dtcpd->pdev->dev;
+	struct dtcon_pin *dtcp;
+	struct dtcon_proxy *proxy = dtcpd->proxy;
+	int ret, paramsz, paramcells, i, count, len, match, score;
+	const char *param, *gpio_prop;
+	const __be32 *paramp;
+	bool avail;
+	u32 ph;
+
+	if (!devnp)
+		return 0;
+
+	paramcells = dtcpd->param_cells;
+	paramsz = paramcells * sizeof(u32);
+
+	score = 0;
+	list_for_each_entry(dtcp, &proxy->proxy_pin_list, proxy_node) {
+
+		param = dtcp->param->name;
+		paramp = of_get_property(muxnp, param, &len);
+
+		/* no such parameter? */
+		if (!paramp) {
+			/* GPIO parameters only on disabled devices */
+			if (of_device_is_available(devnp)) {
+				dev_err(dev, "param %s with enabled device\n", param);
+				score = 0;
+				break;
+			}
+
+			ret = of_property_read_string(dtcp->param,
+					"gpio-property", &gpio_prop);
+			if (ret) {
+				dev_err(dev, "no param %s\n", param);
+				score = 0;
+				break;
+			}
+			dtcp->proxy_gpio = true;
+			/* gpio matches have a low score */
+			score++;
+			continue;
+		}
+
+		/* not-there? malformed? bail out */
+		if ((len % paramsz))  {
+			dev_err(dev, "malformed param %s\n", param);
+			score = 0;
+			break;
+		}
+
+		count = len / paramsz;
+
+		match = 0;
+		for (i = 0; i < count; i++, paramp += paramcells) {
+			/* get phandle of connector pin */
+			ph = be32_to_cpu(paramp[0]);
+			if (ph != dtcp->np->phandle)
+				continue;
+
+			avail = of_device_is_available(devnp);
+			/* when not preeneabled
+			* -> device must be disabled
+			* when preenabled
+			* -> device must be enabled
+			*/
+			if (of_property_read_bool(muxnp, "pre-enabled"))
+				match = avail;
+			else
+				match = !avail;
+
+			if (match) {
+				dtcp->proxy_gpio = false;
+				/* pinmux changes only on disabled devices */
+				if (!avail) {
+					ph = be32_to_cpu(paramp[1]);
+					dtcp->match_mux = ph;
+				}
+				score += (1 << 16);
+				break;
+			}
+		}
+
+		if (!match)
+			return 0;
+	}
+
+	return score;
+}
+
+static int dtcon_proxy_instantiate(struct dtcon_proxy_data *dtcpd)
+{
+	struct device *dev = &dtcpd->pdev->dev;
+	struct dtcon_proxy *proxy = dtcpd->proxy;
+	struct dtcon_function *dtcf = proxy->dtcf;
+	struct device_node *np, *fnp, *devnp, *muxnp, *best_devnp;
+	struct dtcon_pin *dtcp;
+	int err, len, count, score, best_score, arg_len;
+	const void *value;
+	const char *gpio_prop;
+	const void *arg_value;
+	void *data;
+	__be32 *muxp;
+
+	err = 0;
+
+	/* iterate over the device targets */
+	best_score = 0;
+	best_devnp = NULL;
+	for_each_child_of_node(dtcf->np, fnp) {
+		devnp = of_parse_phandle(fnp, "device", 0);
+		if (!devnp)
+			continue;
+		for_each_child_of_node(fnp, muxnp) {
+
+			score = dtcon_proxy_grade_single(dtcpd, fnp,
+							 devnp, muxnp);
+
+			if (score <= best_score)
+				continue;
+
+			/* new best score */
+			best_score = score;
+			of_node_put(best_devnp);
+			best_devnp = of_node_get(devnp);
+			list_for_each_entry(dtcp, &proxy->proxy_pin_list,
+					    proxy_node) {
+
+				/* if it's a GPIO do not select it */
+				if (dtcp->proxy_gpio)
+					continue;
+
+				of_node_put(dtcp->pinctrl);
+				dtcp->pinctrl = of_find_node_by_phandle(
+						dtcp->match_mux);
+				dtcp->match_mux = 0;
+			}
+		}
+		of_node_put(devnp);
+	}
+
+	if (best_score == 0) {
+		dev_info(dev, "no matching proxy config\n");
+		return -ENODEV;
+	}
+
+	devnp = best_devnp;
+	best_devnp = NULL;
+
+	dev_dbg(dev, "matches device %s\n", devnp->full_name);
+
+	/* need to copy subdevices? */
+	if (of_property_read_bool(dtcpd->paramsnp, "copy-subdevices")) {
+		for_each_available_child_of_node(dev->of_node, np) {
+			err = of_changeset_node_move(&dtcpd->ocs, np, devnp);
+			if (err) {
+				dev_err(dev, "Failed to move nodes\n");
+				of_node_put(np);
+				goto err_out;
+			}
+		}
+	}
+
+	/* changes only allowed to non-activated devices */
+	if (!of_device_is_available(devnp)) {
+
+		/* iterate over parameters */
+
+		/* iterate over list of parameters */
+		for_each_child_of_node(dtcpd->paramsnp, np) {
+			if (!of_property_read_bool(np, "copy"))
+				continue;
+
+			value = of_get_property(dev->of_node, np->name, &len);
+			if (!value) {
+				if (!of_property_read_bool(np, "required"))
+					continue;
+				dev_err(dev, "Missing required property %s\n",
+						np->name);
+				of_node_put(np);
+				err = -ENODEV;
+				goto err_out;
+			}
+
+			of_changeset_update_property_copy(&dtcpd->ocs, devnp,
+				np->name, value, len);
+
+		}
+
+		/* generate pinctrl for each pin of the connector */
+		if (of_property_read_bool(dtcpd->paramsnp,
+					"generate-pinctrl")) {
+			/* count the pinctrl entries we're going to need */
+			count = 0;
+			list_for_each_entry(dtcp, &proxy->proxy_pin_list,
+					proxy_node) {
+				if (dtcp->pinctrl)
+					count++;
+			}
+
+			if (count > 0) {
+				muxp = kzalloc(sizeof(u32) * count, GFP_KERNEL);
+				if (!muxp) {
+					dev_err(dev,
+						"Failed to allocate pinmux\n");
+					err = -ENOMEM;
+					goto err_out;
+				}
+
+				count = 0;
+				list_for_each_entry(dtcp,
+						&proxy->proxy_pin_list,
+						proxy_node) {
+					if (!dtcp->pinctrl)
+						continue;
+					muxp[count++] = cpu_to_be32(
+							dtcp->pinctrl->phandle);
+				}
+
+				of_changeset_update_property_string(&dtcpd->ocs,
+						devnp, "pinctrl-names",
+						"default");
+				of_changeset_update_property_copy(&dtcpd->ocs,
+						devnp, "pinctrl-0", muxp,
+						sizeof(u32) * count);
+
+				kfree(muxp);
+			}
+		}
+
+		/* fill in gpio properties if required */
+		list_for_each_entry(dtcp, &proxy->proxy_pin_list, proxy_node) {
+			if (!dtcp->proxy_gpio)
+				continue;
+			err = of_property_read_string(dtcp->param,
+					"gpio-property", &gpio_prop);
+			if (err) {
+				dev_err(dev,
+					"Failed to read gpio-property name %s\n",
+					dtcp->param->name);
+				goto err_out;
+			}
+			value = of_get_property(dtcp->np, "gpio", &len);
+			if (!value) {
+				dev_err(dev,
+					"Failed on gpio name %s - %s\n",
+					dtcp->param->name, dtcp->np->name);
+				err = -EINVAL;
+				goto err_out;
+			}
+			arg_value = of_get_property(dtcp->param,
+					"gpio-args", &arg_len);
+			if (!arg_value) {
+				dev_err(dev,
+					"Failed on gpio-args name %s - %s\n",
+					dtcp->param->name, dtcp->param->name);
+				err = -EINVAL;
+				goto err_out;
+			}
+			data = kmalloc(len + arg_len, GFP_KERNEL);
+			if (!data) {
+				dev_err(dev,
+					"Failed to allocate %s - %s\n",
+					dtcp->param->name, dtcp->param->name);
+				err = -ENOMEM;
+				goto err_out;
+			}
+			memcpy(data, value, len);
+			memcpy(data + len, arg_value, arg_len);
+			of_changeset_add_property_copy(&dtcpd->ocs, devnp,
+				gpio_prop, data, len + arg_len);
+			kfree(data);
+		}
+
+		/* enabled target device and go */
+		of_changeset_update_property_string(&dtcpd->ocs, devnp,
+				"status", "okay");
+	}
+
+	of_changeset_apply(&dtcpd->ocs);
+
+	of_node_put(devnp);
+	of_node_put(muxnp);
+
+	return 0;
+
+err_out:
+	of_changeset_destroy(&dtcpd->ocs);
+
+	of_node_put(devnp);
+
+	return err;
+}
+
+static int dtcon_proxy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dtcon_proxy *proxy;
+	struct dtcon_function *dtcf;
+	struct dtcon_proxy_data *dtcpd;
+	const struct of_device_id *of_id;
+	const char *function;
+	int err;
+
+	of_id = of_match_device(dtcon_proxy_of_match, dev);
+	if (!of_id) {
+		dev_err(dev, "Could not match device\n");
+		return -ENODEV;
+	}
+	function = of_id->data;
+
+	dtcpd = devm_kzalloc(dev, sizeof(*dtcpd), GFP_KERNEL);
+	if (!dtcpd) {
+		dev_err(dev, "Failed to allocate device data\n");
+		return -ENOMEM;
+	}
+	dtcpd->pdev = pdev;
+	of_changeset_init(&dtcpd->ocs);
+
+	proxy = dtcon_proxy_create(pdev, function, NULL);
+	if (IS_ERR(proxy))
+		return PTR_ERR(proxy);
+
+	dtcpd->proxy = proxy;
+
+	dtcf = proxy->dtcf;
+
+	platform_set_drvdata(pdev, dtcpd);
+
+	err = dtcon_proxy_parse_params(dtcpd);
+	if (err) {
+		dev_err(dev, "Failed to parse params\n");
+		return err;
+	}
+
+	err = dtcon_proxy_instantiate(dtcpd);
+	if (err) {
+		dev_err(dev, "Failed to instantiate device\n");
+		return err;
+	}
+
+	dev_info(dev, "OK\n");
+
+	return 0;
+}
+
+static int dtcon_proxy_remove(struct platform_device *pdev)
+{
+	struct dtcon_proxy_data *dtcpd = platform_get_drvdata(pdev);
+
+	of_changeset_revert(&dtcpd->ocs);
+	of_changeset_destroy(&dtcpd->ocs);
+	dtcon_proxy_destroy(dtcpd->proxy, NULL);
+	of_node_put(dtcpd->paramsnp);
+	return 0;
+}
+
+static struct platform_driver dtcon_proxy = {
+	.probe = dtcon_proxy_probe,
+	.remove = dtcon_proxy_remove,
+	.driver = {
+		.name = "dtcon-proxy",
+		.owner = THIS_MODULE,
+		.of_match_table = dtcon_proxy_of_match,
+	}
+};
+
+module_platform_driver(dtcon_proxy);
+MODULE_AUTHOR("Pantelis Antoniou <pantelis.antoniou@konsulko.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/extcon/extcon-dt-con.c b/drivers/extcon/extcon-dt-con.c
new file mode 100644
index 0000000..fbc1a35
--- /dev/null
+++ b/drivers/extcon/extcon-dt-con.c
@@ -0,0 +1,491 @@
+/*
+ *  drivers/extcon/extcon-dt-conn.c
+ *
+ *  Device Tree Overlay based connector driver.
+ *
+ * Copyright (C) 2015 Konsulko Group.
+ * Author: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+*/
+
+#include <linux/extcon.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+
+#include "extcon-dt-con.h"
+
+static const unsigned int dtcon_cable[] = {
+	EXTCON_NONE,
+};
+
+static int dtcon_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node, *npn;
+	struct dtcon_data *dtcd;
+	struct dtcon_pin *dtcp;
+	const __be32 *regp;
+	int regsz, regcells, sz, count, len, i, j, err;
+	char *s, *e;
+	u32 num;
+
+	if (!np) {
+		dev_err(dev, "No device node\n");
+		return -ENODEV;
+	}
+
+	dtcd = devm_kzalloc(dev, sizeof(*dtcd), GFP_KERNEL);
+	if (!dtcd) {
+		dev_err(dev, "Failed to allocated data structure\n");
+		return -ENOMEM;
+	}
+	INIT_LIST_HEAD(&dtcd->pin_list);
+	INIT_LIST_HEAD(&dtcd->function_list);
+
+	dtcd->pdev = pdev;
+	dtcd->edev = devm_extcon_dev_allocate(dev, dtcon_cable);
+	if (IS_ERR(dtcd->edev)) {
+		dev_err(dev, "Failed to allocate extcon device\n");
+		err = PTR_ERR(dtcd->edev);
+		return err;
+	}
+
+	err = devm_extcon_dev_register(dev, dtcd->edev);
+	if (err < 0) {
+		dev_err(dev, "Failed to register extcon device\n");
+		return err;
+	}
+
+	platform_set_drvdata(pdev, dtcd);
+
+	dtcd->connector = of_get_child_by_name(np, "connector");
+	dtcd->functions = of_get_child_by_name(np, "functions");
+	dtcd->plugged = of_get_child_by_name(np, "plugged");
+
+	err = -EINVAL;
+
+	if (!dtcd->connector || !dtcd->functions || !dtcd->plugged) {
+		dev_err(dev, "Bad OF configuration\n");
+		goto out_err;
+	}
+
+	/* if no property return 1 */
+	err = of_property_read_u32(dtcd->connector, "#address-cells", &num);
+	if (err < 0)
+		num = 1;
+	dtcd->connector_address_cells = num;
+
+	/* if no property return 0 */
+	err = of_property_read_u32(dtcd->connector, "#size-cells", &num);
+	if (err < 0)
+		num = 0;
+	dtcd->connector_size_cells = num;
+	if (dtcd->connector_size_cells != 0) {
+		dev_err(dev, "Only #size-cells = <0>; supported for now\n");
+		err = -EINVAL;
+		goto out_err;
+	}
+
+	regcells = dtcd->connector_address_cells;
+	regsz = sizeof(u32) * regcells;
+	for_each_child_of_node(dtcd->connector, npn) {
+		regp = of_get_property(npn, "reg", &len);
+		if (!regp || (len % regsz)) {
+			dev_err(dev, "Bad connector pin @%s\n", npn->name);
+			of_node_put(npn);
+			goto out_err;
+		}
+
+		dtcp = devm_kzalloc(dev, sizeof(*dtcp), GFP_KERNEL);
+		if (!dtcp) {
+			dev_err(dev, "Failed to allocate pin node\n");
+			err = -ENOMEM;
+			of_node_put(npn);
+			goto out_err;
+		}
+		/* keep it and add it to the list */
+		dtcp->np = of_node_get(npn);
+
+		/* convert to number of reg ranges */
+		count = len / regsz;
+		/* max reg is ,<4294967295> */
+		sz = strlen(",<4294967295>") * count * regcells + 2;
+		dtcp->regstr = devm_kmalloc(dev, sz, GFP_KERNEL);
+		if (!dtcp->regstr) {
+			dev_err(dev, "Failed to allocate reg string\n");
+			err = -ENOMEM;
+			of_node_put(npn);
+			goto out_err;
+		}
+		s = dtcp->regstr;
+		e = dtcp->regstr + sz;
+		for (i = 0; i < count; i++, regp += regcells) {
+			if (i > 0)
+				*s++ = ',';
+			*s++ = '<';
+			for (j = 0; j < regcells; j++) {
+				len = scnprintf(s, e - s, "%u",
+						be32_to_cpu(regp[j]));
+				s += len;
+				if (j + 1 < regcells)
+					*s++ = ' ';
+			}
+			*s++ = '>';
+		}
+		*s = '\0';
+
+		list_add_tail(&dtcp->node, &dtcd->pin_list);
+	}
+
+	/* populate anything in plugged */
+	of_platform_default_populate(dev->of_node, NULL, dev);
+
+	dev_info(dev, "OK\n");
+
+	return 0;
+
+out_err:
+	if (dtcd) {
+		list_for_each_entry_reverse(dtcp, &dtcd->pin_list, node)
+			of_node_put(dtcp->np);
+		of_node_put(dtcd->connector);
+		of_node_put(dtcd->functions);
+		of_node_put(dtcd->plugged);
+	}
+
+	/* no need to manually deallocate, it's all devm */
+	return err;
+}
+
+static int dtcon_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dtcon_data *dtcd = platform_get_drvdata(pdev);
+	struct dtcon_pin *dtcp;
+
+	dev_info(dev, "removing\n");
+
+	list_for_each_entry_reverse(dtcp, &dtcd->pin_list, node)
+		of_node_put(dtcp->np);
+	of_node_put(dtcd->connector);
+	of_node_put(dtcd->functions);
+	of_node_put(dtcd->plugged);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int dtcon_resume(struct device *dev)
+{
+	struct dtcon_data *dtcd;
+
+	dtcd = dev_get_drvdata(dev);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(dtcon_pm_ops, NULL, dtcon_resume);
+
+static const struct of_device_id dtcon_of_match[] = {
+	{
+		.compatible = "extcon,dt-con",
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, dtcon_of_match);
+
+static struct platform_driver dtcon_driver = {
+	.probe		= dtcon_probe,
+	.remove		= dtcon_remove,
+	.driver		= {
+		.name	= "extcon-dt-con",
+		.pm	= &dtcon_pm_ops,
+		.of_match_table = of_match_ptr(dtcon_of_match),
+	},
+};
+
+module_platform_driver(dtcon_driver);
+
+/* get the dtcon data from a platform device that's a descendant */
+struct dtcon_data *dtcon_data_from_platform_device(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dtcon_data *dtcd;
+	struct device *parent;
+
+	/* we need to find the connector which must be a parent */
+	for (parent = dev->parent; parent; parent = parent->parent) {
+		if (parent->of_node &&
+			of_device_is_compatible(parent->of_node,
+				dtcon_of_match[0].compatible)) {
+			break;
+		}
+	}
+
+	if (!parent) {
+		dev_err(dev, "Device is not a child of a connector\n");
+		return NULL;
+	}
+
+	/* get pointer to connector data */
+	dtcd = platform_get_drvdata(to_platform_device(parent));
+	if (!dtcd) {
+		dev_err(dev, "Missing connector data\n");
+		return NULL;
+	}
+
+	return dtcd;
+}
+EXPORT_SYMBOL(dtcon_data_from_platform_device);
+
+struct dtcon_pin *dtcon_pin_lookup(struct dtcon_data *dtcd,
+		const void *regp, int regsz)
+{
+	struct dtcon_pin *dtcp = NULL;
+	const void *value;
+	int i, len;
+
+	if (!dtcd || !regp)
+		return NULL;
+
+	/* must be the same size as the address cells */
+	if (regsz != dtcd->connector_address_cells * sizeof(u32))
+		return NULL;
+
+	/* no size cells supported */
+	if (dtcd->connector_size_cells != 0)
+		return NULL;
+
+	/* find pin with the given reg */
+	list_for_each_entry(dtcp, &dtcd->pin_list, node) {
+		value = of_get_property(dtcp->np, "reg", &len);
+
+		/* check that it exists and is a multiple */
+		if (!value || (len % regsz) != 0)
+			continue;
+
+		/* iterate over all */
+		for (i = 0; i < len; i += regsz, value += regsz) {
+			if (memcmp(value, regp, regsz) == 0)
+				goto found;
+		}
+	}
+
+	return NULL;
+
+found:
+	return dtcp;
+}
+EXPORT_SYMBOL(dtcon_pin_lookup);
+
+struct dtcon_pin *dtcon_pin_lookup_by_node(struct dtcon_data *dtcd,
+		struct device_node *np)
+{
+	struct dtcon_pin *dtcp = NULL;
+
+	if (!dtcd)
+		return NULL;
+
+	/* release all pins of this proxy */
+	list_for_each_entry(dtcp, &dtcd->pin_list, node) {
+		if (dtcp->np == np)
+			return dtcp;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(dtcon_pin_lookup_by_node);
+
+struct dtcon_pin *dtcon_pin_lookup_by_phandle(struct dtcon_data *dtcd,
+		phandle phandle)
+{
+	struct device_node *np = of_find_node_by_phandle(phandle);
+	struct dtcon_pin *dtcp;
+
+	if (!np)
+		return NULL;
+
+	dtcp = dtcon_pin_lookup_by_node(dtcd, np);
+	of_node_put(np);
+	return dtcp;
+}
+EXPORT_SYMBOL(dtcon_pin_lookup_by_phandle);
+
+struct dtcon_pin *dtcon_proxy_pin_request(struct dtcon_proxy *proxy,
+		const void *regp, int regsz, unsigned int flags)
+{
+	struct dtcon_data *dtcd;
+	struct dtcon_pin *dtcp;
+	struct device *dev;
+
+	if (!proxy || !regp)
+		return ERR_PTR(-EINVAL);
+
+	dtcd = proxy->dtcf->dtcd;
+	dev = &dtcd->pdev->dev;
+	dtcp = dtcon_pin_lookup(dtcd, regp, regsz);
+	if (!dtcp)
+		return ERR_PTR(-ENXIO);
+
+	dtcp->proxy = proxy;
+	dtcp->data = NULL;
+	list_add_tail(&dtcp->proxy_node, &proxy->proxy_pin_list);
+
+	return dtcp;
+}
+EXPORT_SYMBOL(dtcon_proxy_pin_request);
+
+int dtcon_proxy_pin_release(struct dtcon_proxy *proxy, struct dtcon_pin *dtcp)
+{
+	if (!proxy || !dtcp || dtcp->proxy != proxy)
+		return -EINVAL;
+
+	list_del(&dtcp->proxy_node);
+	dtcp->proxy = NULL;
+	dtcp->data = NULL;
+
+	/* proxy device data release */
+	of_node_put(dtcp->param);
+	of_node_put(dtcp->pinctrl);
+	dtcp->param = NULL;
+	dtcp->pinctrl = NULL;
+	return 0;
+}
+EXPORT_SYMBOL(dtcon_proxy_pin_release);
+
+/* dtcon function methods */
+struct dtcon_function *dtcon_function_lookup(struct dtcon_data *dtcd,
+		const char *kind)
+{
+	struct dtcon_function *dtcf;
+
+	/* lookup function by kind */
+	list_for_each_entry(dtcf, &dtcd->function_list, node) {
+		if (strcmp(dtcf->kind, kind) == 0)
+			return dtcf;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(dtcon_function_lookup);
+
+/* proxy device methods */
+struct dtcon_proxy *dtcon_proxy_create(struct platform_device *pdev,
+		const char *kind,
+		int (*func_init)(struct dtcon_function *dtcf))
+{
+	struct device *dev = &pdev->dev;
+	struct dtcon_data *dtcd;
+	struct dtcon_proxy *proxy;
+	struct dtcon_function *dtcf;
+	int err;
+
+	/* get connector data from a parent */
+	dtcd = dtcon_data_from_platform_device(pdev);
+	if (!dtcd) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	proxy = kzalloc(sizeof(*proxy), GFP_KERNEL);
+	if (!proxy) {
+		dev_err(dev, "Failed to allocate proxy data\n");
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	/* lookup function */
+	dtcf = dtcon_function_lookup(dtcd, kind);
+	if (dtcf == NULL) {
+		dtcf = kzalloc(sizeof(*dtcf), GFP_KERNEL);
+		if (!dtcf) {
+			dev_err(dev, "Failed to allocate proxy data\n");
+			err = -ENOMEM;
+			goto err_free_proxy;
+		}
+		dtcf->dtcd = dtcd;
+		dtcf->kind = kind;
+		dtcf->np = of_get_child_by_name(dtcd->functions, kind);
+		INIT_LIST_HEAD(&dtcf->proxy_list);
+
+		if (func_init) {
+			err = (*func_init)(dtcf);
+			if (err) {
+				dev_err(dev, "function init failed\n");
+				kfree(dtcf);
+				goto err_free_proxy;
+			}
+		}
+		list_add_tail(&dtcf->node, &dtcd->function_list);
+	}
+
+	proxy->pdev = pdev;
+	proxy->dtcf = dtcf;
+
+	INIT_LIST_HEAD(&proxy->proxy_pin_list);
+
+	list_add_tail(&proxy->node, &dtcf->proxy_list);
+
+	return proxy;
+
+err_free_proxy:
+	kfree(proxy);
+err_out:
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL(dtcon_proxy_create);
+
+void dtcon_proxy_destroy(struct dtcon_proxy *proxy,
+		void (*func_fini)(struct dtcon_function *dtcf))
+{
+	struct dtcon_data *dtcd;
+	struct dtcon_function *dtcf;
+	struct dtcon_pin *dtcp, *dtcpn;
+
+	if (!proxy || !proxy->dtcf)
+		return;
+
+	dtcf = proxy->dtcf;
+	dtcd = dtcf->dtcd;
+
+	list_del(&proxy->node);
+
+	/* last proxy; remove function */
+	if (list_empty(&dtcf->proxy_list)) {
+		list_del(&dtcf->node);
+		if (func_fini)
+			(*func_fini)(dtcf);
+		of_node_put(dtcf->np);
+		kfree(dtcf);
+	}
+
+	/* release all pins of this proxy */
+	list_for_each_entry_safe_reverse(dtcp, dtcpn,
+			&proxy->proxy_pin_list, proxy_node)
+		dtcon_proxy_pin_release(proxy, dtcp);
+
+	kfree(proxy);
+}
+EXPORT_SYMBOL(dtcon_proxy_destroy);
+
+MODULE_AUTHOR("Pantelis Antoniou <pantelis.antoniou@konsulko.com>");
+MODULE_DESCRIPTION("DT connector extcon driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:extcon-dt-con");
diff --git a/drivers/extcon/extcon-dt-con.h b/drivers/extcon/extcon-dt-con.h
new file mode 100644
index 0000000..9f08f1d
--- /dev/null
+++ b/drivers/extcon/extcon-dt-con.h
@@ -0,0 +1,93 @@
+/*
+ * dt-con.h
+ *
+ * Copyright (c) 2016 Konsulko Group
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __LINUX_EXTCON_DT_CON_H
+#define __LINUX_EXTCON_DT_CON_H
+
+#include <linux/device.h>
+#include <linux/platform_device.h>
+
+struct dtcon_proxy;
+
+struct dtcon_pin {
+	struct list_head node;
+	struct device_node *np;
+	char *regstr;	/* connector reg prop */
+
+	/* owner of the pin */
+	struct dtcon_proxy *proxy;
+	struct list_head proxy_node;
+	void *data;
+
+	/* proxy device data */
+	struct device_node *param;
+
+	/* pinctrl config device node */
+	bool proxy_gpio;
+	struct device_node *pinctrl;
+	phandle match_mux;
+};
+
+struct dtcon_data {
+	struct platform_device *pdev;
+	struct extcon_dev *edev;
+
+	struct device_node *connector;
+	unsigned int connector_address_cells;
+	unsigned int connector_size_cells;
+
+	struct device_node *functions;
+	struct device_node *plugged;
+	struct list_head pin_list;
+
+	struct list_head function_list;
+};
+
+struct dtcon_function {
+	struct dtcon_data *dtcd;
+	struct list_head node;
+	const char *kind;
+	struct device_node *np;
+	struct list_head proxy_list;
+	void *data;
+};
+
+struct dtcon_proxy {
+	struct platform_device *pdev;
+	struct dtcon_function *dtcf;
+	struct list_head node;
+
+	struct list_head proxy_pin_list;
+
+	void *data;
+};
+
+struct dtcon_data *dtcon_data_from_platform_device(
+		struct platform_device *pdev);
+
+struct dtcon_proxy *dtcon_proxy_create(struct platform_device *pdev,
+		const char *kind,
+		int (*func_init)(struct dtcon_function *dtcf));
+void dtcon_proxy_destroy(struct dtcon_proxy *proxy,
+		void (*func_fini)(struct dtcon_function *dtcf));
+
+struct dtcon_pin *dtcon_pin_lookup(struct dtcon_data *dtcd,
+		const void *regp, int regsz);
+struct dtcon_pin *dtcon_pin_lookup_by_node(struct dtcon_data *dtcd,
+		struct device_node *np);
+struct dtcon_pin *dtcon_pin_lookup_by_phandle(struct dtcon_data *dtcd,
+		phandle phandle);
+struct dtcon_pin *dtcon_proxy_pin_request(struct dtcon_proxy *proxy,
+		const void *regp, int regsz, unsigned int flags);
+int dtcon_proxy_pin_release(struct dtcon_proxy *proxy, struct dtcon_pin *dtcp);
+
+
+#endif /* __LINUX_EXTCON_DT_CON_H */
-- 
1.7.12
