From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] i2c: use void pointers for supplying data for reads and
 writes
Date: Sat, 1 Apr 2017 10:53:55 -0700
Message-ID: <20170401175355.GA12265@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33239 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbdDARx7 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 1 Apr 2017 13:53:59 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

There is no need to force users of i2c_master_send()/i2c_master_recv()
and other i2c read/write bulk data API to cast everything into u* pointers.
While everything can be considered byte stream, the drivers are usually
work with more structured data.

Let's switch the APIs to accept [const] void pointers to cut amount of
casting needed.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/i2c/i2c-core.c | 23 ++++++++++++-----------
 include/linux/i2c.h    | 15 ++++++++-------
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 9ff5ce3d5fba..6efeba42d10b 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -56,6 +56,7 @@
 #include <linux/property.h>
 #include <linux/rwsem.h>
 #include <linux/slab.h>
+#include <asm/unaligned.h>
 
 #include "i2c-core.h"
 
@@ -2817,7 +2818,7 @@ EXPORT_SYMBOL(i2c_transfer);
  *
  * Returns negative errno, or else the number of bytes written.
  */
-int i2c_master_send(const struct i2c_client *client, const char *buf, int count)
+int i2c_master_send(const struct i2c_client *client, const void *buf, int count)
 {
 	int ret;
 	struct i2c_adapter *adap = client->adapter;
@@ -2826,7 +2827,7 @@ int i2c_master_send(const struct i2c_client *client, const char *buf, int count)
 	msg.addr = client->addr;
 	msg.flags = client->flags & I2C_M_TEN;
 	msg.len = count;
-	msg.buf = (char *)buf;
+	msg.buf = (u8 *)buf; /* cast away const */
 
 	ret = i2c_transfer(adap, &msg, 1);
 
@@ -2846,7 +2847,7 @@ EXPORT_SYMBOL(i2c_master_send);
  *
  * Returns negative errno, or else the number of bytes read.
  */
-int i2c_master_recv(const struct i2c_client *client, char *buf, int count)
+int i2c_master_recv(const struct i2c_client *client, void *buf, int count)
 {
 	struct i2c_adapter *adap = client->adapter;
 	struct i2c_msg msg;
@@ -3290,7 +3291,7 @@ EXPORT_SYMBOL(i2c_smbus_write_word_data);
  * mechanism (I2C_M_RECV_LEN) which may not be implemented.
  */
 s32 i2c_smbus_read_block_data(const struct i2c_client *client, u8 command,
-			      u8 *values)
+			      void *values)
 {
 	union i2c_smbus_data data;
 	int status;
@@ -3317,7 +3318,7 @@ EXPORT_SYMBOL(i2c_smbus_read_block_data);
  * else zero on success.
  */
 s32 i2c_smbus_write_block_data(const struct i2c_client *client, u8 command,
-			       u8 length, const u8 *values)
+			       u8 length, const void *values)
 {
 	union i2c_smbus_data data;
 
@@ -3333,7 +3334,7 @@ EXPORT_SYMBOL(i2c_smbus_write_block_data);
 
 /* Returns the number of read bytes */
 s32 i2c_smbus_read_i2c_block_data(const struct i2c_client *client, u8 command,
-				  u8 length, u8 *values)
+				  u8 length, void *values)
 {
 	union i2c_smbus_data data;
 	int status;
@@ -3353,7 +3354,7 @@ s32 i2c_smbus_read_i2c_block_data(const struct i2c_client *client, u8 command,
 EXPORT_SYMBOL(i2c_smbus_read_i2c_block_data);
 
 s32 i2c_smbus_write_i2c_block_data(const struct i2c_client *client, u8 command,
-				   u8 length, const u8 *values)
+				   u8 length, const void *values)
 {
 	union i2c_smbus_data data;
 
@@ -3633,7 +3634,8 @@ EXPORT_SYMBOL(i2c_smbus_xfer);
  * transfer.
  */
 s32 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
-					      u8 command, u8 length, u8 *values)
+					      u8 command, u8 length,
+					      void *values)
 {
 	u8 i = 0;
 	int status;
@@ -3652,8 +3654,7 @@ s32 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
 			status = i2c_smbus_read_word_data(client, command + i);
 			if (status < 0)
 				return status;
-			values[i] = status & 0xff;
-			values[i + 1] = status >> 8;
+			put_unaligned_le16(status, values + i);
 			i += 2;
 		}
 	}
@@ -3662,7 +3663,7 @@ s32 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
 		status = i2c_smbus_read_byte_data(client, command + i);
 		if (status < 0)
 			return status;
-		values[i] = status;
+		*((u8 *)values + i) = status;
 		i++;
 	}
 
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index b4b6583d0e07..d9f9601fce4c 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -62,9 +62,9 @@ struct property_entry;
  * transmit an arbitrary number of messages without interruption.
  * @count must be be less than 64k since msg.len is u16.
  */
-extern int i2c_master_send(const struct i2c_client *client, const char *buf,
+extern int i2c_master_send(const struct i2c_client *client, const void *buf,
 			   int count);
-extern int i2c_master_recv(const struct i2c_client *client, char *buf,
+extern int i2c_master_recv(const struct i2c_client *client, void *buf,
 			   int count);
 
 /* Transfer num messages.
@@ -115,18 +115,19 @@ i2c_smbus_write_word_swapped(const struct i2c_client *client,
 
 /* Returns the number of read bytes */
 extern s32 i2c_smbus_read_block_data(const struct i2c_client *client,
-				     u8 command, u8 *values);
+				     u8 command, void *values);
 extern s32 i2c_smbus_write_block_data(const struct i2c_client *client,
-				      u8 command, u8 length, const u8 *values);
+				      u8 command, u8 length,
+				      const void *values);
 /* Returns the number of read bytes */
 extern s32 i2c_smbus_read_i2c_block_data(const struct i2c_client *client,
-					 u8 command, u8 length, u8 *values);
+					 u8 command, u8 length, void *values);
 extern s32 i2c_smbus_write_i2c_block_data(const struct i2c_client *client,
 					  u8 command, u8 length,
-					  const u8 *values);
+					  const void *values);
 extern s32
 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
-					  u8 command, u8 length, u8 *values);
+					  u8 command, u8 length, void *values);
 #endif /* I2C */
 
 enum i2c_alert_protocol {
-- 
2.12.2.564.g063fe858b8-goog


-- 
Dmitry
