From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Clean up <linux/i2c.h>
Date: Sun, 19 Oct 2008 14:07:56 +0200
Message-ID: <20081019140756.188fe97a@hyperion.delvare>
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
List-Id: linux-i2c@vger.kernel.org

Fix most checkpatch.pl errors and warnings. This includes replacing
spaces with tabs in many places, adding and removing spaces, and
folding long lines.

Also complete a couple prototypes to make it clearer what the
parameters represent.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 include/linux/i2c.h |  149 +++++++++++++++++++++++++--------------------------
 1 file changed, 75 insertions(+), 74 deletions(-)

--- linux-2.6.28-rc0.orig/include/linux/i2c.h	2008-10-19 13:53:30.000000000 +0200
+++ linux-2.6.28-rc0/include/linux/i2c.h	2008-10-19 13:55:21.000000000 +0200
@@ -53,45 +53,44 @@ struct i2c_board_info;
  * transmit one message at a time, a more complex version can be used to
  * transmit an arbitrary number of messages without interruption.
  */
-extern int i2c_master_send(struct i2c_client *,const char* ,int);
-extern int i2c_master_recv(struct i2c_client *,char* ,int);
+extern int i2c_master_send(struct i2c_client *client, const char *buf,
+			   int count);
+extern int i2c_master_recv(struct i2c_client *client, char *buf, int count);
 
 /* Transfer num messages.
  */
-extern int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num);
-
+extern int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
+			int num);
 
 /* This is the very generalized SMBus access routine. You probably do not
    want to use this, though; one of the functions below may be much easier,
    and probably just as fast.
    Note that we use i2c_adapter here, because you do not need a specific
    smbus adapter to call this function. */
-extern s32 i2c_smbus_xfer (struct i2c_adapter * adapter, u16 addr,
-                           unsigned short flags,
-                           char read_write, u8 command, int size,
-                           union i2c_smbus_data * data);
+extern s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
+			  unsigned short flags, char read_write, u8 command,
+			  int size, union i2c_smbus_data *data);
 
 /* Now follow the 'nice' access routines. These also document the calling
    conventions of i2c_smbus_xfer. */
 
-extern s32 i2c_smbus_read_byte(struct i2c_client * client);
-extern s32 i2c_smbus_write_byte(struct i2c_client * client, u8 value);
-extern s32 i2c_smbus_read_byte_data(struct i2c_client * client, u8 command);
-extern s32 i2c_smbus_write_byte_data(struct i2c_client * client,
-                                     u8 command, u8 value);
-extern s32 i2c_smbus_read_word_data(struct i2c_client * client, u8 command);
-extern s32 i2c_smbus_write_word_data(struct i2c_client * client,
-                                     u8 command, u16 value);
+extern s32 i2c_smbus_read_byte(struct i2c_client *client);
+extern s32 i2c_smbus_write_byte(struct i2c_client *client, u8 value);
+extern s32 i2c_smbus_read_byte_data(struct i2c_client *client, u8 command);
+extern s32 i2c_smbus_write_byte_data(struct i2c_client *client,
+				     u8 command, u8 value);
+extern s32 i2c_smbus_read_word_data(struct i2c_client *client, u8 command);
+extern s32 i2c_smbus_write_word_data(struct i2c_client *client,
+				     u8 command, u16 value);
 /* Returns the number of read bytes */
 extern s32 i2c_smbus_read_block_data(struct i2c_client *client,
 				     u8 command, u8 *values);
-extern s32 i2c_smbus_write_block_data(struct i2c_client * client,
-				      u8 command, u8 length,
-				      const u8 *values);
+extern s32 i2c_smbus_write_block_data(struct i2c_client *client,
+				      u8 command, u8 length, const u8 *values);
 /* Returns the number of read bytes */
-extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client * client,
+extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client *client,
 					 u8 command, u8 length, u8 *values);
-extern s32 i2c_smbus_write_i2c_block_data(struct i2c_client * client,
+extern s32 i2c_smbus_write_i2c_block_data(struct i2c_client *client,
 					  u8 command, u8 length,
 					  const u8 *values);
 
@@ -169,7 +168,7 @@ struct i2c_driver {
 	/* a ioctl like command that can be used to perform specific functions
 	 * with the device.
 	 */
-	int (*command)(struct i2c_client *client,unsigned int cmd, void *arg);
+	int (*command)(struct i2c_client *client, unsigned int cmd, void *arg);
 
 	struct device_driver driver;
 	const struct i2c_device_id *id_table;
@@ -226,12 +225,12 @@ static inline struct i2c_client *kobj_to
 
 static inline void *i2c_get_clientdata(const struct i2c_client *dev)
 {
-	return dev_get_drvdata (&dev->dev);
+	return dev_get_drvdata(&dev->dev);
 }
 
-static inline void i2c_set_clientdata (struct i2c_client *dev, void *data)
+static inline void i2c_set_clientdata(struct i2c_client *dev, void *data)
 {
-	dev_set_drvdata (&dev->dev, data);
+	dev_set_drvdata(&dev->dev, data);
 }
 
 /**
@@ -272,7 +271,7 @@ struct i2c_board_info {
  * fields (such as associated irq, or device-specific platform_data)
  * are provided using conventional syntax.
  */
-#define I2C_BOARD_INFO(dev_type,dev_addr) \
+#define I2C_BOARD_INFO(dev_type, dev_addr) \
 	.type = (dev_type), .addr = (dev_addr)
 
 
@@ -306,10 +305,12 @@ extern void i2c_unregister_device(struct
  */
 #ifdef CONFIG_I2C_BOARDINFO
 extern int
-i2c_register_board_info(int busnum, struct i2c_board_info const *info, unsigned n);
+i2c_register_board_info(int busnum, struct i2c_board_info const *info,
+			unsigned n);
 #else
 static inline int
-i2c_register_board_info(int busnum, struct i2c_board_info const *info, unsigned n)
+i2c_register_board_info(int busnum, struct i2c_board_info const *info,
+			unsigned n)
 {
 	return 0;
 }
@@ -328,11 +329,11 @@ struct i2c_algorithm {
 	   using common I2C messages */
 	/* master_xfer should return the number of messages successfully
 	   processed, or a negative value on error */
-	int (*master_xfer)(struct i2c_adapter *adap,struct i2c_msg *msgs,
-	                   int num);
+	int (*master_xfer)(struct i2c_adapter *adap, struct i2c_msg *msgs,
+			   int num);
 	int (*smbus_xfer) (struct i2c_adapter *adap, u16 addr,
-	                   unsigned short flags, char read_write,
-	                   u8 command, int size, union i2c_smbus_data * data);
+			   unsigned short flags, char read_write,
+			   u8 command, int size, union i2c_smbus_data *data);
 
 	/* To determine what the adapter supports */
 	u32 (*functionality) (struct i2c_adapter *);
@@ -371,12 +372,12 @@ struct i2c_adapter {
 
 static inline void *i2c_get_adapdata(const struct i2c_adapter *dev)
 {
-	return dev_get_drvdata (&dev->dev);
+	return dev_get_drvdata(&dev->dev);
 }
 
-static inline void i2c_set_adapdata (struct i2c_adapter *dev, void *data)
+static inline void i2c_set_adapdata(struct i2c_adapter *dev, void *data)
 {
-	dev_set_drvdata (&dev->dev, data);
+	dev_set_drvdata(&dev->dev, data);
 }
 
 /*flags for the client struct: */
@@ -449,7 +450,7 @@ extern int i2c_probe(struct i2c_adapter
 		const struct i2c_client_address_data *address_data,
 		int (*found_proc) (struct i2c_adapter *, int, int));
 
-extern struct i2c_adapter* i2c_get_adapter(int id);
+extern struct i2c_adapter *i2c_get_adapter(int id);
 extern void i2c_put_adapter(struct i2c_adapter *adap);
 
 
@@ -465,7 +466,7 @@ static inline int i2c_check_functionalit
 	return (func & i2c_get_functionality(adap)) == func;
 }
 
-/* Return id number for a specific adapter */
+/* Return the adapter number for a specific adapter */
 static inline int i2c_adapter_id(struct i2c_adapter *adap)
 {
 	return adap->nr;
@@ -526,7 +527,7 @@ struct i2c_msg {
 
 #define I2C_FUNC_I2C			0x00000001
 #define I2C_FUNC_10BIT_ADDR		0x00000002
-#define I2C_FUNC_PROTOCOL_MANGLING	0x00000004 /* I2C_M_{REV_DIR_ADDR,NOSTART,..} */
+#define I2C_FUNC_PROTOCOL_MANGLING	0x00000004 /* I2C_M_NOSTART etc. */
 #define I2C_FUNC_SMBUS_PEC		0x00000008
 #define I2C_FUNC_SMBUS_BLOCK_PROC_CALL	0x00008000 /* SMBus 2.0 */
 #define I2C_FUNC_SMBUS_QUICK		0x00010000
@@ -542,25 +543,25 @@ struct i2c_msg {
 #define I2C_FUNC_SMBUS_READ_I2C_BLOCK	0x04000000 /* I2C-like block xfer  */
 #define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK	0x08000000 /* w/ 1-byte reg. addr. */
 
-#define I2C_FUNC_SMBUS_BYTE (I2C_FUNC_SMBUS_READ_BYTE | \
-                             I2C_FUNC_SMBUS_WRITE_BYTE)
-#define I2C_FUNC_SMBUS_BYTE_DATA (I2C_FUNC_SMBUS_READ_BYTE_DATA | \
-                                  I2C_FUNC_SMBUS_WRITE_BYTE_DATA)
-#define I2C_FUNC_SMBUS_WORD_DATA (I2C_FUNC_SMBUS_READ_WORD_DATA | \
-                                  I2C_FUNC_SMBUS_WRITE_WORD_DATA)
-#define I2C_FUNC_SMBUS_BLOCK_DATA (I2C_FUNC_SMBUS_READ_BLOCK_DATA | \
-                                   I2C_FUNC_SMBUS_WRITE_BLOCK_DATA)
-#define I2C_FUNC_SMBUS_I2C_BLOCK (I2C_FUNC_SMBUS_READ_I2C_BLOCK | \
-                                  I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)
-
-#define I2C_FUNC_SMBUS_EMUL (I2C_FUNC_SMBUS_QUICK | \
-                             I2C_FUNC_SMBUS_BYTE | \
-                             I2C_FUNC_SMBUS_BYTE_DATA | \
-                             I2C_FUNC_SMBUS_WORD_DATA | \
-                             I2C_FUNC_SMBUS_PROC_CALL | \
-                             I2C_FUNC_SMBUS_WRITE_BLOCK_DATA | \
-			     I2C_FUNC_SMBUS_I2C_BLOCK | \
-			     I2C_FUNC_SMBUS_PEC)
+#define I2C_FUNC_SMBUS_BYTE		(I2C_FUNC_SMBUS_READ_BYTE | \
+					 I2C_FUNC_SMBUS_WRITE_BYTE)
+#define I2C_FUNC_SMBUS_BYTE_DATA	(I2C_FUNC_SMBUS_READ_BYTE_DATA | \
+					 I2C_FUNC_SMBUS_WRITE_BYTE_DATA)
+#define I2C_FUNC_SMBUS_WORD_DATA	(I2C_FUNC_SMBUS_READ_WORD_DATA | \
+					 I2C_FUNC_SMBUS_WRITE_WORD_DATA)
+#define I2C_FUNC_SMBUS_BLOCK_DATA	(I2C_FUNC_SMBUS_READ_BLOCK_DATA | \
+					 I2C_FUNC_SMBUS_WRITE_BLOCK_DATA)
+#define I2C_FUNC_SMBUS_I2C_BLOCK	(I2C_FUNC_SMBUS_READ_I2C_BLOCK | \
+					 I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)
+
+#define I2C_FUNC_SMBUS_EMUL		(I2C_FUNC_SMBUS_QUICK | \
+					 I2C_FUNC_SMBUS_BYTE | \
+					 I2C_FUNC_SMBUS_BYTE_DATA | \
+					 I2C_FUNC_SMBUS_WORD_DATA | \
+					 I2C_FUNC_SMBUS_PROC_CALL | \
+					 I2C_FUNC_SMBUS_WRITE_BLOCK_DATA | \
+					 I2C_FUNC_SMBUS_I2C_BLOCK | \
+					 I2C_FUNC_SMBUS_PEC)
 
 /*
  * Data for SMBus Messages
@@ -570,7 +571,7 @@ union i2c_smbus_data {
 	__u8 byte;
 	__u16 word;
 	__u8 block[I2C_SMBUS_BLOCK_MAX + 2]; /* block[0] is used for length */
-	                       /* and one more for user-space compatibility */
+			       /* and one more for user-space compatibility */
 };
 
 /* i2c_smbus_xfer read or write markers */
@@ -598,21 +599,21 @@ union i2c_smbus_data {
 
 /* Default fill of many variables */
 #define I2C_CLIENT_DEFAULTS {I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
-                          I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
-                          I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
-                          I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
-                          I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
-                          I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
-                          I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
-                          I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
-                          I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
-                          I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
-                          I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
-                          I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
-                          I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
-                          I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
-                          I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
-                          I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END}
+			     I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
+			     I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
+			     I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
+			     I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
+			     I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
+			     I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
+			     I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
+			     I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
+			     I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
+			     I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
+			     I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
+			     I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
+			     I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
+			     I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
+			     I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END}
 
 /* I2C_CLIENT_MODULE_PARM creates a module parameter, and puts it in the
    module header */
@@ -621,7 +622,7 @@ union i2c_smbus_data {
   static unsigned short var[I2C_CLIENT_MAX_OPTS] = I2C_CLIENT_DEFAULTS; \
   static unsigned int var##_num; \
   module_param_array(var, short, &var##_num, 0); \
-  MODULE_PARM_DESC(var,desc)
+  MODULE_PARM_DESC(var, desc)
 
 #define I2C_CLIENT_MODULE_PARM_FORCE(name)				\
 I2C_CLIENT_MODULE_PARM(force_##name,					\


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
