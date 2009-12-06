From: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] [MISC] Add HTC PLD driver
Date: Sat,  5 Dec 2009 23:14:43 -0800
Message-ID: <1260083683-13095-1-git-send-email-darkstar6262@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This change introduces a driver for the HTC PLD chip found
on some smartphones, such as the HTC Wizard and HTC Herald.
It works through the I2C bus and provides two main features:

  * 32 general-purpose I/O pins
  * Input device support for directional keypad buttons

The above phones have LCD and keyboard backlight brightness
and LED controls attached to this chip, as well as some
power management functions.

This driver was originally written by
Angelo Arrifano <miknix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> of the Linwizard project.

Signed-off-by: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/misc/Kconfig   |   11 +++
 drivers/misc/Makefile  |    1 +
 drivers/misc/htcpld.c  |  204 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/htcpld.h |   14 ++++
 4 files changed, 230 insertions(+), 0 deletions(-)
 create mode 100644 drivers/misc/htcpld.c
 create mode 100644 include/linux/htcpld.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index df1f86b..be6109e 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -246,6 +246,17 @@ config EP93XX_PWM
 	  To compile this driver as a module, choose M here: the module will
 	  be called ep93xx_pwm.
 
+config HTCPLD
+	tristate "HTC Wizard/Herald CPLD"
+	depends on I2C=y
+	help
+	  If you say yes here you get support for the supposed CPLD
+	  found on omap850 HTC devices like the HTC Wizard and HTC Herald.
+	  This device controls backlight, leds, rumble and also the dpad.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called htcpld.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index f982d2e..1679bc9 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -21,5 +21,6 @@ obj-$(CONFIG_HP_ILO)		+= hpilo.o
 obj-$(CONFIG_ISL29003)		+= isl29003.o
 obj-$(CONFIG_EP93XX_PWM)	+= ep93xx_pwm.o
 obj-$(CONFIG_C2PORT)		+= c2port/
+obj-$(CONFIG_HTCPLD)		+= htcpld.o
 obj-y				+= eeprom/
 obj-y				+= cb710/
diff --git a/drivers/misc/htcpld.c b/drivers/misc/htcpld.c
new file mode 100644
index 0000000..97a0260
--- /dev/null
+++ b/drivers/misc/htcpld.c
@@ -0,0 +1,204 @@
+/*
+ *  htcpld.c
+ *  Chip driver for a ?cpld? found on omap850 HTC devices like the
+ *  HTC Wizard and HTC Herald.
+ *  The cpld is located on the i2c bus and controls backlight, leds,
+ *  vibrator and other power devices. The cpld also returns buttons status
+ *  of the directional pads.
+ *
+ *  Copyright (C) 2008-2009 Angelo Arrifano <miknix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+ *  Copyright (C) 2009 Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
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
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/timer.h>
+#include <linux/platform_device.h>
+#include <linux/i2c.h>
+
+#include <linux/htcpld.h>
+
+#define HTCPLD_ADDR_MAX 16
+
+struct htcpld_chip_data {
+	u8 reset;
+	u8 cache;
+};
+
+static struct i2c_client *htcpld_chip[HTCPLD_ADDR_MAX];
+
+void htcpld_chip_set(u8 chip_addr, u8 val)
+{
+	struct htcpld_chip_data *chip_data;
+
+	if (chip_addr > HTCPLD_ADDR_MAX)
+		return;
+
+	if (!htcpld_chip[chip_addr])
+		return;
+
+	chip_data = i2c_get_clientdata(htcpld_chip[chip_addr]);
+	if (!chip_data)
+		return;
+
+	i2c_smbus_read_byte_data(htcpld_chip[chip_addr],
+				(chip_data->cache = val));
+}
+EXPORT_SYMBOL_GPL(htcpld_chip_set);
+
+u8 htcpld_chip_get(u8 chip_addr)
+{
+	struct htcpld_chip_data *chip_data;
+
+	if (!htcpld_chip[chip_addr])
+		return 0;
+
+	chip_data = i2c_get_clientdata(htcpld_chip[chip_addr]);
+	if (!chip_data)
+		return 0;
+
+	return chip_data->cache;
+}
+EXPORT_SYMBOL_GPL(htcpld_chip_get);
+
+void htcpld_chip_reset(u8 chip_addr)
+{
+	struct htcpld_chip_data *chip_data;
+
+	if (chip_addr > HTCPLD_ADDR_MAX)
+		return;
+
+	if (!htcpld_chip[chip_addr])
+		return;
+
+	chip_data = i2c_get_clientdata(htcpld_chip[chip_addr]);
+	if (!chip_data)
+		return;
+
+	i2c_smbus_read_byte_data(htcpld_chip[chip_addr],
+	  (chip_data->cache = chip_data->reset));
+}
+EXPORT_SYMBOL_GPL(htcpld_chip_reset);
+
+/*
+ * Driver handling
+ */
+
+u8 htcpld_chip_cache_read(const int addr)
+{
+	struct i2c_client *client = htcpld_chip[addr];
+
+	return i2c_smbus_read_byte_data(client,
+		((struct htcpld_chip_data *)i2c_get_clientdata(client))->cache);
+}
+EXPORT_SYMBOL_GPL(htcpld_chip_cache_read);
+
+static int __devinit htcpld_probe(struct i2c_client *client, const struct i2c_device_id *devID)
+{
+	struct htcpld_chip_data *chip_data;
+	struct device *dev = &client->dev;
+	struct htcpld_chip_platform_data *pdata;
+
+	if (!dev)
+		return -ENODEV;
+
+	pdata = (struct htcpld_chip_platform_data *)dev->platform_data;
+	if (!pdata) {
+		printk(KERN_ERR "Platform data not found for chip at 0x%x!\n",
+					client->addr);
+		return -ENXIO;
+	}
+
+	if (!i2c_check_functionality(client->adapter,
+				I2C_FUNC_SMBUS_READ_BYTE_DATA))
+		return -ENODEV;
+
+	if (client->addr > HTCPLD_ADDR_MAX) {
+		printk(KERN_ERR "Address above range.\n");
+		return -ENOMEM;
+	}
+
+	if (htcpld_chip[client->addr]) {
+		printk(KERN_ERR "Address already on use.\n");
+		return -EINVAL;
+	}
+
+	chip_data = kzalloc(sizeof(struct htcpld_chip_data), GFP_KERNEL);
+	if (!chip_data)
+		return -ENOMEM;
+
+	chip_data->reset = pdata->reset;
+	i2c_set_clientdata(client, chip_data);
+	snprintf(client->name, I2C_NAME_SIZE, "Chip_0x%x", client->addr);
+	htcpld_chip[client->addr] = client;
+
+	printk(KERN_INFO "i2c-htcpld: Detected chip at 0x%x\n", client->addr);
+	htcpld_chip_reset(client->addr);
+
+	return 0;
+}
+
+static int htcpld_remove(struct i2c_client *client)
+{
+	htcpld_chip[client->addr] = NULL;
+	kfree(i2c_get_clientdata(client));
+
+	return 0;
+}
+
+static const struct i2c_device_id htcpld_id[] = {
+        { "htcpld", 0 },
+        { }
+};
+MODULE_DEVICE_TABLE(i2c, htcpld_id);
+
+
+static struct i2c_driver htcpld_driver = {
+	.driver = {
+		.name	= "htcpld",
+	},
+	.probe	= htcpld_probe,
+	.remove	= htcpld_remove,
+	.id_table = htcpld_id,
+};
+
+static int __init htcpld_init(void)
+{
+	int ret;
+
+	ret = i2c_add_driver(&htcpld_driver);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void __exit htcpld_exit(void)
+{
+	i2c_del_driver(&htcpld_driver);
+}
+
+module_init(htcpld_init);
+module_exit(htcpld_exit);
+
+MODULE_AUTHOR("Angelo Arrifano <miknix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
+MODULE_DESCRIPTION("HTCPLD Driver");
+MODULE_LICENSE("GPL");
+
diff --git a/include/linux/htcpld.h b/include/linux/htcpld.h
new file mode 100644
index 0000000..4d06336
--- /dev/null
+++ b/include/linux/htcpld.h
@@ -0,0 +1,14 @@
+#ifndef __LINUX_HTCPLD_H
+#define __LINUX_HTCPLD_H
+
+struct htcpld_chip_platform_data {
+	u8 reset;
+};
+
+u8 htcpld_chip_get(u8 chip_addr);
+void htcpld_chip_set(u8 chip_addr, u8 val);
+void htcpld_chip_reset(u8 chip_addr);
+u8 htcpld_chip_cache_read(const int addr);
+
+#endif /* __LINUX_HTCPLD_H */
+
-- 
1.6.3.3
