From: Muthu Mani <muth-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 3/3] gpio: add support for Cypress CYUSBS234 USB-GPIO adapter
Date: Thu, 25 Sep 2014 11:21:58 +0530
Message-ID: <1411624319-5596-1-git-send-email-muth@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Muthu Mani <muth-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, Rajaram Regupathy <rera-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Adds support for USB-GPIO interface of Cypress Semiconductor
CYUSBS234 USB-Serial Bridge controller.

The GPIO get/set can be done through vendor command on control endpoint.

Details about the device can be found at:
http://www.cypress.com/?rID=84126

Signed-off-by: Muthu Mani <muth-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Rajaram Regupathy <rera-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
---
 drivers/gpio/Kconfig          |  13 +++
 drivers/gpio/Makefile         |   1 +
 drivers/gpio/gpio-cyusbs23x.c | 182 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 196 insertions(+)
 create mode 100644 drivers/gpio/gpio-cyusbs23x.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 9de1515..932e07c 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -886,6 +886,19 @@ config GPIO_BCM_KONA
 
 comment "USB GPIO expanders:"
 
+config GPIO_CYUSBS23X
+	tristate "CYUSBS23x GPIO support"
+	depends on MFD_CYUSBS23X && USB
+	help
+	  Say yes here to access the GPIO signals of Cypress
+	  Semiconductor CYUSBS23x USB Serial Bridge Controller.
+
+	  This driver enables the GPIO interface of CYUSBS23x USB Serial
+	  Bridge controller.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called gpio-cyusbs23x.
+
 config GPIO_VIPERBOARD
 	tristate "Viperboard GPIO a & b support"
 	depends on MFD_VIPERBOARD && USB
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 5d024e3..3ad89f1 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_GPIO_BT8XX)	+= gpio-bt8xx.o
 obj-$(CONFIG_GPIO_CLPS711X)	+= gpio-clps711x.o
 obj-$(CONFIG_GPIO_CS5535)	+= gpio-cs5535.o
 obj-$(CONFIG_GPIO_CRYSTAL_COVE)	+= gpio-crystalcove.o
+obj-$(CONFIG_GPIO_CYUSBS23X)	+= gpio-cyusbs23x.o
 obj-$(CONFIG_GPIO_DA9052)	+= gpio-da9052.o
 obj-$(CONFIG_GPIO_DA9055)	+= gpio-da9055.o
 obj-$(CONFIG_GPIO_DAVINCI)	+= gpio-davinci.o
diff --git a/drivers/gpio/gpio-cyusbs23x.c b/drivers/gpio/gpio-cyusbs23x.c
new file mode 100644
index 0000000..ad83b00
--- /dev/null
+++ b/drivers/gpio/gpio-cyusbs23x.c
@@ -0,0 +1,182 @@
+/*
+ * GPIO subdriver for Cypress CYUSBS234 USB-Serial Bridge controller.
+ * Details about the device can be found at:
+ *    http://www.cypress.com/?rID=84126
+ * All GPIOs are exposed for get operation and only unused GPIOs can be set.
+ *
+ * Copyright (c) 2014 Cypress Semiconductor Corporation.
+ *
+ * Author:
+ *   Muthu Mani <muth-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
+ *
+ * Additional contributors include:
+ *   Rajaram Regupathy <rera-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+
+#include <linux/usb.h>
+#include <linux/gpio.h>
+
+#include <linux/mfd/cyusbs23x.h>
+
+#define CY_GPIO_GET_LEN		(2)
+
+struct cyusbs_gpio {
+	struct gpio_chip gpio;
+	struct cyusbs23x *cyusbs;
+};
+
+static int cy_gpio_get(struct gpio_chip *chip,
+			unsigned offset)
+{
+	int ret;
+	char *buf;
+	u16 wIndex, wValue;
+	struct cyusbs_gpio *gpio =
+				container_of(chip, struct cyusbs_gpio, gpio);
+	struct cyusbs23x *cyusbs = gpio->cyusbs;
+
+	dev_dbg(&cyusbs->usb_intf->dev, "%s: %d\n", __func__,
+		offset);
+	wValue = offset;
+	wIndex = 0;
+	buf = kmalloc(CY_GPIO_GET_LEN, GFP_KERNEL);
+
+	mutex_lock(&cyusbs->lock);
+	ret = usb_control_msg(cyusbs->usb_dev,
+			usb_rcvctrlpipe(cyusbs->usb_dev, 0),
+			CY_GPIO_GET_VALUE_CMD,
+			USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
+			wValue, wIndex, buf, CY_GPIO_GET_LEN, 2000);
+	mutex_unlock(&cyusbs->lock);
+
+	dev_dbg(&cyusbs->usb_intf->dev, "%s: %d %02x %02x\n", __func__,
+		ret, buf[0], buf[1]);
+
+	if (ret == CY_GPIO_GET_LEN) {
+		if (buf[0] == 0)
+			ret = buf[1];
+		else
+			ret = -EINVAL;
+	} else {
+		ret = -EREMOTEIO;
+	}
+
+	kfree(buf);
+	return ret;
+}
+
+static void cy_gpio_set(struct gpio_chip *chip,
+			unsigned offset, int value)
+{
+	int ret;
+	u16 wIndex, wValue;
+	struct cyusbs_gpio *gpio =
+			container_of(chip, struct cyusbs_gpio, gpio);
+	struct cyusbs23x *cyusbs = gpio->cyusbs;
+
+	dev_dbg(&cyusbs->usb_intf->dev, "%s: %d\n", __func__,
+		offset);
+	wValue = offset;
+	wIndex = value;
+
+	mutex_lock(&cyusbs->lock);
+	ret = usb_control_msg(cyusbs->usb_dev,
+			usb_sndctrlpipe(cyusbs->usb_dev, 0),
+			CY_GPIO_SET_VALUE_CMD,
+			USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
+			wValue, wIndex, NULL, 0, 2000);
+	mutex_unlock(&cyusbs->lock);
+
+	if (ret < 0)
+		dev_err(&cyusbs->usb_intf->dev, "error setting gpio:%d\n", ret);
+}
+
+static int cy_gpio_direction_input(struct gpio_chip *chip,
+					unsigned offset)
+{
+	return 0;
+}
+
+static int cy_gpio_direction_output(struct gpio_chip *chip,
+					unsigned offset, int value)
+{
+	return 0;
+}
+
+static int cyusbs23x_gpio_probe(struct platform_device *pdev)
+{
+	struct cyusbs23x *cyusbs;
+	struct cyusbs_gpio *cy_gpio;
+	int ret = 0;
+
+	dev_dbg(&pdev->dev, "%s\n", __func__);
+
+	cyusbs = dev_get_drvdata(pdev->dev.parent);
+
+	cy_gpio = devm_kzalloc(&pdev->dev, sizeof(*cy_gpio), GFP_KERNEL);
+	if (cy_gpio == NULL)
+		return -ENOMEM;
+
+	cy_gpio->cyusbs = cyusbs;
+	/* registering gpio */
+	cy_gpio->gpio.label = dev_name(&pdev->dev);
+	cy_gpio->gpio.dev = &pdev->dev;
+	cy_gpio->gpio.owner = THIS_MODULE;
+	cy_gpio->gpio.base = -1;
+	cy_gpio->gpio.ngpio = 12; /* total GPIOs */
+	cy_gpio->gpio.can_sleep = true;
+	cy_gpio->gpio.set = cy_gpio_set;
+	cy_gpio->gpio.get = cy_gpio_get;
+	cy_gpio->gpio.direction_input = cy_gpio_direction_input;
+	cy_gpio->gpio.direction_output = cy_gpio_direction_output;
+	ret = gpiochip_add(&cy_gpio->gpio);
+	if (ret < 0) {
+		dev_err(cy_gpio->gpio.dev, "could not add gpio");
+		goto error;
+	}
+
+	platform_set_drvdata(pdev, cy_gpio);
+
+	dev_dbg(&pdev->dev, "added GPIO\n");
+	return ret;
+
+error:
+	dev_dbg(&pdev->dev, "error occured %d\n", ret);
+	return ret;
+}
+
+static int cyusbs23x_gpio_remove(struct platform_device *pdev)
+{
+	struct cyusbs_gpio *cy_gpio = platform_get_drvdata(pdev);
+
+	dev_dbg(&pdev->dev, "%s\n", __func__);
+	gpiochip_remove(&cy_gpio->gpio);
+	return 0;
+}
+
+static struct platform_driver cyusbs23x_gpio_driver = {
+	.driver.name    = "cyusbs23x-gpio",
+	.driver.owner   = THIS_MODULE,
+	.probe          = cyusbs23x_gpio_probe,
+	.remove         = cyusbs23x_gpio_remove,
+};
+
+module_platform_driver(cyusbs23x_gpio_driver);
+
+MODULE_AUTHOR("Rajaram Regupathy <rera-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>");
+MODULE_AUTHOR("Muthu Mani <muth-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>");
+MODULE_DESCRIPTION("GPIO driver for CYUSBS23x");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:cyusbs23x-gpio");
-- 
1.8.3.2
