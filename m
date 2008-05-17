From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Delete unused function i2c_smbus_write_quick
Date: Sat, 17 May 2008 17:51:00 +0200
Message-ID: <20080517175100.5bf2ee05@hyperion.delvare>
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
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Function i2c_smbus_write_quick has no users left, so we can delete it.

Also update the list of these helper functions which are gone but
could be added back if needed.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 Documentation/i2c/smbus-protocol  |    4 ++--
 Documentation/i2c/writing-clients |   14 +++++++-------
 drivers/i2c/i2c-core.c            |    7 -------
 include/linux/i2c.h               |    1 -
 4 files changed, 9 insertions(+), 17 deletions(-)

--- linux-2.6.26-rc2.orig/Documentation/i2c/smbus-protocol	2008-05-12 08:22:03.000000000 +0200
+++ linux-2.6.26-rc2/Documentation/i2c/smbus-protocol	2008-05-17 17:02:07.000000000 +0200
@@ -42,8 +42,8 @@ Count (8 bits): A data byte containing t
 [..]: Data sent by I2C device, as opposed to data sent by the host adapter.
 
 
-SMBus Quick Command:  i2c_smbus_write_quick()
-=============================================
+SMBus Quick Command
+===================
 
 This sends a single bit to the device, at the place of the Rd/Wr bit.
 
--- linux-2.6.26-rc2.orig/Documentation/i2c/writing-clients	2008-05-04 09:49:36.000000000 +0200
+++ linux-2.6.26-rc2/Documentation/i2c/writing-clients	2008-05-17 17:37:24.000000000 +0200
@@ -559,7 +559,6 @@ SMBus communication
   in terms of it. Never use this function directly!
 
 
-  extern s32 i2c_smbus_write_quick(struct i2c_client * client, u8 value);
   extern s32 i2c_smbus_read_byte(struct i2c_client * client);
   extern s32 i2c_smbus_write_byte(struct i2c_client * client, u8 value);
   extern s32 i2c_smbus_read_byte_data(struct i2c_client * client, u8 command);
@@ -568,20 +567,21 @@ SMBus communication
   extern s32 i2c_smbus_read_word_data(struct i2c_client * client, u8 command);
   extern s32 i2c_smbus_write_word_data(struct i2c_client * client,
                                        u8 command, u16 value);
+  extern s32 i2c_smbus_read_block_data(struct i2c_client * client,
+                                       u8 command, u8 *values);
   extern s32 i2c_smbus_write_block_data(struct i2c_client * client,
                                         u8 command, u8 length,
                                         u8 *values);
   extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client * client,
                                            u8 command, u8 length, u8 *values);
-
-These ones were removed in Linux 2.6.10 because they had no users, but could
-be added back later if needed:
-
-  extern s32 i2c_smbus_read_block_data(struct i2c_client * client,
-                                       u8 command, u8 *values);
   extern s32 i2c_smbus_write_i2c_block_data(struct i2c_client * client,
                                             u8 command, u8 length,
                                             u8 *values);
+
+These ones were removed from i2c-core because they had no users, but could
+be added back later if needed:
+
+  extern s32 i2c_smbus_write_quick(struct i2c_client * client, u8 value);
   extern s32 i2c_smbus_process_call(struct i2c_client * client,
                                     u8 command, u16 value);
   extern s32 i2c_smbus_block_process_call(struct i2c_client *client,
--- linux-2.6.26-rc2.orig/drivers/i2c/i2c-core.c	2008-05-17 16:54:32.000000000 +0200
+++ linux-2.6.26-rc2/drivers/i2c/i2c-core.c	2008-05-17 17:03:56.000000000 +0200
@@ -1299,13 +1299,6 @@ static int i2c_smbus_check_pec(u8 cpec, 
 	return 0;
 }
 
-s32 i2c_smbus_write_quick(struct i2c_client *client, u8 value)
-{
-	return i2c_smbus_xfer(client->adapter,client->addr,client->flags,
-	                      value,0,I2C_SMBUS_QUICK,NULL);
-}
-EXPORT_SYMBOL(i2c_smbus_write_quick);
-
 s32 i2c_smbus_read_byte(struct i2c_client *client)
 {
 	union i2c_smbus_data data;
--- linux-2.6.26-rc2.orig/include/linux/i2c.h	2008-05-15 15:14:18.000000000 +0200
+++ linux-2.6.26-rc2/include/linux/i2c.h	2008-05-17 17:12:04.000000000 +0200
@@ -71,7 +71,6 @@ extern s32 i2c_smbus_xfer (struct i2c_ad
 /* Now follow the 'nice' access routines. These also document the calling
    conventions of smbus_access. */
 
-extern s32 i2c_smbus_write_quick(struct i2c_client * client, u8 value);
 extern s32 i2c_smbus_read_byte(struct i2c_client * client);
 extern s32 i2c_smbus_write_byte(struct i2c_client * client, u8 value);
 extern s32 i2c_smbus_read_byte_data(struct i2c_client * client, u8 command);


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
