From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Improve the functionality documentation
Date: Sat, 10 May 2008 10:39:37 +0200
Message-ID: <20080510103937.1c74ca8c@hyperion.delvare>
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
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "Maciej W. Rozycki" <macro-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Attempt to make the documentation about the I2C/SMBus functionality
checking API clearer.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 Documentation/i2c/functionality |  101 +++++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 46 deletions(-)

--- linux-2.6.26-rc1.orig/Documentation/i2c/functionality	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6.26-rc1/Documentation/i2c/functionality	2008-05-10 10:22:44.000000000 +0200
@@ -51,26 +51,38 @@ A few combinations of the above flags ar
                                   the transparent emulation layer)
 
 
-ALGORITHM/ADAPTER IMPLEMENTATION
---------------------------------
+ADAPTER IMPLEMENTATION
+----------------------
 
-When you write a new algorithm driver, you will have to implement a
-function callback `functionality', that gets an i2c_adapter structure
-pointer as its only parameter:
+When you write a new adapter driver, you will have to implement a
+function callback `functionality'. Typical implementations are given
+below.
 
-  struct i2c_algorithm {
-	/* Many other things of course; check <linux/i2c.h>! */
-	u32 (*functionality) (struct i2c_adapter *);
+A typical SMBus-only adapter would list all the SMBus transactions it
+supports. This example comes from the i2c-piix4 driver:
+
+  static u32 piix4_func(struct i2c_adapter *adapter)
+  {
+	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
+	       I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
+	       I2C_FUNC_SMBUS_BLOCK_DATA;
   }
 
-A typically implementation is given below, from i2c-algo-bit.c:
+A typical full-I2C adapter would use the following (from the i2c-pxa
+driver):
 
-  static u32 bit_func(struct i2c_adapter *adap)
+  static u32 i2c_pxa_functionality(struct i2c_adapter *adap)
   {
-	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR | 
-	       I2C_FUNC_PROTOCOL_MANGLING;
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
   }
 
+I2C_FUNC_SMBUS_EMUL includes all the SMBus transactions (with the
+addition of I2C block transactions) which i2c-core can emulate using
+I2C_FUNC_I2C without any help from the adapter driver. The idea is
+to let the client drivers check for the support of SMBus functions
+without having to care whether the said functions are implemented in
+hardware by the adapter, or emulated in software by i2c-core on top
+of an I2C adapter.
 
 
 CLIENT CHECKING
@@ -78,36 +90,33 @@ CLIENT CHECKING
 
 Before a client tries to attach to an adapter, or even do tests to check
 whether one of the devices it supports is present on an adapter, it should
-check whether the needed functionality is present. There are two functions
-defined which should be used instead of calling the functionality hook
-in the algorithm structure directly:
-
-  /* Return the functionality mask */
-  extern u32 i2c_get_functionality (struct i2c_adapter *adap);
-
-  /* Return 1 if adapter supports everything we need, 0 if not. */
-  extern int i2c_check_functionality (struct i2c_adapter *adap, u32 func);
-
-This is a typical way to use these functions (from the writing-clients
-document):
-  int foo_detect_client(struct i2c_adapter *adapter, int address, 
-                          unsigned short flags, int kind)
-  {
-	/* Define needed variables */
-
-	/* As the very first action, we check whether the adapter has the
-	   needed functionality: we need the SMBus read_word_data,
-           write_word_data and write_byte functions in this example. */
-	if (!i2c_check_functionality(adapter,I2C_FUNC_SMBUS_WORD_DATA |
-	                                     I2C_FUNC_SMBUS_WRITE_BYTE))
-		goto ERROR0;
-
-	/* Now we can do the real detection */
-
-	ERROR0:
-		/* Return an error */
-  }
+check whether the needed functionality is present. The typical way to do
+this is (from the lm75 driver):
 
+  static int lm75_detect(...)
+  {
+	(...)
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_SMBUS_WORD_DATA))
+		goto exit;
+	(...)
+  }
+
+Here, the lm75 driver checks if the adapter can do both SMBus byte data
+and SMBus word data transactions. If not, then the driver won't work on
+this adapter and there's no point in going on. If the check above is
+successful, then the driver knows that it can call the following
+functions: i2c_smbus_read_byte_data(), i2c_smbus_write_byte_data(),
+i2c_smbus_read_word_data() and i2c_smbus_write_word_data(). As a rule of
+thumb, the functionality constants you test for with
+i2c_check_functionality() should match exactly the i2c_smbus_* functions
+which you driver is calling.
+
+Note that the check above doesn't tell whether the functionalities are
+implemented in hardware by the underlying adapter or emulated in
+software by i2c-core. Client drivers don't have to care about this, as
+i2c-core will transparently implement SMBus transactions on top of I2C
+adapters.
 
 
 CHECKING THROUGH /DEV
@@ -116,19 +125,19 @@ CHECKING THROUGH /DEV
 If you try to access an adapter from a userspace program, you will have
 to use the /dev interface. You will still have to check whether the
 functionality you need is supported, of course. This is done using
-the I2C_FUNCS ioctl. An example, adapted from the lm_sensors i2cdetect
-program, is below:
+the I2C_FUNCS ioctl. An example, adapted from the i2cdetect program, is
+below:
 
   int file;
-  if (file = open("/dev/i2c-0",O_RDWR) < 0) {
+  if (file = open("/dev/i2c-0", O_RDWR) < 0) {
 	/* Some kind of error handling */
 	exit(1);
   }
-  if (ioctl(file,I2C_FUNCS,&funcs) < 0) {
+  if (ioctl(file, I2C_FUNCS, &funcs) < 0) {
 	/* Some kind of error handling */
 	exit(1);
   }
-  if (! (funcs & I2C_FUNC_SMBUS_QUICK)) {
+  if (!(funcs & I2C_FUNC_SMBUS_QUICK)) {
 	/* Oops, the needed functionality (SMBus write_quick function) is
            not available! */
 	exit(1);


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
