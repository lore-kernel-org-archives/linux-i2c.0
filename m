From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Constify i2c_client where possible
Date: Wed, 5 Jan 2011 19:42:08 +0100
Message-ID: <20110105194208.67e89379@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Helper functions for I2C and SMBus transactions don't modify the
i2c_client that is passed to them, so it can be marked const.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/i2c-core.c   |   29 ++++++++++++++++-------------
 drivers/rtc/rtc-ds1307.c |   12 ++++++------
 include/linux/i2c.h      |   27 +++++++++++++++------------
 3 files changed, 37 insertions(+), 31 deletions(-)

--- linux-2.6.37-rc8.orig/include/linux/i2c.h	2011-01-05 18:31:17.000000000 +0100
+++ linux-2.6.37-rc8/include/linux/i2c.h	2011-01-05 18:31:41.000000000 +0100
@@ -57,9 +57,10 @@ struct i2c_board_info;
  * transmit an arbitrary number of messages without interruption.
  * @count must be be less than 64k since msg.len is u16.
  */
-extern int i2c_master_send(struct i2c_client *client, const char *buf,
+extern int i2c_master_send(const struct i2c_client *client, const char *buf,
+			   int count);
+extern int i2c_master_recv(const struct i2c_client *client, char *buf,
 			   int count);
-extern int i2c_master_recv(struct i2c_client *client, char *buf, int count);
 
 /* Transfer num messages.
  */
@@ -78,23 +79,25 @@ extern s32 i2c_smbus_xfer(struct i2c_ada
 /* Now follow the 'nice' access routines. These also document the calling
    conventions of i2c_smbus_xfer. */
 
-extern s32 i2c_smbus_read_byte(struct i2c_client *client);
-extern s32 i2c_smbus_write_byte(struct i2c_client *client, u8 value);
-extern s32 i2c_smbus_read_byte_data(struct i2c_client *client, u8 command);
-extern s32 i2c_smbus_write_byte_data(struct i2c_client *client,
+extern s32 i2c_smbus_read_byte(const struct i2c_client *client);
+extern s32 i2c_smbus_write_byte(const struct i2c_client *client, u8 value);
+extern s32 i2c_smbus_read_byte_data(const struct i2c_client *client,
+				    u8 command);
+extern s32 i2c_smbus_write_byte_data(const struct i2c_client *client,
 				     u8 command, u8 value);
-extern s32 i2c_smbus_read_word_data(struct i2c_client *client, u8 command);
-extern s32 i2c_smbus_write_word_data(struct i2c_client *client,
+extern s32 i2c_smbus_read_word_data(const struct i2c_client *client,
+				    u8 command);
+extern s32 i2c_smbus_write_word_data(const struct i2c_client *client,
 				     u8 command, u16 value);
 /* Returns the number of read bytes */
-extern s32 i2c_smbus_read_block_data(struct i2c_client *client,
+extern s32 i2c_smbus_read_block_data(const struct i2c_client *client,
 				     u8 command, u8 *values);
-extern s32 i2c_smbus_write_block_data(struct i2c_client *client,
+extern s32 i2c_smbus_write_block_data(const struct i2c_client *client,
 				      u8 command, u8 length, const u8 *values);
 /* Returns the number of read bytes */
-extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client *client,
+extern s32 i2c_smbus_read_i2c_block_data(const struct i2c_client *client,
 					 u8 command, u8 length, u8 *values);
-extern s32 i2c_smbus_write_i2c_block_data(struct i2c_client *client,
+extern s32 i2c_smbus_write_i2c_block_data(const struct i2c_client *client,
 					  u8 command, u8 length,
 					  const u8 *values);
 #endif /* I2C */
--- linux-2.6.37-rc8.orig/drivers/i2c/i2c-core.c	2011-01-05 18:31:17.000000000 +0100
+++ linux-2.6.37-rc8/drivers/i2c/i2c-core.c	2011-01-05 18:31:41.000000000 +0100
@@ -1362,7 +1362,7 @@ EXPORT_SYMBOL(i2c_transfer);
  *
  * Returns negative errno, or else the number of bytes written.
  */
-int i2c_master_send(struct i2c_client *client, const char *buf, int count)
+int i2c_master_send(const struct i2c_client *client, const char *buf, int count)
 {
 	int ret;
 	struct i2c_adapter *adap = client->adapter;
@@ -1389,7 +1389,7 @@ EXPORT_SYMBOL(i2c_master_send);
  *
  * Returns negative errno, or else the number of bytes read.
  */
-int i2c_master_recv(struct i2c_client *client, char *buf, int count)
+int i2c_master_recv(const struct i2c_client *client, char *buf, int count)
 {
 	struct i2c_adapter *adap = client->adapter;
 	struct i2c_msg msg;
@@ -1679,7 +1679,7 @@ static int i2c_smbus_check_pec(u8 cpec,
  * This executes the SMBus "receive byte" protocol, returning negative errno
  * else the byte received from the device.
  */
-s32 i2c_smbus_read_byte(struct i2c_client *client)
+s32 i2c_smbus_read_byte(const struct i2c_client *client)
 {
 	union i2c_smbus_data data;
 	int status;
@@ -1699,7 +1699,7 @@ EXPORT_SYMBOL(i2c_smbus_read_byte);
  * This executes the SMBus "send byte" protocol, returning negative errno
  * else zero on success.
  */
-s32 i2c_smbus_write_byte(struct i2c_client *client, u8 value)
+s32 i2c_smbus_write_byte(const struct i2c_client *client, u8 value)
 {
 	return i2c_smbus_xfer(client->adapter, client->addr, client->flags,
 	                      I2C_SMBUS_WRITE, value, I2C_SMBUS_BYTE, NULL);
@@ -1714,7 +1714,7 @@ EXPORT_SYMBOL(i2c_smbus_write_byte);
  * This executes the SMBus "read byte" protocol, returning negative errno
  * else a data byte received from the device.
  */
-s32 i2c_smbus_read_byte_data(struct i2c_client *client, u8 command)
+s32 i2c_smbus_read_byte_data(const struct i2c_client *client, u8 command)
 {
 	union i2c_smbus_data data;
 	int status;
@@ -1735,7 +1735,8 @@ EXPORT_SYMBOL(i2c_smbus_read_byte_data);
  * This executes the SMBus "write byte" protocol, returning negative errno
  * else zero on success.
  */
-s32 i2c_smbus_write_byte_data(struct i2c_client *client, u8 command, u8 value)
+s32 i2c_smbus_write_byte_data(const struct i2c_client *client, u8 command,
+			      u8 value)
 {
 	union i2c_smbus_data data;
 	data.byte = value;
@@ -1753,7 +1754,7 @@ EXPORT_SYMBOL(i2c_smbus_write_byte_data)
  * This executes the SMBus "read word" protocol, returning negative errno
  * else a 16-bit unsigned "word" received from the device.
  */
-s32 i2c_smbus_read_word_data(struct i2c_client *client, u8 command)
+s32 i2c_smbus_read_word_data(const struct i2c_client *client, u8 command)
 {
 	union i2c_smbus_data data;
 	int status;
@@ -1774,7 +1775,8 @@ EXPORT_SYMBOL(i2c_smbus_read_word_data);
  * This executes the SMBus "write word" protocol, returning negative errno
  * else zero on success.
  */
-s32 i2c_smbus_write_word_data(struct i2c_client *client, u8 command, u16 value)
+s32 i2c_smbus_write_word_data(const struct i2c_client *client, u8 command,
+			      u16 value)
 {
 	union i2c_smbus_data data;
 	data.word = value;
@@ -1793,7 +1795,8 @@ EXPORT_SYMBOL(i2c_smbus_write_word_data)
  * This executes the SMBus "process call" protocol, returning negative errno
  * else a 16-bit unsigned "word" received from the device.
  */
-s32 i2c_smbus_process_call(struct i2c_client *client, u8 command, u16 value)
+s32 i2c_smbus_process_call(const struct i2c_client *client, u8 command,
+			   u16 value)
 {
 	union i2c_smbus_data data;
 	int status;
@@ -1821,7 +1824,7 @@ EXPORT_SYMBOL(i2c_smbus_process_call);
  * support this; its emulation through I2C messaging relies on a specific
  * mechanism (I2C_M_RECV_LEN) which may not be implemented.
  */
-s32 i2c_smbus_read_block_data(struct i2c_client *client, u8 command,
+s32 i2c_smbus_read_block_data(const struct i2c_client *client, u8 command,
 			      u8 *values)
 {
 	union i2c_smbus_data data;
@@ -1848,7 +1851,7 @@ EXPORT_SYMBOL(i2c_smbus_read_block_data)
  * This executes the SMBus "block write" protocol, returning negative errno
  * else zero on success.
  */
-s32 i2c_smbus_write_block_data(struct i2c_client *client, u8 command,
+s32 i2c_smbus_write_block_data(const struct i2c_client *client, u8 command,
 			       u8 length, const u8 *values)
 {
 	union i2c_smbus_data data;
@@ -1864,7 +1867,7 @@ s32 i2c_smbus_write_block_data(struct i2
 EXPORT_SYMBOL(i2c_smbus_write_block_data);
 
 /* Returns the number of read bytes */
-s32 i2c_smbus_read_i2c_block_data(struct i2c_client *client, u8 command,
+s32 i2c_smbus_read_i2c_block_data(const struct i2c_client *client, u8 command,
 				  u8 length, u8 *values)
 {
 	union i2c_smbus_data data;
@@ -1884,7 +1887,7 @@ s32 i2c_smbus_read_i2c_block_data(struct
 }
 EXPORT_SYMBOL(i2c_smbus_read_i2c_block_data);
 
-s32 i2c_smbus_write_i2c_block_data(struct i2c_client *client, u8 command,
+s32 i2c_smbus_write_i2c_block_data(const struct i2c_client *client, u8 command,
 				   u8 length, const u8 *values)
 {
 	union i2c_smbus_data data;
--- linux-2.6.37-rc8.orig/drivers/rtc/rtc-ds1307.c	2011-01-05 18:31:17.000000000 +0100
+++ linux-2.6.37-rc8/drivers/rtc/rtc-ds1307.c	2011-01-05 18:31:41.000000000 +0100
@@ -106,9 +106,9 @@ struct ds1307 {
 	struct i2c_client	*client;
 	struct rtc_device	*rtc;
 	struct work_struct	work;
-	s32 (*read_block_data)(struct i2c_client *client, u8 command,
+	s32 (*read_block_data)(const struct i2c_client *client, u8 command,
 			       u8 length, u8 *values);
-	s32 (*write_block_data)(struct i2c_client *client, u8 command,
+	s32 (*write_block_data)(const struct i2c_client *client, u8 command,
 				u8 length, const u8 *values);
 };
 
@@ -158,8 +158,8 @@ MODULE_DEVICE_TABLE(i2c, ds1307_id);
 
 #define BLOCK_DATA_MAX_TRIES 10
 
-static s32 ds1307_read_block_data_once(struct i2c_client *client, u8 command,
-				  u8 length, u8 *values)
+static s32 ds1307_read_block_data_once(const struct i2c_client *client,
+				       u8 command, u8 length, u8 *values)
 {
 	s32 i, data;
 
@@ -172,7 +172,7 @@ static s32 ds1307_read_block_data_once(s
 	return i;
 }
 
-static s32 ds1307_read_block_data(struct i2c_client *client, u8 command,
+static s32 ds1307_read_block_data(const struct i2c_client *client, u8 command,
 				  u8 length, u8 *values)
 {
 	u8 oldvalues[I2C_SMBUS_BLOCK_MAX];
@@ -198,7 +198,7 @@ static s32 ds1307_read_block_data(struct
 	return length;
 }
 
-static s32 ds1307_write_block_data(struct i2c_client *client, u8 command,
+static s32 ds1307_write_block_data(const struct i2c_client *client, u8 command,
 				   u8 length, const u8 *values)
 {
 	u8 currvalues[I2C_SMBUS_BLOCK_MAX];


-- 
Jean Delvare
