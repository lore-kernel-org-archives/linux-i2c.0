From: Tushar Behera <tushar.behera-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] i2c-core: Remove definition of i2c_smbus_process_call
Date: Mon, 19 Nov 2012 16:31:42 +0530
Message-ID: <1353322902-3059-1-git-send-email-tushar.behera@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

i2c_smbus_process_call has no users in the kernel, so this can be
removed. Documentation for the same has been updated accordingly.

Fixes following sparse warning.
drivers/i2c/i2c-core.c:1871:5: warning: symbol 'i2c_smbus_process_call'
was not declared. Should it be static?

Signed-off-by: Tushar Behera <tushar.behera-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 Documentation/i2c/writing-clients |    4 ++--
 drivers/i2c/i2c-core.c            |   23 -----------------------
 2 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/Documentation/i2c/writing-clients b/Documentation/i2c/writing-clients
index 3a94b0e..51059f7 100644
--- a/Documentation/i2c/writing-clients
+++ b/Documentation/i2c/writing-clients
@@ -365,8 +365,6 @@ in terms of it. Never use this function directly!
 	s32 i2c_smbus_read_word_data(struct i2c_client *client, u8 command);
 	s32 i2c_smbus_write_word_data(struct i2c_client *client,
 				      u8 command, u16 value);
-	s32 i2c_smbus_process_call(struct i2c_client *client,
-				   u8 command, u16 value);
 	s32 i2c_smbus_read_block_data(struct i2c_client *client,
 				      u8 command, u8 *values);
 	s32 i2c_smbus_write_block_data(struct i2c_client *client,
@@ -383,6 +381,8 @@ be added back later if needed:
 	s32 i2c_smbus_write_quick(struct i2c_client *client, u8 value);
 	s32 i2c_smbus_block_process_call(struct i2c_client *client,
 					 u8 command, u8 length, u8 *values);
+	s32 i2c_smbus_process_call(struct i2c_client *client,
+				   u8 command, u16 value);
 
 All these transactions return a negative errno value on failure. The 'write'
 transactions return 0 on success; the 'read' transactions return the read
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index a7edf98..b4c4028 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1860,29 +1860,6 @@ s32 i2c_smbus_write_word_data(const struct i2c_client *client, u8 command,
 EXPORT_SYMBOL(i2c_smbus_write_word_data);
 
 /**
- * i2c_smbus_process_call - SMBus "process call" protocol
- * @client: Handle to slave device
- * @command: Byte interpreted by slave
- * @value: 16-bit "word" being written
- *
- * This executes the SMBus "process call" protocol, returning negative errno
- * else a 16-bit unsigned "word" received from the device.
- */
-s32 i2c_smbus_process_call(const struct i2c_client *client, u8 command,
-			   u16 value)
-{
-	union i2c_smbus_data data;
-	int status;
-	data.word = value;
-
-	status = i2c_smbus_xfer(client->adapter, client->addr, client->flags,
-				I2C_SMBUS_WRITE, command,
-				I2C_SMBUS_PROC_CALL, &data);
-	return (status < 0) ? status : data.word;
-}
-EXPORT_SYMBOL(i2c_smbus_process_call);
-
-/**
  * i2c_smbus_read_block_data - SMBus "block read" protocol
  * @client: Handle to slave device
  * @command: Byte interpreted by slave
-- 
1.7.4.1
