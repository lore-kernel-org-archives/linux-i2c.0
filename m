From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/2] libi2c: Propagate error codes
Date: Fri, 22 Jun 2012 16:59:02 +0200
Message-ID: <20120622165902.0d7f7673@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Properly propagate error codes.

---
 lib/smbus.c |  106 +++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 63 insertions(+), 43 deletions(-)

--- i2c-tools.orig/lib/smbus.c	2012-06-22 16:10:22.000000000 +0200
+++ i2c-tools/lib/smbus.c	2012-06-22 16:17:57.534645602 +0200
@@ -3,6 +3,7 @@
 
     Copyright (C) 1995-97 Simon G. Vogl
     Copyright (C) 1998-99 Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>
+    Copyright (C) 2012    Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -20,6 +21,7 @@
     MA 02110-1301 USA.
 */
 
+#include <errno.h>
 #include <i2c/smbus.h>
 #include <sys/ioctl.h>
 #include <linux/types.h>
@@ -38,12 +40,17 @@ __s32 i2c_smbus_access(int file, char re
 		       int size, union i2c_smbus_data *data)
 {
 	struct i2c_smbus_ioctl_data args;
+	__s32 err;
 
 	args.read_write = read_write;
 	args.command = command;
 	args.size = size;
 	args.data = data;
-	return ioctl(file, I2C_SMBUS, &args);
+
+	err = ioctl(file, I2C_SMBUS, &args);
+	if (err == -1)
+		err = -errno;
+	return err;
 }
 
 
@@ -55,10 +62,13 @@ __s32 i2c_smbus_write_quick(int file, __
 __s32 i2c_smbus_read_byte(int file)
 {
 	union i2c_smbus_data data;
-	if (i2c_smbus_access(file, I2C_SMBUS_READ, 0, I2C_SMBUS_BYTE, &data))
-		return -1;
-	else
-		return 0x0FF & data.byte;
+	int err;
+
+	err = i2c_smbus_access(file, I2C_SMBUS_READ, 0, I2C_SMBUS_BYTE, &data);
+	if (err < 0)
+		return err;
+
+	return 0x0FF & data.byte;
 }
 
 __s32 i2c_smbus_write_byte(int file, __u8 value)
@@ -70,11 +80,14 @@ __s32 i2c_smbus_write_byte(int file, __u
 __s32 i2c_smbus_read_byte_data(int file, __u8 command)
 {
 	union i2c_smbus_data data;
-	if (i2c_smbus_access(file, I2C_SMBUS_READ, command,
-			     I2C_SMBUS_BYTE_DATA, &data))
-		return -1;
-	else
-		return 0x0FF & data.byte;
+	int err;
+
+	err = i2c_smbus_access(file, I2C_SMBUS_READ, command,
+			       I2C_SMBUS_BYTE_DATA, &data);
+	if (err < 0)
+		return err;
+
+	return 0x0FF & data.byte;
 }
 
 __s32 i2c_smbus_write_byte_data(int file, __u8 command, __u8 value)
@@ -88,11 +101,14 @@ __s32 i2c_smbus_write_byte_data(int file
 __s32 i2c_smbus_read_word_data(int file, __u8 command)
 {
 	union i2c_smbus_data data;
-	if (i2c_smbus_access(file, I2C_SMBUS_READ, command,
-			     I2C_SMBUS_WORD_DATA, &data))
-		return -1;
-	else
-		return 0x0FFFF & data.word;
+	int err;
+
+	err = i2c_smbus_access(file, I2C_SMBUS_READ, command,
+			       I2C_SMBUS_WORD_DATA, &data);
+	if (err < 0)
+		return err;
+
+	return 0x0FFFF & data.word;
 }
 
 __s32 i2c_smbus_write_word_data(int file, __u8 command, __u16 value)
@@ -118,15 +134,16 @@ __s32 i2c_smbus_process_call(int file, _
 __s32 i2c_smbus_read_block_data(int file, __u8 command, __u8 *values)
 {
 	union i2c_smbus_data data;
-	int i;
-	if (i2c_smbus_access(file, I2C_SMBUS_READ, command,
-			     I2C_SMBUS_BLOCK_DATA, &data))
-		return -1;
-	else {
-		for (i = 1; i <= data.block[0]; i++)
-			values[i-1] = data.block[i];
-		return data.block[0];
-	}
+	int i, err;
+
+	err = i2c_smbus_access(file, I2C_SMBUS_READ, command,
+			       I2C_SMBUS_BLOCK_DATA, &data);
+	if (err < 0)
+		return err;
+
+	for (i = 1; i <= data.block[0]; i++)
+		values[i-1] = data.block[i];
+	return data.block[0];
 }
 
 __s32 i2c_smbus_write_block_data(int file, __u8 command, __u8 length,
@@ -151,20 +168,21 @@ __s32 i2c_smbus_read_i2c_block_data(int
 				    __u8 *values)
 {
 	union i2c_smbus_data data;
-	int i;
+	int i, err;
 
 	if (length > 32)
 		length = 32;
 	data.block[0] = length;
-	if (i2c_smbus_access(file, I2C_SMBUS_READ, command,
-			     length == 32 ? I2C_SMBUS_I2C_BLOCK_BROKEN :
-			      I2C_SMBUS_I2C_BLOCK_DATA, &data))
-		return -1;
-	else {
-		for (i = 1; i <= data.block[0]; i++)
-			values[i-1] = data.block[i];
-		return data.block[0];
-	}
+
+	err = i2c_smbus_access(file, I2C_SMBUS_READ, command,
+			       length == 32 ? I2C_SMBUS_I2C_BLOCK_BROKEN :
+				I2C_SMBUS_I2C_BLOCK_DATA, &data);
+	if (err < 0)
+		return err;
+
+	for (i = 1; i <= data.block[0]; i++)
+		values[i-1] = data.block[i];
+	return data.block[0];
 }
 
 __s32 i2c_smbus_write_i2c_block_data(int file, __u8 command, __u8 length,
@@ -186,18 +204,20 @@ __s32 i2c_smbus_block_process_call(int f
 				   __u8 *values)
 {
 	union i2c_smbus_data data;
-	int i;
+	int i, err;
+
 	if (length > 32)
 		length = 32;
 	for (i = 1; i <= length; i++)
 		data.block[i] = values[i-1];
 	data.block[0] = length;
-	if (i2c_smbus_access(file, I2C_SMBUS_WRITE, command,
-			     I2C_SMBUS_BLOCK_PROC_CALL, &data))
-		return -1;
-	else {
-		for (i = 1; i <= data.block[0]; i++)
-			values[i-1] = data.block[i];
-		return data.block[0];
-	}
+
+	err = i2c_smbus_access(file, I2C_SMBUS_WRITE, command,
+			       I2C_SMBUS_BLOCK_PROC_CALL, &data);
+	if (err < 0)
+		return err;
+
+	for (i = 1; i <= data.block[0]; i++)
+		values[i-1] = data.block[i];
+	return data.block[0];
 }


-- 
Jean Delvare
