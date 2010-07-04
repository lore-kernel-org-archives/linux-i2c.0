From: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: add generic I2C multiplexer using gpio api
Date: Mon,  5 Jul 2010 01:19:44 +0200
Message-ID: <1278285584-13632-1-git-send-email-peter.korsgaard@barco.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add an i2c bus driver providing virtual i2c busses using a hardware MUX
sitting on a master bus and controlled through gpio pins.

E.G. something like:

  ----------              ----------  Virtual bus 1   - - - - -
 |          | SCL/SDA    |          |-------------- |           |
 |          |------------|          |
 |          |            |          | Virtual bus 2 |           |
 |  Linux   | GPIO 1..N  |   MUX    |---------------   Devices
 |          |------------|          |               |           |
 |          |            |          | Virtual bus M
 |          |            |          |---------------|           |
  ----------              ----------                  - - - - -

SCL/SDA of the master I2C bus is multiplexed to virtual bus 1..M
according to the settings of the GPIO pins 1..N.

Signed-off-by: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
---
 Documentation/i2c/busses/i2c-gpiomux |   65 +++++++++++
 MAINTAINERS                          |    7 ++
 drivers/i2c/busses/Kconfig           |   12 ++
 drivers/i2c/busses/Makefile          |    1 +
 drivers/i2c/busses/i2c-gpiomux.c     |  196 ++++++++++++++++++++++++++++++++++
 include/linux/i2c-gpiomux.h          |   35 ++++++
 6 files changed, 316 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/i2c/busses/i2c-gpiomux
 create mode 100644 drivers/i2c/busses/i2c-gpiomux.c
 create mode 100644 include/linux/i2c-gpiomux.h

diff --git a/Documentation/i2c/busses/i2c-gpiomux b/Documentation/i2c/busses/i2c-gpiomux
new file mode 100644
index 0000000..b0a7746
--- /dev/null
+++ b/Documentation/i2c/busses/i2c-gpiomux
@@ -0,0 +1,65 @@
+Kernel driver i2c-gpiomux
+
+Author: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
+
+Description
+-----------
+
+i2c-gpiomux is an i2c bus driver providing virtual I2C busses from a
+master I2C bus and a hardware MUX controlled through GPIO pins.
+
+E.G.:
+
+  ----------              ----------  Virtual bus 1   - - - - -
+ |          | SCL/SDA    |          |-------------- |           |
+ |          |------------|          |
+ |          |            |          | Virtual bus 2 |           |
+ |  Linux   | GPIO 1..N  |   MUX    |---------------   Devices
+ |          |------------|          |               |           |
+ |          |            |          | Virtual bus M
+ |          |            |          |---------------|           |
+  ----------              ----------                  - - - - -
+
+SCL/SDA of the master I2C bus is multiplexed to virtual bus 1..M
+according to the settings of the GPIO pins 1..N.
+
+Usage
+-----
+
+i2c-gpiomux uses the platform bus, so you need to provide a struct
+platform_device with the platform_data pointing to a struct
+gpiomux_i2c_platform_data with the I2C adapter number of the master
+bus, the number of virtual busses to create and the GPIO pins used
+to control it. See include/linux/i2c-gpiomux.h for details.
+
+E.G. something like this for a MUX providing 4 virtual busses
+controlled through 3 GPIO pins:
+
+#include <linux/i2c-gpiomux.h>
+#include <linux/platform_device.h>
+
+static unsigned myboard_gpiomux_pins[] = {
+	AT91_PIN_PC26, AT91_PIN_PC25, AT91_PIN_PC24
+};
+
+static unsigned myboard_gpiomux_values[] = {
+	0, 1, 2, 3
+};
+
+static struct gpiomux_i2c_platform_data myboard_i2cmux_data = {
+	.parent		= 1,
+	.base_nr	= 2,
+	.busses		= ARRAY_SIZE(myboard_gpiomux_values),
+	.gpios		= ARRAY_SIZE(myboard_gpiomux_pins),
+	.gpio		= myboard_gpiomux_pins,
+	.values		= myboard_gpiomux_values,
+	.idle		= 4,
+};
+
+static struct platform_device myboard_i2cmux = {
+	.name		= "i2c-gpiomux",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &myboard_i2cmux_data,
+	},
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 7642365..f80ad93 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2453,6 +2453,13 @@ S:	Supported
 F:	drivers/i2c/busses/i2c-gpio.c
 F:	include/linux/i2c-gpio.h
 
+GENERIC GPIO I2C MULTIPLEXER DRIVER
+M:	Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
+L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
+S:	Supported
+F:	drivers/i2c/busses/i2c-gpiomux.c
+F:	include/linux/i2c-gpiomux.h
+
 GENERIC HDLC (WAN) DRIVERS
 M:	Krzysztof Halasa <khc-9GfyWEdoJtJmR6Xm/wNWPw@public.gmane.org>
 W:	http://www.kernel.org/pub/linux/utils/net/hdlc/
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index bceafbf..055b0f1 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -364,6 +364,18 @@ config I2C_GPIO
 	  This is a very simple bitbanging I2C driver utilizing the
 	  arch-neutral GPIO API to control the SCL and SDA lines.
 
+config I2C_GPIOMUX
+	tristate "GPIO-based I2C multiplexer"
+	depends on GENERIC_GPIO
+	help
+	  If you say yes to this option, support will be included for a
+	  GPIO based I2C multiplexer. This driver provides virtual I2C
+	  busses from a master bus through a MUX controlled through
+	  the generic GPIO interface.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-gpiomux.
+
 config I2C_HIGHLANDER
 	tristate "Highlander FPGA SMBus interface"
 	depends on SH_HIGHLANDER
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 936880b..5ec15ec 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_I2C_CPM)		+= i2c-cpm.o
 obj-$(CONFIG_I2C_DAVINCI)	+= i2c-davinci.o
 obj-$(CONFIG_I2C_DESIGNWARE)	+= i2c-designware.o
 obj-$(CONFIG_I2C_GPIO)		+= i2c-gpio.o
+obj-$(CONFIG_I2C_GPIOMUX)	+= i2c-gpiomux.o
 obj-$(CONFIG_I2C_HIGHLANDER)	+= i2c-highlander.o
 obj-$(CONFIG_I2C_IBM_IIC)	+= i2c-ibm_iic.o
 obj-$(CONFIG_I2C_IMX)		+= i2c-imx.o
diff --git a/drivers/i2c/busses/i2c-gpiomux.c b/drivers/i2c/busses/i2c-gpiomux.c
new file mode 100644
index 0000000..b4cc9e2
--- /dev/null
+++ b/drivers/i2c/busses/i2c-gpiomux.c
@@ -0,0 +1,196 @@
+/*
+ * I2C multiplexer using GPIO API
+ *
+ * Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/i2c.h>
+#include <linux/i2c-gpiomux.h>
+#include <linux/platform_device.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/gpio.h>
+
+struct gpiomux_i2c {
+	struct i2c_adapter *parent; /* parent bus */
+	struct i2c_adapter *adap; /* children busses */
+	struct gpiomux_i2c_platform_data data;
+};
+
+static void gpiomux_set(struct gpiomux_i2c *i2c, unsigned val)
+{
+	int i;
+
+	for (i = 0;  i < i2c->data.gpios; i++)
+		gpio_set_value(i2c->data.gpio[i], val & (1<<i));
+}
+
+static int gpiomux_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
+			 int num)
+{
+	struct gpiomux_i2c *i2c = i2c_get_adapdata(adap);
+	int nr = adap->nr - i2c->data.base_nr;
+	int ret;
+
+	rt_mutex_lock(&i2c->parent->bus_lock);
+
+	gpiomux_set(i2c, i2c->data.values[nr]);
+	ret = i2c->parent->algo->master_xfer(i2c->parent, msgs, num);
+	gpiomux_set(i2c, i2c->data.idle);
+
+	rt_mutex_unlock(&i2c->parent->bus_lock);
+
+	return ret;
+}
+
+static u32 gpiomux_func(struct i2c_adapter *adap)
+{
+	struct gpiomux_i2c *i2c = i2c_get_adapdata(adap);
+
+	return i2c->parent->algo->functionality(i2c->parent);
+}
+
+static struct i2c_algorithm gpiomux_algorithm = {
+	.master_xfer	= gpiomux_xfer,
+	.functionality	= gpiomux_func,
+};
+
+static struct i2c_adapter gpiomux_adapter = {
+	.owner		= THIS_MODULE,
+	.name		= "gpiomux",
+	.class		= I2C_CLASS_HWMON,
+	.algo		= &gpiomux_algorithm,
+	.timeout	= 2,
+	.retries	= 1
+};
+
+static int __devinit gpiomux_probe(struct platform_device *pdev)
+{
+	struct gpiomux_i2c *i2c;
+	struct gpiomux_i2c_platform_data *pdata;
+	struct i2c_adapter *adap;
+	int i, j, ret;
+
+	pdata = pdev->dev.platform_data;
+	if (!pdata) {
+		dev_err(&pdev->dev, "Missing platform data\n");
+		return -ENODEV;
+	}
+
+	adap = i2c_get_adapter(pdata->parent);
+	if (!adap) {
+		dev_err(&pdev->dev, "Parent adapter (%d) not found\n",
+			pdata->parent);
+		return -ENODEV;
+	}
+
+	i2c = kzalloc(sizeof(*i2c), GFP_KERNEL);
+	if (!i2c) {
+		ret = -ENOMEM;
+		goto alloc_failed;
+	}
+
+	i2c->parent = adap;
+	i2c->data = *pdata;
+	i2c->adap = kzalloc(sizeof(struct i2c_adapter)*pdata->busses,
+			    GFP_KERNEL);
+	if (!i2c->adap) {
+		ret = -ENOMEM;
+		goto alloc_failed2;
+	}
+
+	for (i = 0; i < pdata->gpios; i++) {
+		ret = gpio_request(pdata->gpio[i], "i2c-gpiomux");
+		if (ret)
+			goto err_request_gpio;
+		gpio_direction_output(pdata->gpio[i], pdata->idle & (1<<i));
+	}
+
+	for (i = 0; i < pdata->busses; i++) {
+		i2c->adap[i] = gpiomux_adapter;
+		i2c->adap[i].dev.parent = &adap->dev;
+		i2c->adap[i].nr = pdata->base_nr + i;
+
+		snprintf(i2c->adap[i].name, I2C_NAME_SIZE, "%s.%d",
+			 gpiomux_adapter.name, i);
+		i2c_set_adapdata(&i2c->adap[i], i2c);
+		ret = i2c_add_numbered_adapter(&i2c->adap[i]);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to add adapter %d\n", i);
+			goto add_adapter_failed;
+		}
+	}
+
+	dev_info(&pdev->dev, "%d port mux on %s adapter\n",
+		 pdata->busses, adap->name);
+
+	platform_set_drvdata(pdev, i2c);
+
+	return 0;
+
+ add_adapter_failed:
+	for (j = 0; j < i; j++)
+		i2c_del_adapter(&i2c->adap[j]);
+	i = pdata->gpios;
+ err_request_gpio:
+	for (j = 0; j < i; j++)
+		gpio_free(pdata->gpio[j]);
+	kfree(i2c->adap);
+ alloc_failed2:
+	kfree(i2c);
+ alloc_failed:
+	i2c_put_adapter(adap);
+
+	return ret;
+}
+
+static int __devexit gpiomux_remove(struct platform_device *pdev)
+{
+	struct gpiomux_i2c *i2c = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < i2c->data.busses; i++)
+		i2c_del_adapter(&i2c->adap[i]);
+
+	for (i = 0; i < i2c->data.gpios; i++)
+		gpio_free(i2c->data.gpio[i]);
+
+	platform_set_drvdata(pdev, NULL);
+	i2c_put_adapter(i2c->parent);
+	kfree(i2c->adap);
+	kfree(i2c);
+
+	return 0;
+}
+
+static struct platform_driver gpiomux_driver = {
+	.probe  = gpiomux_probe,
+	.remove = __devexit_p(gpiomux_remove),
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "i2c-gpiomux",
+	},
+};
+
+static int __init gpiomux_init(void)
+{
+	return platform_driver_register(&gpiomux_driver);
+}
+
+static void __exit gpiomux_exit(void)
+{
+	platform_driver_unregister(&gpiomux_driver);
+}
+
+module_init(gpiomux_init);
+module_exit(gpiomux_exit);
+
+MODULE_DESCRIPTION("GPIO-based I2C multiplexer driver");
+MODULE_AUTHOR("Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:i2c-gpiomux");
diff --git a/include/linux/i2c-gpiomux.h b/include/linux/i2c-gpiomux.h
new file mode 100644
index 0000000..2388ff2
--- /dev/null
+++ b/include/linux/i2c-gpiomux.h
@@ -0,0 +1,35 @@
+/*
+ * i2c-gpiomux interface to platform code
+ *
+ * Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _LINUX_I2C_GPIOMUX_H
+#define _LINUX_I2C_GPIOMUX_H
+
+/**
+ * struct gpiomux_i2c_platform_data - Platform-dependent data for i2c-gpiomux
+ * @parent: Parent I2C bus adapter number
+ * @base_nr: Base bus number value to number adapters from
+ * @busses: Number of multiplexer positions (busses to instantiate)
+ * @gpios: Number of gpios used to control MUX
+ * @gpio: Array of @gpios gpio numbers used to control MUX
+ * @values: Array of @bussed bitmasks of gpio settings (low/high) for each
+ *	position
+ * @idle: Bitmask to write to MUX when idle
+ */
+struct gpiomux_i2c_platform_data {
+	int parent;
+	int base_nr;
+	int busses;
+	int gpios;
+	unsigned *gpio;
+	unsigned *values;
+	unsigned idle;
+};
+
+#endif /* _LINUX_I2C_GPIOMUX_H */
-- 
1.7.1
