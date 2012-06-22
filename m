From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/2] libi2c: Use I2C_SMBUS_BLOCK_MAX
Date: Fri, 22 Jun 2012 16:59:39 +0200
Message-ID: <20120622165939.1cef58bb@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Use I2C_SMBUS_BLOCK_MAX instead of hardcoding 32.

---
 lib/smbus.c |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

--- i2c-tools.orig/lib/smbus.c	2012-06-22 16:09:54.426235336 +0200
+++ i2c-tools/lib/smbus.c	2012-06-22 16:10:18.169262240 +0200
@@ -151,8 +151,8 @@ __s32 i2c_smbus_write_block_data(int fil
 {
 	union i2c_smbus_data data;
 	int i;
-	if (length > 32)
-		length = 32;
+	if (length > I2C_SMBUS_BLOCK_MAX)
+		length = I2C_SMBUS_BLOCK_MAX;
 	for (i = 1; i <= length; i++)
 		data.block[i] = values[i-1];
 	data.block[0] = length;
@@ -161,21 +161,22 @@ __s32 i2c_smbus_write_block_data(int fil
 }
 
 /* Returns the number of read bytes */
-/* Until kernel 2.6.22, the length is hardcoded to 32 bytes. If you
-   ask for less than 32 bytes, your code will only work with kernels
-   2.6.23 and later. */
+/* Until kernel 2.6.22, the length is hardcoded to 32 bytes
+   (I2C_SMBUS_BLOCK_MAX.) If you ask for less than 32 bytes, your code
+   will only work with kernels 2.6.23 and later. */
 __s32 i2c_smbus_read_i2c_block_data(int file, __u8 command, __u8 length,
 				    __u8 *values)
 {
 	union i2c_smbus_data data;
 	int i, err;
 
-	if (length > 32)
-		length = 32;
+	if (length > I2C_SMBUS_BLOCK_MAX)
+		length = I2C_SMBUS_BLOCK_MAX;
 	data.block[0] = length;
 
 	err = i2c_smbus_access(file, I2C_SMBUS_READ, command,
-			       length == 32 ? I2C_SMBUS_I2C_BLOCK_BROKEN :
+			       length == I2C_SMBUS_BLOCK_MAX ?
+				I2C_SMBUS_I2C_BLOCK_BROKEN :
 				I2C_SMBUS_I2C_BLOCK_DATA, &data);
 	if (err < 0)
 		return err;
@@ -190,8 +191,8 @@ __s32 i2c_smbus_write_i2c_block_data(int
 {
 	union i2c_smbus_data data;
 	int i;
-	if (length > 32)
-		length = 32;
+	if (length > I2C_SMBUS_BLOCK_MAX)
+		length = I2C_SMBUS_BLOCK_MAX;
 	for (i = 1; i <= length; i++)
 		data.block[i] = values[i-1];
 	data.block[0] = length;
@@ -206,8 +207,8 @@ __s32 i2c_smbus_block_process_call(int f
 	union i2c_smbus_data data;
 	int i, err;
 
-	if (length > 32)
-		length = 32;
+	if (length > I2C_SMBUS_BLOCK_MAX)
+		length = I2C_SMBUS_BLOCK_MAX;
 	for (i = 1; i <= length; i++)
 		data.block[i] = values[i-1];
 	data.block[0] = length;


-- 
Jean Delvare
