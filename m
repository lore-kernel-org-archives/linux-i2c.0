From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/2] i2c: Improve dev-interface documentation
Date: Sat, 6 Sep 2008 12:22:53 +0200
Message-ID: <20080906122253.72a41262@hyperion.delvare>
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

* Clarify some points.
* Point developers to i2c-tools instead of lm_sensors.
* Fix coding style in code examples.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 Documentation/i2c/dev-interface |   65 ++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 25 deletions(-)

--- linux-2.6.27-rc5.orig/Documentation/i2c/dev-interface	2008-09-06 12:19:20.000000000 +0200
+++ linux-2.6.27-rc5/Documentation/i2c/dev-interface	2008-09-06 12:19:47.000000000 +0200
@@ -4,6 +4,10 @@ the /dev interface. You need to load mod
 
 Each registered i2c adapter gets a number, counting from 0. You can
 examine /sys/class/i2c-dev/ to see what number corresponds to which adapter.
+Alternatively, you can run "i2cdetect -l" to obtain a formated list of all
+i2c adapters present on your system at a given time. i2cdetect is part of
+the i2c-tools package.
+
 I2C device files are character device files with major device number 89
 and a minor device number corresponding to the number assigned as 
 explained above. They should be called "i2c-%d" (i2c-0, i2c-1, ..., 
@@ -17,30 +21,34 @@ So let's say you want to access an i2c a
 first thing to do is "#include <linux/i2c-dev.h>". Please note that
 there are two files named "i2c-dev.h" out there, one is distributed
 with the Linux kernel and is meant to be included from kernel
-driver code, the other one is distributed with lm_sensors and is
+driver code, the other one is distributed with i2c-tools and is
 meant to be included from user-space programs. You obviously want
 the second one here.
 
 Now, you have to decide which adapter you want to access. You should
-inspect /sys/class/i2c-dev/ to decide this. Adapter numbers are assigned
-somewhat dynamically, so you can not even assume /dev/i2c-0 is the
-first adapter.
+inspect /sys/class/i2c-dev/ or run "i2cdetect -l" to decide this.
+Adapter numbers are assigned somewhat dynamically, so you can not
+assume much about them. They can even change from one boot to the next.
 
 Next thing, open the device file, as follows:
+
   int file;
   int adapter_nr = 2; /* probably dynamically determined */
   char filename[20];
   
-  sprintf(filename,"/dev/i2c-%d",adapter_nr);
-  if ((file = open(filename,O_RDWR)) < 0) {
+  snprintf(filename, 19, "/dev/i2c-%d", adapter_nr);
+  file = open(filename, O_RDWR);
+  if (file < 0) {
     /* ERROR HANDLING; you can check errno to see what went wrong */
     exit(1);
   }
 
 When you have opened the device, you must specify with what device
 address you want to communicate:
+
   int addr = 0x40; /* The I2C address */
-  if (ioctl(file,I2C_SLAVE,addr) < 0) {
+
+  if (ioctl(file, I2C_SLAVE, addr) < 0) {
     /* ERROR HANDLING; you can check errno to see what went wrong */
     exit(1);
   }
@@ -48,31 +56,41 @@ address you want to communicate:
 Well, you are all set up now. You can now use SMBus commands or plain
 I2C to communicate with your device. SMBus commands are preferred if
 the device supports them. Both are illustrated below.
+
   __u8 register = 0x10; /* Device register to access */
   __s32 res;
   char buf[10];
+
   /* Using SMBus commands */
-  res = i2c_smbus_read_word_data(file,register);
+  res = i2c_smbus_read_word_data(file, register);
   if (res < 0) {
     /* ERROR HANDLING: i2c transaction failed */
   } else {
     /* res contains the read word */
   }
+
   /* Using I2C Write, equivalent of 
-           i2c_smbus_write_word_data(file,register,0x6543) */
+     i2c_smbus_write_word_data(file, register, 0x6543) */
   buf[0] = register;
   buf[1] = 0x43;
   buf[2] = 0x65;
-  if ( write(file,buf,3) != 3) {
+  if (write(file, buf, 3) ! =3) {
     /* ERROR HANDLING: i2c transaction failed */
   }
+
   /* Using I2C Read, equivalent of i2c_smbus_read_byte(file) */
-  if (read(file,buf,1) != 1) {
+  if (read(file, buf, 1) != 1) {
     /* ERROR HANDLING: i2c transaction failed */
   } else {
     /* buf[0] contains the read byte */
   }
 
+Note that only a subset of the I2C and SMBus protocols can be achieved by
+the means of read() and write() calls. In particular, so-called combined
+transactions (mixing read and write messages in the same transaction)
+aren't supported. For this reason, this interface is almost never used by
+user-space programs.
+
 IMPORTANT: because of the use of inline functions, you *have* to use
 '-O' or some variation when you compile your program!
 
@@ -80,31 +98,29 @@ IMPORTANT: because of the use of inline 
 Full interface description
 ==========================
 
-The following IOCTLs are defined and fully supported 
-(see also i2c-dev.h):
+The following IOCTLs are defined:
 
-ioctl(file,I2C_SLAVE,long addr)
+ioctl(file, I2C_SLAVE, long addr)
   Change slave address. The address is passed in the 7 lower bits of the
   argument (except for 10 bit addresses, passed in the 10 lower bits in this
   case).
 
-ioctl(file,I2C_TENBIT,long select)
+ioctl(file, I2C_TENBIT, long select)
   Selects ten bit addresses if select not equals 0, selects normal 7 bit
   addresses if select equals 0. Default 0.  This request is only valid
   if the adapter has I2C_FUNC_10BIT_ADDR.
 
-ioctl(file,I2C_PEC,long select)
+ioctl(file, I2C_PEC, long select)
   Selects SMBus PEC (packet error checking) generation and verification
   if select not equals 0, disables if select equals 0. Default 0.
   Used only for SMBus transactions.  This request only has an effect if the
   the adapter has I2C_FUNC_SMBUS_PEC; it is still safe if not, it just
   doesn't have any effect.
 
-ioctl(file,I2C_FUNCS,unsigned long *funcs)
+ioctl(file, I2C_FUNCS, unsigned long *funcs)
   Gets the adapter functionality and puts it in *funcs.
 
-ioctl(file,I2C_RDWR,struct i2c_rdwr_ioctl_data *msgset)
-
+ioctl(file, I2C_RDWR, struct i2c_rdwr_ioctl_data *msgset)
   Do combined read/write transaction without stop in between.
   Only valid if the adapter has I2C_FUNC_I2C.  The argument is
   a pointer to a
@@ -120,10 +136,9 @@ ioctl(file,I2C_RDWR,struct i2c_rdwr_ioct
   The slave address and whether to use ten bit address mode has to be
   set in each message, overriding the values set with the above ioctl's.
 
-
-Other values are NOT supported at this moment, except for I2C_SMBUS,
-which you should never directly call; instead, use the access functions
-below.
+ioctl(file, I2C_SMBUS, struct i2c_smbus_ioctl_data *args)
+  Not meant to be called  directly; instead, use the access functions
+  below.
 
 You can do plain i2c transactions by using read(2) and write(2) calls.
 You do not need to pass the address byte; instead, set it through
@@ -148,7 +163,7 @@ what happened. The 'write' transactions 
 returns the number of values read. The block buffers need not be longer
 than 32 bytes.
 
-The above functions are all macros, that resolve to calls to the
-i2c_smbus_access function, that on its turn calls a specific ioctl
+The above functions are all inline functions, that resolve to calls to
+the i2c_smbus_access function, that on its turn calls a specific ioctl
 with the data in a specific format. Read the source code if you
 want to know what happens behind the screens.


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
