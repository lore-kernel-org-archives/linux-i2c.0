From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 2/3] i2c-smbus: add SMBus Host Notify support
Date: Thu,  9 Jul 2015 13:30:51 -0400
Message-ID: <1436463052-6944-3-git-send-email-benjamin.tissoires@redhat.com>
References: <1436463052-6944-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436463052-6944-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: benjamin.tissoires@gmail.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-i2c@vger.kernel.org

SMBus Host Notify allows a slave device to act as a master on a bus to
notify the host of an interrupt. On Intel chipsets, the functionality
is directly implemented in the firmware. We just need to export a
function to call .alert() on the proper device driver.

Compared to i2c_handle_smbus_alert(), it is much more convenient to
require to be able to sleep in i2c_propagate_smbus_host_notify().
device_(un)lock() in smbus_do_alert() needs to be able to sleep,
but because the address and payload are given directly by the caller
scheduling a new task would require a fifo or a lock on the current
I2C address and payload.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Changes in v2:
- do the actual processing of finding the device in i2c-smbus.c
- remove the i2c-core implementations
- remove the manual toggle of SMBus Host Notify

 Documentation/i2c/smbus-protocol |  3 +++
 drivers/i2c/i2c-smbus.c          | 36 +++++++++++++++++++++++++++++++-----
 include/linux/i2c-smbus.h        |  8 ++++++++
 include/linux/i2c.h              |  3 +++
 include/uapi/linux/i2c.h         |  1 +
 5 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/Documentation/i2c/smbus-protocol b/Documentation/i2c/smbus-protocol
index 6012b12..4e07848 100644
--- a/Documentation/i2c/smbus-protocol
+++ b/Documentation/i2c/smbus-protocol
@@ -199,6 +199,9 @@ alerting device's address.
 
 [S] [HostAddr] [Wr] A [DevAddr] A [DataLow] A [DataHigh] A [P]
 
+I2C drivers for devices which can trigger SMBus Host Notify should implement
+the optional alert() callback.
+
 
 Packet Error Checking (PEC)
 ===========================
diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index abad351..c348c1a 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -33,7 +33,8 @@ struct i2c_smbus_alert {
 
 struct alert_data {
 	unsigned short		addr;
-	u8			flag:1;
+	enum i2c_alert_protocol	type;
+	unsigned int		data;
 };
 
 /* If this is the alerting device, notify its driver */
@@ -56,8 +57,7 @@ static int smbus_do_alert(struct device *dev, void *addrp)
 	if (client->dev.driver) {
 		driver = to_i2c_driver(client->dev.driver);
 		if (driver->alert)
-			driver->alert(client, I2C_PROTOCOL_SMBUS_ALERT,
-				      data->flag);
+			driver->alert(client, data->type, data->data);
 		else
 			dev_warn(&client->dev, "no driver alert()!\n");
 	} else
@@ -97,8 +97,9 @@ static void smbus_alert(struct work_struct *work)
 		if (status < 0)
 			break;
 
-		data.flag = status & 1;
+		data.data = status & 1;
 		data.addr = status >> 1;
+		data.type = I2C_PROTOCOL_SMBUS_ALERT;
 
 		if (data.addr == prev_addr) {
 			dev_warn(&ara->dev, "Duplicate SMBALERT# from dev "
@@ -106,7 +107,7 @@ static void smbus_alert(struct work_struct *work)
 			break;
 		}
 		dev_dbg(&ara->dev, "SMBALERT# from dev 0x%02x, flag %d\n",
-			data.addr, data.flag);
+			data.addr, data.data);
 
 		/* Notify driver for the device which issued the alert */
 		device_for_each_child(&ara->adapter->dev, &data,
@@ -240,6 +241,31 @@ int i2c_handle_smbus_alert(struct i2c_client *ara)
 }
 EXPORT_SYMBOL_GPL(i2c_handle_smbus_alert);
 
+/**
+ * i2c_propagate_smbus_host_notify - Forward a Host Notify event to the correct
+ * I2C client.
+ * @adapter: the adapter that triggered the Host Notify event
+ * @data: the Host Notify data which contains the payload and address of the
+ * client
+ * Context: Must be able to sleep
+ *
+ * Helper function to be called from an I2C bus driver's interrupt
+ * handler that can sleep. It will call the Host Notify callback of the I2C
+ * device driver if it is found on the adapter.
+ */
+void i2c_propagate_smbus_host_notify(struct i2c_adapter *adapter,
+				     unsigned short addr, unsigned int data)
+{
+	struct alert_data alert = {
+		.type = I2C_PROTOCOL_SMBUS_HOST_NOTIFY,
+		.addr = addr,
+		.data = data,
+	};
+
+	device_for_each_child(&adapter->dev, &alert, smbus_do_alert);
+}
+EXPORT_SYMBOL_GPL(i2c_propagate_smbus_host_notify);
+
 module_i2c_driver(smbalert_driver);
 
 MODULE_AUTHOR("Jean Delvare <jdelvare@suse.de>");
diff --git a/include/linux/i2c-smbus.h b/include/linux/i2c-smbus.h
index 8f1b086..285efe05 100644
--- a/include/linux/i2c-smbus.h
+++ b/include/linux/i2c-smbus.h
@@ -48,4 +48,12 @@ struct i2c_client *i2c_setup_smbus_alert(struct i2c_adapter *adapter,
 					 struct i2c_smbus_alert_setup *setup);
 int i2c_handle_smbus_alert(struct i2c_client *ara);
 
+#if defined(CONFIG_I2C_SMBUS) || defined(CONFIG_I2C_SMBUS_MODULE)
+void i2c_propagate_smbus_host_notify(struct i2c_adapter *adapter,
+				     unsigned short addr, unsigned int data);
+#else
+static inline void i2c_propagate_smbus_host_notify(struct i2c_adapter *adapter,
+				     unsigned short addr, unsigned int data) {}
+#endif /* I2C_SMBUS */
+
 #endif /* _LINUX_I2C_SMBUS_H */
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 6764734..81344d3 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -125,6 +125,7 @@ extern s32 i2c_smbus_write_i2c_block_data(const struct i2c_client *client,
 
 enum i2c_alert_protocol {
 	I2C_PROTOCOL_SMBUS_ALERT,
+	I2C_PROTOCOL_SMBUS_HOST_NOTIFY,
 };
 
 /**
@@ -181,6 +182,8 @@ struct i2c_driver {
 	 * The format and meaning of the data value depends on the protocol.
 	 * For the SMBus alert protocol, there is a single bit of data passed
 	 * as the alert response's low bit ("event flag").
+	 * For the SMBus Host Notify protocol, the data corresponds to the
+	 * 16-bit payload data reported by the slave device acting as master.
 	 */
 	void (*alert)(struct i2c_client *, enum i2c_alert_protocol protocol,
 		      unsigned int data);
diff --git a/include/uapi/linux/i2c.h b/include/uapi/linux/i2c.h
index b0a7dd6..83ec8ae 100644
--- a/include/uapi/linux/i2c.h
+++ b/include/uapi/linux/i2c.h
@@ -101,6 +101,7 @@ struct i2c_msg {
 #define I2C_FUNC_SMBUS_WRITE_BLOCK_DATA 0x02000000
 #define I2C_FUNC_SMBUS_READ_I2C_BLOCK	0x04000000 /* I2C-like block xfer  */
 #define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK	0x08000000 /* w/ 1-byte reg. addr. */
+#define I2C_FUNC_SMBUS_HOST_NOTIFY	0x10000000
 
 #define I2C_FUNC_SMBUS_BYTE		(I2C_FUNC_SMBUS_READ_BYTE | \
 					 I2C_FUNC_SMBUS_WRITE_BYTE)
-- 
2.4.3
