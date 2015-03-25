From: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [RFC PATCH 1/1] i2c: core: Add support for best effort block read emulation
Date: Wed, 25 Mar 2015 16:33:20 +0200
Message-ID: <1427294000-32406-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

There are devices that need to handle block transactions
regardless of the capabilities exported by the adapter.
For performance reasons, they need to use i2c read blocks
if available, otherwise emulate the block transaction with word
or byte transactions.

Add support for a helper function that would read a data block
using the best transfer available: I2C_FUNC_SMBUS_READ_I2C_BLOCK,
I2C_FUNC_SMBUS_READ_WORD_DATA or I2C_FUNC_SMBUS_READ_BYTE_DATA.

Signed-off-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---

Hi,

This is a new API proposal to handle i2c block emulation in the
core instead of the driver code.

This is needed for a set of iio sensor changes ([1], [2], [3])
that would otherwise duplicate this code. There are also some
usages of this functionality in the kernel (e.g. eeprom driver at24).

Please let me know what you think.

Thanks,
Irina

[1] https://lkml.org/lkml/2015/2/16/408
[2] https://lkml.org/lkml/2015/2/16/413
[3] https://lkml.org/lkml/2015/2/16/402

 drivers/i2c/i2c-core.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c.h    |  3 +++
 2 files changed, 65 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index fe80f85..2579f7d 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -2907,6 +2907,68 @@ trace:
 }
 EXPORT_SYMBOL(i2c_smbus_xfer);
 
+/**
+ * i2c_smbus_read_i2c_block_data_or_emulated - read block or emulate
+ * @client: Handle to slave device
+ * @command: Byte interpreted by slave
+ * @length: Size of data block; SMBus allows at most 32 bytes
+ * @values: Byte array into which data will be read; big enough to hold
+ *	the data returned by the slave.  SMBus allows at most 32 bytes.
+ *
+ * This executes the SMBus "block read" protocol if supported by the adapter.
+ * If block read is not supported, it emulates it using either word or byte
+ * read protocols depending on availability.
+ */
+s32 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
+					      u8 command, u8 length, u8 *values)
+{
+	u8 i;
+	int status;
+
+	if (length > I2C_SMBUS_BLOCK_MAX)
+		length = I2C_SMBUS_BLOCK_MAX;
+
+	if (i2c_check_functionality(client->adapter,
+				    I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
+		return i2c_smbus_read_i2c_block_data(client, command,
+						     length, values);
+	} else if (i2c_check_functionality(client->adapter,
+					   I2C_FUNC_SMBUS_READ_WORD_DATA |
+					   I2C_FUNC_SMBUS_READ_BYTE_DATA)) {
+		for (i = 0; (i + 2) <= length; i += 2) {
+			status = i2c_smbus_read_word_data(client, command + i);
+			if (status < 0)
+				return status;
+			values[i] = status & 0xff;
+			values[i+1] = status >> 8;
+		}
+		if (i < length) {
+			status = i2c_smbus_read_byte_data(client, command + i);
+			if (status < 0)
+				return status;
+			values[i] = status;
+			i++;
+		}
+		return i;
+	} else if (i2c_check_functionality(client->adapter,
+					   I2C_FUNC_SMBUS_READ_BYTE_DATA)) {
+		for (i = 0; i < length; i++) {
+			status = i2c_smbus_read_byte_data(client, command + i);
+			if (status < 0)
+				return status;
+			values[i] = status;
+		}
+		return i;
+	}
+
+	dev_err(&client->adapter->dev, "Unsupported transactions: %d,%d,%d\n",
+		I2C_SMBUS_I2C_BLOCK_DATA, I2C_SMBUS_WORD_DATA,
+		I2C_SMBUS_BYTE_DATA);
+
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(i2c_smbus_read_i2c_block_data_or_emulated);
+
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
 int i2c_slave_register(struct i2c_client *client, i2c_slave_cb_t slave_cb)
 {
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 243d1a1..f3ede76 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -121,6 +121,9 @@ extern s32 i2c_smbus_read_i2c_block_data(const struct i2c_client *client,
 extern s32 i2c_smbus_write_i2c_block_data(const struct i2c_client *client,
 					  u8 command, u8 length,
 					  const u8 *values);
+extern s32
+i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
+					  u8 command, u8 length, u8 *values);
 #endif /* I2C */
 
 /**
-- 
1.9.1
