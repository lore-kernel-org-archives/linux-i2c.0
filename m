From: eajames.ibm@gmail.com
Subject: [PATCH linux 2/6] hwmon: occ: Add sysfs interface
Date: Fri, 30 Dec 2016 11:56:04 -0600
Message-ID: <1483120568-21082-3-git-send-email-eajames.ibm@gmail.com>
References: <1483120568-21082-1-git-send-email-eajames.ibm@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1483120568-21082-1-git-send-email-eajames.ibm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@roeck-us.net
Cc: jdelvare@suse.com, corbet@lwn.net, mark.rutland@arm.com, robh+dt@kernel.org, wsa@the-dreams.de, andrew@aj.id.au, joel@jms.id.au, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, "Edward A. James" <eajames@us.ibm.com>
List-Id: linux-i2c@vger.kernel.org

From: "Edward A. James" <eajames@us.ibm.com>

Add a generic mechanism to expose the sensors provided by the OCC in
sysfs.

Signed-off-by: Edward A. James <eajames@us.ibm.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
 Documentation/hwmon/occ       |  48 +++++
 drivers/hwmon/occ/Makefile    |   2 +-
 drivers/hwmon/occ/occ_sysfs.c | 492 ++++++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/occ/occ_sysfs.h |  52 +++++
 4 files changed, 593 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hwmon/occ/occ_sysfs.c
 create mode 100644 drivers/hwmon/occ/occ_sysfs.h

diff --git a/Documentation/hwmon/occ b/Documentation/hwmon/occ
index 79d1642..1ee8689 100644
--- a/Documentation/hwmon/occ
+++ b/Documentation/hwmon/occ
@@ -25,6 +25,54 @@ Currently, all versions of the OCC support four types of sensor data: power,
 temperature, frequency, and "caps," which indicate limits and thresholds used
 internally on the OCC.
 
+sysfs Entries
+-------------
+
+The OCC driver uses the hwmon sysfs framework to provide data to userspace.
+
+The driver exports two sysfs files for each frequency, temperature, and power
+sensor. These are "input" and "label". The input file contains the value of the
+sensor. The label file contains the sensor id. The sensor id is the unique
+internal OCC identifier. Sensor ids may be provided by the OCC specification.
+The names of these files will be in the following format:
+	<sensor type><sensor index>_input
+	<sensor type><sensor index>_label
+Sensor types will be one of "temp", "freq", or "power". The sensor index is
+an index to differentiate different sensor files. For example, a single
+temperature sensor will have two sysfs files: temp1_input and temp1_label.
+
+Caps sensors are exported differently. For each caps sensor, the driver will
+export 6 entries:
+	curr_powercap - current power cap in watts
+	curr_powerreading - current power output in watts
+	norm_powercap - power cap without redundant power
+	max_powercap - maximum power cap that can be set in watts
+	min_powercap - minimum power cap that can be set in watts
+	user_powerlimit - power limit specified by the user in watts
+In addition, the OCC driver for P9 will export a 7th entry:
+	user_powerlimit_source - can be one of two values depending on who set
+		the user_powerlimit. 0x1 - out of band from BMC or host. 0x2 -
+		in band from other source.
+The format for these files is caps<sensor index>_<entry type>. For example,
+caps1_curr_powercap.
+
+The driver also provides a number of sysfs entries through hwmon to better
+control the driver and monitor the OCC.
+	powercap - read or write the OCC user power limit in watts.
+	name - read the name of the driver
+	update_interval - read or write the minimum interval for polling the
+		OCC.
+
+The driver also exports a single sysfs file through the communication protocol
+device (see BMC - Host Communications). The filename is "online" and represents
+the status of the OCC with respect to the driver. The OCC can be in one of two
+states: OCC polling enabled or OCC polling disabled. The purpose of this file
+is to control the behavior of the driver and it's hwmon sysfs entries, not to
+infer any information about the state of the physical OCC. Reading the file
+returns either a 0 (polling disabled) or 1 (polling enabled). Writing 1 to the
+file enables OCC polling in the driver if communications can be established
+with the OCC. Writing a 0 to the driver disables OCC polling.
+
 BMC - Host Communications
 -------------------------
 
diff --git a/drivers/hwmon/occ/Makefile b/drivers/hwmon/occ/Makefile
index 93cb52f..a6881f9 100644
--- a/drivers/hwmon/occ/Makefile
+++ b/drivers/hwmon/occ/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_SENSORS_PPC_OCC) += occ.o
+obj-$(CONFIG_SENSORS_PPC_OCC) += occ.o occ_sysfs.o
diff --git a/drivers/hwmon/occ/occ_sysfs.c b/drivers/hwmon/occ/occ_sysfs.c
new file mode 100644
index 0000000..b0e063da
--- /dev/null
+++ b/drivers/hwmon/occ/occ_sysfs.c
@@ -0,0 +1,492 @@
+/*
+ * occ_sysfs.c - OCC sysfs interface
+ *
+ * This file contains the methods and data structures for implementing the OCC
+ * hwmon sysfs entries.
+ *
+ * Copyright 2016 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+
+#include "occ_sysfs.h"
+
+#define MAX_SENSOR_ATTR_LEN	32
+
+#define RESP_RETURN_CMD_INVAL	0x13
+
+struct sensor_attr_data {
+	enum sensor_type type;
+	u32 hwmon_index;
+	u32 attr_id;
+	char name[MAX_SENSOR_ATTR_LEN];
+	struct device_attribute dev_attr;
+};
+
+static ssize_t show_input(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	int val;
+	struct sensor_attr_data *sdata = container_of(attr,
+						      struct sensor_attr_data,
+						      dev_attr);
+	struct occ_sysfs *driver = dev_get_drvdata(dev);
+
+	val = occ_get_sensor_value(driver->occ, sdata->type,
+				   sdata->hwmon_index - 1);
+	if (sdata->type == TEMP)
+		val *= 1000;	/* in millidegree Celsius */
+
+	return snprintf(buf, PAGE_SIZE - 1, "%d\n", val);
+}
+
+/* show_label provides the OCC sensor id. The sensor id will be either a
+ * 2-byte (for P8) or 4-byte (for P9) value. The sensor id is a way to
+ * identify what each sensor represents, according to the OCC specification.
+ */
+static ssize_t show_label(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	int val;
+	struct sensor_attr_data *sdata = container_of(attr,
+						      struct sensor_attr_data,
+						      dev_attr);
+	struct occ_sysfs *driver = dev_get_drvdata(dev);
+
+	val = occ_get_sensor_id(driver->occ, sdata->type,
+				sdata->hwmon_index - 1);
+
+	return snprintf(buf, PAGE_SIZE - 1, "%d\n", val);
+}
+
+static ssize_t show_caps(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	int val;
+	struct caps_sensor *sensor;
+	struct sensor_attr_data *sdata = container_of(attr,
+						      struct sensor_attr_data,
+						      dev_attr);
+	struct occ_sysfs *driver = dev_get_drvdata(dev);
+
+	sensor = occ_get_sensor(driver->occ, CAPS);
+	if (!sensor) {
+		val = -1;
+		return snprintf(buf, PAGE_SIZE - 1, "%d\n", val);
+	}
+
+	val = occ_get_caps_value(driver->occ, sensor, sdata->hwmon_index - 1,
+				 sdata->attr_id);
+
+	return snprintf(buf, PAGE_SIZE - 1, "%d\n", val);
+}
+
+static ssize_t show_update_interval(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct occ_sysfs *driver = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE - 1, "%lu\n", driver->update_interval);
+}
+
+static ssize_t store_update_interval(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct occ_sysfs *driver = dev_get_drvdata(dev);
+	unsigned long val;
+	int rc;
+
+	rc = kstrtoul(buf, 10, &val);
+	if (rc)
+		return rc;
+
+	driver->update_interval = val;
+	occ_set_update_interval(driver->occ, val);
+
+	return count;
+}
+
+static DEVICE_ATTR(update_interval, S_IWUSR | S_IRUGO, show_update_interval,
+		   store_update_interval);
+
+static ssize_t show_name(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE - 1, "occ\n");
+}
+
+static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+
+static ssize_t show_user_powercap(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct occ_sysfs *driver = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE - 1, "%u\n", driver->user_powercap);
+}
+
+static ssize_t store_user_powercap(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct occ_sysfs *driver = dev_get_drvdata(dev);
+	u16 val;
+	int rc;
+
+	rc = kstrtou16(buf, 10, &val);
+	if (rc)
+		return rc;
+
+	dev_dbg(dev, "set user powercap to: %d\n", val);
+	rc = occ_set_user_powercap(driver->occ, val);
+	if (rc) {
+		dev_err(dev, "set user powercap failed: 0x%x\n", rc);
+		if (rc == RESP_RETURN_CMD_INVAL) {
+			dev_err(dev, "set invalid powercap value: %d\n", val);
+			return -EINVAL;
+		}
+
+		return rc;
+	}
+
+	driver->user_powercap = val;
+
+	return count;
+}
+
+static DEVICE_ATTR(user_powercap, S_IWUSR | S_IRUGO, show_user_powercap,
+		   store_user_powercap);
+
+static void deinit_sensor_groups(struct device *dev,
+				 struct sensor_group *sensor_groups)
+{
+	int i;
+
+	for (i = 0; i < MAX_OCC_SENSOR_TYPE; i++) {
+		if (sensor_groups[i].group.attrs)
+			devm_kfree(dev, sensor_groups[i].group.attrs);
+		if (sensor_groups[i].sattr)
+			devm_kfree(dev, sensor_groups[i].sattr);
+		sensor_groups[i].group.attrs = NULL;
+		sensor_groups[i].sattr = NULL;
+	}
+}
+
+static void sensor_attr_init(struct sensor_attr_data *sdata,
+			     char *sensor_group_name,
+			     char *attr_name,
+			     ssize_t (*show)(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf))
+{
+	sysfs_attr_init(&sdata->dev_attr.attr);
+
+	snprintf(sdata->name, MAX_SENSOR_ATTR_LEN, "%s%d_%s",
+		 sensor_group_name, sdata->hwmon_index, attr_name);
+	sdata->dev_attr.attr.name = sdata->name;
+	sdata->dev_attr.attr.mode = S_IRUGO;
+	sdata->dev_attr.show = show;
+}
+
+static int create_sensor_group(struct occ_sysfs *driver,
+			       enum sensor_type type, int sensor_num)
+{
+	struct device *dev = driver->dev;
+	struct sensor_group *sensor_groups = driver->sensor_groups;
+	struct sensor_attr_data *sdata;
+	int rc, i;
+
+	/* each sensor has 'label' and 'input' attributes */
+	sensor_groups[type].group.attrs =
+		devm_kzalloc(dev, sizeof(struct attribute *) *
+			     sensor_num * 2 + 1, GFP_KERNEL);
+	if (!sensor_groups[type].group.attrs) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	sensor_groups[type].sattr =
+		devm_kzalloc(dev, sizeof(struct sensor_attr_data) *
+			     sensor_num * 2, GFP_KERNEL);
+	if (!sensor_groups[type].sattr) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	for (i = 0; i < sensor_num; i++) {
+		sdata = &sensor_groups[type].sattr[i];
+		/* hwmon attributes index starts from 1 */
+		sdata->hwmon_index = i + 1;
+		sdata->type = type;
+		sensor_attr_init(sdata, sensor_groups[type].name, "input",
+				 show_input);
+		sensor_groups[type].group.attrs[i] = &sdata->dev_attr.attr;
+
+		sdata = &sensor_groups[type].sattr[i + sensor_num];
+		sdata->hwmon_index = i + 1;
+		sdata->type = type;
+		sensor_attr_init(sdata, sensor_groups[type].name, "label",
+				 show_label);
+		sensor_groups[type].group.attrs[i + sensor_num] =
+			&sdata->dev_attr.attr;
+	}
+
+	rc = sysfs_create_group(&dev->kobj, &sensor_groups[type].group);
+	if (rc)
+		goto err;
+
+	return 0;
+err:
+	deinit_sensor_groups(dev, sensor_groups);
+	return rc;
+}
+
+static void caps_sensor_attr_init(struct sensor_attr_data *sdata,
+				  char *attr_name, uint32_t hwmon_index,
+				  uint32_t attr_id)
+{
+	sdata->type = CAPS;
+	sdata->hwmon_index = hwmon_index;
+	sdata->attr_id = attr_id;
+
+	snprintf(sdata->name, MAX_SENSOR_ATTR_LEN, "%s%d_%s",
+		 "caps", sdata->hwmon_index, attr_name);
+
+	sysfs_attr_init(&sdata->dev_attr.attr);
+	sdata->dev_attr.attr.name = sdata->name;
+	sdata->dev_attr.attr.mode = S_IRUGO;
+	sdata->dev_attr.show = show_caps;
+}
+
+static int create_caps_sensor_group(struct occ_sysfs *driver, int sensor_num)
+{
+	struct device *dev = driver->dev;
+	struct sensor_group *sensor_groups = driver->sensor_groups;
+	int field_num = driver->num_caps_fields;
+	struct sensor_attr_data *sdata;
+	int i, j, rc;
+
+	sensor_groups[CAPS].group.attrs =
+		devm_kzalloc(dev, sizeof(struct attribute *) * sensor_num *
+			     field_num + 1, GFP_KERNEL);
+	if (!sensor_groups[CAPS].group.attrs) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	sensor_groups[CAPS].sattr =
+		devm_kzalloc(dev, sizeof(struct sensor_attr_data) *
+			     sensor_num * field_num, GFP_KERNEL);
+	if (!sensor_groups[CAPS].sattr) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	for (j = 0; j < sensor_num; ++j) {
+		for (i = 0; i < field_num; ++i) {
+			sdata = &sensor_groups[CAPS].sattr[j * field_num + i];
+			caps_sensor_attr_init(sdata,
+					      driver->caps_names[i], j + 1, i);
+			sensor_groups[CAPS].group.attrs[j * field_num + i] =
+				&sdata->dev_attr.attr;
+		}
+	}
+
+	rc = sysfs_create_group(&dev->kobj, &sensor_groups[CAPS].group);
+	if (rc)
+		goto err;
+
+	return rc;
+err:
+	deinit_sensor_groups(dev, sensor_groups);
+	return rc;
+}
+
+static void occ_remove_hwmon_attrs(struct occ_sysfs *driver)
+{
+	struct device *dev = driver->dev;
+
+	device_remove_file(dev, &dev_attr_user_powercap);
+	device_remove_file(dev, &dev_attr_update_interval);
+	device_remove_file(dev, &dev_attr_name);
+}
+
+static int occ_create_hwmon_attrs(struct occ_sysfs *driver)
+{
+	int i, rc, id, sensor_num;
+	struct device *dev = driver->dev;
+	struct sensor_group *sensor_groups = driver->sensor_groups;
+	struct occ_blocks *resp = NULL;
+
+	occ_get_response_blocks(driver->occ, &resp);
+
+	for (i = 0; i < MAX_OCC_SENSOR_TYPE; ++i)
+		resp->sensor_block_id[i] = -1;
+
+	/* read sensor data from occ */
+	rc = occ_update_device(driver->occ);
+	if (rc) {
+		dev_err(dev, "cannot get occ sensor data: %d\n", rc);
+		return rc;
+	}
+	if (!resp->blocks)
+		return -ENOMEM;
+
+	rc = device_create_file(dev, &dev_attr_name);
+	if (rc)
+		goto error;
+
+	rc = device_create_file(dev, &dev_attr_update_interval);
+	if (rc)
+		goto error;
+
+	if (resp->sensor_block_id[CAPS] >= 0) {
+		/* user powercap: only for master OCC */
+		rc = device_create_file(dev, &dev_attr_user_powercap);
+		if (rc)
+			goto error;
+	}
+
+	sensor_groups[FREQ].name = "freq";
+	sensor_groups[TEMP].name = "temp";
+	sensor_groups[POWER].name = "power";
+	sensor_groups[CAPS].name = "caps";
+
+	for (i = 0; i < MAX_OCC_SENSOR_TYPE; i++) {
+		id = resp->sensor_block_id[i];
+		if (id < 0)
+			continue;
+
+		sensor_num = resp->blocks[id].header.sensor_num;
+		if (i == CAPS)
+			rc = create_caps_sensor_group(driver, sensor_num);
+		else
+			rc = create_sensor_group(driver, i, sensor_num);
+		if (rc)
+			goto error;
+	}
+
+	return 0;
+
+error:
+	dev_err(dev, "cannot create hwmon attributes: %d\n", rc);
+	occ_remove_hwmon_attrs(driver);
+	return rc;
+}
+
+static ssize_t show_occ_online(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct occ_sysfs *driver = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE - 1, "%u\n", driver->occ_online);
+}
+
+static ssize_t store_occ_online(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct occ_sysfs *driver = dev_get_drvdata(dev);
+	unsigned long val;
+	int rc;
+
+	rc = kstrtoul(buf, 10, &val);
+	if (rc)
+		return rc;
+
+	if (val == 1) {
+		if (driver->occ_online)
+			return count;
+
+		driver->dev = hwmon_device_register(dev);
+		if (IS_ERR(driver->dev))
+			return PTR_ERR(driver->dev);
+
+		dev_set_drvdata(driver->dev, driver);
+
+		rc = occ_create_hwmon_attrs(driver);
+		if (rc) {
+			hwmon_device_unregister(driver->dev);
+			driver->dev = NULL;
+			return rc;
+		}
+	} else if (val == 0) {
+		if (!driver->occ_online)
+			return count;
+
+		occ_remove_hwmon_attrs(driver);
+		hwmon_device_unregister(driver->dev);
+		driver->dev = NULL;
+	} else
+		return -EINVAL;
+
+	driver->occ_online = val;
+	return count;
+}
+
+static DEVICE_ATTR(online, S_IWUSR | S_IRUGO, show_occ_online,
+		   store_occ_online);
+
+struct occ_sysfs *occ_sysfs_start(struct device *dev, struct occ *occ,
+				  struct occ_sysfs_config *config)
+{
+	struct occ_sysfs *hwmon = devm_kzalloc(dev, sizeof(struct occ_sysfs),
+					       GFP_KERNEL);
+	int rc;
+
+	if (!hwmon)
+		return ERR_PTR(-ENOMEM);
+
+	hwmon->occ = occ;
+	hwmon->num_caps_fields = config->num_caps_fields;
+	hwmon->caps_names = config->caps_names;
+
+	dev_set_drvdata(dev, hwmon);
+
+	rc = device_create_file(dev, &dev_attr_online);
+	if (rc)
+		return ERR_PTR(rc);
+
+	return hwmon;
+}
+EXPORT_SYMBOL(occ_sysfs_start);
+
+int occ_sysfs_stop(struct device *dev, struct occ_sysfs *driver)
+{
+	if (driver->dev) {
+		occ_remove_hwmon_attrs(driver);
+		hwmon_device_unregister(driver->dev);
+	}
+
+	device_remove_file(driver->dev, &dev_attr_online);
+
+	devm_kfree(dev, driver);
+
+	return 0;
+}
+EXPORT_SYMBOL(occ_sysfs_stop);
+
+MODULE_AUTHOR("Eddie James <eajames@us.ibm.com>");
+MODULE_DESCRIPTION("OCC sysfs driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/hwmon/occ/occ_sysfs.h b/drivers/hwmon/occ/occ_sysfs.h
new file mode 100644
index 0000000..2a8044f
--- /dev/null
+++ b/drivers/hwmon/occ/occ_sysfs.h
@@ -0,0 +1,52 @@
+/*
+ * occ_sysfs.h - OCC sysfs interface
+ *
+ * This file contains the data structures and function prototypes for the OCC
+ * hwmon sysfs entries.
+ *
+ * Copyright 2016 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __OCC_SYSFS_H__
+#define __OCC_SYSFS_H__
+
+#include "occ.h"
+
+struct sensor_group {
+	char *name;
+	struct sensor_attr_data *sattr;
+	struct attribute_group group;
+};
+
+struct occ_sysfs_config {
+	unsigned int num_caps_fields;
+	char **caps_names;
+};
+
+struct occ_sysfs {
+	struct device *dev;
+	struct occ *occ;
+
+	u16 user_powercap;
+	bool occ_online;
+	struct sensor_group sensor_groups[MAX_OCC_SENSOR_TYPE];
+	unsigned long update_interval;
+	unsigned int num_caps_fields;
+	char **caps_names;
+};
+
+struct occ_sysfs *occ_sysfs_start(struct device *dev, struct occ *occ,
+				  struct occ_sysfs_config *config);
+int occ_sysfs_stop(struct device *dev, struct occ_sysfs *driver);
+
+#endif /* __OCC_SYSFS_H__ */
-- 
1.9.1
