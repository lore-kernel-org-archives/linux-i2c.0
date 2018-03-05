From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 1/2] i2c: add i2c_get_device_id() to get the standard i2c device id
Date: Mon,  5 Mar 2018 21:58:21 +0100
Message-ID: <20180305205822.951-2-peda@axentia.se>
References: <20180305205822.951-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180305205822.951-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Adrian Fiergolski <adrian.fiergolski@cern.ch>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Can be used during probe to double check that the probed device is
what is expected.

Loosely based on code from Adrian Fiergolski <adrian.fiergolski@cern.ch>.

Tested-by: Adrian Fiergolski <adrian.fiergolski@cern.ch>
Reviewed-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/i2c-core-base.c | 33 +++++++++++++++++++++++++++++++++
 include/linux/i2c.h         | 30 ++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 5a00bf443d06..aa03eeb43814 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -58,6 +58,8 @@
 #define I2C_ADDR_7BITS_MAX	0x77
 #define I2C_ADDR_7BITS_COUNT	(I2C_ADDR_7BITS_MAX + 1)
 
+#define I2C_ADDR_DEVICE_ID	0x7c
+
 /*
  * core_lock protects i2c_adapter_idr, and guarantees that device detection,
  * deletion of detected devices, and attach_adapter calls are serialized
@@ -1968,6 +1970,37 @@ int i2c_transfer_buffer_flags(const struct i2c_client *client, char *buf,
 }
 EXPORT_SYMBOL(i2c_transfer_buffer_flags);
 
+/**
+ * i2c_get_device_id - get manufacturer, part id and die revision of a device
+ * @client: The device to query
+ * @id: The queried information
+ *
+ * Returns negative errno on error, zero on success.
+ */
+int i2c_get_device_id(const struct i2c_client *client,
+		      struct i2c_device_identity *id)
+{
+	struct i2c_adapter *adap = client->adapter;
+	union i2c_smbus_data raw_id;
+	int ret;
+
+	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_READ_I2C_BLOCK))
+		return -EOPNOTSUPP;
+
+	raw_id.block[0] = 3;
+	ret = i2c_smbus_xfer(adap, I2C_ADDR_DEVICE_ID, 0,
+			     I2C_SMBUS_READ, client->addr << 1,
+			     I2C_SMBUS_I2C_BLOCK_DATA, &raw_id);
+	if (ret)
+		return ret;
+
+	id->manufacturer_id = (raw_id.block[1] << 4) | (raw_id.block[2] >> 4);
+	id->part_id = ((raw_id.block[2] & 0xf) << 5) | (raw_id.block[3] >> 3);
+	id->die_revision = raw_id.block[3] & 0x7;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(i2c_get_device_id);
+
 /* ----------------------------------------------------
  * the i2c address scanning function
  * Will not work for 10-bit addresses!
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 419a38e7c315..44ad14e016b5 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -47,6 +47,7 @@ struct i2c_algorithm;
 struct i2c_adapter;
 struct i2c_client;
 struct i2c_driver;
+struct i2c_device_identity;
 union i2c_smbus_data;
 struct i2c_board_info;
 enum i2c_slave_event;
@@ -186,8 +187,37 @@ extern s32 i2c_smbus_write_i2c_block_data(const struct i2c_client *client,
 extern s32
 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
 					  u8 command, u8 length, u8 *values);
+int i2c_get_device_id(const struct i2c_client *client,
+		      struct i2c_device_identity *id);
 #endif /* I2C */
 
+/**
+ * struct i2c_device_identity - i2c client device identification
+ * @manufacturer_id: 0 - 4095, database maintained by NXP
+ * @part_id: 0 - 511, according to manufacturer
+ * @die_revision: 0 - 7, according to manufacturer
+ */
+struct i2c_device_identity {
+	u16 manufacturer_id;
+#define I2C_DEVICE_ID_NXP_SEMICONDUCTORS                0
+#define I2C_DEVICE_ID_NXP_SEMICONDUCTORS_1              1
+#define I2C_DEVICE_ID_NXP_SEMICONDUCTORS_2              2
+#define I2C_DEVICE_ID_NXP_SEMICONDUCTORS_3              3
+#define I2C_DEVICE_ID_RAMTRON_INTERNATIONAL             4
+#define I2C_DEVICE_ID_ANALOG_DEVICES                    5
+#define I2C_DEVICE_ID_STMICROELECTRONICS                6
+#define I2C_DEVICE_ID_ON_SEMICONDUCTOR                  7
+#define I2C_DEVICE_ID_SPRINTEK_CORPORATION              8
+#define I2C_DEVICE_ID_ESPROS_PHOTONICS_AG               9
+#define I2C_DEVICE_ID_FUJITSU_SEMICONDUCTOR            10
+#define I2C_DEVICE_ID_FLIR                             11
+#define I2C_DEVICE_ID_O2MICRO                          12
+#define I2C_DEVICE_ID_ATMEL                            13
+#define I2C_DEVICE_ID_NONE                         0xffff
+	u16 part_id;
+	u8 die_revision;
+};
+
 enum i2c_alert_protocol {
 	I2C_PROTOCOL_SMBUS_ALERT,
 	I2C_PROTOCOL_SMBUS_HOST_NOTIFY,
-- 
2.11.0
