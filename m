From: Jonathan Kunkee <jonathan.kunkee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH RFC] i2c: Honeywell HMC6343 Support
Date: Mon, 18 Jul 2011 16:26:44 -0600
Message-ID: <CAGRJchhhf+GApvJ2103wwujo=d-jG3DJAwQiJZ0YrhkJsRSk1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

I recently got my hands on a Honeywell HMC6343 3-axis
magnetometer/accelerometer/compass module. Rather than manipulating
the I2C buss by means of ioctl() calls, I looked on line for a kernel
module that provided a convenient /sys interface. The one I found was
on this mailing list, by Rodolfo Giometti, viewable at
http://www.mail-archive.com/linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg00811.html

It was almost exactly what I needed, but I found nothing like it
upstream. After some polishing and adjusting, I now have it working
with the module as per the current datasheet. It is also located in
the path suggested later in that thread.

First, I have a few questions:
- First and foremost, is there a better forum for this?
- Should all magnetometers (notably the hmc6352 code and this patch)
end up under drivers/staging/iio/magnetometer with the hmc5843 and
ak8975 code?
- Would you please review my style as well as the code itself? This is
my first kernel patch to be reviewed publicly.
- Mr. Giometti, do I need to add anything like a Signed-off-by line
for proper attribution?

Tests from Documentation/SubmitChecklist in the kernel tree that I did
not do: 9, 12, 13, 14, 15, 21, 23

It is not power management compliant, that is, .suspend and .resume
methods are not included as requested in
Documentation/SubmittingDrivers. They will be fairly easy to
implement.

Now for the patch. This was developed and tested against the 2.6.39
stable release (not .1 or .2) and compiles when applied to the 3.0
tree. Specifically, I used commit
5dcd07b9f39ca3e9be5bcc387d193fc0674e1c81. This is also available as a
fork at
https://github.com/jkunkee/linux-2.6/tree/magnetometer



From: Jonathan Kunkee <jonathan.kunkee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This patch adds a kernel module that utilizes the I2C buss
to drive an HMC6343 magnetometer and provide the
generated data under /sys.

Signed-off-by: Jonathan Kunkee <jonathan.kunkee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
It is derived from work done by Rodolfo Giometti. Proper attribution
may not be in place yet.

drivers/misc/Kconfig              |   10 +
drivers/misc/Makefile             |    1 +
drivers/misc/hmc6343.c            |  782 +++++++++++++++++++++++++++++++++++++
4 files changed, 803 insertions(+), 1 deletions(-)
create mode 100644 drivers/misc/hmc6343.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 4e349cd..d30f175 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -354,6 +354,16 @@ config SENSORS_TSL2550
 	  This driver can also be built as a module.  If so, the module
 	  will be called tsl2550.

+config SENSORS_HMC6343
+	tristate "Honeywell HMC6343 3-Axis digital compass module"
+  depends on EXPERIMENTAL && I2C
+  help
+    If you say yes here you get support for the Honeywell HMC6343
+    3-Axis digital compass/accelerometer module.
+
+    This driver can also be built as a module.  If so, the module
+    will be called hmc6343.
+
 config SENSORS_BH1780
 	tristate "ROHM BH1780GLI ambient light sensor"
 	depends on I2C && SYSFS
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 5f03172..3bde1d4 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_APDS9802ALS)	+= apds9802als.o
 obj-$(CONFIG_ISL29003)		+= isl29003.o
 obj-$(CONFIG_ISL29020)		+= isl29020.o
 obj-$(CONFIG_SENSORS_TSL2550)	+= tsl2550.o
+obj-$(CONFIG_SENSORS_HMC6343)  += hmc6343.o
 obj-$(CONFIG_EP93XX_PWM)	+= ep93xx_pwm.o
 obj-$(CONFIG_DS1682)		+= ds1682.o
 obj-$(CONFIG_TI_DAC7512)	+= ti_dac7512.o
diff --git a/drivers/misc/hmc6343.c b/drivers/misc/hmc6343.c
new file mode 100644
index 0000000..70890f8
--- /dev/null
+++ b/drivers/misc/hmc6343.c
@@ -0,0 +1,782 @@
+/*
+ *  hmc6343.c - driver for 3-Axis digital compass module
+ *
+ *  Copyright (C) 2008-2009 Rodolfo Giometti <giome...-k2GhghHVRtY@public.gmane.org>
+ *  Copyright (C) 2008-2009 Eurotech S.p.A. <i...-ymFC7zkAqBI1GQ1Ptb7lUw@public.gmane.org>
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
+/*
+ * TODO for this driver:
+ *  Measurement rate show/set (including change the op_1 function)
+ *  Test sleep mode
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+
+#define DRIVER_VERSION      "1.0.0"
+
+/*
+ * Defines
+ */
+
+/* Commands for reading data */
+#define HMC6343_POST_ACCEL_DATA     0x40
+#define HMC6343_POST_MAG_DATA       0x45
+#define HMC6343_POST_HEADING_DATA   0x50
+#define HMC6343_POST_TILT_DATA      0x55
+
+/* Commands for setting the axis orientation */
+#define HMC6343_LEVEL_OR            0x72
+#define HMC6343_UPRIGHT_FRONT_OR    0x74
+#define HMC6343_UPRIGHT_EDGE_OR     0x73
+
+#define HMC6343_USR_CAL_ENTER       0x71
+#define HMC6343_USR_CAL_EXIT        0x7e
+
+#define HMC6343_RESET               0x82
+
+#define HMC6343_RUN_MODE            0x75
+#define HMC6343_STANDBY_MODE        0x76
+#define HMC6343_ENTER_SLEEP         0x83
+#define HMC6343_EXIT_SLEEP          0x84
+
+#define HMC6343_EEPROM_READ         0xe1
+#define HMC6343_EEPROM_WRITE        0xf1
+
+#define HMC6343_EEPROM_DEVIATION_LSB    0x0a
+#define HMC6343_EEPROM_DEVIATION_MSB    0x0b
+#define HMC6343_EEPROM_VARIATION_LSB    0x0c
+#define HMC6343_EEPROM_VARIATION_MSB    0x0d
+
+#define HMC6343_EEPROM_OP_1         0x04
+
+#define HMC6343_ORIENTATION_BITS    0x07
+#define HMC6343_LEVEL_OR_BIT        0x01
+#define HMC6343_EDGE_OR_BIT         0x02
+#define HMC6343_FRONT_OR_BIT        0x04
+
+/*
+ * Note that all bits of OP_2 except these must be
+ * clear for proper operation, so each of these
+ * values may be written to the register unmasked.
+ */
+#define HMC6343_EEPROM_OP_2         0x05
+
+#define HMC6343_RATE_BITS           0X03
+#define HMC6343_1_HZ                0x00
+#define HMC6343_5_HZ                0x01
+#define HMC6343_10_HZ               0x02
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
+/* Uses the 0x65 command to acquire the current contents of the status
+ *  register (EEPROM 0x4). This is the live value, as opposed to the
+ *  boot default value accessed using the EEPROM read command.
+ */
+static int hmc6343_read_op_1(struct i2c_client *client, u8 *data)
+{
+	unsigned char count = 1;
+	u8 command = 0x65;
+
+	struct i2c_msg read_command[] = {
+		{ client->addr, I2C_M_RD, count, data },
+	};
+	int ret;
+
+	ret = i2c_smbus_write_byte(client, command);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_transfer(client->adapter, read_command, count);
+	return ret;
+}
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
+/* TODO: print the EEPROM contents as readable hex? */
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
+		 *
+		 * Also note that register 4 can be written to set
+		 * the orientation at power on.
+		 */
+		if (addr == 0 || \
+			addr == 1 || addr == 3 /*|| addr == 4*/)
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
+			hmc6343_show_eeprom, hmc6343_store_eeprom);
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
+								val & 0x00ff);
+	if (ret < 0)
+		goto exit;
+
+	ret = hmc6343_write_eeprom(client, HMC6343_EEPROM_DEVIATION_MSB,
+							(val & 0xff00) >> 8);
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
+			hmc6343_show_deviation, hmc6343_store_deviation);
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
+							val & 0x00ff);
+	if (ret < 0)
+		goto exit;
+
+	ret = hmc6343_write_eeprom(client, HMC6343_EEPROM_VARIATION_MSB,
+							(val & 0xff00) >> 8);
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
+			hmc6343_show_variation, hmc6343_store_variation);
+
+static ssize_t hmc6343_show_calibration(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	u8 op_1;
+	hmc6343_read_op_1(client, &op_1);
+
+	switch (op_1 & 0b01000000) {
+	case 0:
+		return sprintf(buf, " enter [exit]\n");
+		break;
+	case 64:
+		return sprintf(buf, "[enter] exit\n");
+		break;
+	default:
+		return sprintf(buf, "unknown calibration state: "
+				"OP_1 = 0x%x\n", op_1);
+		break;
+	}
+	return sprintf(buf, "hmc6343.o: can't get here\n");
+}
+
+static ssize_t hmc6343_store_calibration(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
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
+static DEVICE_ATTR(calibration, S_IWUSR | S_IRUGO,
+		hmc6343_show_calibration, hmc6343_store_calibration);
+
+static ssize_t hmc6343_show_orientation(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	u8 op_1;
+	hmc6343_read_op_1(client, &op_1);
+
+	switch (op_1 & 0b00000111) {
+	case 1:
+		return sprintf(buf, "[level] edge  front\n");
+		break;
+	case 2:
+		return sprintf(buf, " level [edge] front\n");
+		break;
+	case 4:
+		return sprintf(buf, " level  edge [front]\n");
+		break;
+	default:
+		return sprintf(buf, "unknown orientation: "
+				"OP_1 = 0x%x\n", op_1);
+		break;
+	}
+	return sprintf(buf, "hmc6343.o: can't get here\n");
+}
+
+static ssize_t hmc6343_store_orientation(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
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
+
+	if (ret < 0)
+		return ret;
+
+	udelay(300);
+
+	return count;
+}
+
+static DEVICE_ATTR(orientation, S_IWUSR | S_IRUGO, hmc6343_show_orientation,
+		hmc6343_store_orientation);
+
+static ssize_t hmc6343_show_mode(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	u8 op_1;
+	hmc6343_read_op_1(client, &op_1);
+
+	switch (op_1 & 0b00011000) {
+	case 8:
+		return sprintf(buf, " run [standby]\n");
+		break;
+	case 16:
+		return sprintf(buf, "[run] standby\n");
+		break;
+	default:
+		return sprintf(buf, "unknown mode: OP_1 = 0x%x\n", op_1);
+		break;
+	}
+	return sprintf(buf, "hmc6343.o: can't get here\n");
+}
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
+	else
+		return -EINVAL;
+
+	ret = i2c_smbus_write_byte(client, mode);
+
+	if (ret < 0)
+		return ret;
+
+	udelay(300);
+
+	return ret;
+}
+
+static DEVICE_ATTR(mode, S_IWUSR | S_IRUGO,
+		hmc6343_show_mode, hmc6343_store_mode);
+
+static ssize_t hmc6343_show_reset(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "valid input: 1\n");
+}
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
+
+	if (ret < 0)
+		return ret;
+
+	udelay(300);
+
+	return count;
+}
+
+static DEVICE_ATTR(reset, S_IWUSR | S_IRUGO,
+		hmc6343_show_reset, hmc6343_store_reset);
+
+static ssize_t hmc6343_show_sleep(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	u8 op_1;
+	struct i2c_client *client = to_i2c_client(dev);
+	hmc6343_read_op_1(client, &op_1);
+
+	/* Bits 3 and 4 are the current mode - TODO: test this */
+	if ((op_1 & 0x18) == 0)
+		return sprintf(buf, "[1] = enter sleep\n 0  = exit sleep\n");
+	else
+		return sprintf(buf, " 1  = enter sleep\n[0] = exit sleep\n");
+}
+
+static ssize_t hmc6343_store_sleep(struct device *dev,
+		 struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned long val;
+	int ret;
+
+	ret = strict_strtoul(buf, 10, &val);
+	if (ret || ((val != 0) && (val != 1)))
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
+static DEVICE_ATTR(sleep, S_IWUSR | S_IRUGO,
+		hmc6343_show_sleep, hmc6343_store_sleep);
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
+						data[0], data[1], data[2]);
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
+						data[0], data[1], data[2]);
+}
+
+static DEVICE_ATTR(tilt, S_IRUGO, hmc6343_show_tilt, NULL);
+
+static struct attribute *hmc6343_attributes[] = {
+	&dev_attr_eeprom.attr,
+	&dev_attr_deviation.attr,
+	&dev_attr_variation.attr,
+	&dev_attr_calibration.attr,
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
+						const struct i2c_device_id *id)
+{
+	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	struct hmc6343_data *data;
+	int err = 0;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE
+					| I2C_FUNC_SMBUS_WRITE_BYTE_DATA)) {
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
+		.name   = "hmc6343",
+		.owner  = THIS_MODULE,
+	},
+	.probe  = hmc6343_probe,
+	.remove = __devexit_p(hmc6343_remove),
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
+MODULE_AUTHOR("Rodolfo Giometti <giome...-k2GhghHVRtY@public.gmane.org>");
+MODULE_DESCRIPTION("HMC6343 3-axis digital compass module driver");
+MODULE_LICENSE("GPL");
+
+module_init(hmc6343_init);
+module_exit(hmc6343_exit);
