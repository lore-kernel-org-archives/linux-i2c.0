From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Update and clean up writing-clients document
Date: Sun, 19 Oct 2008 13:54:46 +0200
Message-ID: <20081019135446.4afa8e1e@hyperion.delvare>
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

* Strip trailing white space.
* Remove out-of-date or irrelevant parts.
* Insist on the fact that command is deprecated.
* Fix spelling mistakes and typos.
* Reformat code examples and function prototypes to comply with the
  kernel coding style.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 Documentation/i2c/writing-clients |  238 ++++++++++++++++---------------------
 1 file changed, 103 insertions(+), 135 deletions(-)

--- linux-2.6.28-rc0.orig/Documentation/i2c/writing-clients	2008-10-19 12:45:45.000000000 +0200
+++ linux-2.6.28-rc0/Documentation/i2c/writing-clients	2008-10-19 13:19:09.000000000 +0200
@@ -10,17 +10,17 @@ General remarks
 ===============
 
 Try to keep the kernel namespace as clean as possible. The best way to
-do this is to use a unique prefix for all global symbols. This is 
+do this is to use a unique prefix for all global symbols. This is
 especially important for exported symbols, but it is a good idea to do
 it for non-exported symbols too. We will use the prefix `foo_' in this
-tutorial, and `FOO_' for preprocessor variables.
+tutorial.
 
 
 The driver structure
 ====================
 
 Usually, you will implement a single driver structure, and instantiate
-all clients from it. Remember, a driver structure contains general access 
+all clients from it. Remember, a driver structure contains general access
 routines, and should be zero-initialized except for fields with data you
 provide.  A client structure holds device-specific information like the
 driver model device node, and its I2C address.
@@ -49,16 +49,16 @@ static struct i2c_driver foo_driver = {
 	.shutdown	= foo_shutdown,	/* optional */
 	.suspend	= foo_suspend,	/* optional */
 	.resume		= foo_resume,	/* optional */
-	.command	= foo_command,	/* optional */
+	.command	= foo_command,	/* optional, deprecated */
 }
- 
+
 The name field is the driver name, and must not contain spaces.  It
 should match the module name (if the driver can be compiled as a module),
 although you can use MODULE_ALIAS (passing "foo" in this example) to add
 another name for the module.  If the driver name doesn't match the module
 name, the module won't be automatically loaded (hotplug/coldplug).
 
-All other fields are for call-back functions which will be explained 
+All other fields are for call-back functions which will be explained
 below.
 
 
@@ -66,10 +66,7 @@ Extra client data
 =================
 
 Each client structure has a special `data' field that can point to any
-structure at all.  You should use this to keep device-specific data,
-especially in drivers that handle multiple I2C or SMBUS devices.  You
-do not always need this, but especially for `sensors' drivers, it can
-be very useful.
+structure at all.  You should use this to keep device-specific data.
 
 	/* store the value */
 	void i2c_set_clientdata(struct i2c_client *client, void *data);
@@ -77,35 +74,15 @@ be very useful.
 	/* retrieve the value */
 	void *i2c_get_clientdata(const struct i2c_client *client);
 
-An example structure is below.
-
-  struct foo_data {
-    struct i2c_client *client;
-    enum chips type;       /* To keep the chips type for `sensors' drivers. */
-   
-    /* Because the i2c bus is slow, it is often useful to cache the read
-       information of a chip for some time (for example, 1 or 2 seconds).
-       It depends of course on the device whether this is really worthwhile
-       or even sensible. */
-    struct mutex update_lock;     /* When we are reading lots of information,
-                                     another process should not update the
-                                     below information */
-    char valid;                   /* != 0 if the following fields are valid. */
-    unsigned long last_updated;   /* In jiffies */
-    /* Add the read information here too */
-  };
-
 
 Accessing the client
 ====================
 
 Let's say we have a valid client structure. At some time, we will need
 to gather information from the client, or write new information to the
-client. How we will export this information to user-space is less 
-important at this moment (perhaps we do not need to do this at all for
-some obscure clients). But we need generic reading and writing routines.
+client.
 
-I have found it useful to define foo_read and foo_write function for this.
+I have found it useful to define foo_read and foo_write functions for this.
 For some cases, it will be easier to call the i2c functions directly,
 but many chips have some kind of register-value idea that can easily
 be encapsulated.
@@ -113,23 +90,23 @@ be encapsulated.
 The below functions are simple examples, and should not be copied
 literally.
 
-  int foo_read_value(struct i2c_client *client, u8 reg)
-  {
-    if (reg < 0x10) /* byte-sized register */
-      return i2c_smbus_read_byte_data(client,reg);
-    else /* word-sized register */
-      return i2c_smbus_read_word_data(client,reg);
-  }
-
-  int foo_write_value(struct i2c_client *client, u8 reg, u16 value)
-  {
-    if (reg == 0x10) /* Impossible to write - driver error! */ {
-      return -1;
-    else if (reg < 0x10) /* byte-sized register */
-      return i2c_smbus_write_byte_data(client,reg,value);
-    else /* word-sized register */
-      return i2c_smbus_write_word_data(client,reg,value);
-  }
+int foo_read_value(struct i2c_client *client, u8 reg)
+{
+	if (reg < 0x10)	/* byte-sized register */
+		return i2c_smbus_read_byte_data(client, reg);
+	else		/* word-sized register */
+		return i2c_smbus_read_word_data(client, reg);
+}
+
+int foo_write_value(struct i2c_client *client, u8 reg, u16 value)
+{
+	if (reg == 0x10)	/* Impossible to write - driver error! */
+		return -EINVAL;
+	else if (reg < 0x10)	/* byte-sized register */
+		return i2c_smbus_write_byte_data(client, reg, value);
+	else			/* word-sized register */
+		return i2c_smbus_write_word_data(client, reg, value);
+}
 
 
 Probing and attaching
@@ -251,42 +228,37 @@ called automatically before the underlyi
 device can't survive its parent in the device driver model.
 
 
-Initializing the module or kernel
-=================================
+Initializing the driver
+=======================
 
-When the kernel is booted, or when your foo driver module is inserted, 
-you have to do some initializing. Fortunately, just attaching (registering)
-the driver module is usually enough.
-
-  static int __init foo_init(void)
-  {
-    int res;
-    
-    if ((res = i2c_add_driver(&foo_driver))) {
-      printk("foo: Driver registration failed, module not inserted.\n");
-      return res;
-    }
-    return 0;
-  }
-
-  static void __exit foo_cleanup(void)
-  {
-    i2c_del_driver(&foo_driver);
-  }
-
-  /* Substitute your own name and email address */
-  MODULE_AUTHOR("Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>"
-  MODULE_DESCRIPTION("Driver for Barf Inc. Foo I2C devices");
-
-  /* a few non-GPL license types are also allowed */
-  MODULE_LICENSE("GPL");
-
-  module_init(foo_init);
-  module_exit(foo_cleanup);
-
-Note that some functions are marked by `__init', and some data structures
-by `__initdata'.  These functions and structures can be removed after
-kernel booting (or module loading) is completed.
+When the kernel is booted, or when your foo driver module is inserted,
+you have to do some initializing. Fortunately, just registering the
+driver module is usually enough.
+
+static int __init foo_init(void)
+{
+	return i2c_add_driver(&foo_driver);
+}
+
+static void __exit foo_cleanup(void)
+{
+	i2c_del_driver(&foo_driver);
+}
+
+/* Substitute your own name and email address */
+MODULE_AUTHOR("Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>"
+MODULE_DESCRIPTION("Driver for Barf Inc. Foo I2C devices");
+
+/* a few non-GPL license types are also allowed */
+MODULE_LICENSE("GPL");
+
+module_init(foo_init);
+module_exit(foo_cleanup);
+
+Note that some functions are marked by `__init'.  These functions can
+be removed after kernel booting (or module loading) is completed.
+Likewise, functions marked by `__exit' are dropped by the compiler when
+the code is built into the kernel, as they would never be called.
 
 
 Power Management
@@ -321,33 +293,35 @@ Command function
 
 A generic ioctl-like function call back is supported. You will seldom
 need this, and its use is deprecated anyway, so newer design should not
-use it. Set it to NULL.
+use it.
 
 
 Sending and receiving
 =====================
 
 If you want to communicate with your device, there are several functions
-to do this. You can find all of them in i2c.h.
+to do this. You can find all of them in <linux/i2c.h>.
 
-If you can choose between plain i2c communication and SMBus level
-communication, please use the last. All adapters understand SMBus level
-commands, but only some of them understand plain i2c!
+If you can choose between plain I2C communication and SMBus level
+communication, please use the latter. All adapters understand SMBus level
+commands, but only some of them understand plain I2C!
 
 
-Plain i2c communication
+Plain I2C communication
 -----------------------
 
-  extern int i2c_master_send(struct i2c_client *,const char* ,int);
-  extern int i2c_master_recv(struct i2c_client *,char* ,int);
+	int i2c_master_send(struct i2c_client *client, const char *buf,
+			    int count);
+	int i2c_master_recv(struct i2c_client *client, char *buf, int count);
 
 These routines read and write some bytes from/to a client. The client
 contains the i2c address, so you do not have to include it. The second
-parameter contains the bytes the read/write, the third the length of the
-buffer. Returned is the actual number of bytes read/written.
-  
-  extern int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msg,
-                          int num);
+parameter contains the bytes to read/write, the third the number of bytes
+to read/write (must be less than the length of the buffer.) Returned is
+the actual number of bytes read/written.
+
+	int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msg,
+			 int num);
 
 This sends a series of messages. Each message can be a read or write,
 and they can be mixed in any way. The transactions are combined: no
@@ -356,49 +330,45 @@ for each message the client address, the
 and the message data itself.
 
 You can read the file `i2c-protocol' for more information about the
-actual i2c protocol.
+actual I2C protocol.
 
 
 SMBus communication
 -------------------
 
-  extern s32 i2c_smbus_xfer (struct i2c_adapter * adapter, u16 addr, 
-                             unsigned short flags,
-                             char read_write, u8 command, int size,
-                             union i2c_smbus_data * data);
-
-  This is the generic SMBus function. All functions below are implemented
-  in terms of it. Never use this function directly!
-
-
-  extern s32 i2c_smbus_read_byte(struct i2c_client * client);
-  extern s32 i2c_smbus_write_byte(struct i2c_client * client, u8 value);
-  extern s32 i2c_smbus_read_byte_data(struct i2c_client * client, u8 command);
-  extern s32 i2c_smbus_write_byte_data(struct i2c_client * client,
-                                       u8 command, u8 value);
-  extern s32 i2c_smbus_read_word_data(struct i2c_client * client, u8 command);
-  extern s32 i2c_smbus_write_word_data(struct i2c_client * client,
-                                       u8 command, u16 value);
-  extern s32 i2c_smbus_process_call(struct i2c_client *client,
-                                    u8 command, u16 value);
-  extern s32 i2c_smbus_read_block_data(struct i2c_client * client,
-                                       u8 command, u8 *values);
-  extern s32 i2c_smbus_write_block_data(struct i2c_client * client,
-                                        u8 command, u8 length,
-                                        u8 *values);
-  extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client * client,
-                                           u8 command, u8 length, u8 *values);
-  extern s32 i2c_smbus_write_i2c_block_data(struct i2c_client * client,
-                                            u8 command, u8 length,
-                                            u8 *values);
+	s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
+			   unsigned short flags, char read_write, u8 command,
+			   int size, union i2c_smbus_data *data);
+
+This is the generic SMBus function. All functions below are implemented
+in terms of it. Never use this function directly!
+
+	s32 i2c_smbus_read_byte(struct i2c_client *client);
+	s32 i2c_smbus_write_byte(struct i2c_client *client, u8 value);
+	s32 i2c_smbus_read_byte_data(struct i2c_client *client, u8 command);
+	s32 i2c_smbus_write_byte_data(struct i2c_client *client,
+				      u8 command, u8 value);
+	s32 i2c_smbus_read_word_data(struct i2c_client *client, u8 command);
+	s32 i2c_smbus_write_word_data(struct i2c_client *client,
+				      u8 command, u16 value);
+	s32 i2c_smbus_process_call(struct i2c_client *client,
+				   u8 command, u16 value);
+	s32 i2c_smbus_read_block_data(struct i2c_client *client,
+				      u8 command, u8 *values);
+	s32 i2c_smbus_write_block_data(struct i2c_client *client,
+				       u8 command, u8 length, const u8 *values);
+	s32 i2c_smbus_read_i2c_block_data(struct i2c_client *client,
+					  u8 command, u8 length, u8 *values);
+	s32 i2c_smbus_write_i2c_block_data(struct i2c_client *client,
+					   u8 command, u8 length,
+					   const u8 *values);
 
 These ones were removed from i2c-core because they had no users, but could
 be added back later if needed:
 
-  extern s32 i2c_smbus_write_quick(struct i2c_client * client, u8 value);
-  extern s32 i2c_smbus_block_process_call(struct i2c_client *client,
-                                          u8 command, u8 length,
-                                          u8 *values)
+	s32 i2c_smbus_write_quick(struct i2c_client *client, u8 value);
+	s32 i2c_smbus_block_process_call(struct i2c_client *client,
+					 u8 command, u8 length, u8 *values);
 
 All these transactions return a negative errno value on failure. The 'write'
 transactions return 0 on success; the 'read' transactions return the read
@@ -415,7 +385,5 @@ General purpose routines
 Below all general purpose routines are listed, that were not mentioned
 before.
 
-  /* This call returns a unique low identifier for each registered adapter.
-   */
-  extern int i2c_adapter_id(struct i2c_adapter *adap);
-
+	/* Return the adapter number for a specific adapter */
+	int i2c_adapter_id(struct i2c_adapter *adap);


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
