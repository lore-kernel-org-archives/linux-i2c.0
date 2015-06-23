From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/2] i2c: add SMBus Host Notify support
Date: Tue, 23 Jun 2015 14:58:18 -0400
Message-ID: <1435085899-11017-2-git-send-email-benjamin.tissoires@redhat.com>
References: <1435085899-11017-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435085899-11017-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: benjamin.tissoires@gmail.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-i2c@vger.kernel.org

SMBus Host Notify allows a slave device to act as a master on a bus to
notify the host of an interrupt. The functionality is directly implemented
in the firmware so we just export a toggle function and rely on the
adapter to actually support this.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 Documentation/i2c/smbus-protocol |  4 ++++
 drivers/i2c/i2c-core.c           | 26 ++++++++++++++++++++++++++
 include/linux/i2c.h              |  8 ++++++++
 include/uapi/linux/i2c.h         |  1 +
 4 files changed, 39 insertions(+)

diff --git a/Documentation/i2c/smbus-protocol b/Documentation/i2c/smbus-protocol
index 6012b12..af4e4b9 100644
--- a/Documentation/i2c/smbus-protocol
+++ b/Documentation/i2c/smbus-protocol
@@ -199,6 +199,10 @@ alerting device's address.
 
 [S] [HostAddr] [Wr] A [DevAddr] A [DataLow] A [DataHigh] A [P]
 
+I2C drivers for devices which can trigger SMBus Host Notify should call
+i2c_smbus_toggle_host_notify() to enable SMBUS Host Notify on the adapter
+and implement the optional alert() callback.
+
 
 Packet Error Checking (PEC)
 ===========================
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 987c124..eaaf5b0 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -2959,6 +2959,32 @@ int i2c_slave_unregister(struct i2c_client *client)
 EXPORT_SYMBOL_GPL(i2c_slave_unregister);
 #endif
 
+int i2c_smbus_toggle_host_notify(struct i2c_client *client, bool state)
+{
+	int ret;
+
+	if (!client)
+		return -EINVAL;
+
+	if (!(client->flags & I2C_CLIENT_TEN)) {
+		/* Enforce stricter address checking */
+		ret = i2c_check_addr_validity(client->addr);
+		if (ret)
+			return ret;
+	}
+
+	if (!client->adapter->algo->toggle_smbus_host_notify)
+		return -EOPNOTSUPP;
+
+	i2c_lock_adapter(client->adapter);
+	ret = client->adapter->algo->toggle_smbus_host_notify(client->adapter,
+							      state);
+	i2c_unlock_adapter(client->adapter);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i2c_smbus_toggle_host_notify);
+
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus main module");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index e83a738..7ffc970 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -177,6 +177,8 @@ struct i2c_driver {
 	 * The format and meaning of the data value depends on the protocol.
 	 * For the SMBus alert protocol, there is a single bit of data passed
 	 * as the alert response's low bit ("event flag").
+	 * For the SMBus Host Notify protocol, the data corresponds to the
+	 * 16-bits payload data reported by the external device.
 	 */
 	void (*alert)(struct i2c_client *, unsigned int data);
 
@@ -270,6 +272,9 @@ static inline int i2c_slave_event(struct i2c_client *client,
 }
 #endif
 
+
+extern int i2c_smbus_toggle_host_notify(struct i2c_client *client, bool state);
+
 /**
  * struct i2c_board_info - template for device creation
  * @type: chip type, to initialize i2c_client.name
@@ -378,6 +383,8 @@ i2c_register_board_info(int busnum, struct i2c_board_info const *info,
  *   from the I2C_FUNC_* flags.
  * @reg_slave: Register given client to I2C slave mode of this adapter
  * @unreg_slave: Unregister given client from I2C slave mode of this adapter
+ * @toggle_smbus_host_notify: toggle the SMBus Host Notify support of this
+ *   adapter.
  *
  * The following structs are for those who like to implement new bus drivers:
  * i2c_algorithm is the interface to a class of hardware solutions which can
@@ -408,6 +415,7 @@ struct i2c_algorithm {
 	int (*reg_slave)(struct i2c_client *client);
 	int (*unreg_slave)(struct i2c_client *client);
 #endif
+	int (*toggle_smbus_host_notify)(struct i2c_adapter *adap, bool state);
 };
 
 /**
diff --git a/include/uapi/linux/i2c.h b/include/uapi/linux/i2c.h
index 0e949cb..c72708e 100644
--- a/include/uapi/linux/i2c.h
+++ b/include/uapi/linux/i2c.h
@@ -100,6 +100,7 @@ struct i2c_msg {
 #define I2C_FUNC_SMBUS_WRITE_BLOCK_DATA 0x02000000
 #define I2C_FUNC_SMBUS_READ_I2C_BLOCK	0x04000000 /* I2C-like block xfer  */
 #define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK	0x08000000 /* w/ 1-byte reg. addr. */
+#define I2C_FUNC_SMBUS_HOST_NOTIFY	0x10000000
 
 #define I2C_FUNC_SMBUS_BYTE		(I2C_FUNC_SMBUS_READ_BYTE | \
 					 I2C_FUNC_SMBUS_WRITE_BYTE)
-- 
2.4.3
