From: Richard =?ISO-8859-1?Q?R=F6jfors?=
	<richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
Subject: [PATCH 1/1] misc: Add Tunnel creek In-Vehicle I2C loader driver
Date: Wed, 08 Sep 2010 16:41:39 +0200
Message-ID: <1283956899.4593.13.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Since X86 lacks board config this drivers adds I2C devices to
a I2C bus. It adds the devices that will exists on Tunnel creek
In-Vehicle development boards.

So far only the TSC2007 is added.

Signed-off-by: Richard R=C3=B6jfors <richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
---
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 0b591b6..74ef860 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -390,6 +390,16 @@ config BMP085
 	  To compile this driver as a module, choose M here: the
 	  module will be called bmp085.
=20
+config TC_IVI_I2C_LOADER
+	tristate "Tunnel creek In-Vehicle I2C loader driver"
+	depends on I2C && GPIOLIB
+	help
+	  If you say yes here you will get support for the Tunnel creek
+	  In-Vehicle I2C loader driver.
+
+	  Since X86 don't have any board config this driver adds I2C devices
+	  to the I2C bus.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 255a80d..a64d07e 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_ISL29003)		+=3D isl29003.o
 obj-$(CONFIG_SENSORS_TSL2550)	+=3D tsl2550.o
 obj-$(CONFIG_EP93XX_PWM)	+=3D ep93xx_pwm.o
 obj-$(CONFIG_DS1682)		+=3D ds1682.o
+obj-$(CONFIG_TC_IVI_I2C_LOADER)	+=3D tc_ivi_i2c_loader.o
 obj-$(CONFIG_TI_DAC7512)	+=3D ti_dac7512.o
 obj-$(CONFIG_C2PORT)		+=3D c2port/
 obj-$(CONFIG_IWMC3200TOP)      +=3D iwmc3200top/
diff --git a/drivers/misc/tc_ivi_i2c_loader.c b/drivers/misc/tc_ivi_i2c=
_loader.c
new file mode 100644
index 0000000..d1310ef
--- /dev/null
+++ b/drivers/misc/tc_ivi_i2c_loader.c
@@ -0,0 +1,114 @@
+/*
+ * Tunnel creek In-Vehicle I2C loader driver
+ * Copyright (c) 2010 Intel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/gpio.h>
+#include <linux/i2c.h>
+#include <linux/i2c/tsc2007.h>
+
+#define DRIVER_NAME "loader"
+
+static int	i2c_bus =3D 1;
+static unsigned	tsc2007_irq_pin =3D 102;
+
+static __devinitdata struct tsc2007_platform_data tsc2007_platform_dat=
a =3D {
+	.model =3D 2007,
+	.x_plate_ohms =3D 200
+};
+
+static __initdata struct i2c_board_info tsc2007_i2c_board_info =3D {
+	I2C_BOARD_INFO("tsc2007", 0x48),
+	.platform_data =3D &tsc2007_platform_data,
+	/* irq to be filled in runtime */
+};
+
+static struct i2c_client *tsc2007_client;
+
+static __init int loader_get_irq(unsigned gpio_pin)
+{
+	int err;
+
+	err =3D gpio_request(gpio_pin, DRIVER_NAME);
+	if (err)
+		return err;
+
+	err =3D gpio_direction_input(gpio_pin);
+	if (err)
+		goto err;
+
+	err =3D gpio_to_irq(gpio_pin);
+	if (err < 0)
+		goto err;
+
+	return err;
+err:
+	gpio_free(tsc2007_irq_pin);
+	return err;
+}
+
+static __init int loader_init(void)
+{
+	struct i2c_adapter *adapt;
+	int err;
+
+	adapt =3D i2c_get_adapter(i2c_bus);
+	if (!adapt) {
+		printk(KERN_ERR "%s: Failed to get I2C adapter\n", __func__);
+		return -ENODEV;
+	}
+
+	err =3D loader_get_irq(tsc2007_irq_pin);
+	if (err < 0)
+		goto put_adapter;
+	tsc2007_i2c_board_info.irq =3D err;
+
+	/* add in the devices on the bus */
+	tsc2007_client =3D i2c_new_device(adapt, &tsc2007_i2c_board_info);
+	if (!tsc2007_client)
+		goto free_tsc2007_pin;
+
+	i2c_put_adapter(adapt);
+
+	return 0;
+
+free_tsc2007_pin:
+	gpio_free(tsc2007_irq_pin);
+put_adapter:
+	i2c_put_adapter(adapt);
+
+	return err;
+}
+
+static void __exit loader_exit(void)
+{
+	i2c_unregister_device(tsc2007_client);
+}
+
+module_init(loader_init);
+module_exit(loader_exit);
+
+module_param(i2c_bus, int, 0);
+MODULE_PARM_DESC(i2c_bus,
+	"I2C bus where the I2C devices are connected, default =3D 1");
+
+module_param(tsc2007_irq_pin, uint, 0);
+MODULE_PARM_DESC(tsc2007_irq_pin,
+	"GPIO pin where the TSC2007 penIRQ is connected, default =3D 102");
+
+MODULE_DESCRIPTION("Tunnel creek In-Vehicle I2C loader driver");
+MODULE_AUTHOR("Pelagicore AB <info-gfIc91nka+FZroRs9YW3xA@public.gmane.org>");
+MODULE_LICENSE("GPL v2");
