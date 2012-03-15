From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/2] Split i2c-dev.h into parts
Date: Thu, 15 Mar 2012 17:00:43 +0100
Message-ID: <20120315170043.0cf69005@endymion.delvare>
References: <20120315165344.5f8e060f@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120315165344.5f8e060f-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Properly split i2c-dev.h into parts:
* The i2c_smbus_* inline functions go to a dedicated user-space header
  file for now (and later to a library.)
* The parts from the kernel's i2c.h go away, and applications will include
  <linux/i2c.h> explicitly from now on.
* The parts from the kernel's i2c-dev.h stay here. This is now an exact
  copy of the file generated from the kernel's i2c-dev.h, and will be
  dropped soon.

Adjust all tools accordingly. Third party applications will have to do the
same.
---
 eepromer/24cXX.c        |    3 
 eepromer/24cXX.h        |    2 
 eepromer/eeprom.c       |    2 
 eepromer/eepromer.c     |    2 
 include/Module.mk       |    4 
 include/i2c-dev/smbus.h |  212 ++++++++++++++++++++++++++++++++++++++
 include/linux/i2c-dev.h |  257 -----------------------------------------------
 py-smbus/Module.mk      |    2 
 py-smbus/smbusmodule.c  |    3 
 tools/Module.mk         |   12 +-
 tools/i2cbusses.c       |    4 
 tools/i2cdetect.c       |    4 
 tools/i2cdump.c         |    4 
 tools/i2cget.c          |    4 
 tools/i2cset.c          |    4 
 15 files changed, 247 insertions(+), 272 deletions(-)

--- i2c-tools.orig/eepromer/24cXX.c	2012-03-15 16:35:11.000000000 +0100
+++ i2c-tools/eepromer/24cXX.c	2012-03-15 16:35:22.362963310 +0100
@@ -18,11 +18,14 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <linux/fs.h>
+#include <linux/i2c.h>
+#include <linux/i2c-dev.h>
 #include <sys/types.h>
 #include <sys/ioctl.h>
 #include <errno.h>
 #include <assert.h>
 #include <string.h>
+#include <i2c-dev/smbus.h>
 #include "24cXX.h"
 
 static int i2c_write_1b(struct eeprom *e, __u8 buf)
--- i2c-tools.orig/eepromer/24cXX.h	2012-03-15 16:35:11.000000000 +0100
+++ i2c-tools/eepromer/24cXX.h	2012-03-15 16:35:22.362963310 +0100
@@ -15,7 +15,7 @@
  ***************************************************************************/
 #ifndef _24CXX_H_
 #define _24CXX_H_
-#include <linux/i2c-dev.h>
+#include <linux/types.h>
 
 #define EEPROM_TYPE_UNKNOWN	0
 #define EEPROM_TYPE_8BIT_ADDR	1
--- i2c-tools.orig/eepromer/eeprom.c	2012-03-15 16:35:11.000000000 +0100
+++ i2c-tools/eepromer/eeprom.c	2012-03-15 16:35:22.362963310 +0100
@@ -2,6 +2,7 @@
 This program is hereby placed into the public domain.
 Of course the program is provided without warranty of any kind.
 */
+#include <sys/ioctl.h>
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -9,6 +10,7 @@ Of course the program is provided withou
 #include <fcntl.h>
 #include <string.h>
 #include <time.h>
+#include <linux/i2c.h>
 #include <linux/i2c-dev.h>
 
 /*
--- i2c-tools.orig/eepromer/eepromer.c	2012-03-15 16:35:11.000000000 +0100
+++ i2c-tools/eepromer/eepromer.c	2012-03-15 16:35:22.362963310 +0100
@@ -1,3 +1,4 @@
+#include <sys/ioctl.h>
 #include <errno.h>                                                              
 #include <string.h>                                                             
 #include <stdio.h>                                                              
@@ -5,6 +6,7 @@
 #include <unistd.h>                                                             
 #include <fcntl.h>                                                              
 #include <time.h>
+#include <linux/i2c.h>
 #include <linux/i2c-dev.h>
 
 
--- i2c-tools.orig/include/Module.mk	2012-03-15 16:35:11.000000000 +0100
+++ i2c-tools/include/Module.mk	2012-03-15 16:35:22.365963310 +0100
@@ -1,6 +1,6 @@
 # Linux I2C header files
 #
-# Copyright (C) 2007  Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+# Copyright (C) 2007, 2012  Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
@@ -9,7 +9,7 @@
 
 INCLUDE_DIR	:= include
 
-INCLUDE_TARGETS	:= linux/i2c-dev.h
+INCLUDE_TARGETS	:= i2c-dev/smbus.h
 
 #
 # Commands
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ i2c-tools/include/i2c-dev/smbus.h	2012-03-15 16:57:01.569668742 +0100
@@ -0,0 +1,212 @@
+/*
+    smbus.h - SMBus level access helper functions
+
+    Copyright (C) 1995-97 Simon G. Vogl
+    Copyright (C) 1998-99 Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.
+*/
+
+#ifndef LIB_I2C_DEV_SMBUS_H
+#define LIB_I2C_DEV_SMBUS_H
+
+#include <sys/ioctl.h>
+#include <linux/types.h>
+#include <linux/i2c.h>
+#include <linux/i2c-dev.h>
+
+/* Compatibility defines */
+#ifndef I2C_SMBUS_I2C_BLOCK_BROKEN
+#define I2C_SMBUS_I2C_BLOCK_BROKEN I2C_SMBUS_I2C_BLOCK_DATA
+#endif
+#ifndef I2C_FUNC_SMBUS_PEC
+#define I2C_FUNC_SMBUS_PEC I2C_FUNC_SMBUS_HWPEC_CALC
+#endif
+
+static inline __s32 i2c_smbus_access(int file, char read_write, __u8 command,
+				     int size, union i2c_smbus_data *data)
+{
+	struct i2c_smbus_ioctl_data args;
+
+	args.read_write = read_write;
+	args.command = command;
+	args.size = size;
+	args.data = data;
+	return ioctl(file, I2C_SMBUS, &args);
+}
+
+
+static inline __s32 i2c_smbus_write_quick(int file, __u8 value)
+{
+	return i2c_smbus_access(file, value, 0, I2C_SMBUS_QUICK, NULL);
+}
+
+static inline __s32 i2c_smbus_read_byte(int file)
+{
+	union i2c_smbus_data data;
+	if (i2c_smbus_access(file, I2C_SMBUS_READ, 0, I2C_SMBUS_BYTE, &data))
+		return -1;
+	else
+		return 0x0FF & data.byte;
+}
+
+static inline __s32 i2c_smbus_write_byte(int file, __u8 value)
+{
+	return i2c_smbus_access(file, I2C_SMBUS_WRITE, value,
+				I2C_SMBUS_BYTE, NULL);
+}
+
+static inline __s32 i2c_smbus_read_byte_data(int file, __u8 command)
+{
+	union i2c_smbus_data data;
+	if (i2c_smbus_access(file, I2C_SMBUS_READ, command,
+			     I2C_SMBUS_BYTE_DATA, &data))
+		return -1;
+	else
+		return 0x0FF & data.byte;
+}
+
+static inline __s32 i2c_smbus_write_byte_data(int file, __u8 command,
+					      __u8 value)
+{
+	union i2c_smbus_data data;
+	data.byte = value;
+	return i2c_smbus_access(file, I2C_SMBUS_WRITE, command,
+				I2C_SMBUS_BYTE_DATA, &data);
+}
+
+static inline __s32 i2c_smbus_read_word_data(int file, __u8 command)
+{
+	union i2c_smbus_data data;
+	if (i2c_smbus_access(file, I2C_SMBUS_READ, command,
+			     I2C_SMBUS_WORD_DATA, &data))
+		return -1;
+	else
+		return 0x0FFFF & data.word;
+}
+
+static inline __s32 i2c_smbus_write_word_data(int file, __u8 command,
+					      __u16 value)
+{
+	union i2c_smbus_data data;
+	data.word = value;
+	return i2c_smbus_access(file, I2C_SMBUS_WRITE, command,
+				I2C_SMBUS_WORD_DATA, &data);
+}
+
+static inline __s32 i2c_smbus_process_call(int file, __u8 command, __u16 value)
+{
+	union i2c_smbus_data data;
+	data.word = value;
+	if (i2c_smbus_access(file, I2C_SMBUS_WRITE, command,
+			     I2C_SMBUS_PROC_CALL, &data))
+		return -1;
+	else
+		return 0x0FFFF & data.word;
+}
+
+
+/* Returns the number of read bytes */
+static inline __s32 i2c_smbus_read_block_data(int file, __u8 command,
+					      __u8 *values)
+{
+	union i2c_smbus_data data;
+	int i;
+	if (i2c_smbus_access(file, I2C_SMBUS_READ, command,
+			     I2C_SMBUS_BLOCK_DATA, &data))
+		return -1;
+	else {
+		for (i = 1; i <= data.block[0]; i++)
+			values[i-1] = data.block[i];
+		return data.block[0];
+	}
+}
+
+static inline __s32 i2c_smbus_write_block_data(int file, __u8 command,
+					       __u8 length, const __u8 *values)
+{
+	union i2c_smbus_data data;
+	int i;
+	if (length > 32)
+		length = 32;
+	for (i = 1; i <= length; i++)
+		data.block[i] = values[i-1];
+	data.block[0] = length;
+	return i2c_smbus_access(file, I2C_SMBUS_WRITE, command,
+				I2C_SMBUS_BLOCK_DATA, &data);
+}
+
+/* Returns the number of read bytes */
+/* Until kernel 2.6.22, the length is hardcoded to 32 bytes. If you
+   ask for less than 32 bytes, your code will only work with kernels
+   2.6.23 and later. */
+static inline __s32 i2c_smbus_read_i2c_block_data(int file, __u8 command,
+						  __u8 length, __u8 *values)
+{
+	union i2c_smbus_data data;
+	int i;
+
+	if (length > 32)
+		length = 32;
+	data.block[0] = length;
+	if (i2c_smbus_access(file, I2C_SMBUS_READ, command,
+			     length == 32 ? I2C_SMBUS_I2C_BLOCK_BROKEN :
+			      I2C_SMBUS_I2C_BLOCK_DATA, &data))
+		return -1;
+	else {
+		for (i = 1; i <= data.block[0]; i++)
+			values[i-1] = data.block[i];
+		return data.block[0];
+	}
+}
+
+static inline __s32 i2c_smbus_write_i2c_block_data(int file, __u8 command,
+						   __u8 length,
+						   const __u8 *values)
+{
+	union i2c_smbus_data data;
+	int i;
+	if (length > 32)
+		length = 32;
+	for (i = 1; i <= length; i++)
+		data.block[i] = values[i-1];
+	data.block[0] = length;
+	return i2c_smbus_access(file, I2C_SMBUS_WRITE, command,
+				I2C_SMBUS_I2C_BLOCK_BROKEN, &data);
+}
+
+/* Returns the number of read bytes */
+static inline __s32 i2c_smbus_block_process_call(int file, __u8 command,
+						 __u8 length, __u8 *values)
+{
+	union i2c_smbus_data data;
+	int i;
+	if (length > 32)
+		length = 32;
+	for (i = 1; i <= length; i++)
+		data.block[i] = values[i-1];
+	data.block[0] = length;
+	if (i2c_smbus_access(file, I2C_SMBUS_WRITE, command,
+			     I2C_SMBUS_BLOCK_PROC_CALL, &data))
+		return -1;
+	else {
+		for (i = 1; i <= data.block[0]; i++)
+			values[i-1] = data.block[i];
+		return data.block[0];
+	}
+}
+
+#endif /* LIB_I2C_DEV_SMBUS_H */
--- i2c-tools.orig/include/linux/i2c-dev.h	2012-03-15 16:35:11.000000000 +0100
+++ i2c-tools/include/linux/i2c-dev.h	2012-03-15 16:35:22.363963310 +0100
@@ -24,89 +24,6 @@
 #define _LINUX_I2C_DEV_H
 
 #include <linux/types.h>
-#include <sys/ioctl.h>
-
-
-/* -- i2c.h -- */
-
-
-/*
- * I2C Message - used for pure i2c transaction, also from /dev interface
- */
-struct i2c_msg {
-	__u16 addr;	/* slave address			*/
-	unsigned short flags;		
-#define I2C_M_TEN	0x10	/* we have a ten bit chip address	*/
-#define I2C_M_RD	0x01
-#define I2C_M_NOSTART	0x4000
-#define I2C_M_REV_DIR_ADDR	0x2000
-#define I2C_M_IGNORE_NAK	0x1000
-#define I2C_M_NO_RD_ACK		0x0800
-	short len;		/* msg length				*/
-	char *buf;		/* pointer to msg data			*/
-};
-
-/* To determine what functionality is present */
-
-#define I2C_FUNC_I2C			0x00000001
-#define I2C_FUNC_10BIT_ADDR		0x00000002
-#define I2C_FUNC_PROTOCOL_MANGLING	0x00000004 /* I2C_M_{REV_DIR_ADDR,NOSTART,..} */
-#define I2C_FUNC_SMBUS_PEC		0x00000008
-#define I2C_FUNC_SMBUS_BLOCK_PROC_CALL	0x00008000 /* SMBus 2.0 */
-#define I2C_FUNC_SMBUS_QUICK		0x00010000 
-#define I2C_FUNC_SMBUS_READ_BYTE	0x00020000 
-#define I2C_FUNC_SMBUS_WRITE_BYTE	0x00040000 
-#define I2C_FUNC_SMBUS_READ_BYTE_DATA	0x00080000 
-#define I2C_FUNC_SMBUS_WRITE_BYTE_DATA	0x00100000 
-#define I2C_FUNC_SMBUS_READ_WORD_DATA	0x00200000 
-#define I2C_FUNC_SMBUS_WRITE_WORD_DATA	0x00400000 
-#define I2C_FUNC_SMBUS_PROC_CALL	0x00800000 
-#define I2C_FUNC_SMBUS_READ_BLOCK_DATA	0x01000000 
-#define I2C_FUNC_SMBUS_WRITE_BLOCK_DATA 0x02000000 
-#define I2C_FUNC_SMBUS_READ_I2C_BLOCK	0x04000000 /* I2C-like block xfer  */
-#define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK	0x08000000 /* w/ 1-byte reg. addr. */
-
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
-/* Old name, for compatibility */
-#define I2C_FUNC_SMBUS_HWPEC_CALC	I2C_FUNC_SMBUS_PEC
-
-/* 
- * Data for SMBus Messages 
- */
-#define I2C_SMBUS_BLOCK_MAX	32	/* As specified in SMBus standard */	
-#define I2C_SMBUS_I2C_BLOCK_MAX	32	/* Not specified but we use same structure */
-union i2c_smbus_data {
-	__u8 byte;
-	__u16 word;
-	__u8 block[I2C_SMBUS_BLOCK_MAX + 2]; /* block[0] is used for length */
-	                                            /* and one more for PEC */
-};
-
-/* smbus_access read or write markers */
-#define I2C_SMBUS_READ	1
-#define I2C_SMBUS_WRITE	0
-
-/* SMBus transaction types (size parameter in the above functions) 
-   Note: these no longer correspond to the (arbitrary) PIIX4 internal codes! */
-#define I2C_SMBUS_QUICK		    0
-#define I2C_SMBUS_BYTE		    1
-#define I2C_SMBUS_BYTE_DATA	    2 
-#define I2C_SMBUS_WORD_DATA	    3
-#define I2C_SMBUS_PROC_CALL	    4
-#define I2C_SMBUS_BLOCK_DATA	    5
-#define I2C_SMBUS_I2C_BLOCK_BROKEN  6
-#define I2C_SMBUS_BLOCK_PROC_CALL   7		/* SMBus 2.0 */
-#define I2C_SMBUS_I2C_BLOCK_DATA    8
 
 
 /* /dev/i2c-X ioctl commands.  The ioctl's parameter is always an
@@ -152,178 +69,4 @@ struct i2c_rdwr_ioctl_data {
 #define  I2C_RDRW_IOCTL_MAX_MSGS	42
 
 
-static inline __s32 i2c_smbus_access(int file, char read_write, __u8 command, 
-                                     int size, union i2c_smbus_data *data)
-{
-	struct i2c_smbus_ioctl_data args;
-
-	args.read_write = read_write;
-	args.command = command;
-	args.size = size;
-	args.data = data;
-	return ioctl(file,I2C_SMBUS,&args);
-}
-
-
-static inline __s32 i2c_smbus_write_quick(int file, __u8 value)
-{
-	return i2c_smbus_access(file,value,0,I2C_SMBUS_QUICK,NULL);
-}
-	
-static inline __s32 i2c_smbus_read_byte(int file)
-{
-	union i2c_smbus_data data;
-	if (i2c_smbus_access(file,I2C_SMBUS_READ,0,I2C_SMBUS_BYTE,&data))
-		return -1;
-	else
-		return 0x0FF & data.byte;
-}
-
-static inline __s32 i2c_smbus_write_byte(int file, __u8 value)
-{
-	return i2c_smbus_access(file,I2C_SMBUS_WRITE,value,
-	                        I2C_SMBUS_BYTE,NULL);
-}
-
-static inline __s32 i2c_smbus_read_byte_data(int file, __u8 command)
-{
-	union i2c_smbus_data data;
-	if (i2c_smbus_access(file,I2C_SMBUS_READ,command,
-	                     I2C_SMBUS_BYTE_DATA,&data))
-		return -1;
-	else
-		return 0x0FF & data.byte;
-}
-
-static inline __s32 i2c_smbus_write_byte_data(int file, __u8 command, 
-                                              __u8 value)
-{
-	union i2c_smbus_data data;
-	data.byte = value;
-	return i2c_smbus_access(file,I2C_SMBUS_WRITE,command,
-	                        I2C_SMBUS_BYTE_DATA, &data);
-}
-
-static inline __s32 i2c_smbus_read_word_data(int file, __u8 command)
-{
-	union i2c_smbus_data data;
-	if (i2c_smbus_access(file,I2C_SMBUS_READ,command,
-	                     I2C_SMBUS_WORD_DATA,&data))
-		return -1;
-	else
-		return 0x0FFFF & data.word;
-}
-
-static inline __s32 i2c_smbus_write_word_data(int file, __u8 command, 
-                                              __u16 value)
-{
-	union i2c_smbus_data data;
-	data.word = value;
-	return i2c_smbus_access(file,I2C_SMBUS_WRITE,command,
-	                        I2C_SMBUS_WORD_DATA, &data);
-}
-
-static inline __s32 i2c_smbus_process_call(int file, __u8 command, __u16 value)
-{
-	union i2c_smbus_data data;
-	data.word = value;
-	if (i2c_smbus_access(file,I2C_SMBUS_WRITE,command,
-	                     I2C_SMBUS_PROC_CALL,&data))
-		return -1;
-	else
-		return 0x0FFFF & data.word;
-}
-
-
-/* Returns the number of read bytes */
-static inline __s32 i2c_smbus_read_block_data(int file, __u8 command, 
-                                              __u8 *values)
-{
-	union i2c_smbus_data data;
-	int i;
-	if (i2c_smbus_access(file,I2C_SMBUS_READ,command,
-	                     I2C_SMBUS_BLOCK_DATA,&data))
-		return -1;
-	else {
-		for (i = 1; i <= data.block[0]; i++)
-			values[i-1] = data.block[i];
-		return data.block[0];
-	}
-}
-
-static inline __s32 i2c_smbus_write_block_data(int file, __u8 command, 
-                                               __u8 length, const __u8 *values)
-{
-	union i2c_smbus_data data;
-	int i;
-	if (length > 32)
-		length = 32;
-	for (i = 1; i <= length; i++)
-		data.block[i] = values[i-1];
-	data.block[0] = length;
-	return i2c_smbus_access(file,I2C_SMBUS_WRITE,command,
-	                        I2C_SMBUS_BLOCK_DATA, &data);
-}
-
-/* Returns the number of read bytes */
-/* Until kernel 2.6.22, the length is hardcoded to 32 bytes. If you
-   ask for less than 32 bytes, your code will only work with kernels
-   2.6.23 and later. */
-static inline __s32 i2c_smbus_read_i2c_block_data(int file, __u8 command,
-                                                  __u8 length, __u8 *values)
-{
-	union i2c_smbus_data data;
-	int i;
-
-	if (length > 32)
-		length = 32;
-	data.block[0] = length;
-	if (i2c_smbus_access(file,I2C_SMBUS_READ,command,
-	                     length == 32 ? I2C_SMBUS_I2C_BLOCK_BROKEN :
-	                      I2C_SMBUS_I2C_BLOCK_DATA,&data))
-		return -1;
-	else {
-		for (i = 1; i <= data.block[0]; i++)
-			values[i-1] = data.block[i];
-		return data.block[0];
-	}
-}
-
-static inline __s32 i2c_smbus_write_i2c_block_data(int file, __u8 command,
-                                                   __u8 length,
-                                                   const __u8 *values)
-{
-	union i2c_smbus_data data;
-	int i;
-	if (length > 32)
-		length = 32;
-	for (i = 1; i <= length; i++)
-		data.block[i] = values[i-1];
-	data.block[0] = length;
-	return i2c_smbus_access(file,I2C_SMBUS_WRITE,command,
-	                        I2C_SMBUS_I2C_BLOCK_BROKEN, &data);
-}
-
-/* Returns the number of read bytes */
-static inline __s32 i2c_smbus_block_process_call(int file, __u8 command,
-                                                 __u8 length, __u8 *values)
-{
-	union i2c_smbus_data data;
-	int i;
-	if (length > 32)
-		length = 32;
-	for (i = 1; i <= length; i++)
-		data.block[i] = values[i-1];
-	data.block[0] = length;
-	if (i2c_smbus_access(file,I2C_SMBUS_WRITE,command,
-	                     I2C_SMBUS_BLOCK_PROC_CALL,&data))
-		return -1;
-	else {
-		for (i = 1; i <= data.block[0]; i++)
-			values[i-1] = data.block[i];
-		return data.block[0];
-	}
-}
-
-
 #endif /* _LINUX_I2C_DEV_H */
--- i2c-tools.orig/py-smbus/Module.mk	2012-03-15 16:35:11.000000000 +0100
+++ i2c-tools/py-smbus/Module.mk	2012-03-15 16:35:22.365963310 +0100
@@ -14,7 +14,7 @@ DISTUTILS := \
 	cd $(PY_SMBUS_DIR) && \
 	CPPFLAGS="$(CPPFLAGS) -I../include" $(PYTHON) setup.py
 
-all-python: $(INCLUDE_DIR)/linux/i2c-dev.h
+all-python: $(INCLUDE_DIR)/i2c-dev/smbus.h
 	$(DISTUTILS) build
 
 clean-python:
--- i2c-tools.orig/py-smbus/smbusmodule.c	2012-03-15 16:35:11.000000000 +0100
+++ i2c-tools/py-smbus/smbusmodule.c	2012-03-15 16:44:55.413838358 +0100
@@ -18,10 +18,13 @@
 
 #include <Python.h>
 #include "structmember.h"
+#include <sys/ioctl.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <fcntl.h>
+#include <linux/i2c.h>
 #include <linux/i2c-dev.h>
+#include <i2c-dev/smbus.h>
 
 /*
 ** These are required to build this module against Linux older than 2.6.23.
--- i2c-tools.orig/tools/Module.mk	2012-03-15 16:35:11.000000000 +0100
+++ i2c-tools/tools/Module.mk	2012-03-15 16:54:39.883128132 +0100
@@ -1,6 +1,6 @@
 # I2C tools for Linux
 #
-# Copyright (C) 2007  Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+# Copyright (C) 2007, 2012  Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
@@ -35,19 +35,19 @@ $(TOOLS_DIR)/i2cget: $(TOOLS_DIR)/i2cget
 # Objects
 #
 
-$(TOOLS_DIR)/i2cdetect.o: $(TOOLS_DIR)/i2cdetect.c $(TOOLS_DIR)/i2cbusses.h $(INCLUDE_DIR)/linux/i2c-dev.h
+$(TOOLS_DIR)/i2cdetect.o: $(TOOLS_DIR)/i2cdetect.c $(TOOLS_DIR)/i2cbusses.h $(INCLUDE_DIR)/i2c-dev/smbus.h
 	$(CC) $(CFLAGS) $(TOOLS_CFLAGS) -c $< -o $@
 
-$(TOOLS_DIR)/i2cdump.o: $(TOOLS_DIR)/i2cdump.c $(TOOLS_DIR)/i2cbusses.h $(TOOLS_DIR)/util.h $(INCLUDE_DIR)/linux/i2c-dev.h
+$(TOOLS_DIR)/i2cdump.o: $(TOOLS_DIR)/i2cdump.c $(TOOLS_DIR)/i2cbusses.h $(TOOLS_DIR)/util.h $(INCLUDE_DIR)/i2c-dev/smbus.h
 	$(CC) $(CFLAGS) $(TOOLS_CFLAGS) -c $< -o $@
 
-$(TOOLS_DIR)/i2cset.o: $(TOOLS_DIR)/i2cset.c $(TOOLS_DIR)/i2cbusses.h $(TOOLS_DIR)/util.h $(INCLUDE_DIR)/linux/i2c-dev.h
+$(TOOLS_DIR)/i2cset.o: $(TOOLS_DIR)/i2cset.c $(TOOLS_DIR)/i2cbusses.h $(TOOLS_DIR)/util.h $(INCLUDE_DIR)/i2c-dev/smbus.h
 	$(CC) $(CFLAGS) $(TOOLS_CFLAGS) -c $< -o $@
 
-$(TOOLS_DIR)/i2cget.o: $(TOOLS_DIR)/i2cget.c $(TOOLS_DIR)/i2cbusses.h $(TOOLS_DIR)/util.h $(INCLUDE_DIR)/linux/i2c-dev.h
+$(TOOLS_DIR)/i2cget.o: $(TOOLS_DIR)/i2cget.c $(TOOLS_DIR)/i2cbusses.h $(TOOLS_DIR)/util.h $(INCLUDE_DIR)/i2c-dev/smbus.h
 	$(CC) $(CFLAGS) $(TOOLS_CFLAGS) -c $< -o $@
 
-$(TOOLS_DIR)/i2cbusses.o: $(TOOLS_DIR)/i2cbusses.c $(TOOLS_DIR)/i2cbusses.h $(INCLUDE_DIR)/linux/i2c-dev.h
+$(TOOLS_DIR)/i2cbusses.o: $(TOOLS_DIR)/i2cbusses.c $(TOOLS_DIR)/i2cbusses.h
 	$(CC) $(CFLAGS) $(TOOLS_CFLAGS) -c $< -o $@
 
 $(TOOLS_DIR)/util.o: $(TOOLS_DIR)/util.c $(TOOLS_DIR)/util.h
--- i2c-tools.orig/tools/i2cbusses.c	2012-03-15 16:35:11.000000000 +0100
+++ i2c-tools/tools/i2cbusses.c	2012-03-15 16:54:35.287128000 +0100
@@ -4,7 +4,7 @@
                devices.
     Copyright (c) 1999-2003  Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org> and
                              Mark D. Studebaker <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
-    Copyright (C) 2008-2010  Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+    Copyright (C) 2008-2012  Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -28,6 +28,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/param.h>	/* for NAME_MAX */
+#include <sys/ioctl.h>
 #include <string.h>
 #include <strings.h>	/* for strcasecmp() */
 #include <stdio.h>
@@ -38,6 +39,7 @@
 #include <fcntl.h>
 #include <errno.h>
 #include "i2cbusses.h"
+#include <linux/i2c.h>
 #include <linux/i2c-dev.h>
 
 enum adt { adt_dummy, adt_isa, adt_i2c, adt_smbus, adt_unknown };
--- i2c-tools.orig/tools/i2cdetect.c	2012-03-15 16:35:11.000000000 +0100
+++ i2c-tools/tools/i2cdetect.c	2012-03-15 16:54:29.816127967 +0100
@@ -2,7 +2,7 @@
     i2cdetect.c - a user-space program to scan for I2C devices
     Copyright (C) 1999-2004  Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>, and
                              Mark D. Studebaker <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
-    Copyright (C) 2004-2010  Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+    Copyright (C) 2004-2012  Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -20,12 +20,14 @@
     MA 02110-1301 USA.
 */
 
+#include <sys/ioctl.h>
 #include <errno.h>
 #include <string.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <linux/i2c-dev.h>
+#include <i2c-dev/smbus.h>
 #include "i2cbusses.h"
 #include "../version.h"
 
--- i2c-tools.orig/tools/i2cdump.c	2012-03-15 16:35:11.000000000 +0100
+++ i2c-tools/tools/i2cdump.c	2012-03-15 16:54:26.328127929 +0100
@@ -2,7 +2,7 @@
     i2cdump.c - a user-space program to dump I2C registers
     Copyright (C) 2002-2003  Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>, and
                              Mark D. Studebaker <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
-    Copyright (C) 2004-2010  Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+    Copyright (C) 2004-2012  Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -20,12 +20,14 @@
     MA 02110-1301 USA.
 */
 
+#include <sys/ioctl.h>
 #include <errno.h>
 #include <string.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <linux/i2c-dev.h>
+#include <i2c-dev/smbus.h>
 #include "i2cbusses.h"
 #include "util.h"
 #include "../version.h"
--- i2c-tools.orig/tools/i2cget.c	2012-03-15 16:35:11.000000000 +0100
+++ i2c-tools/tools/i2cget.c	2012-03-15 16:54:21.836127805 +0100
@@ -1,6 +1,6 @@
 /*
     i2cget.c - A user-space program to read an I2C register.
-    Copyright (C) 2005-2010  Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+    Copyright (C) 2005-2012  Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
 
     Based on i2cset.c:
     Copyright (C) 2001-2003  Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>, and
@@ -23,12 +23,14 @@
     MA 02110-1301 USA.
 */
 
+#include <sys/ioctl.h>
 #include <errno.h>
 #include <string.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <linux/i2c-dev.h>
+#include <i2c-dev/smbus.h>
 #include "i2cbusses.h"
 #include "util.h"
 #include "../version.h"
--- i2c-tools.orig/tools/i2cset.c	2012-03-15 16:35:11.000000000 +0100
+++ i2c-tools/tools/i2cset.c	2012-03-15 16:54:15.106127786 +0100
@@ -2,7 +2,7 @@
     i2cset.c - A user-space program to write an I2C register.
     Copyright (C) 2001-2003  Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>, and
                              Mark D. Studebaker <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
-    Copyright (C) 2004-2010  Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+    Copyright (C) 2004-2012  Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -20,12 +20,14 @@
     MA 02110-1301 USA.
 */
 
+#include <sys/ioctl.h>
 #include <errno.h>
 #include <string.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <linux/i2c-dev.h>
+#include <i2c-dev/smbus.h>
 #include "i2cbusses.h"
 #include "util.h"
 #include "../version.h"

-- 
Jean Delvare
