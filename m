From: eajames.ibm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH linux 4/6] hwmon: occ: Add callbacks for parsing P8 OCC datastructures
Date: Fri, 30 Dec 2016 11:56:06 -0600
Message-ID: <1483120568-21082-5-git-send-email-eajames.ibm@gmail.com>
References: <1483120568-21082-1-git-send-email-eajames.ibm@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1483120568-21082-1-git-send-email-eajames.ibm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org
Cc: jdelvare-IBi9RG/b67k@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, andrew-zrmu5oMJ5Fs@public.gmane.org, joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Edward A. James" <eajames-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: "Edward A. James" <eajames-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

Add functions to parse the data structures that are specific to the OCC on
the POWER8 processor. These are the sensor data structures, including
temperature, frequency, power, and "caps."

Signed-off-by: Edward A. James <eajames-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Andrew Jeffery <andrew-zrmu5oMJ5Fs@public.gmane.org>
Reviewed-by: Andrew Jeffery <andrew-zrmu5oMJ5Fs@public.gmane.org>
---
 Documentation/hwmon/occ    |   9 ++
 drivers/hwmon/occ/occ_p8.c | 217 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/occ/occ_p8.h |  30 +++++++
 3 files changed, 256 insertions(+)
 create mode 100644 drivers/hwmon/occ/occ_p8.c
 create mode 100644 drivers/hwmon/occ/occ_p8.h

diff --git a/Documentation/hwmon/occ b/Documentation/hwmon/occ
index 1ee8689..a6b3dd6 100644
--- a/Documentation/hwmon/occ
+++ b/Documentation/hwmon/occ
@@ -25,6 +25,15 @@ Currently, all versions of the OCC support four types of sensor data: power,
 temperature, frequency, and "caps," which indicate limits and thresholds used
 internally on the OCC.
 
+The format for the POWER8 OCC sensor data can be found in the P8 OCC
+specification:
+github.com/open-power/docs/blob/master/occ/OCC_OpenPwr_FW_Interfaces.pdf
+This document provides the details of the OCC sensors: power, frequency,
+temperature, and caps. These sensor formats are specific to the POWER8 OCC. A
+number of data structures, such as command format, response headers, and the
+like, are also defined in this specification, and are common to both POWER8 and
+POWER9 OCCs.
+
 sysfs Entries
 -------------
 
diff --git a/drivers/hwmon/occ/occ_p8.c b/drivers/hwmon/occ/occ_p8.c
new file mode 100644
index 0000000..812df16
--- /dev/null
+++ b/drivers/hwmon/occ/occ_p8.c
@@ -0,0 +1,217 @@
+/*
+ * occ_p8.c - OCC hwmon driver
+ *
+ * This file contains the Power8-specific methods and data structures for
+ * the OCC hwmon driver.
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
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <asm/unaligned.h>
+
+#include "occ.h"
+#include "occ_p8.h"
+
+/* P8 OCC sensor data format */
+struct p8_occ_sensor {
+	u16 sensor_id;
+	u16 value;
+};
+
+struct p8_power_sensor {
+	u16 sensor_id;
+	u32 update_tag;
+	u32 accumulator;
+	u16 value;
+};
+
+struct p8_caps_sensor {
+	u16 curr_powercap;
+	u16 curr_powerreading;
+	u16 norm_powercap;
+	u16 max_powercap;
+	u16 min_powercap;
+	u16 user_powerlimit;
+};
+
+void p8_parse_sensor(u8 *data, void *sensor, int sensor_type, int off,
+		     int snum)
+{
+	switch (sensor_type) {
+	case FREQ:
+	case TEMP:
+	{
+		struct p8_occ_sensor *os =
+			&(((struct p8_occ_sensor *)sensor)[snum]);
+
+		os->sensor_id = be16_to_cpu(get_unaligned((u16 *)&data[off]));
+		os->value = be16_to_cpu(get_unaligned((u16 *)&data[off + 2]));
+	}
+		break;
+	case POWER:
+	{
+		struct p8_power_sensor *ps =
+			&(((struct p8_power_sensor *)sensor)[snum]);
+
+		ps->sensor_id = be16_to_cpu(get_unaligned((u16 *)&data[off]));
+		ps->update_tag =
+			be32_to_cpu(get_unaligned((u32 *)&data[off + 2]));
+		ps->accumulator =
+			be32_to_cpu(get_unaligned((u32 *)&data[off + 6]));
+		ps->value = be16_to_cpu(get_unaligned((u16 *)&data[off + 10]));
+	}
+		break;
+	case CAPS:
+	{
+		struct p8_caps_sensor *cs =
+			&(((struct p8_caps_sensor *)sensor)[snum]);
+
+		cs->curr_powercap =
+			be16_to_cpu(get_unaligned((u16 *)&data[off]));
+		cs->curr_powerreading =
+			be16_to_cpu(get_unaligned((u16 *)&data[off + 2]));
+		cs->norm_powercap =
+			be16_to_cpu(get_unaligned((u16 *)&data[off + 4]));
+		cs->max_powercap =
+			be16_to_cpu(get_unaligned((u16 *)&data[off + 6]));
+		cs->min_powercap =
+			be16_to_cpu(get_unaligned((u16 *)&data[off + 8]));
+		cs->user_powerlimit =
+			be16_to_cpu(get_unaligned((u16 *)&data[off + 10]));
+	}
+		break;
+	};
+}
+
+void *p8_alloc_sensor(int sensor_type, int num_sensors)
+{
+	switch (sensor_type) {
+	case FREQ:
+	case TEMP:
+		return kcalloc(num_sensors, sizeof(struct p8_occ_sensor),
+			       GFP_KERNEL);
+	case POWER:
+		return kcalloc(num_sensors, sizeof(struct p8_power_sensor),
+			       GFP_KERNEL);
+	case CAPS:
+		return kcalloc(num_sensors, sizeof(struct p8_caps_sensor),
+			       GFP_KERNEL);
+	default:
+		return NULL;
+	}
+}
+
+int p8_get_sensor_value(struct occ *driver, int sensor_type, int snum)
+{
+	void *sensor;
+
+	if (sensor_type == CAPS)
+		return -EINVAL;
+
+	sensor = occ_get_sensor(driver, sensor_type);
+	if (!sensor)
+		return -ENODEV;
+
+	switch (sensor_type) {
+	case FREQ:
+	case TEMP:
+		return ((struct p8_occ_sensor *)sensor)[snum].value;
+	case POWER:
+		return ((struct p8_power_sensor *)sensor)[snum].value;
+	default:
+		return -EINVAL;
+	}
+}
+
+int p8_get_sensor_id(struct occ *driver, int sensor_type, int snum)
+{
+	void *sensor;
+	int i = snum;
+
+	if (sensor_type == CAPS)
+		return -EINVAL;
+
+	sensor = occ_get_sensor(driver, sensor_type);
+	if (!sensor)
+		return -ENODEV;
+
+	switch (sensor_type) {
+	case FREQ:
+	case TEMP:
+		return ((struct p8_occ_sensor *)sensor)[i].sensor_id;
+	case POWER:
+		return ((struct p8_power_sensor *)sensor)[i].sensor_id;
+	default:
+		return -EINVAL;
+	}
+}
+
+int p8_get_caps_value(void *sensor, int snum, int caps_field)
+{
+	struct p8_caps_sensor *caps_sensor = sensor;
+
+	switch (caps_field) {
+	case 0:
+		return caps_sensor[snum].curr_powercap;
+	case 1:
+		return caps_sensor[snum].curr_powerreading;
+	case 2:
+		return caps_sensor[snum].norm_powercap;
+	case 3:
+		return caps_sensor[snum].max_powercap;
+	case 4:
+		return caps_sensor[snum].min_powercap;
+	case 5:
+		return caps_sensor[snum].user_powerlimit;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct occ_ops p8_ops = {
+	.parse_sensor = p8_parse_sensor,
+	.alloc_sensor = p8_alloc_sensor,
+	.get_sensor_value = p8_get_sensor_value,
+	.get_sensor_id = p8_get_sensor_id,
+	.get_caps_value = p8_get_caps_value,
+};
+
+static const struct occ_config p8_config = {
+	.command_addr = 0xFFFF6000,
+	.response_addr = 0xFFFF7000,
+};
+
+struct occ *p8_occ_start(struct device *dev, void *bus,
+			 struct occ_bus_ops *bus_ops)
+{
+	return occ_start(dev, bus, bus_ops, &p8_ops, &p8_config);
+}
+EXPORT_SYMBOL(p8_occ_start);
+
+int p8_occ_stop(struct occ *occ)
+{
+	return occ_stop(occ);
+}
+EXPORT_SYMBOL(p8_occ_stop);
+
+MODULE_AUTHOR("Eddie James <eajames-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>");
+MODULE_DESCRIPTION("P8 OCC sensors");
+MODULE_LICENSE("GPL");
diff --git a/drivers/hwmon/occ/occ_p8.h b/drivers/hwmon/occ/occ_p8.h
new file mode 100644
index 0000000..b44cdd4
--- /dev/null
+++ b/drivers/hwmon/occ/occ_p8.h
@@ -0,0 +1,30 @@
+/*
+ * occ_p8.h - OCC hwmon driver
+ *
+ * This file contains Power8-specific function prototypes
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
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __OCC_P8_H__
+#define __OCC_P8_H__
+
+#include "scom.h"
+
+struct device;
+
+struct occ *p8_occ_start(struct device *dev, void *bus,
+			 struct occ_bus_ops *bus_ops);
+int p8_occ_stop(struct occ *occ);
+
+#endif /* __OCC_P8_H__ */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
