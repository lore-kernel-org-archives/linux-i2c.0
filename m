From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] i2c/chips: move ds1682 to drivers/misc
Date: Thu,  8 Oct 2009 00:31:50 +0200
Message-ID: <1254954710-18263-1-git-send-email-w.sang@pengutronix.de>
References: <20091007115017.6941faa7@hyperion.delvare>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091007115017.6941faa7-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

As i2c/chips is deprecated, move ds1682 to a more apropriate location.
Build tested.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/chips/Kconfig  |   10 --
 drivers/i2c/chips/Makefile |    1 -
 drivers/i2c/chips/ds1682.c |  267 --------------------------------------------
 drivers/misc/Kconfig       |   10 ++
 drivers/misc/Makefile      |    1 +
 drivers/misc/ds1682.c      |  267 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 278 insertions(+), 278 deletions(-)
 delete mode 100644 drivers/i2c/chips/ds1682.c
 create mode 100644 drivers/misc/ds1682.c

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index f9618f4..ae4539d 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -6,16 +6,6 @@
 
 menu "Miscellaneous I2C Chip support"
 
-config DS1682
-	tristate "Dallas DS1682 Total Elapsed Time Recorder with Alarm"
-	depends on EXPERIMENTAL
-	help
-	  If you say yes here you get support for Dallas Semiconductor
-	  DS1682 Total Elapsed Time Recorder.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called ds1682.
-
 config SENSORS_TSL2550
 	tristate "Taos TSL2550 ambient light sensor"
 	depends on EXPERIMENTAL
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
index 749cf36..fe0af0f 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -10,7 +10,6 @@
 # * I/O expander drivers go to drivers/gpio
 #
 
-obj-$(CONFIG_DS1682)		+= ds1682.o
 obj-$(CONFIG_SENSORS_TSL2550)	+= tsl2550.o
 
 ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)
diff --git a/drivers/i2c/chips/ds1682.c b/drivers/i2c/chips/ds1682.c
deleted file mode 100644
index f3ee4a1..0000000
--- a/drivers/i2c/chips/ds1682.c
+++ /dev/null
@@ -1,267 +0,0 @@
-/*
- * Dallas Semiconductor DS1682 Elapsed Time Recorder device driver
- *
- * Written by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
- *
- * Copyright (C) 2007 Secret Lab Technologies Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-/*
- * The DS1682 elapsed timer recorder is a simple device that implements
- * one elapsed time counter, one event counter, an alarm signal and 10
- * bytes of general purpose EEPROM.
- *
- * This driver provides access to the DS1682 counters and user data via
- * the sysfs.  The following attributes are added to the device node:
- *     elapsed_time (u32): Total elapsed event time in ms resolution
- *     alarm_time (u32): When elapsed time exceeds the value in alarm_time,
- *                       then the alarm pin is asserted.
- *     event_count (u16): number of times the event pin has gone low.
- *     eeprom (u8[10]): general purpose EEPROM
- *
- * Counter registers and user data are both read/write unless the device
- * has been write protected.  This driver does not support turning off write
- * protection.  Once write protection is turned on, it is impossible to
- * turn it off again, so I have left the feature out of this driver to avoid
- * accidental enabling, but it is trivial to add write protect support.
- *
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/i2c.h>
-#include <linux/string.h>
-#include <linux/list.h>
-#include <linux/sysfs.h>
-#include <linux/ctype.h>
-#include <linux/hwmon-sysfs.h>
-
-/* Device registers */
-#define DS1682_REG_CONFIG		0x00
-#define DS1682_REG_ALARM		0x01
-#define DS1682_REG_ELAPSED		0x05
-#define DS1682_REG_EVT_CNTR		0x09
-#define DS1682_REG_EEPROM		0x0b
-#define DS1682_REG_RESET		0x1d
-#define DS1682_REG_WRITE_DISABLE	0x1e
-#define DS1682_REG_WRITE_MEM_DISABLE	0x1f
-
-#define DS1682_EEPROM_SIZE		10
-
-/*
- * Generic counter attributes
- */
-static ssize_t ds1682_show(struct device *dev, struct device_attribute *attr,
-			   char *buf)
-{
-	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
-	struct i2c_client *client = to_i2c_client(dev);
-	__le32 val = 0;
-	int rc;
-
-	dev_dbg(dev, "ds1682_show() called on %s\n", attr->attr.name);
-
-	/* Read the register */
-	rc = i2c_smbus_read_i2c_block_data(client, sattr->index, sattr->nr,
-					   (u8 *) & val);
-	if (rc < 0)
-		return -EIO;
-
-	/* Special case: the 32 bit regs are time values with 1/4s
-	 * resolution, scale them up to milliseconds */
-	if (sattr->nr == 4)
-		return sprintf(buf, "%llu\n",
-			((unsigned long long)le32_to_cpu(val)) * 250);
-
-	/* Format the output string and return # of bytes */
-	return sprintf(buf, "%li\n", (long)le32_to_cpu(val));
-}
-
-static ssize_t ds1682_store(struct device *dev, struct device_attribute *attr,
-			    const char *buf, size_t count)
-{
-	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
-	struct i2c_client *client = to_i2c_client(dev);
-	char *endp;
-	u64 val;
-	__le32 val_le;
-	int rc;
-
-	dev_dbg(dev, "ds1682_store() called on %s\n", attr->attr.name);
-
-	/* Decode input */
-	val = simple_strtoull(buf, &endp, 0);
-	if (buf == endp) {
-		dev_dbg(dev, "input string not a number\n");
-		return -EINVAL;
-	}
-
-	/* Special case: the 32 bit regs are time values with 1/4s
-	 * resolution, scale input down to quarter-seconds */
-	if (sattr->nr == 4)
-		do_div(val, 250);
-
-	/* write out the value */
-	val_le = cpu_to_le32(val);
-	rc = i2c_smbus_write_i2c_block_data(client, sattr->index, sattr->nr,
-					    (u8 *) & val_le);
-	if (rc < 0) {
-		dev_err(dev, "register write failed; reg=0x%x, size=%i\n",
-			sattr->index, sattr->nr);
-		return -EIO;
-	}
-
-	return count;
-}
-
-/*
- * Simple register attributes
- */
-static SENSOR_DEVICE_ATTR_2(elapsed_time, S_IRUGO | S_IWUSR, ds1682_show,
-			    ds1682_store, 4, DS1682_REG_ELAPSED);
-static SENSOR_DEVICE_ATTR_2(alarm_time, S_IRUGO | S_IWUSR, ds1682_show,
-			    ds1682_store, 4, DS1682_REG_ALARM);
-static SENSOR_DEVICE_ATTR_2(event_count, S_IRUGO | S_IWUSR, ds1682_show,
-			    ds1682_store, 2, DS1682_REG_EVT_CNTR);
-
-static const struct attribute_group ds1682_group = {
-	.attrs = (struct attribute *[]) {
-		&sensor_dev_attr_elapsed_time.dev_attr.attr,
-		&sensor_dev_attr_alarm_time.dev_attr.attr,
-		&sensor_dev_attr_event_count.dev_attr.attr,
-		NULL,
-	},
-};
-
-/*
- * User data attribute
- */
-static ssize_t ds1682_eeprom_read(struct kobject *kobj, struct bin_attribute *attr,
-				  char *buf, loff_t off, size_t count)
-{
-	struct i2c_client *client = kobj_to_i2c_client(kobj);
-	int rc;
-
-	dev_dbg(&client->dev, "ds1682_eeprom_read(p=%p, off=%lli, c=%zi)\n",
-		buf, off, count);
-
-	if (off >= DS1682_EEPROM_SIZE)
-		return 0;
-
-	if (off + count > DS1682_EEPROM_SIZE)
-		count = DS1682_EEPROM_SIZE - off;
-
-	rc = i2c_smbus_read_i2c_block_data(client, DS1682_REG_EEPROM + off,
-					   count, buf);
-	if (rc < 0)
-		return -EIO;
-
-	return count;
-}
-
-static ssize_t ds1682_eeprom_write(struct kobject *kobj, struct bin_attribute *attr,
-				   char *buf, loff_t off, size_t count)
-{
-	struct i2c_client *client = kobj_to_i2c_client(kobj);
-
-	dev_dbg(&client->dev, "ds1682_eeprom_write(p=%p, off=%lli, c=%zi)\n",
-		buf, off, count);
-
-	if (off >= DS1682_EEPROM_SIZE)
-		return -ENOSPC;
-
-	if (off + count > DS1682_EEPROM_SIZE)
-		count = DS1682_EEPROM_SIZE - off;
-
-	/* Write out to the device */
-	if (i2c_smbus_write_i2c_block_data(client, DS1682_REG_EEPROM + off,
-					   count, buf) < 0)
-		return -EIO;
-
-	return count;
-}
-
-static struct bin_attribute ds1682_eeprom_attr = {
-	.attr = {
-		.name = "eeprom",
-		.mode = S_IRUGO | S_IWUSR,
-	},
-	.size = DS1682_EEPROM_SIZE,
-	.read = ds1682_eeprom_read,
-	.write = ds1682_eeprom_write,
-};
-
-/*
- * Called when a ds1682 device is matched with this driver
- */
-static int ds1682_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
-{
-	int rc;
-
-	if (!i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_I2C_BLOCK)) {
-		dev_err(&client->dev, "i2c bus does not support the ds1682\n");
-		rc = -ENODEV;
-		goto exit;
-	}
-
-	rc = sysfs_create_group(&client->dev.kobj, &ds1682_group);
-	if (rc)
-		goto exit;
-
-	rc = sysfs_create_bin_file(&client->dev.kobj, &ds1682_eeprom_attr);
-	if (rc)
-		goto exit_bin_attr;
-
-	return 0;
-
- exit_bin_attr:
-	sysfs_remove_group(&client->dev.kobj, &ds1682_group);
- exit:
-	return rc;
-}
-
-static int ds1682_remove(struct i2c_client *client)
-{
-	sysfs_remove_bin_file(&client->dev.kobj, &ds1682_eeprom_attr);
-	sysfs_remove_group(&client->dev.kobj, &ds1682_group);
-	return 0;
-}
-
-static const struct i2c_device_id ds1682_id[] = {
-	{ "ds1682", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, ds1682_id);
-
-static struct i2c_driver ds1682_driver = {
-	.driver = {
-		.name = "ds1682",
-	},
-	.probe = ds1682_probe,
-	.remove = ds1682_remove,
-	.id_table = ds1682_id,
-};
-
-static int __init ds1682_init(void)
-{
-	return i2c_add_driver(&ds1682_driver);
-}
-
-static void __exit ds1682_exit(void)
-{
-	i2c_del_driver(&ds1682_driver);
-}
-
-MODULE_AUTHOR("Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>");
-MODULE_DESCRIPTION("DS1682 Elapsed Time Indicator driver");
-MODULE_LICENSE("GPL");
-
-module_init(ds1682_init);
-module_exit(ds1682_exit);
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index df1f86b..ebff36b 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -246,6 +246,16 @@ config EP93XX_PWM
 	  To compile this driver as a module, choose M here: the module will
 	  be called ep93xx_pwm.
 
+config DS1682
+	tristate "Dallas DS1682 Total Elapsed Time Recorder with Alarm"
+	depends on EXPERIMENTAL
+	help
+	  If you say yes here you get support for Dallas Semiconductor
+	  DS1682 Total Elapsed Time Recorder.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called ds1682.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index f982d2e..b6245e4 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_SGI_GRU)		+= sgi-gru/
 obj-$(CONFIG_HP_ILO)		+= hpilo.o
 obj-$(CONFIG_ISL29003)		+= isl29003.o
 obj-$(CONFIG_EP93XX_PWM)	+= ep93xx_pwm.o
+obj-$(CONFIG_DS1682)		+= ds1682.o
 obj-$(CONFIG_C2PORT)		+= c2port/
 obj-y				+= eeprom/
 obj-y				+= cb710/
diff --git a/drivers/misc/ds1682.c b/drivers/misc/ds1682.c
new file mode 100644
index 0000000..f3ee4a1
--- /dev/null
+++ b/drivers/misc/ds1682.c
@@ -0,0 +1,267 @@
+/*
+ * Dallas Semiconductor DS1682 Elapsed Time Recorder device driver
+ *
+ * Written by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
+ *
+ * Copyright (C) 2007 Secret Lab Technologies Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * The DS1682 elapsed timer recorder is a simple device that implements
+ * one elapsed time counter, one event counter, an alarm signal and 10
+ * bytes of general purpose EEPROM.
+ *
+ * This driver provides access to the DS1682 counters and user data via
+ * the sysfs.  The following attributes are added to the device node:
+ *     elapsed_time (u32): Total elapsed event time in ms resolution
+ *     alarm_time (u32): When elapsed time exceeds the value in alarm_time,
+ *                       then the alarm pin is asserted.
+ *     event_count (u16): number of times the event pin has gone low.
+ *     eeprom (u8[10]): general purpose EEPROM
+ *
+ * Counter registers and user data are both read/write unless the device
+ * has been write protected.  This driver does not support turning off write
+ * protection.  Once write protection is turned on, it is impossible to
+ * turn it off again, so I have left the feature out of this driver to avoid
+ * accidental enabling, but it is trivial to add write protect support.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/string.h>
+#include <linux/list.h>
+#include <linux/sysfs.h>
+#include <linux/ctype.h>
+#include <linux/hwmon-sysfs.h>
+
+/* Device registers */
+#define DS1682_REG_CONFIG		0x00
+#define DS1682_REG_ALARM		0x01
+#define DS1682_REG_ELAPSED		0x05
+#define DS1682_REG_EVT_CNTR		0x09
+#define DS1682_REG_EEPROM		0x0b
+#define DS1682_REG_RESET		0x1d
+#define DS1682_REG_WRITE_DISABLE	0x1e
+#define DS1682_REG_WRITE_MEM_DISABLE	0x1f
+
+#define DS1682_EEPROM_SIZE		10
+
+/*
+ * Generic counter attributes
+ */
+static ssize_t ds1682_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+	struct i2c_client *client = to_i2c_client(dev);
+	__le32 val = 0;
+	int rc;
+
+	dev_dbg(dev, "ds1682_show() called on %s\n", attr->attr.name);
+
+	/* Read the register */
+	rc = i2c_smbus_read_i2c_block_data(client, sattr->index, sattr->nr,
+					   (u8 *) & val);
+	if (rc < 0)
+		return -EIO;
+
+	/* Special case: the 32 bit regs are time values with 1/4s
+	 * resolution, scale them up to milliseconds */
+	if (sattr->nr == 4)
+		return sprintf(buf, "%llu\n",
+			((unsigned long long)le32_to_cpu(val)) * 250);
+
+	/* Format the output string and return # of bytes */
+	return sprintf(buf, "%li\n", (long)le32_to_cpu(val));
+}
+
+static ssize_t ds1682_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+	struct i2c_client *client = to_i2c_client(dev);
+	char *endp;
+	u64 val;
+	__le32 val_le;
+	int rc;
+
+	dev_dbg(dev, "ds1682_store() called on %s\n", attr->attr.name);
+
+	/* Decode input */
+	val = simple_strtoull(buf, &endp, 0);
+	if (buf == endp) {
+		dev_dbg(dev, "input string not a number\n");
+		return -EINVAL;
+	}
+
+	/* Special case: the 32 bit regs are time values with 1/4s
+	 * resolution, scale input down to quarter-seconds */
+	if (sattr->nr == 4)
+		do_div(val, 250);
+
+	/* write out the value */
+	val_le = cpu_to_le32(val);
+	rc = i2c_smbus_write_i2c_block_data(client, sattr->index, sattr->nr,
+					    (u8 *) & val_le);
+	if (rc < 0) {
+		dev_err(dev, "register write failed; reg=0x%x, size=%i\n",
+			sattr->index, sattr->nr);
+		return -EIO;
+	}
+
+	return count;
+}
+
+/*
+ * Simple register attributes
+ */
+static SENSOR_DEVICE_ATTR_2(elapsed_time, S_IRUGO | S_IWUSR, ds1682_show,
+			    ds1682_store, 4, DS1682_REG_ELAPSED);
+static SENSOR_DEVICE_ATTR_2(alarm_time, S_IRUGO | S_IWUSR, ds1682_show,
+			    ds1682_store, 4, DS1682_REG_ALARM);
+static SENSOR_DEVICE_ATTR_2(event_count, S_IRUGO | S_IWUSR, ds1682_show,
+			    ds1682_store, 2, DS1682_REG_EVT_CNTR);
+
+static const struct attribute_group ds1682_group = {
+	.attrs = (struct attribute *[]) {
+		&sensor_dev_attr_elapsed_time.dev_attr.attr,
+		&sensor_dev_attr_alarm_time.dev_attr.attr,
+		&sensor_dev_attr_event_count.dev_attr.attr,
+		NULL,
+	},
+};
+
+/*
+ * User data attribute
+ */
+static ssize_t ds1682_eeprom_read(struct kobject *kobj, struct bin_attribute *attr,
+				  char *buf, loff_t off, size_t count)
+{
+	struct i2c_client *client = kobj_to_i2c_client(kobj);
+	int rc;
+
+	dev_dbg(&client->dev, "ds1682_eeprom_read(p=%p, off=%lli, c=%zi)\n",
+		buf, off, count);
+
+	if (off >= DS1682_EEPROM_SIZE)
+		return 0;
+
+	if (off + count > DS1682_EEPROM_SIZE)
+		count = DS1682_EEPROM_SIZE - off;
+
+	rc = i2c_smbus_read_i2c_block_data(client, DS1682_REG_EEPROM + off,
+					   count, buf);
+	if (rc < 0)
+		return -EIO;
+
+	return count;
+}
+
+static ssize_t ds1682_eeprom_write(struct kobject *kobj, struct bin_attribute *attr,
+				   char *buf, loff_t off, size_t count)
+{
+	struct i2c_client *client = kobj_to_i2c_client(kobj);
+
+	dev_dbg(&client->dev, "ds1682_eeprom_write(p=%p, off=%lli, c=%zi)\n",
+		buf, off, count);
+
+	if (off >= DS1682_EEPROM_SIZE)
+		return -ENOSPC;
+
+	if (off + count > DS1682_EEPROM_SIZE)
+		count = DS1682_EEPROM_SIZE - off;
+
+	/* Write out to the device */
+	if (i2c_smbus_write_i2c_block_data(client, DS1682_REG_EEPROM + off,
+					   count, buf) < 0)
+		return -EIO;
+
+	return count;
+}
+
+static struct bin_attribute ds1682_eeprom_attr = {
+	.attr = {
+		.name = "eeprom",
+		.mode = S_IRUGO | S_IWUSR,
+	},
+	.size = DS1682_EEPROM_SIZE,
+	.read = ds1682_eeprom_read,
+	.write = ds1682_eeprom_write,
+};
+
+/*
+ * Called when a ds1682 device is matched with this driver
+ */
+static int ds1682_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	int rc;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_I2C_BLOCK)) {
+		dev_err(&client->dev, "i2c bus does not support the ds1682\n");
+		rc = -ENODEV;
+		goto exit;
+	}
+
+	rc = sysfs_create_group(&client->dev.kobj, &ds1682_group);
+	if (rc)
+		goto exit;
+
+	rc = sysfs_create_bin_file(&client->dev.kobj, &ds1682_eeprom_attr);
+	if (rc)
+		goto exit_bin_attr;
+
+	return 0;
+
+ exit_bin_attr:
+	sysfs_remove_group(&client->dev.kobj, &ds1682_group);
+ exit:
+	return rc;
+}
+
+static int ds1682_remove(struct i2c_client *client)
+{
+	sysfs_remove_bin_file(&client->dev.kobj, &ds1682_eeprom_attr);
+	sysfs_remove_group(&client->dev.kobj, &ds1682_group);
+	return 0;
+}
+
+static const struct i2c_device_id ds1682_id[] = {
+	{ "ds1682", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ds1682_id);
+
+static struct i2c_driver ds1682_driver = {
+	.driver = {
+		.name = "ds1682",
+	},
+	.probe = ds1682_probe,
+	.remove = ds1682_remove,
+	.id_table = ds1682_id,
+};
+
+static int __init ds1682_init(void)
+{
+	return i2c_add_driver(&ds1682_driver);
+}
+
+static void __exit ds1682_exit(void)
+{
+	i2c_del_driver(&ds1682_driver);
+}
+
+MODULE_AUTHOR("Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>");
+MODULE_DESCRIPTION("DS1682 Elapsed Time Indicator driver");
+MODULE_LICENSE("GPL");
+
+module_init(ds1682_init);
+module_exit(ds1682_exit);
-- 
1.6.3.3
