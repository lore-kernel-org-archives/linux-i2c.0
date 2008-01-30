From: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/3] [I2C]: add AD5252 chip driver
Date: Wed, 30 Jan 2008 18:09:54 +0800
Message-ID: <1201687796-987-2-git-send-email-bryan.wu@analog.com>
References: <1201687796-987-1-git-send-email-bryan.wu@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1201687796-987-1-git-send-email-bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/chips/Kconfig  |    7 ++
 drivers/i2c/chips/Makefile |    1 +
 drivers/i2c/chips/ad5252.c |  252 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c-id.h     |    1 +
 4 files changed, 261 insertions(+), 0 deletions(-)
 create mode 100644 drivers/i2c/chips/ad5252.c

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index bd7082c..bb8c253 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -14,6 +14,13 @@ config DS1682
 	  This driver can also be built as a module.  If so, the module
 	  will be called ds1682.
 
+config SENSORS_AD5252
+	tristate "Analog Devices AD5252 and AD5251 Digital Potentiometers"
+	depends on I2C && EXPERIMENTAL
+	help
+	  If you say yes here you get support for Analog Devices and AD5252
+	  AD5251 chips.
+
 config SENSORS_EEPROM
 	tristate "EEPROM reader"
 	depends on EXPERIMENTAL
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
index 501f00c..a1e1f5f 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -2,6 +2,7 @@
 # Makefile for miscellaneous I2C chip drivers.
 #
 
+obj-$(CONFIG_SENSORS_AD5252)	+= ad5252.o
 obj-$(CONFIG_DS1682)		+= ds1682.o
 obj-$(CONFIG_SENSORS_EEPROM)	+= eeprom.o
 obj-$(CONFIG_SENSORS_MAX6875)	+= max6875.o
diff --git a/drivers/i2c/chips/ad5252.c b/drivers/i2c/chips/ad5252.c
new file mode 100644
index 0000000..188795a
--- /dev/null
+++ b/drivers/i2c/chips/ad5252.c
@@ -0,0 +1,252 @@
+/*
+    ad5252.c - Part of lm_sensors, Linux kernel modules for hardware
+             monitoring
+
+    Driver for dual digitally controlled potentiometers
+
+    Copyright (c) 2006 Michael Hennerich <hennerich-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
+
+    derived from pcf8547.c
+
+    Copyright (c) 2000  Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>,
+                        Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>,
+                        Dan Eaton <dan.eaton-RtyX3GHucphnQYSypqKXDg@public.gmane.org>
+    Ported to Linux 2.6 by Aurelien Jarno <aurel32-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org> with
+    the help of Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/delay.h>
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, 0x2f, I2C_CLIENT_END };
+
+/* Insmod parameters */
+I2C_CLIENT_INSMOD_1(ad5252);
+
+/* Initial values */
+#define AD5252_INIT 128	/* Wiper in middle position */
+/* Each client has this additional data */
+struct ad5252_data {
+	struct i2c_client client;
+
+	u8 read, write;			/* Register values */
+};
+
+static int ad5252_attach_adapter(struct i2c_adapter *adapter);
+static int ad5252_detect(struct i2c_adapter *adapter, int address, int kind);
+static int ad5252_detach_client(struct i2c_client *client);
+static void ad5252_init_client(struct i2c_client *client);
+
+/* This is the driver that will be inserted */
+static struct i2c_driver ad5252_driver = {
+	.driver = {
+	.name		= "ad5252",
+	},
+	.id		= I2C_DRIVERID_AD5252,
+	.attach_adapter	= ad5252_attach_adapter,
+	.detach_client	= ad5252_detach_client,
+};
+
+/* following are the sysfs callback functions */
+static ssize_t show_read_w1(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	return sprintf(buf, "%u\n", i2c_smbus_read_byte_data(client,0x1));
+}
+
+static DEVICE_ATTR(read_w1, S_IRUGO, show_read_w1, NULL);
+
+static ssize_t show_read_w3(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	return sprintf(buf, "%u\n", i2c_smbus_read_byte_data(client,0x3));
+}
+
+static DEVICE_ATTR(read_w3, S_IRUGO, show_read_w3, NULL);
+
+static ssize_t show_write(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct ad5252_data *data = i2c_get_clientdata(to_i2c_client(dev));
+	return sprintf(buf, "%u\n", data->write);
+}
+
+static ssize_t set_write_w1(struct device *dev, struct device_attribute *attr, const char *buf,
+			size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct ad5252_data *data = i2c_get_clientdata(client);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	if (val > 0xff)
+		return -EINVAL;
+
+	data->write = val;
+
+	i2c_smbus_write_byte_data(client,0x1, data->write);
+	return count;
+}
+
+static DEVICE_ATTR(write_w1, S_IWUSR | S_IRUGO, show_write, set_write_w1);
+
+static ssize_t set_write_w3(struct device *dev, struct device_attribute *attr, const char *buf,
+			 size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct ad5252_data *data = i2c_get_clientdata(client);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	if (val > 0xff)
+		return -EINVAL;
+
+	data->write = val;
+
+	i2c_smbus_write_byte_data(client,0x3, data->write);
+	return count;
+}
+
+static DEVICE_ATTR(write_w3, S_IWUSR | S_IRUGO, show_write, set_write_w3);
+
+/*
+ * Real code
+ */
+
+static int ad5252_attach_adapter(struct i2c_adapter *adapter)
+{
+	return i2c_probe(adapter, &addr_data, ad5252_detect);
+}
+
+/* This function is called by i2c_detect */
+int ad5252_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	struct i2c_client *new_client;
+	struct ad5252_data *data;
+	int err = 0;
+	const char *client_name = "";
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
+		goto exit;
+
+	/* OK. For now, we presume we have a valid client. We now create the
+	   client structure, even though we cannot fill it completely yet. */
+	if (!(data = kzalloc(sizeof(struct ad5252_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	new_client = &data->client;
+	i2c_set_clientdata(new_client, data);
+	new_client->addr = address;
+	new_client->adapter = adapter;
+	new_client->driver = &ad5252_driver;
+	new_client->flags = 0;
+
+	/* Determine the chip type */
+	if (kind <= 0) {
+		if (address >= 0x2c && address <= 0x2f)
+			kind = ad5252;
+
+	}
+
+	client_name = "ad5252";
+
+	/* Fill in the remaining client fields and put it into the global list */
+	strlcpy(new_client->name, client_name, I2C_NAME_SIZE);
+
+	/* Tell the I2C layer a new client has arrived */
+
+	/*FIXME: Don't know why there needs to be a delay !!!*/
+	udelay(100);
+
+	if ((err = i2c_attach_client(new_client)))
+		goto exit_free;
+
+	/* Initialize the AD5252 chip */
+	ad5252_init_client(new_client);
+
+	/* Register sysfs hooks */
+	err = device_create_file(&new_client->dev, &dev_attr_read_w1);
+	err |= device_create_file(&new_client->dev, &dev_attr_read_w3);
+	err |= device_create_file(&new_client->dev, &dev_attr_write_w1);
+	err |= device_create_file(&new_client->dev, &dev_attr_write_w3);
+
+	if (err)
+		printk(KERN_WARNING "AD5252: failed to register sysfs hooks\n");
+
+	printk(KERN_INFO "AD5252 Attached\n");
+	return 0;
+
+/* OK, this is not exactly good programming practice, usually. But it is
+   very code-efficient in this case. */
+
+      exit_free:
+	kfree(data);
+      exit:
+	printk(KERN_INFO "AD5252 attaching failed\n");
+	return err;
+}
+
+static int ad5252_detach_client(struct i2c_client *client)
+{
+	int err;
+
+	if ((err = i2c_detach_client(client))) {
+		dev_err(&client->dev,
+			"Client deregistration failed, client not detached.\n");
+		return err;
+	}
+
+	kfree(i2c_get_clientdata(client));
+	return 0;
+}
+
+/* Called when we have found a new AD5252. */
+static void ad5252_init_client(struct i2c_client *client)
+{
+	//struct ad5252_data *data = i2c_get_clientdata(client);
+	//data->write = AD5252_INIT;
+	//i2c_smbus_write_byte_data(client,0x1, data->write);
+	//i2c_smbus_write_byte_data(client,0x3, data->write);
+}
+
+static int __init ad5252_init(void)
+{
+	return i2c_add_driver(&ad5252_driver);
+}
+
+static void __exit ad5252_exit(void)
+{
+	i2c_del_driver(&ad5252_driver);
+}
+
+
+MODULE_AUTHOR
+    ("Michael Hennerich <hennerich-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>, "
+     "Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>, "
+     "Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>, "
+     "Dan Eaton <dan.eaton-RtyX3GHucphnQYSypqKXDg@public.gmane.org> "
+     "and Aurelien Jarno <aurelien-rXXEIb44qovR7s880joybQ@public.gmane.org>");
+MODULE_DESCRIPTION("AD5252 digital potentiometer driver");
+MODULE_LICENSE("GPL");
+
+module_init(ad5252_init);
+module_exit(ad5252_exit);
diff --git a/include/linux/i2c-id.h b/include/linux/i2c-id.h
index f922b06..67d639d 100644
--- a/include/linux/i2c-id.h
+++ b/include/linux/i2c-id.h
@@ -133,6 +133,7 @@
 #define I2C_DRIVERID_FSCHER 1046
 #define I2C_DRIVERID_W83L785TS 1047
 #define I2C_DRIVERID_OV7670 1048	/* Omnivision 7670 camera */
+#define I2C_DRIVERID_AD5252 1049
 
 /*
  * ---- Adapter types ----------------------------------------------------
-- 
1.5.3.4

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
