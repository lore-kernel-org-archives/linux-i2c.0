From: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Subject: Re: [PATCH] Added driver for ISL29003 ambient light sensor
Date: Mon, 9 Mar 2009 22:09:01 +0100
Message-ID: <20090309210901.GC31367@buzzloop.caiaq.de>
References: <20090225212119.67402391@hyperion.delvare> <1235606248-13004-1-git-send-email-daniel@caiaq.de> <20090226094857.50d0710d@hyperion.delvare> <20090306160042.GA17800@buzzloop.caiaq.de> <20090306182432.338b0244@hyperion.delvare> <20090306181409.GA20135@buzzloop.caiaq.de> <20090307115449.32f0ab26@hyperion.delvare> <20090307120631.GA25276@buzzloop.caiaq.de> <20090307130818.367bcaad@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090307130818.367bcaad-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Mar 07, 2009 at 01:08:18PM +0100, Jean Delvare wrote:
> > > Please post new patches, I'll review and apply them.
> > 
> > Oh, I thought we agreed now to Jonathan Cameron's idea to merge this
> > driver into the IIO framework and put it mainline sooner or later? No
> > extra steps needed from my side - this driver certainly doesn't hurry :)
> 
> Both ways are equally fine with me.

Ok, nevermind, just to be sure :) As soon as IIO is merged, I'll send a
patch to (re)move it again ...

Thanks,
Daniel


>From 48f05c0df089909928bf65a3cef29c5cff7ffb28 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Date: Mon, 9 Mar 2009 22:02:23 +0100
Subject: [PATCH] Added driver for ISL29003 ambient light sensor

This patch adds a driver for Intersil's ISL29003 ambient light sensor
device plus some documentation. Inspired by tsl2550.c, a driver for a
similar device.

It is put to drivers/misc for now until the industrial I/O framework
gets merged.

Signed-off-by: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
---
 Documentation/i2c/chips/isl29003 |   62 +++++
 drivers/misc/Kconfig             |   10 +
 drivers/misc/Makefile            |    1 +
 drivers/misc/isl29003.c          |  486 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 559 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/i2c/chips/isl29003
 create mode 100644 drivers/misc/isl29003.c

diff --git a/Documentation/i2c/chips/isl29003 b/Documentation/i2c/chips/isl29003
new file mode 100644
index 0000000..c4ff5f3
--- /dev/null
+++ b/Documentation/i2c/chips/isl29003
@@ -0,0 +1,62 @@
+Kernel driver isl29003
+=====================
+
+Supported chips:
+* Intersil ISL29003
+Prefix: 'isl29003'
+Addresses scanned: none
+Datasheet:
+http://www.intersil.com/data/fn/fn7464.pdf
+
+Author: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
+
+
+Description
+-----------
+The ISL29003 is an integrated light sensor with a 16-bit integrating type
+ADC, I2C user programmable lux range select for optimized counts/lux, and
+I2C multi-function control and monitoring capabilities. The internal ADC
+provides 16-bit resolution while rejecting 50Hz and 60Hz flicker caused by
+artificial light sources.
+
+The driver allows to set the lux range, the bit resolution, the operational
+mode (see below) and the power state of device and can read the current lux
+value, of course.
+
+
+Detection
+---------
+
+The ISL29003 does not have an ID register which could be used to identify
+it, so the detection routine will just try to read from the configured I2C
+addess and consider the device to be present as soon as it ACKs the
+transfer.
+
+
+Sysfs entries
+-------------
+
+range:
+	0: 0 lux to 1000 lux (default)
+	1: 0 lux to 4000 lux
+	2: 0 lux to 16,000 lux
+	3: 0 lux to 64,000 lux
+
+resolution:
+	0: 2^16 cycles (default)
+	1: 2^12 cycles
+	2: 2^8 cycles
+	3: 2^4 cycles
+
+mode:
+	0: diode1's current (unsigned 16bit) (default)
+	1: diode1's current (unsigned 16bit)
+	2: difference between diodes (l1 - l2, signed 15bit)
+
+power_state:
+	0: device is disabled (default)
+	1: device is enabled
+
+lux (read only):
+	returns the value from the last sensor reading
+
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index c64e679..b883b19 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -223,6 +223,16 @@ config DELL_LAPTOP
 	This driver adds support for rfkill and backlight control to Dell
 	laptops.
 
+config ISL29003
+	tristate "Intersil ISL29003 ambient light sensor"
+	depends on I2C
+	help
+	  If you say yes here you get support for the Intersil ISL29003
+	  ambient light sensor.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called isl29003.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index bc11998..7871f05 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -18,5 +18,6 @@ obj-$(CONFIG_KGDB_TESTS)	+= kgdbts.o
 obj-$(CONFIG_SGI_XP)		+= sgi-xp/
 obj-$(CONFIG_SGI_GRU)		+= sgi-gru/
 obj-$(CONFIG_HP_ILO)		+= hpilo.o
+obj-$(CONFIG_ISL29003)		+= isl29003.o
 obj-$(CONFIG_C2PORT)		+= c2port/
 obj-y				+= eeprom/
diff --git a/drivers/misc/isl29003.c b/drivers/misc/isl29003.c
new file mode 100644
index 0000000..a17e89b
--- /dev/null
+++ b/drivers/misc/isl29003.c
@@ -0,0 +1,486 @@
+/*
+ *  isl29003.c - Linux kernel module for
+ * 	Intersil ISL29003 ambient light sensor
+ *
+ *  See file:Documentation/i2c/chips/isl29003
+ *
+ *  Copyright (c) 2009 Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
+ *
+ *  Based on code written by
+ *  	Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
+ *  	Eurotech S.p.A. <info-ymFC7zkAqBI1GQ1Ptb7lUw@public.gmane.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+
+#define ISL29003_DRV_NAME	"isl29003"
+#define DRIVER_VERSION		"1.0"
+
+#define ISL29003_REG_COMMAND		0x00
+#define ISL29003_ADC_ENABLED		(1 << 7)
+#define ISL29003_ADC_PD			(1 << 6)
+#define ISL29003_TIMING_INT		(1 << 5)
+#define ISL29003_MODE_SHIFT		(2)
+#define ISL29003_MODE_MASK		(0x3 << ISL29003_MODE_SHIFT)
+#define ISL29003_RES_SHIFT		(0)
+#define ISL29003_RES_MASK		(0x3 << ISL29003_RES_SHIFT)
+
+#define ISL29003_REG_CONTROL		0x01
+#define ISL29003_INT_FLG		(1 << 5)
+#define ISL29003_RANGE_SHIFT		(2)
+#define ISL29003_RANGE_MASK		(0x3 << ISL29003_RANGE_SHIFT)
+#define ISL29003_INT_PERSISTS_SHIFT	(0)
+#define ISL29003_INT_PERSISTS_MASK	(0xf << ISL29003_INT_PERSISTS_SHIFT)
+
+#define ISL29003_REG_IRQ_THRESH_HI	0x02
+#define ISL29003_REG_IRQ_THRESH_LO	0x03
+#define ISL29003_REG_LSB_SENSOR		0x04
+#define ISL29003_REG_MSB_SENSOR		0x05
+#define ISL29003_REG_LSB_TIMER		0x06
+#define ISL29003_REG_MSB_TIMER		0x07
+
+struct isl29003_data {
+	struct i2c_client *client;
+	struct mutex lock;
+	u8 reg_cache[8];
+};
+
+static int gain_range[] = {
+	1000, 4000, 16000, 64000
+};
+
+/*
+ * register access helpers
+ */
+
+static int __isl29003_read_reg(struct i2c_client *client,
+			       u32 reg, u8 mask, u8 shift)
+{
+	struct isl29003_data *data = i2c_get_clientdata(client);
+	return (data->reg_cache[reg] & mask) >> shift;
+}
+
+static int __isl29003_write_reg(struct i2c_client *client,
+				u32 reg, u8 mask, u8 shift, u8 val)
+{
+	struct isl29003_data *data = i2c_get_clientdata(client);
+	int ret = 0;
+	u8 tmp;
+
+	mutex_lock(&data->lock);
+
+	tmp = data->reg_cache[reg];
+	tmp &= ~mask;
+	tmp |= val << shift;
+
+	ret = i2c_smbus_write_byte_data(client, reg, tmp);
+	if (ret >= 0)
+		data->reg_cache[reg] = tmp;
+
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
+/*
+ * internally used functions
+ */
+
+/* range */
+static int isl29003_get_range(struct i2c_client *client)
+{
+	return __isl29003_read_reg(client, ISL29003_REG_CONTROL,
+		ISL29003_RANGE_MASK, ISL29003_RANGE_SHIFT);
+}
+
+static int isl29003_set_range(struct i2c_client *client, int range)
+{
+	return __isl29003_write_reg(client, ISL29003_REG_CONTROL,
+		ISL29003_RANGE_MASK, ISL29003_RANGE_SHIFT, range);
+}
+
+/* resolution */
+static int isl29003_get_resolution(struct i2c_client *client)
+{
+	return __isl29003_read_reg(client, ISL29003_REG_COMMAND,
+		ISL29003_RES_MASK, ISL29003_RES_SHIFT);
+}
+
+static int isl29003_set_resolution(struct i2c_client *client, int res)
+{
+	return __isl29003_write_reg(client, ISL29003_REG_COMMAND,
+		ISL29003_RES_MASK, ISL29003_RES_SHIFT, res);
+}
+
+/* mode */
+static int isl29003_get_mode(struct i2c_client *client)
+{
+	return __isl29003_read_reg(client, ISL29003_REG_COMMAND,
+		ISL29003_RES_MASK, ISL29003_RES_SHIFT);
+}
+
+static int isl29003_set_mode(struct i2c_client *client, int mode)
+{
+	return __isl29003_write_reg(client, ISL29003_REG_COMMAND,
+		ISL29003_RES_MASK, ISL29003_RES_SHIFT, mode);
+}
+
+/* power_state */
+static int isl29003_set_power_state(struct i2c_client *client, int state)
+{
+	int ret;
+
+	ret = __isl29003_write_reg(client, ISL29003_REG_COMMAND,
+		ISL29003_ADC_ENABLED, 0, state);
+	if (ret < 0)
+		return ret;
+
+	ret = __isl29003_write_reg(client, ISL29003_REG_COMMAND,
+		ISL29003_ADC_PD, 0, ~state);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int isl29003_get_power_state(struct i2c_client *client)
+{
+	struct isl29003_data *data = i2c_get_clientdata(client);
+	u8 cmdreg = data->reg_cache[ISL29003_REG_COMMAND];
+	return (cmdreg & ISL29003_ADC_ENABLED) && (~cmdreg & ISL29003_ADC_PD);
+}
+
+static int isl29003_get_adc_value(struct i2c_client *client)
+{
+	struct isl29003_data *data = i2c_get_clientdata(client);
+	int lsb, msb, range, bitdepth;
+
+	mutex_lock(&data->lock);
+	lsb = i2c_smbus_read_byte_data(client, ISL29003_REG_LSB_SENSOR);
+
+	if (lsb < 0) {
+		mutex_unlock(&data->lock);
+		return lsb;
+	}
+
+	msb = i2c_smbus_read_byte_data(client, ISL29003_REG_MSB_SENSOR);
+	mutex_unlock(&data->lock);
+
+	if (msb < 0)
+		return msb;
+
+	range = isl29003_get_range(client);
+	bitdepth = (4 - isl29003_get_resolution(client)) * 4;
+	return (((msb << 8) | lsb) * gain_range[range]) >> bitdepth;
+}
+
+/*
+ * sysfs layer
+ */
+
+/* range */
+static ssize_t isl29003_show_range(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	return sprintf(buf, "%i\n", isl29003_get_range(client));
+}
+
+static ssize_t isl29003_store_range(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned long val;
+	int ret;
+
+	if ((strict_strtoul(buf, 10, &val) < 0) || (val > 3))
+		return -EINVAL;
+
+	if (!isl29003_get_power_state(client))
+		return -EBUSY;
+
+	ret = isl29003_set_range(client, val);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR(range, S_IWUSR | S_IRUGO,
+		   isl29003_show_range, isl29003_store_range);
+
+
+/* resolution */
+static ssize_t isl29003_show_resolution(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	return sprintf(buf, "%d\n", isl29003_get_resolution(client));
+}
+
+static ssize_t isl29003_store_resolution(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned long val;
+	int ret;
+
+	if ((strict_strtoul(buf, 10, &val) < 0) || (val > 3))
+		return -EINVAL;
+
+	if (!isl29003_get_power_state(client))
+		return -EBUSY;
+
+	ret = isl29003_set_resolution(client, val);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR(resolution, S_IWUSR | S_IRUGO,
+		   isl29003_show_resolution, isl29003_store_resolution);
+
+/* mode */
+static ssize_t isl29003_show_mode(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	return sprintf(buf, "%d\n", isl29003_get_mode(client));
+}
+
+static ssize_t isl29003_store_mode(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned long val;
+	int ret;
+
+	if ((strict_strtoul(buf, 10, &val) < 0) || (val > 2))
+		return -EINVAL;
+
+	if (!isl29003_get_power_state(client))
+		return -EBUSY;
+
+	ret = isl29003_set_mode(client, val);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR(mode, S_IWUSR | S_IRUGO,
+		   isl29003_show_mode, isl29003_store_mode);
+
+
+/* power state */
+static ssize_t isl29003_show_power_state(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	return sprintf(buf, "%d\n", isl29003_get_power_state(client));
+}
+
+static ssize_t isl29003_store_power_state(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned long val;
+	int ret;
+
+	if ((strict_strtoul(buf, 10, &val) < 0) || (val > 1))
+		return -EINVAL;
+
+	ret = isl29003_set_power_state(client, val);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR(power_state, S_IWUSR | S_IRUGO,
+		   isl29003_show_power_state, isl29003_store_power_state);
+
+
+/* lux */
+static ssize_t isl29003_show_lux(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	/* No LUX data if not operational */
+	if (!isl29003_get_power_state(client))
+		return -EBUSY;
+
+	return sprintf(buf, "%d\n", isl29003_get_adc_value(client));
+}
+
+static DEVICE_ATTR(lux, S_IRUGO, isl29003_show_lux, NULL);
+
+static struct attribute *isl29003_attributes[] = {
+	&dev_attr_range.attr,
+	&dev_attr_resolution.attr,
+	&dev_attr_mode.attr,
+	&dev_attr_power_state.attr,
+	&dev_attr_lux.attr,
+	NULL
+};
+
+static const struct attribute_group isl29003_attr_group = {
+	.attrs = isl29003_attributes,
+};
+
+static int isl29003_init_client(struct i2c_client *client)
+{
+	struct isl29003_data *data = i2c_get_clientdata(client);
+	int i;
+
+	/* read all the registers once to fill the cache.
+	 * if one of the reads fails, we consider the init failed */
+	for (i = 0; i < ARRAY_SIZE(data->reg_cache); i++) {
+		int v = i2c_smbus_read_byte_data(client, i);
+		if (v < 0)
+			return -ENODEV;
+
+		data->reg_cache[i] = v;
+	}
+
+	/* set defaults */
+	isl29003_set_range(client, 0);
+	isl29003_set_resolution(client, 0);
+	isl29003_set_mode(client, 0);
+	isl29003_set_power_state(client, 0);
+
+	return 0;
+}
+
+/*
+ * I2C layer
+ */
+
+static int __devinit isl29003_probe(struct i2c_client *client,
+				    const struct i2c_device_id *id)
+{
+	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	struct isl29003_data *data;
+	int err = 0;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
+		return -EIO;
+
+	data = kzalloc(sizeof(struct isl29003_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->client = client;
+	i2c_set_clientdata(client, data);
+	mutex_init(&data->lock);
+
+	/* initialize the ISL29003 chip */
+	err = isl29003_init_client(client);
+	if (err)
+		goto exit_kfree;
+
+	/* register sysfs hooks */
+	err = sysfs_create_group(&client->dev.kobj, &isl29003_attr_group);
+	if (err)
+		goto exit_kfree;
+
+	dev_info(&client->dev, "driver version %s enabled\n", DRIVER_VERSION);
+	return 0;
+
+exit_kfree:
+	kfree(data);
+	return err;
+}
+
+static int __devexit isl29003_remove(struct i2c_client *client)
+{
+	sysfs_remove_group(&client->dev.kobj, &isl29003_attr_group);
+	isl29003_set_power_state(client, 0);
+	kfree(i2c_get_clientdata(client));
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int isl29003_suspend(struct i2c_client *client, pm_message_t mesg)
+{
+	return isl29003_set_power_state(client, 0);
+}
+
+static int isl29003_resume(struct i2c_client *client)
+{
+	int i;
+
+	/* restore registers from cache */
+	for (i = 0; i < ARRAY_SIZE(data->reg_cache); i++)
+		if (i2c_smbus_read_byte_data(client, i, data->reg_cache[i]) < 0)
+			return -ENODEV;
+
+	return 0;
+}
+
+#else
+#define isl29003_suspend	NULL
+#define isl29003_resume		NULL
+#endif /* CONFIG_PM */
+
+static const struct i2c_device_id isl29003_id[] = {
+	{ "isl29003", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, isl29003_id);
+
+static struct i2c_driver isl29003_driver = {
+	.driver = {
+		.name	= ISL29003_DRV_NAME,
+		.owner	= THIS_MODULE,
+	},
+	.suspend = isl29003_suspend,
+	.resume	= isl29003_resume,
+	.probe	= isl29003_probe,
+	.remove	= __devexit_p(isl29003_remove),
+	.id_table = isl29003_id,
+};
+
+static int __init isl29003_init(void)
+{
+	return i2c_add_driver(&isl29003_driver);
+}
+
+static void __exit isl29003_exit(void)
+{
+	i2c_del_driver(&isl29003_driver);
+}
+
+MODULE_AUTHOR("Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>");
+MODULE_DESCRIPTION("ISL29003 ambient light sensor driver");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION(DRIVER_VERSION);
+
+module_init(isl29003_init);
+module_exit(isl29003_exit);
+
-- 
1.6.1.3
