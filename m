From: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] i2c: support for hmc6343 3-Axis digital compass module.
Date: Thu,  9 Apr 2009 17:29:44 +0200
Message-ID: <1239290984-22787-1-git-send-email-giometti@enneenne.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>

Signed-off-by: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
---
 drivers/i2c/chips/Kconfig   |   10 +
 drivers/i2c/chips/Makefile  |    1 +
 drivers/i2c/chips/hmc6343.c |  677 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 688 insertions(+), 0 deletions(-)
 create mode 100644 drivers/i2c/chips/hmc6343.c

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index c80312c..7c5a497 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -102,4 +102,14 @@ config SENSORS_TSL2550
 	  This driver can also be built as a module.  If so, the module
 	  will be called tsl2550.
 
+config SENSORS_HMC6343
+	tristate "Honeywell 3-Axis digital compass module"
+	depends on EXPERIMENTAL
+	help
+	  If you say yes here you get support for the Honeywell 3-Axis
+	  digital compass module.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called hmc6343.
+
 endmenu
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
index d142f23..a6c7305 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_SENSORS_PCF8574)	+= pcf8574.o
 obj-$(CONFIG_PCF8575)		+= pcf8575.o
 obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
 obj-$(CONFIG_SENSORS_TSL2550)	+= tsl2550.o
+obj-$(CONFIG_SENSORS_HMC6343)	+= hmc6343.o
 
 ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/drivers/i2c/chips/hmc6343.c b/drivers/i2c/chips/hmc6343.c
new file mode 100644
index 0000000..c63aa41
--- /dev/null
+++ b/drivers/i2c/chips/hmc6343.c
@@ -0,0 +1,677 @@
+/*
+ *  hmc6343.c - driver for 3-Axis digital compass module
+ *
+ *  Copyright (C) 2008-2009 Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
+ *  Copyright (C) 2008-2009 Eurotech S.p.A. <info-ymFC7zkAqBI1GQ1Ptb7lUw@public.gmane.org>
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
+#define DRIVER_VERSION		"1.0.0"
+
+/*
+ * Defines
+ */
+
+#define HMC6343_POST_ACCEL_DATA		0x40
+#define HMC6343_POST_MAG_DATA		0x45
+#define HMC6343_POST_HEADING_DATA	0x50
+#define HMC6343_POST_TILT_DATA		0x55
+#define HMC6343_USR_CAL_ENTER		0x70
+#define HMC6343_USR_CAL2D_ENTER		0x71
+#define HMC6343_LEVEL_OR		0x72
+#define HMC6343_UPRIGHT_FRONT_OR	0x73
+#define HMC6343_UPRIGHT_EDGE_OR		0x74
+#define HMC6343_RUN_MODE		0x75
+#define HMC6343_STANDBY_MODE		0x76
+#define HMC6343_USR_CAL2D_EXIT		0x7e
+#define HMC6343_USR_CAL_EXIT		0x7f
+#define HMC6343_RESET			0x82
+#define HMC6343_ENTER_SLEEP		0x83
+#define HMC6343_EXIT_SLEEP		0x84
+
+#define HMC6343_EEPROM_READ		0xe1
+#define HMC6343_EEPROM_WRITE		0xf1
+
+#define	   HMC6343_EEPROM_DEVIATION_LSB	   0x0a
+#define	   HMC6343_EEPROM_DEVIATION_MSB	   0x0b
+#define	   HMC6343_EEPROM_VARIATION_LSB	   0x0c
+#define	   HMC6343_EEPROM_VARIATION_MSB	   0x0d
+
+/*
+ * Structs
+ */
+
+struct hmc6343_data {
+	struct mutex access_lock;
+};
+
+/*
+ * Management functions
+ */
+
+static int hmc6343_read_eeprom(struct i2c_client *client, u8 addr, u8 *data)
+{
+	u8 cmd[] = { HMC6343_EEPROM_READ, addr };
+	struct i2c_msg msg1[] = {
+		{ client->addr, 0, 2, cmd },
+	};
+	struct i2c_msg msg2[] = {
+		{ client->addr, I2C_M_RD, 1, data },
+	};
+	int ret;
+
+	ret = i2c_transfer(client->adapter, msg1, 1);
+	if (ret < 0)
+		return ret;
+
+	mdelay(10);
+
+	return i2c_transfer(client->adapter, msg2, 1);
+}
+
+static int hmc6343_write_eeprom(struct i2c_client *client, u8 addr, u8 data)
+{
+	u8 cmd[] = { HMC6343_EEPROM_WRITE, addr, data };
+	struct i2c_msg msg1[] = {
+		{ client->addr, 0, 3, cmd },
+	};
+	int ret;
+
+	ret = i2c_transfer(client->adapter, msg1, 1);
+
+	mdelay(10);
+
+	return ret;
+}
+
+static int hmc6343_set_calibration(struct i2c_client *client, int state)
+{
+	int ret;
+
+	if (state) {
+		ret = i2c_smbus_write_byte(client, HMC6343_USR_CAL_ENTER);
+		udelay(300);
+	} else {
+		ret = i2c_smbus_write_byte(client, HMC6343_USR_CAL_EXIT);
+		mdelay(3);
+	}
+
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int hmc6343_set_calibration_2d(struct i2c_client *client, int state)
+{
+	int ret;
+
+	if (state) {
+		ret = i2c_smbus_write_byte(client, HMC6343_USR_CAL2D_ENTER);
+		udelay(300);
+	} else {
+		ret = i2c_smbus_write_byte(client, HMC6343_USR_CAL2D_EXIT);
+		mdelay(3);
+	}
+
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int hmc6343_get_angle(struct i2c_client *client, u8 type, s16 *v)
+{
+	struct hmc6343_data *data = i2c_get_clientdata(client);
+	struct i2c_msg msg1[] = {
+		{ client->addr, 0, 1, &type },
+	};
+	u8 d[6];
+	struct i2c_msg msg2[] = {
+		{ client->addr, I2C_M_RD, 6, d },
+	};
+	int ret = 0;
+
+	mutex_lock(&data->access_lock);
+
+	ret = i2c_transfer(client->adapter, msg1, 1);
+	if (ret < 0)
+		goto exit;
+
+	mdelay(1);
+
+	ret = i2c_transfer(client->adapter, msg2, 1);
+	if (ret < 0)
+		goto exit;
+
+	v[0] = (s16) ((d[0] << 8) | d[1]);
+	v[1] = (s16) ((d[2] << 8) | d[3]);
+	v[2] = (s16) ((d[4] << 8) | d[5]);
+exit:
+	mutex_unlock(&data->access_lock);
+
+	return ret;
+}
+
+/*
+ * SysFS support
+ */
+
+static ssize_t hmc6343_show_eeprom(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct hmc6343_data *data = i2c_get_clientdata(client);
+	u8 addr;
+	int ret;
+
+	mutex_lock(&data->access_lock);
+
+	for (addr = 0; addr < 0x16; addr++) {
+		ret = hmc6343_read_eeprom(client, addr, &buf[addr]);
+		if (ret < 0)
+			goto exit;
+	}
+
+	ret = 0x16;
+exit:
+	mutex_unlock(&data->access_lock);
+
+	return ret;
+}
+
+static ssize_t hmc6343_store_eeprom(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct hmc6343_data *data = i2c_get_clientdata(client);
+	u8 addr;
+	int ret;
+
+	if (count > 0x16)
+		return -EINVAL;
+
+	mutex_lock(&data->access_lock);
+
+	for (addr = 0; addr < count; addr++) {
+		/* Skip reserved addresses.
+		 * Note that we also skip address 0x00 since it's used
+		 * to update the device's slave address and the driver
+		 * cannot manage an address modification...
+		 */
+		if (addr == 0 || \
+			addr == 1 || addr == 3 || addr == 4)
+			continue;
+
+		ret = hmc6343_write_eeprom(client, addr, buf[addr]);
+		if (ret < 0)
+			goto exit;
+	}
+
+	ret = count;
+exit:
+	mutex_unlock(&data->access_lock);
+
+	return ret;
+}
+
+static DEVICE_ATTR(eeprom, S_IWUSR | S_IRUGO,
+		   hmc6343_show_eeprom, hmc6343_store_eeprom);
+
+static ssize_t hmc6343_show_deviation(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct hmc6343_data *data = i2c_get_clientdata(client);
+	u8 d1, d2;
+	int ret;
+
+	mutex_lock(&data->access_lock);
+
+	ret = hmc6343_read_eeprom(client, HMC6343_EEPROM_DEVIATION_LSB, &d1);
+	if (ret < 0)
+		goto exit;
+
+	ret = hmc6343_read_eeprom(client, HMC6343_EEPROM_DEVIATION_MSB, &d2);
+	if (ret < 0)
+		goto exit;
+
+	ret = sprintf(buf, "%d\n", (s16) ((d2 << 8) | d1));
+exit:
+	mutex_unlock(&data->access_lock);
+
+	return ret;
+}
+
+static ssize_t hmc6343_store_deviation(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct hmc6343_data *data = i2c_get_clientdata(client);
+	long val;
+	int ret;
+
+	ret = strict_strtol(buf, 10, &val);
+	if (ret || val < -1800 || val > 1800)
+		return -EINVAL;
+
+	mutex_lock(&data->access_lock);
+
+	ret = hmc6343_write_eeprom(client, HMC6343_EEPROM_DEVIATION_LSB,
+						val & 0x00ff);
+	if (ret < 0)
+		goto exit;
+
+	ret = hmc6343_write_eeprom(client, HMC6343_EEPROM_DEVIATION_MSB,
+						(val & 0xff00) >> 8);
+	if (ret < 0)
+		goto exit;
+
+	ret = count;
+exit:
+	mutex_unlock(&data->access_lock);
+
+	return ret;
+}
+
+static DEVICE_ATTR(deviation, S_IWUSR | S_IRUGO,
+		   hmc6343_show_deviation, hmc6343_store_deviation);
+
+static ssize_t hmc6343_show_variation(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct hmc6343_data *data = i2c_get_clientdata(client);
+	u8 d1, d2;
+	int ret;
+
+	mutex_lock(&data->access_lock);
+
+	ret = hmc6343_read_eeprom(client, HMC6343_EEPROM_VARIATION_LSB, &d1);
+	if (ret < 0)
+		goto exit;
+
+	ret = hmc6343_read_eeprom(client, HMC6343_EEPROM_VARIATION_MSB, &d2);
+	if (ret < 0)
+		goto exit;
+
+	ret = sprintf(buf, "%d\n", (s16) ((d2 << 8) | d1));
+exit:
+	mutex_unlock(&data->access_lock);
+
+	return ret;
+}
+
+static ssize_t hmc6343_store_variation(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct hmc6343_data *data = i2c_get_clientdata(client);
+	long val;
+	int ret;
+
+	ret = strict_strtol(buf, 10, &val);
+	if (ret || val < -1800 || val > 1800)
+		return -EINVAL;
+
+	mutex_lock(&data->access_lock);
+
+	ret = hmc6343_write_eeprom(client, HMC6343_EEPROM_VARIATION_LSB,
+						val & 0x00ff);
+	if (ret < 0)
+		goto exit;
+
+	ret = hmc6343_write_eeprom(client, HMC6343_EEPROM_VARIATION_MSB,
+						(val & 0xff00) >> 8);
+	if (ret < 0)
+		goto exit;
+
+	ret = count;
+exit:
+	mutex_unlock(&data->access_lock);
+
+	return ret;
+}
+
+static DEVICE_ATTR(variation, S_IWUSR | S_IRUGO,
+		   hmc6343_show_variation, hmc6343_store_variation);
+
+static ssize_t hmc6343_store_calibration(struct device *dev,
+		 struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int state;
+	int ret;
+
+	if (strncmp(buf, "enter", 5) == 0)
+		state = 1;
+	else if (strncmp(buf, "exit", 4) == 0)
+		state = 0;
+	else
+		return -EINVAL;
+
+	ret = hmc6343_set_calibration(client, state);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR(calibration, S_IWUSR, NULL, hmc6343_store_calibration);
+
+static ssize_t hmc6343_store_calibration_2d(struct device *dev,
+		 struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int state;
+	int ret;
+
+	if (strncmp(buf, "enter", 5) == 0)
+		state = 1;
+	else if (strncmp(buf, "exit", 4) == 0)
+		state = 0;
+	else
+		return -EINVAL;
+
+	ret = hmc6343_set_calibration_2d(client, state);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR(calibration_2d, S_IWUSR, NULL, hmc6343_store_calibration_2d);
+
+static ssize_t hmc6343_store_orientation(struct device *dev,
+		 struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	u8 or;
+	int ret;
+
+	if (strncmp(buf, "level", 5) == 0)
+		or = HMC6343_LEVEL_OR;
+	else if (strncmp(buf, "front", 5) == 0)
+		or = HMC6343_UPRIGHT_FRONT_OR;
+	else if (strncmp(buf, "edge", 4) == 0)
+		or = HMC6343_UPRIGHT_EDGE_OR;
+	else
+		return -EINVAL;
+
+	ret = i2c_smbus_write_byte(client, or);
+	if (ret < 0)
+		return ret;
+
+	udelay(300);
+
+	return count;
+}
+
+static DEVICE_ATTR(orientation, S_IWUSR, NULL, hmc6343_store_orientation);
+
+static ssize_t hmc6343_store_mode(struct device *dev,
+		 struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	u8 mode;
+	int ret;
+
+	if (strncmp(buf, "run", 3) == 0)
+		mode = HMC6343_RUN_MODE;
+	else if (strncmp(buf, "standby", 7) == 0)
+		mode = HMC6343_STANDBY_MODE;
+	else if (strncmp(buf, "SLEEP", 5) == 0) /* FIXME: REMOVE ME */
+		mode = HMC6343_ENTER_SLEEP;
+	else if (strncmp(buf, "WAKE", 4) == 0) /* FIXME: REMOVE ME */
+		mode = HMC6343_EXIT_SLEEP;
+	else
+		return -EINVAL;
+
+	ret = i2c_smbus_write_byte(client, mode);
+	if (ret < 0)
+		return ret;
+
+	udelay(300);
+
+	return count;
+}
+
+static DEVICE_ATTR(mode, S_IWUSR, NULL, hmc6343_store_mode);
+
+static ssize_t hmc6343_store_reset(struct device *dev,
+		 struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned long val;
+	int ret;
+
+	ret = strict_strtoul(buf, 10, &val);
+	if (ret || val != 1)
+		return -EINVAL;
+
+	ret = i2c_smbus_write_byte(client, HMC6343_RESET);
+	if (ret < 0)
+		return ret;
+
+	udelay(300);
+
+	return count;
+}
+
+static DEVICE_ATTR(reset, S_IWUSR, NULL, hmc6343_store_reset);
+
+static ssize_t hmc6343_store_sleep(struct device *dev,
+		 struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned long val;
+	int ret;
+
+	ret = strict_strtoul(buf, 10, &val);
+	if (ret || val != 0 || val != 1)
+		return -EINVAL;
+
+	if (val) {
+		ret = i2c_smbus_write_byte(client, HMC6343_ENTER_SLEEP);
+		mdelay(1);
+	} else {
+		ret = i2c_smbus_write_byte(client, HMC6343_EXIT_SLEEP);
+		mdelay(20);
+	}
+
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR(sleep, S_IWUSR, NULL, hmc6343_store_sleep);
+
+static ssize_t hmc6343_show_accel(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	s16 data[3];
+	int ret;
+
+	ret = hmc6343_get_angle(client, HMC6343_POST_ACCEL_DATA, data);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "Ax:%d,Ay:%d,Az:%d\n", data[0], data[1], data[2]);
+}
+
+static DEVICE_ATTR(accel, S_IRUGO, hmc6343_show_accel, NULL);
+
+static ssize_t hmc6343_show_mag(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	s16 data[3];
+	int ret;
+
+	ret = hmc6343_get_angle(client, HMC6343_POST_MAG_DATA, data);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "Mx:%d,My:%d,Mz:%d\n", data[0], data[1], data[2]);
+}
+
+static DEVICE_ATTR(mag, S_IRUGO, hmc6343_show_mag, NULL);
+
+static ssize_t hmc6343_show_heading(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	s16 data[3];
+	int ret;
+
+	ret = hmc6343_get_angle(client, HMC6343_POST_HEADING_DATA, data);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "head:%d,pitch:%d,roll:%d\n",
+					data[0], data[1], data[2]);
+}
+
+static DEVICE_ATTR(heading, S_IRUGO, hmc6343_show_heading, NULL);
+
+static ssize_t hmc6343_show_tilt(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	s16 data[3];
+	int ret;
+
+	ret = hmc6343_get_angle(client, HMC6343_POST_TILT_DATA, data);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "pitch:%d,roll:%d,temp:%d\n",
+					data[0], data[1], data[2]);
+}
+
+static DEVICE_ATTR(tilt, S_IRUGO, hmc6343_show_tilt, NULL);
+
+static struct attribute *hmc6343_attributes[] = {
+	&dev_attr_eeprom.attr,
+	&dev_attr_deviation.attr,
+	&dev_attr_variation.attr,
+	&dev_attr_calibration.attr,
+	&dev_attr_calibration_2d.attr,
+	&dev_attr_orientation.attr,
+	&dev_attr_mode.attr,
+	&dev_attr_reset.attr,
+	&dev_attr_sleep.attr,
+	&dev_attr_accel.attr,
+	&dev_attr_mag.attr,
+	&dev_attr_heading.attr,
+	&dev_attr_tilt.attr,
+	NULL
+};
+
+static const struct attribute_group hmc6343_attr_group = {
+	.attrs = hmc6343_attributes,
+};
+
+/*
+ * I2C init/probing/exit functions
+ */
+
+static struct i2c_driver hmc6343_driver;
+static int __devinit hmc6343_probe(struct i2c_client *client,
+					const struct i2c_device_id *id)
+{
+	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	struct hmc6343_data *data;
+	int err = 0;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE
+				     | I2C_FUNC_SMBUS_WRITE_BYTE_DATA)) {
+		err = -EIO;
+		goto exit;
+	}
+
+	data = kzalloc(sizeof(struct hmc6343_data), GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto exit;
+	}
+	i2c_set_clientdata(client, data);
+
+	mutex_init(&data->access_lock);
+
+	/* Register sysfs hooks */
+	err = sysfs_create_group(&client->dev.kobj, &hmc6343_attr_group);
+	if (err)
+		goto exit;
+
+	dev_info(&client->dev, "support ver. %s enabled\n", DRIVER_VERSION);
+
+	return 0;
+
+exit:
+	return err;
+}
+
+static int __devexit hmc6343_remove(struct i2c_client *client)
+{
+	sysfs_remove_group(&client->dev.kobj, &hmc6343_attr_group);
+
+	kfree(i2c_get_clientdata(client));
+
+	return 0;
+}
+
+static const struct i2c_device_id hmc6343_id[] = {
+	{ "hmc6343", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, hmc6343_id);
+
+static struct i2c_driver hmc6343_driver = {
+	.driver = {
+		.name	= "hmc6343",
+		.owner	= THIS_MODULE,
+	},
+	.probe	= hmc6343_probe,
+	.remove	= __devexit_p(hmc6343_remove),
+	.id_table = hmc6343_id,
+};
+
+static int __init hmc6343_init(void)
+{
+	return i2c_add_driver(&hmc6343_driver);
+}
+
+static void __exit hmc6343_exit(void)
+{
+	i2c_del_driver(&hmc6343_driver);
+}
+
+MODULE_AUTHOR("Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>");
+MODULE_DESCRIPTION("HMC6343 3-axis digital compass module driver");
+MODULE_LICENSE("GPL");
+
+module_init(hmc6343_init);
+module_exit(hmc6343_exit);
-- 
1.5.6.3
