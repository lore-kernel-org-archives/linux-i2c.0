From: eajames.ibm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH linux v2 1/6] hwmon: Add core On-Chip Controller support for POWER CPUs
Date: Wed, 11 Jan 2017 12:10:32 -0600
Message-ID: <1484158237-10014-2-git-send-email-eajames.ibm@gmail.com>
References: <1484158237-10014-1-git-send-email-eajames.ibm@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1484158237-10014-1-git-send-email-eajames.ibm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jdelvare-IBi9RG/b67k@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, andrew-zrmu5oMJ5Fs@public.gmane.org, joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, "Edward A. James" <eajames-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: "Edward A. James" <eajames-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

Add core support for polling the OCC for it's sensor data and parsing that
data into sensor-specific information.

Signed-off-by: Edward A. James <eajames-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Andrew Jeffery <andrew-zrmu5oMJ5Fs@public.gmane.org>
---
 Documentation/hwmon/occ    |  40 ++++
 drivers/hwmon/Kconfig      |   2 +
 drivers/hwmon/Makefile     |   1 +
 drivers/hwmon/occ/Kconfig  |  15 ++
 drivers/hwmon/occ/Makefile |   1 +
 drivers/hwmon/occ/occ.c    | 533 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/occ/occ.h    |  83 +++++++
 drivers/hwmon/occ/scom.h   |  47 ++++
 8 files changed, 722 insertions(+)
 create mode 100644 Documentation/hwmon/occ
 create mode 100644 drivers/hwmon/occ/Kconfig
 create mode 100644 drivers/hwmon/occ/Makefile
 create mode 100644 drivers/hwmon/occ/occ.c
 create mode 100644 drivers/hwmon/occ/occ.h
 create mode 100644 drivers/hwmon/occ/scom.h

diff --git a/Documentation/hwmon/occ b/Documentation/hwmon/occ
new file mode 100644
index 0000000..79d1642
--- /dev/null
+++ b/Documentation/hwmon/occ
@@ -0,0 +1,40 @@
+Kernel driver occ
+=================
+
+Supported chips:
+ * ASPEED AST2400
+ * ASPEED AST2500
+
+Please note that the chip must be connected to a POWER8 or POWER9 processor
+(see the BMC - Host Communications section).
+
+Author: Eddie James <eajames-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
+
+Description
+-----------
+
+This driver implements support for the OCC (On-Chip Controller) on the IBM
+POWER8 and POWER9 processors, from a BMC (Baseboard Management Controller). The
+OCC is an embedded processor that provides real time power and thermal
+monitoring.
+
+This driver provides an interface on a BMC to poll OCC sensor data, set user
+power caps, and perform some basic OCC error handling.
+
+Currently, all versions of the OCC support four types of sensor data: power,
+temperature, frequency, and "caps," which indicate limits and thresholds used
+internally on the OCC.
+
+BMC - Host Communications
+-------------------------
+
+For the POWER8 application, the BMC can communicate with the P8 over I2C bus.
+However, to access the OCC register space, any data transfer must use a SCOM
+operation. SCOM is a procedure to initiate a data transfer, typically of 8
+bytes. SCOMs consist of writing a 32-bit command register and then
+reading/writing two 32-bit data registers. This driver implements these
+SCOM operations over I2C bus in order to communicate with the OCC.
+
+For the POWER9 application, the BMC can communicate with the P9 over FSI bus
+and SBE engine. Once again, SCOM operations are required. This driver will
+implement SCOM ops over FSI/SBE. This will require the FSI driver.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 190d270..e80ca81 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1240,6 +1240,8 @@ config SENSORS_NSA320
 	  This driver can also be built as a module. If so, the module
 	  will be called nsa320-hwmon.
 
+source drivers/hwmon/occ/Kconfig
+
 config SENSORS_PCF8591
 	tristate "Philips PCF8591 ADC/DAC"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index d2cb7e8..c7ec5d4 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -169,6 +169,7 @@ obj-$(CONFIG_SENSORS_WM831X)	+= wm831x-hwmon.o
 obj-$(CONFIG_SENSORS_WM8350)	+= wm8350-hwmon.o
 obj-$(CONFIG_SENSORS_XGENE)	+= xgene-hwmon.o
 
+obj-$(CONFIG_SENSORS_PPC_OCC)	+= occ/
 obj-$(CONFIG_PMBUS)		+= pmbus/
 
 ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
diff --git a/drivers/hwmon/occ/Kconfig b/drivers/hwmon/occ/Kconfig
new file mode 100644
index 0000000..cdb64a7
--- /dev/null
+++ b/drivers/hwmon/occ/Kconfig
@@ -0,0 +1,15 @@
+#
+# On Chip Controller configuration
+#
+
+menuconfig SENSORS_PPC_OCC
+	bool "PPC On-Chip Controller"
+	help
+	  If you say yes here you get support to monitor Power CPU
+	  sensors via the On-Chip Controller (OCC).
+
+	  Generally this is used by management controllers such as a BMC
+	  on an OpenPower system.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called occ.
diff --git a/drivers/hwmon/occ/Makefile b/drivers/hwmon/occ/Makefile
new file mode 100644
index 0000000..93cb52f
--- /dev/null
+++ b/drivers/hwmon/occ/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SENSORS_PPC_OCC) += occ.o
diff --git a/drivers/hwmon/occ/occ.c b/drivers/hwmon/occ/occ.c
new file mode 100644
index 0000000..31e6164
--- /dev/null
+++ b/drivers/hwmon/occ/occ.c
@@ -0,0 +1,533 @@
+/*
+ * occ.c - OCC hwmon driver
+ *
+ * This file contains the methods and data structures for the OCC hwmon driver.
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
+#include <linux/jiffies.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <asm/unaligned.h>
+
+#include "occ.h"
+
+#define OCC_DATA_MAX		4096
+#define OCC_BMC_TIMEOUT_MS	20000
+
+/* To generate attn to OCC */
+#define ATTN_DATA		0x0006B035
+
+/* For BMC to read/write SRAM */
+#define OCB_ADDRESS		0x0006B070
+#define OCB_DATA		0x0006B075
+#define OCB_STATUS_CONTROL_AND	0x0006B072
+#define OCB_STATUS_CONTROL_OR	0x0006B073
+
+/* To init OCB */
+#define OCB_AND_INIT0		0xFBFFFFFF
+#define OCB_AND_INIT1		0xFFFFFFFF
+#define OCB_OR_INIT0		0x08000000
+#define OCB_OR_INIT1		0x00000000
+
+/* To generate attention on OCC */
+#define ATTN0			0x01010000
+#define ATTN1			0x00000000
+
+/* OCC return status */
+#define RESP_RETURN_CMD_IN_PRG	0xFF
+#define RESP_RETURN_SUCCESS	0
+#define RESP_RETURN_CMD_INVAL	0x11
+#define RESP_RETURN_CMD_LEN	0x12
+#define RESP_RETURN_DATA_INVAL	0x13
+#define RESP_RETURN_CHKSUM	0x14
+#define RESP_RETURN_OCC_ERR	0x15
+#define RESP_RETURN_STATE	0x16
+
+/* time interval to retry on "command in progress" return status */
+#define CMD_IN_PRG_INT_MS	100
+#define CMD_IN_PRG_RETRIES	(OCC_BMC_TIMEOUT_MS / CMD_IN_PRG_INT_MS)
+
+/* OCC command definitions */
+#define OCC_POLL		0
+#define OCC_SET_USER_POWR_CAP	0x22
+
+/* OCC poll command data */
+#define OCC_POLL_STAT_SENSOR	0x10
+
+/* OCC response data offsets */
+#define RESP_RETURN_STATUS	2
+#define RESP_DATA_LENGTH	3
+#define RESP_HEADER_OFFSET	5
+#define SENSOR_STR_OFFSET	37
+#define SENSOR_BLOCK_NUM_OFFSET	43
+#define SENSOR_BLOCK_OFFSET	45
+
+/* occ_poll_header
+ * structure to match the raw occ poll response data
+ */
+struct occ_poll_header {
+	u8 status;
+	u8 ext_status;
+	u8 occs_present;
+	u8 config;
+	u8 occ_state;
+	u8 mode;
+	u8 ips_status;
+	u8 error_log_id;
+	u32 error_log_addr_start;
+	u16 error_log_length;
+	u8 reserved2;
+	u8 reserved3;
+	u8 occ_code_level[16];
+	u8 sensor_eye_catcher[6];
+	u8 sensor_block_num;
+	u8 sensor_data_version;
+} __attribute__((packed, aligned(4)));
+
+struct occ_response {
+	struct occ_poll_header header;
+	struct occ_blocks data;
+};
+
+struct occ {
+	struct device *dev;
+	void *bus;
+	struct occ_bus_ops bus_ops;
+	struct occ_ops ops;
+	struct occ_config config;
+	unsigned long update_interval;
+	unsigned long last_updated;
+	struct mutex update_lock;
+	struct occ_response response;
+	bool valid;
+};
+
+static void deinit_occ_resp_buf(struct occ_response *resp)
+{
+	int i;
+
+	if (!resp)
+		return;
+
+	if (!resp->data.blocks)
+		return;
+
+	for (i = 0; i < resp->header.sensor_block_num; ++i)
+		kfree(resp->data.blocks[i].sensors);
+
+	kfree(resp->data.blocks);
+
+	memset(resp, 0, sizeof(struct occ_response));
+
+	for (i = 0; i < MAX_OCC_SENSOR_TYPE; ++i)
+		resp->data.sensor_block_id[i] = -1;
+}
+
+static void *occ_get_sensor_by_type(struct occ_response *resp,
+				    enum sensor_type t)
+{
+	if (!resp->data.blocks)
+		return NULL;
+
+	if (resp->data.sensor_block_id[t] == -1)
+		return NULL;
+
+	return resp->data.blocks[resp->data.sensor_block_id[t]].sensors;
+}
+
+static int occ_check_sensor(struct occ *driver, u8 sensor_length,
+			    u8 sensor_num, enum sensor_type t, int block)
+{
+	void *sensor;
+	int type_block_id;
+	struct occ_response *resp = &driver->response;
+
+	sensor = occ_get_sensor_by_type(resp, t);
+
+	/* empty sensor block, release older sensor data */
+	if (sensor_num == 0 || sensor_length == 0) {
+		kfree(sensor);
+		dev_err(driver->dev, "no sensor blocks available\n");
+		return -ENODATA;
+	}
+
+	type_block_id = resp->data.sensor_block_id[t];
+	if (!sensor || sensor_num !=
+	    resp->data.blocks[type_block_id].header.sensor_num) {
+		kfree(sensor);
+		resp->data.blocks[block].sensors =
+			driver->ops.alloc_sensor(t, sensor_num);
+		if (!resp->data.blocks[block].sensors)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int parse_occ_response(struct occ *driver, u8 *data,
+			      struct occ_response *resp)
+{
+	int b;
+	int s;
+	int rc;
+	int offset = SENSOR_BLOCK_OFFSET;
+	int sensor_type;
+	u8 sensor_block_num;
+	char sensor_type_string[5] = { 0 };
+	struct sensor_data_block_header *block;
+	struct device *dev = driver->dev;
+
+	/* check if the data is valid */
+	if (strncmp(&data[SENSOR_STR_OFFSET], "SENSOR", 6) != 0) {
+		dev_err(dev, "no SENSOR string in response\n");
+		rc = -ENODATA;
+		goto err;
+	}
+
+	sensor_block_num = data[SENSOR_BLOCK_NUM_OFFSET];
+	if (sensor_block_num == 0) {
+		dev_err(dev, "no sensor blocks available\n");
+		rc = -ENODATA;
+		goto err;
+	}
+
+	/* if number of sensor block has changed, re-malloc */
+	if (sensor_block_num != resp->header.sensor_block_num) {
+		deinit_occ_resp_buf(resp);
+		resp->data.blocks = kcalloc(sensor_block_num,
+					    sizeof(struct sensor_data_block),
+					    GFP_KERNEL);
+		if (!resp->data.blocks)
+			return -ENOMEM;
+	}
+
+	memcpy(&resp->header, &data[RESP_HEADER_OFFSET],
+	       sizeof(struct occ_poll_header));
+	resp->header.error_log_addr_start =
+		be32_to_cpu(resp->header.error_log_addr_start);
+	resp->header.error_log_length =
+		be16_to_cpu(resp->header.error_log_length);
+
+	dev_dbg(dev, "Reading %d sensor blocks\n",
+		resp->header.sensor_block_num);
+	for (b = 0; b < sensor_block_num; b++) {
+		block = (struct sensor_data_block_header *)&data[offset];
+		/* copy to a null terminated string */
+		strncpy(sensor_type_string, block->sensor_type, 4);
+		offset += 8;
+
+		dev_dbg(dev, "sensor block[%d]: type: %s, sensor_num: %d\n", b,
+			sensor_type_string, block->sensor_num);
+
+		if (strncmp(block->sensor_type, "FREQ", 4) == 0)
+			sensor_type = FREQ;
+		else if (strncmp(block->sensor_type, "TEMP", 4) == 0)
+			sensor_type = TEMP;
+		else if (strncmp(block->sensor_type, "POWR", 4) == 0)
+			sensor_type = POWER;
+		else if (strncmp(block->sensor_type, "CAPS", 4) == 0)
+			sensor_type = CAPS;
+		else {
+			dev_err(dev, "sensor type not supported %s\n",
+				sensor_type_string);
+			continue;
+		}
+
+		rc = occ_check_sensor(driver, block->sensor_length,
+				      block->sensor_num, sensor_type, b);
+		if (rc == -ENOMEM)
+			goto err;
+		else if (rc)
+			continue;
+
+		resp->data.sensor_block_id[sensor_type] = b;
+		for (s = 0; s < block->sensor_num; s++) {
+			driver->ops.parse_sensor(data,
+						 resp->data.blocks[b].sensors,
+						 sensor_type, offset, s);
+			offset += block->sensor_length;
+		}
+
+		/* copy block data over to response pointer */
+		resp->data.blocks[b].header = *block;
+	}
+
+	return 0;
+err:
+	deinit_occ_resp_buf(resp);
+	return rc;
+}
+
+static u8 occ_send_cmd(struct occ *driver, u8 seq, u8 type, u16 length,
+		       const u8 *data, u8 *resp)
+{
+	u32 cmd1, cmd2;
+	u16 checksum = 0;
+	u16 length_le = cpu_to_le16(length);
+	bool retry = 0;
+	int i, rc, tries = 0;
+
+	cmd1 = (seq << 24) | (type << 16) | length_le;
+	memcpy(&cmd2, data, length);
+	cmd2 <<= ((4 - length) * 8);
+
+	/* checksum: sum of every bytes of cmd1, cmd2 */
+	for (i = 0; i < 4; i++) {
+		checksum += (cmd1 >> (i * 8)) & 0xFF;
+		checksum += (cmd2 >> (i * 8)) & 0xFF;
+	}
+
+	cmd2 |= checksum << ((2 - length) * 8);
+
+	/* Init OCB */
+	rc = driver->bus_ops.putscom(driver->bus, OCB_STATUS_CONTROL_OR,
+				     OCB_OR_INIT0, OCB_OR_INIT1);
+	if (rc)
+		goto err;
+
+	rc = driver->bus_ops.putscom(driver->bus, OCB_STATUS_CONTROL_AND,
+				     OCB_AND_INIT0, OCB_AND_INIT1);
+	if (rc)
+		goto err;
+
+	/* Send command, 2nd half of the 64-bit addr is unused (write 0) */
+	rc = driver->bus_ops.putscom(driver->bus, OCB_ADDRESS,
+				     driver->config.command_addr, 0);
+	if (rc)
+		goto err;
+
+	rc = driver->bus_ops.putscom(driver->bus, OCB_DATA, cmd1, cmd2);
+	if (rc)
+		goto err;
+
+	/* Trigger attention */
+	rc = driver->bus_ops.putscom(driver->bus, ATTN_DATA, ATTN0, ATTN1);
+	if (rc)
+		goto err;
+
+	/* Get response data */
+	rc = driver->bus_ops.putscom(driver->bus, OCB_ADDRESS,
+				     driver->config.response_addr, 0);
+	if (rc)
+		goto err;
+
+	do {
+		if (retry) {
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule_timeout(msecs_to_jiffies(CMD_IN_PRG_INT_MS));
+		}
+
+		rc = driver->bus_ops.getscom(driver->bus, OCB_DATA,
+					     (u64 *)resp);
+		if (rc)
+			goto err;
+
+		/* retry if we get "command in progress" return status */
+		retry = (resp[RESP_RETURN_STATUS] == RESP_RETURN_CMD_IN_PRG) &&
+			(tries++ < CMD_IN_PRG_RETRIES);
+	} while (retry);
+
+	switch (resp[RESP_RETURN_STATUS]) {
+	case RESP_RETURN_CMD_IN_PRG:
+		rc = -EALREADY;
+		break;
+	case RESP_RETURN_SUCCESS:
+		rc = 0;
+		break;
+	case RESP_RETURN_CMD_INVAL:
+	case RESP_RETURN_CMD_LEN:
+	case RESP_RETURN_DATA_INVAL:
+	case RESP_RETURN_CHKSUM:
+		rc = -EINVAL;
+		break;
+	case RESP_RETURN_OCC_ERR:
+		rc = -EREMOTE;
+		break;
+	default:
+		rc = -EFAULT;
+	}
+
+	return rc;
+
+err:
+	dev_err(driver->dev, "scom op failed rc:%d\n", rc);
+	return rc;
+}
+
+static int occ_get_all(struct occ *driver)
+{
+	int i = 0, rc;
+	u8 *occ_data;
+	u16 num_bytes;
+	const u8 poll_cmd_data = OCC_POLL_STAT_SENSOR;
+	struct device *dev = driver->dev;
+	struct occ_response *resp = &driver->response;
+
+	occ_data = devm_kzalloc(dev, OCC_DATA_MAX, GFP_KERNEL);
+	if (!occ_data)
+		return -ENOMEM;
+
+	rc = occ_send_cmd(driver, 0, OCC_POLL, 1, &poll_cmd_data, occ_data);
+	if (rc) {
+		dev_err(dev, "OCC poll failed: %d\n", rc);
+		goto out;
+	}
+
+	num_bytes = get_unaligned((u16 *)&occ_data[RESP_DATA_LENGTH]);
+	num_bytes = be16_to_cpu(num_bytes);
+	dev_dbg(dev, "OCC data length: %d\n", num_bytes);
+
+	if (num_bytes > OCC_DATA_MAX) {
+		dev_err(dev, "OCC data length must be < 4KB\n");
+		rc = -EINVAL;
+		goto out;
+	}
+
+	if (num_bytes <= 0) {
+		dev_err(dev, "OCC data length is zero\n");
+		rc = -EINVAL;
+		goto out;
+	}
+
+	/* read remaining data */
+	for (i = 8; i < num_bytes + 8; i += 8) {
+		rc = driver->bus_ops.getscom(driver->bus, OCB_DATA,
+					     (u64 *)&occ_data[i]);
+		if (rc) {
+			dev_err(dev, "scom op failed rc:%d\n", rc);
+			goto out;
+		}
+	}
+
+	/* don't need more sanity checks; buffer is alloc'd for max response
+	 * size so we just check for valid data in parse_occ_response
+	 */
+	rc = parse_occ_response(driver, occ_data, resp);
+
+out:
+	devm_kfree(dev, occ_data);
+	return rc;
+}
+
+int occ_update_device(struct occ *driver)
+{
+	int rc = 0;
+
+	mutex_lock(&driver->update_lock);
+
+	if (time_after(jiffies, driver->last_updated + driver->update_interval)
+	    || !driver->valid) {
+		driver->valid = 1;
+
+		rc = occ_get_all(driver);
+		if (rc)
+			driver->valid = 0;
+
+		driver->last_updated = jiffies;
+	}
+
+	mutex_unlock(&driver->update_lock);
+
+	return rc;
+}
+EXPORT_SYMBOL(occ_update_device);
+
+void *occ_get_sensor(struct occ *driver, int sensor_type)
+{
+	int rc;
+
+	/* occ_update_device locks the update lock */
+	rc = occ_update_device(driver);
+	if (rc) {
+		dev_err(driver->dev, "cannot get occ sensor data: %d\n",
+			rc);
+		return NULL;
+	}
+
+	return occ_get_sensor_by_type(&driver->response, sensor_type);
+}
+EXPORT_SYMBOL(occ_get_sensor);
+
+int occ_get_sensor_value(struct occ *occ, int sensor_type, int sensor_num,
+			 u32 hwmon, long *val)
+{
+	return occ->ops.get_sensor(occ, sensor_type, sensor_num, hwmon, val);
+}
+EXPORT_SYMBOL(occ_get_sensor_value);
+
+void occ_get_response_blocks(struct occ *occ, struct occ_blocks **blocks)
+{
+	*blocks = &occ->response.data;
+}
+EXPORT_SYMBOL(occ_get_response_blocks);
+
+void occ_set_update_interval(struct occ *occ, unsigned long interval)
+{
+	occ->update_interval = msecs_to_jiffies(interval);
+}
+EXPORT_SYMBOL(occ_set_update_interval);
+
+int occ_set_user_powercap(struct occ *occ, u16 cap)
+{
+	u8 resp[8];
+
+	cap = cpu_to_be16(cap);
+
+	return occ_send_cmd(occ, 0, OCC_SET_USER_POWR_CAP, 2, (const u8 *)&cap,
+			    resp);
+}
+EXPORT_SYMBOL(occ_set_user_powercap);
+
+struct occ *occ_start(struct device *dev, void *bus,
+		      struct occ_bus_ops *bus_ops, const struct occ_ops *ops,
+		      const struct occ_config *config)
+{
+	struct occ *driver = devm_kzalloc(dev, sizeof(struct occ), GFP_KERNEL);
+
+	if (!driver)
+		return ERR_PTR(-ENOMEM);
+
+	driver->dev = dev;
+	driver->bus = bus;
+	driver->bus_ops = *bus_ops;
+	driver->ops = *ops;
+	driver->config = *config;
+
+	driver->update_interval = HZ;
+	mutex_init(&driver->update_lock);
+
+	return driver;
+}
+EXPORT_SYMBOL(occ_start);
+
+int occ_stop(struct occ *occ)
+{
+	devm_kfree(occ->dev, occ);
+
+	return 0;
+}
+EXPORT_SYMBOL(occ_stop);
+
+MODULE_AUTHOR("Eddie James <eajames-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>");
+MODULE_DESCRIPTION("OCC hwmon core driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/hwmon/occ/occ.h b/drivers/hwmon/occ/occ.h
new file mode 100644
index 0000000..be869bc
--- /dev/null
+++ b/drivers/hwmon/occ/occ.h
@@ -0,0 +1,83 @@
+/*
+ * occ.h - hwmon OCC driver
+ *
+ * This file contains data structures and function prototypes for common access
+ * between different bus protocols and host systems.
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
+#ifndef __OCC_H__
+#define __OCC_H__
+
+#include "scom.h"
+
+struct device;
+struct occ;
+
+/* sensor_data_block_header
+ * structure to match the raw occ sensor block header
+ */
+struct sensor_data_block_header {
+	u8 sensor_type[4];
+	u8 reserved0;
+	u8 sensor_format;
+	u8 sensor_length;
+	u8 sensor_num;
+} __attribute__((packed, aligned(4)));
+
+struct sensor_data_block {
+	struct sensor_data_block_header header;
+	void *sensors;
+};
+
+enum sensor_type {
+	FREQ = 0,
+	TEMP,
+	POWER,
+	CAPS,
+	MAX_OCC_SENSOR_TYPE
+};
+
+struct occ_ops {
+	void (*parse_sensor)(u8 *data, void *sensor, int sensor_type, int off,
+			     int snum);
+	void *(*alloc_sensor)(int sensor_type, int num_sensors);
+	int (*get_sensor)(struct occ *driver, int sensor_type, int sensor_num,
+			  u32 hwmon, long *val);
+};
+
+struct occ_config {
+	u32 command_addr;
+	u32 response_addr;
+};
+
+struct occ_blocks {
+	int sensor_block_id[MAX_OCC_SENSOR_TYPE];
+	struct sensor_data_block *blocks;
+};
+
+struct occ *occ_start(struct device *dev, void *bus,
+		      struct occ_bus_ops *bus_ops, const struct occ_ops *ops,
+		      const struct occ_config *config);
+int occ_stop(struct occ *occ);
+
+void *occ_get_sensor(struct occ *occ, int sensor_type);
+int occ_get_sensor_value(struct occ *occ, int sensor_type, int sensor_num,
+			 u32 hwmon, long *val);
+void occ_get_response_blocks(struct occ *occ, struct occ_blocks **blocks);
+int occ_update_device(struct occ *driver);
+void occ_set_update_interval(struct occ *occ, unsigned long interval);
+int occ_set_user_powercap(struct occ *occ, u16 cap);
+
+#endif /* __OCC_H__ */
diff --git a/drivers/hwmon/occ/scom.h b/drivers/hwmon/occ/scom.h
new file mode 100644
index 0000000..c1da645
--- /dev/null
+++ b/drivers/hwmon/occ/scom.h
@@ -0,0 +1,47 @@
+/*
+ * scom.h - hwmon OCC driver
+ *
+ * This file contains data structures for scom operations to the OCC
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
+#ifndef __SCOM_H__
+#define __SCOM_H__
+
+/*
+ * occ_bus_ops - represent the low-level transfer methods to communicate with
+ * the OCC.
+ *
+ * getscom - OCC scom read
+ * @bus: handle to slave device
+ * @address: address
+ * @data: where to store data read from slave; buffer size must be at least
+ * eight bytes.
+ *
+ * Returns 0 on success or a negative errno on error
+ *
+ * putscom - OCC scom write
+ * @bus: handle to slave device
+ * @address: address
+ * @data0: first data byte to write
+ * @data1: second data byte to write
+ *
+ * Returns 0 on success or a negative errno on error
+ */
+struct occ_bus_ops {
+	int (*getscom)(void *bus, u32 address, u64 *data);
+	int (*putscom)(void *bus, u32 address, u32 data0, u32 data1);
+};
+
+#endif /* __SCOM_H__ */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
