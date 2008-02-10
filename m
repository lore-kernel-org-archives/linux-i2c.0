From: Paul Hays <haysp-g2xSkUqgFfVeoWH0uzbU5w@public.gmane.org>
Subject: [PATCH 1/1] Add i2c chip driver for INA209 power monitor
Date: Sun, 10 Feb 2008 00:35:49 -0500
Message-ID: <1202621749.19303.17.camel@amd2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

For your consideration, this adds Linux support for the
Texas Instruments / Burr-Brown INA209 power monitoring chip
with i2c interface. (As far as I know, this isn't used like
a sensor on any mainboard; I use it in a solar power system.)

The driver works in kernel 2.6.20-voyage (http://linux.voyage.hk)
on a WRAP sbc from PC Engines (http://www.pcengines.ch).

Kernel 2.6.24 also built without incident after this patch.

Signed-off-by: Paul Hays <haysp-J4oS66wZXds@public.gmane.org>
--

diff -Naur -X b/Documentation/dontdiff a/Documentation/i2c/chips/ina209 b/Documentation/i2c/chips/ina209
--- a/Documentation/i2c/chips/ina209	1969-12-31 19:00:00.000000000 -0500
+++ b/Documentation/i2c/chips/ina209	2008-02-06 14:59:48.000000000 -0500
@@ -0,0 +1,70 @@
+Kernel driver ina209
+=====================
+
+Supported chips:
+  * Burr-Brown / Texas Instruments INA209
+    Prefix: 'ina209'
+    Addresses scanned: 0x40-0x4f
+    Datasheet:
+        http://www.ti.com/lit/gpn/ina209
+
+Author: Paul Hays <haysp-g2xSkUqgFfVeoWH0uzbU5w@public.gmane.org>
+
+
+Description
+-----------
+
+The Burr-Brown INA209 monitors voltage and current on the high side
+of a D.C. power supply. It can perform measurements and calculations
+in the background to supply readings at any time. It includes a
+programmable calibration multiplier to scale the displayed current
+and power values.
+
+
+Sysfs entries
+-------------
+
+The INA209 chip is highly configurable both via hardwiring and via
+the I2C bus. See the datasheet for details.
+
+The driver simply exposes the registers of an INA209 via sysfs as
+decimal integers. Some registers (marked "bits" here) contain various
+bit fields, and others use configurable scaling.  (I found it convenient
+to process all of the values in userspace with friendly Perl scripts.)
+
+configuration				bits
+status			read only,	bits
+status_mask				bits
+shunt_v			read only
+bus_v			read only
+power			read only
+bus_current		read only
+shunt_v_pos_peak
+shunt_v_neg_peak
+bus_v_max_peak
+bus_v_min_peak
+power_peak
+shunt_v_pos_warn
+shunt_v_neg_warn
+power_warn
+bus_over_v_warn
+bus_under_v_warn
+power_over_limit
+bus_over_v_over_limit
+bus_under_v_over_limit
+critical_dac_pos
+critical_dac_neg
+calibration
+
+
+General Remarks
+---------------
+
+The layouts of values in some registers surprised me; read
+that datasheet very closely.
+
+Application information in the datasheet shows 10 Ohm resistors
+in series with the sensing inputs to filter noise and for
+transient protection. Experience shows that they also degrade
+accuracy.
+
diff -Naur -X b/Documentation/dontdiff a/drivers/i2c/chips/ina209.c b/drivers/i2c/chips/ina209.c
--- a/drivers/i2c/chips/ina209.c	1969-12-31 19:00:00.000000000 -0500
+++ b/drivers/i2c/chips/ina209.c	2008-02-06 13:16:34.000000000 -0500
@@ -0,0 +1,334 @@
+/*
+ * ina209.c - chip driver for bi-directional power monitor
+ *
+ * Copyright (C) 2008 Paul Hays <haysp-J4oS66wZXds@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * The INA209 chip transfers 16-bit word data as two successive bytes
+ * on the i2c bus. Transfers go most-significant byte (msb) first,
+ * so writes involve cpu_to_be16() etc.
+ *
+ * This borrows from a similar driver written by Ben Gardner.
+ */
+
+#include <asm/byteorder.h>	/* cpu-to-be16() etc. */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/hwmon-sysfs.h>
+
+/* Addresses to probe. The chip can be hardwired to use any of these
+ * addresses using pins A0 and A1. (E.g. connecting both to the SDA pin
+ * selects address 0x4a).
+ */
+static unsigned short normal_i2c[] = {
+	0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47,
+	0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f,
+	I2C_CLIENT_END};
+
+/* Insmod parameters */
+I2C_CLIENT_INSMOD_1(ina209);
+
+/* Here are names of the chip's registers (a.k.a. commands) */
+enum ina209_cmd
+{
+	INA209_CONFIGURATION		= 0x00, /*		bits */
+	INA209_STATUS			= 0x01,	/* readonly	bits */
+	INA209_STATUS_MASK		= 0x02,	/*		bits */
+	INA209_SHUNT_V			= 0x03,	/* readonly */
+	INA209_BUS_V			= 0x04,	/* readonly */
+	INA209_POWER			= 0x05,	/* readonly */
+	INA209_BUS_CURRENT		= 0x06,	/* readonly */
+	INA209_SHUNT_V_POS_PEAK		= 0x07,
+	INA209_SHUNT_V_NEG_PEAK		= 0x08,
+	INA209_BUS_V_MAX_PEAK		= 0x09,
+	INA209_BUS_V_MIN_PEAK		= 0x0a,
+	INA209_POWER_PEAK		= 0x0b,
+	INA209_SHUNT_V_POS_WARN		= 0x0c,
+	INA209_SHUNT_V_NEG_WARN		= 0x0d,
+	INA209_POWER_WARN		= 0x0e,
+	INA209_BUS_OVER_V_WARN		= 0x0f,
+	INA209_BUS_UNDER_V_WARN		= 0x10,
+	INA209_POWER_OVER_LIMIT		= 0x11,
+	INA209_BUS_OVER_V_OVER_LIMIT	= 0x12,
+	INA209_BUS_UNDER_V_OVER_LIMIT	= 0x13,
+	INA209_CRITICAL_DAC_POS		= 0x14,
+	INA209_CRITICAL_DAC_NEG		= 0x15,
+	INA209_CALIBRATION		= 0x16,
+};
+
+static int ina209_attach_adapter(struct i2c_adapter *adapter);
+static int ina209_detect(struct i2c_adapter *adapter, int address, int kind);
+static int ina209_detach_client(struct i2c_client *client);
+
+/* This data structure describes the chip driver */
+static struct i2c_driver ina209_driver = {
+	.driver = {
+		.name	= "ina209",
+	},
+	.attach_adapter	= ina209_attach_adapter,
+	.detach_client	= ina209_detach_client,
+};
+
+struct ina209_data {
+	struct i2c_client client;
+};
+
+/* Functions to handle calls to the sysfs device files for the registers */
+
+/* Commands to show values always render the result as a decimal integer.
+ * That is sort of nasty in cases of bit-field registers like "status";
+ * one could add access functions for each bit-field.
+ * (Might be expensive... we'll just handle this with e.g. Perl in userspace.)
+ */
+static ssize_t ina209_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	s32 val;
+	struct sensor_device_attribute *psa = to_sensor_dev_attr(attr);
+	struct i2c_client *client = to_i2c_client(dev);
+
+	val = i2c_smbus_read_word_data(client, psa->index);
+	if (val < 0 ) {
+		dev_dbg(dev, "failed to read register 0x%2.2x\n", psa->index);
+		memset(buf, 0, PAGE_SIZE); /* user should not see old data */
+		return (0);
+	}
+	return ((ssize_t) snprintf(buf, PAGE_SIZE, "%hd\n",
+			(short int) be16_to_cpu((u16) val)));
+}
+
+/* Commands to store values accept integers as strings per
+ * function simple_strtol():
+ * strings beginning with 0x or 0X are base 16,
+ * strings beginning with 0 and any digit are base 8
+ * other strings beginning with '-' are negative, and
+ * others are positive
+ */
+static ssize_t ina209_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	u16 val;
+	struct sensor_device_attribute *psa = to_sensor_dev_attr(attr);
+	struct i2c_client *client = to_i2c_client(dev);
+
+	val = (u16) simple_strtol(buf, 0, 0);
+	if (i2c_smbus_write_word_data(client, psa->index, cpu_to_be16(val))
+			 < 0 ) {
+		dev_err(&client->dev, "failed to store \"%.10s\" "
+				"at register 0x%2.2x\n",
+				buf, psa->index);
+		return (0);
+	}
+	return ((ssize_t) count);
+}
+
+/* These macros are used below in constructing device attribute objects
+ * for use with sysfs_create_group() to make a sysfs device file
+ * for each register.
+ */
+
+#define INA209_ENTRY_RO(name, ina209_cmd_idx) \
+	static SENSOR_DEVICE_ATTR(name, S_IRUGO, \
+	ina209_show, 0, ina209_cmd_idx)
+
+#define INA209_ENTRY_RW(name, ina209_cmd_idx) \
+	static SENSOR_DEVICE_ATTR(name, S_IRUGO | S_IWUSR, \
+	ina209_show, ina209_store, ina209_cmd_idx)
+
+/* Construct a sensor_device_attribute structure for each register */
+INA209_ENTRY_RW(configuration,		INA209_CONFIGURATION);
+INA209_ENTRY_RO(status,			INA209_STATUS);
+INA209_ENTRY_RW(status_mask,		INA209_STATUS_MASK);
+INA209_ENTRY_RO(shunt_v,		INA209_SHUNT_V);
+INA209_ENTRY_RO(bus_v,			INA209_BUS_V);
+INA209_ENTRY_RO(power,			INA209_POWER);
+INA209_ENTRY_RO(bus_current,		INA209_BUS_CURRENT);
+INA209_ENTRY_RW(shunt_v_pos_peak,	INA209_SHUNT_V_POS_PEAK);
+INA209_ENTRY_RW(shunt_v_neg_peak,	INA209_SHUNT_V_NEG_PEAK);
+INA209_ENTRY_RW(bus_v_max_peak,		INA209_BUS_V_MAX_PEAK);
+INA209_ENTRY_RW(bus_v_min_peak,		INA209_BUS_V_MIN_PEAK);
+INA209_ENTRY_RW(power_peak,		INA209_POWER_PEAK);
+INA209_ENTRY_RW(shunt_v_pos_warn,	INA209_SHUNT_V_POS_WARN);
+INA209_ENTRY_RW(shunt_v_neg_warn,	INA209_SHUNT_V_NEG_WARN);
+INA209_ENTRY_RW(power_warn,		INA209_POWER_WARN);
+INA209_ENTRY_RW(bus_over_v_warn,	INA209_BUS_OVER_V_WARN);
+INA209_ENTRY_RW(bus_under_v_warn,	INA209_BUS_UNDER_V_WARN);
+INA209_ENTRY_RW(power_over_limit,	INA209_POWER_OVER_LIMIT);
+INA209_ENTRY_RW(bus_over_v_over_limit,	INA209_BUS_OVER_V_OVER_LIMIT);
+INA209_ENTRY_RW(bus_under_v_over_limit,	INA209_BUS_UNDER_V_OVER_LIMIT);
+INA209_ENTRY_RW(critical_dac_pos,	INA209_CRITICAL_DAC_POS);
+INA209_ENTRY_RW(critical_dac_neg,	INA209_CRITICAL_DAC_NEG);
+INA209_ENTRY_RW(calibration,		INA209_CALIBRATION);
+
+/* Finally, construct an array of pointers to members of the above objects,
+ * as required for sysfs_create_group()
+ */
+static struct attribute *ina209_attributes[] = {
+	&sensor_dev_attr_configuration.dev_attr.attr,
+	&sensor_dev_attr_status.dev_attr.attr,
+	&sensor_dev_attr_status_mask.dev_attr.attr,
+	&sensor_dev_attr_shunt_v.dev_attr.attr,
+	&sensor_dev_attr_bus_v.dev_attr.attr,
+	&sensor_dev_attr_power.dev_attr.attr,
+	&sensor_dev_attr_bus_current.dev_attr.attr,
+	&sensor_dev_attr_shunt_v_pos_peak.dev_attr.attr,
+	&sensor_dev_attr_shunt_v_neg_peak.dev_attr.attr,
+	&sensor_dev_attr_bus_v_max_peak.dev_attr.attr,
+	&sensor_dev_attr_bus_v_min_peak.dev_attr.attr,
+	&sensor_dev_attr_power_peak.dev_attr.attr,
+	&sensor_dev_attr_shunt_v_pos_warn.dev_attr.attr,
+	&sensor_dev_attr_shunt_v_neg_warn.dev_attr.attr,
+	&sensor_dev_attr_power_warn.dev_attr.attr,
+	&sensor_dev_attr_bus_over_v_warn.dev_attr.attr,
+	&sensor_dev_attr_bus_under_v_warn.dev_attr.attr,
+	&sensor_dev_attr_power_over_limit.dev_attr.attr,
+	&sensor_dev_attr_bus_over_v_over_limit.dev_attr.attr,
+	&sensor_dev_attr_bus_under_v_over_limit.dev_attr.attr,
+	&sensor_dev_attr_critical_dac_pos.dev_attr.attr,
+	&sensor_dev_attr_critical_dac_neg.dev_attr.attr,
+	&sensor_dev_attr_calibration.dev_attr.attr,
+	0
+};
+
+static struct attribute_group ina209_defattr_group = {
+	.attrs = ina209_attributes,
+};
+
+static int ina209_attach_adapter(struct i2c_adapter *adapter)
+{
+	return i2c_probe(adapter, &addr_data, ina209_detect);
+}
+
+/* This function is called by i2c_probe when some chip responds to an
+ * as-yet-unused slave address listed in normal_i2c or
+ * when a 'force' parameter is used e.g. with modprobe.
+ * Param kind has -1 for probed detection, >=0 for forced detection.
+ */
+static int ina209_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	struct ina209_data *data;
+	struct i2c_client *new_client;
+	int err = 0;
+	char *step ;		/* debug info */
+
+	/* Verify that the adapter can read and write 16-bit words */
+	step = "i2c_check_functionality";
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA))
+		goto exit;
+
+	/* OK. For now, we presume we have a valid client. We now create the
+	 * client structure, even though we cannot fill it completely yet.
+	 */
+	if (0 == (data = kzalloc(sizeof *data, GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	new_client = &data->client;
+	i2c_set_clientdata(new_client, data);
+	new_client->addr = address;
+	new_client->adapter = adapter;
+	new_client->driver = &ina209_driver;
+	new_client->flags = 0;
+
+	if (kind < 0) {		/* probed detection - check the chip type */
+		s32 v;		/* 16 bits from the chip, or -1 for error */
+
+		/* Chip registers 0x00-0x16 are documented. The vendor's
+		 * program INA209EVM.exe hints that register 0x17 is "unused"
+		 * and that 0x18-0x1b provide internal status data.
+		 * i2cdump shows that 0x17 returns 0 and that the chip
+		 * ignores register address bits 0x20 and higher (e.g.
+		 * registers 0x00, 0x20, 0x40 etc through 0xe0 give
+		 * identical values).
+		 */
+		step = "probe1";	/* read "unused" register, expect 0 */
+		if (i2c_smbus_read_word_data(new_client, 0x17) != 0)
+			goto exit_kfree;
+
+		step = "probe2";	/* expect 0 bits in configuration */
+		v = i2c_smbus_read_word_data(new_client, INA209_CONFIGURATION);
+		if (v < 0 || 0 != (be16_to_cpu((u16)v) & 0xc000))
+			goto exit_kfree;
+
+		step = "probe3";	/* chip must ignore address bit 0x20 */
+		if (i2c_smbus_read_word_data(new_client,
+				0x20 | INA209_CONFIGURATION) != v)
+			goto exit_kfree;
+
+		step = "probe4";	/* expect 0 bits in status */
+		v = i2c_smbus_read_word_data(new_client, INA209_STATUS);
+		if ( v < 0 || 0 != (be16_to_cpu((u16)v) & 0x0007))
+			goto exit_kfree;
+	}
+
+	strlcpy(new_client->name, "ina209", I2C_NAME_SIZE);
+
+	/* Tell the I2C layer a new client has arrived */
+	step = "i2c_attach_client";
+	if (0 != (err = i2c_attach_client(new_client)))
+		goto exit_kfree;
+
+	/* Register sysfs hooks */
+	step = "sysfs_create_group";
+	err = sysfs_create_group(&new_client->dev.kobj, &ina209_defattr_group);
+	if (0 != err)
+		goto exit_detach;
+
+	step = "success";
+	goto exit;
+
+exit_detach:
+	i2c_detach_client(new_client);
+exit_kfree:
+	kfree(data);
+exit:
+	printk(KERN_INFO "ina209: i2c bus %u detect addr 0x%02x, (%s),"
+			" returning %d: %s\n",
+			adapter->id, address, kind<0 ? "probed":"forced",
+			err, step);
+	return err;
+}
+
+static int ina209_detach_client(struct i2c_client *client)
+{
+	int err;
+
+	sysfs_remove_group(&client->dev.kobj, &ina209_defattr_group);
+
+	/* If we succeed in detaching client, free its space */
+	if (0 == (err = i2c_detach_client(client)))
+		kfree(i2c_get_clientdata(client));
+
+	printk(KERN_INFO "ina209: detach returning %d\n", err);
+	return err;
+}
+
+static int __init ina209_init(void)
+{
+	int ret = i2c_add_driver(&ina209_driver);
+	if (0 == ret)
+		printk(KERN_INFO "ina209: chip driver loaded\n");
+	else
+		printk(KERN_INFO "ina209: i2c_add_driver failure %d\n", ret);
+	return (ret);
+}
+
+static void __exit ina209_exit(void)
+{
+	i2c_del_driver(&ina209_driver);
+	printk(KERN_INFO "ina209: chip driver unloaded\n");
+}
+
+MODULE_AUTHOR("Paul Hays <haysp-J4oS66wZXds@public.gmane.org>");
+MODULE_DESCRIPTION("INA209 driver");
+MODULE_LICENSE("GPL");
+
+module_init(ina209_init);
+module_exit(ina209_exit);
+
diff -Naur -X b/Documentation/dontdiff a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig	2007-04-12 13:15:56.000000000 -0400
+++ b/drivers/i2c/chips/Kconfig	2008-02-06 14:18:09.000000000 -0500
@@ -125,4 +125,15 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called max6875.
 
+config SENSORS_INA209
+	tristate "Burr-Brown / Texas Instruments INA509 (EXPERIMENTAL)"
+	depends on I2C && EXPERIMENTAL
+	help
+	  If you say yes here you get support for the Burr-Brown / TI INA509
+	  chip for monitoring voltage, current, and power. Enter N unless
+          you are sure your system uses this chip (very few do use it).
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called ina209.
+
 endmenu
diff -Naur -X b/Documentation/dontdiff a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
--- a/drivers/i2c/chips/Makefile	2007-04-12 13:15:56.000000000 -0400
+++ b/drivers/i2c/chips/Makefile	2008-01-09 19:08:48.000000000 -0500
@@ -10,6 +10,7 @@
 obj-$(CONFIG_SENSORS_PCA9539)	+= pca9539.o
 obj-$(CONFIG_SENSORS_PCF8574)	+= pcf8574.o
 obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
+obj-$(CONFIG_SENSORS_INA209)	+= ina209.o
 obj-$(CONFIG_ISP1301_OMAP)	+= isp1301_omap.o
 obj-$(CONFIG_TPS65010)		+= tps65010.o
 



_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
