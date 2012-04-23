From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 3/3] i2c-tools: New libi2c library
Date: Mon, 23 Apr 2012 18:50:55 +0200
Message-ID: <20120423185055.5606d26f@endymion.delvare>
References: <20120423184319.3e09d7b4@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120423184319.3e09d7b4-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

New library for I2C device access under Linux. As a first step, the
library will host the i2c_smbus_*() inline functions which were
previously in the user-space flavor of <linux/i2c-dev.h>.
---
 Makefile            |   14 ++-
 README              |   32 +++++---
 include/i2c/smbus.h |  191 ++++-------------------------------------------
 lib/Module.mk       |  102 +++++++++++++++++++++++++
 lib/libi2c.map      |   18 ++++
 lib/smbus.c         |  203 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/Module.mk     |    9 +-
 7 files changed, 378 insertions(+), 191 deletions(-)

--- i2c-tools.orig/Makefile	2012-04-23 17:17:55.000000000 +0200
+++ i2c-tools/Makefile	2012-04-23 17:19:17.620841792 +0200
@@ -14,19 +14,25 @@ sbindir	= $(prefix)/sbin
 mandir	= $(prefix)/share/man
 man8dir	= $(mandir)/man8
 incdir	= $(prefix)/include
+libdir	= $(prefix)/lib
 
 INSTALL		:= install
 INSTALL_DATA	:= $(INSTALL) -m 644
 INSTALL_DIR	:= $(INSTALL) -m 755 -d
 INSTALL_PROGRAM	:= $(INSTALL) -m 755
+LN		:= ln -sf
 RM		:= rm -f
 
 CC	?= gcc
+AR	?= ar
 
-CFLAGS	?= -O2
+CFLAGS		?= -O2
 # When debugging, use the following instead
-#CFLAGS	:= -O -g
-CFLAGS	+= -Wall
+#CFLAGS		:= -O -g
+CFLAGS		+= -Wall
+SOCFLAGS	:= -fpic -D_REENTRANT $(CFLAGS)
+
+BUILD_STATIC_LIB ?= 1
 
 KERNELVERSION	:= $(shell uname -r)
 
@@ -36,5 +42,5 @@ all:
 
 EXTRA	:=
 #EXTRA	+= py-smbus
-SRCDIRS	:= include eeprom stub tools $(EXTRA)
+SRCDIRS	:= include lib eeprom stub tools $(EXTRA)
 include $(SRCDIRS:%=%/Module.mk)
--- i2c-tools.orig/README	2010-11-16 09:33:15.000000000 +0100
+++ i2c-tools/README	2012-04-23 17:37:04.992752809 +0200
@@ -1,10 +1,15 @@
 I2C TOOLS FOR LINUX
 ===================
 
-This package contains an heterogeneous set of I2C tools for the Linux kernel.
-These tools were originally part of the lm-sensors project but were finally
-split into their own package for convenience. They compile, run and have been
-tested on GNU/Linux.
+This package contains an heterogeneous set of I2C tools for the Linux kernel
+as well as an I2C library. The tools were originally part of the lm-sensors
+project but were finally split into their own package for convenience. The
+library is used by some of the tools, but can also be used by third-party
+applications. The tools and library compile, run and have been tested on
+GNU/Linux.
+
+The latest version of the code can be downloaded from:
+  http://www.lm-sensors.org/wiki/I2CTools
 
 
 CONTENTS
@@ -25,6 +30,10 @@ category has its own sub-directory:
   C/C++ header files for I2C and SMBus access over i2c-dev. Installed by
   default.
 
+* lib
+  The I2C library, used by eepromer, py-smbus and tools. Installed by
+  default.
+
 * py-smbus
   Python wrapper for SMBus access over i2c-dev. Not installed by default.
 
@@ -40,16 +49,17 @@ category has its own sub-directory:
 INSTALLATION
 ------------
 
-There's no configure script, so simply run "make" to build the tools, and
-"make install" to install them. You also can use "make uninstall" to remove
-all the files you installed. By default, files are installed in /usr/local
-but you can change this behavior by editing the Makefile file and setting
-prefix to wherever you want. You may change the C compiler and the
-compilation flags as well.
+There's no configure script, so simply run "make" to build the library and
+tools, and "make install" to install them. You also can use "make uninstall"
+to remove all the files you installed. By default, files are installed in
+/usr/local but you can change the location by editing the Makefile file and
+setting prefix to wherever you want. You may change the C compiler and the
+compilation flags as well, and also decide whether to build the static
+library or not.
 
 Optionally, you can run "make strip" prior to "make install" if you want
 smaller binaries. However, be aware that this will prevent any further
-attempt to debug the programs.
+attempt to debug the library and tools.
 
 If you wish to include sub-directories that are not enabled by default, then
 just set them via the EXTRA make variable. For example, to build py-smbus,
--- i2c-tools.orig/include/i2c/smbus.h	2012-04-23 17:17:55.000000000 +0200
+++ i2c-tools/include/i2c/smbus.h	2012-04-23 17:19:17.621841792 +0200
@@ -23,190 +23,37 @@
 #ifndef LIB_I2C_SMBUS_H
 #define LIB_I2C_SMBUS_H
 
-#include <sys/ioctl.h>
 #include <linux/types.h>
 #include <linux/i2c.h>
-#include <linux/i2c-dev.h>
-
-/* Compatibility defines */
-#ifndef I2C_SMBUS_I2C_BLOCK_BROKEN
-#define I2C_SMBUS_I2C_BLOCK_BROKEN I2C_SMBUS_I2C_BLOCK_DATA
-#endif
-#ifndef I2C_FUNC_SMBUS_PEC
-#define I2C_FUNC_SMBUS_PEC I2C_FUNC_SMBUS_HWPEC_CALC
-#endif
-
-static inline __s32 i2c_smbus_access(int file, char read_write, __u8 command,
-				     int size, union i2c_smbus_data *data)
-{
-	struct i2c_smbus_ioctl_data args;
-
-	args.read_write = read_write;
-	args.command = command;
-	args.size = size;
-	args.data = data;
-	return ioctl(file, I2C_SMBUS, &args);
-}
-
-
-static inline __s32 i2c_smbus_write_quick(int file, __u8 value)
-{
-	return i2c_smbus_access(file, value, 0, I2C_SMBUS_QUICK, NULL);
-}
-
-static inline __s32 i2c_smbus_read_byte(int file)
-{
-	union i2c_smbus_data data;
-	if (i2c_smbus_access(file, I2C_SMBUS_READ, 0, I2C_SMBUS_BYTE, &data))
-		return -1;
-	else
-		return 0x0FF & data.byte;
-}
-
-static inline __s32 i2c_smbus_write_byte(int file, __u8 value)
-{
-	return i2c_smbus_access(file, I2C_SMBUS_WRITE, value,
-				I2C_SMBUS_BYTE, NULL);
-}
-
-static inline __s32 i2c_smbus_read_byte_data(int file, __u8 command)
-{
-	union i2c_smbus_data data;
-	if (i2c_smbus_access(file, I2C_SMBUS_READ, command,
-			     I2C_SMBUS_BYTE_DATA, &data))
-		return -1;
-	else
-		return 0x0FF & data.byte;
-}
-
-static inline __s32 i2c_smbus_write_byte_data(int file, __u8 command,
-					      __u8 value)
-{
-	union i2c_smbus_data data;
-	data.byte = value;
-	return i2c_smbus_access(file, I2C_SMBUS_WRITE, command,
-				I2C_SMBUS_BYTE_DATA, &data);
-}
-
-static inline __s32 i2c_smbus_read_word_data(int file, __u8 command)
-{
-	union i2c_smbus_data data;
-	if (i2c_smbus_access(file, I2C_SMBUS_READ, command,
-			     I2C_SMBUS_WORD_DATA, &data))
-		return -1;
-	else
-		return 0x0FFFF & data.word;
-}
 
-static inline __s32 i2c_smbus_write_word_data(int file, __u8 command,
-					      __u16 value)
-{
-	union i2c_smbus_data data;
-	data.word = value;
-	return i2c_smbus_access(file, I2C_SMBUS_WRITE, command,
-				I2C_SMBUS_WORD_DATA, &data);
-}
-
-static inline __s32 i2c_smbus_process_call(int file, __u8 command, __u16 value)
-{
-	union i2c_smbus_data data;
-	data.word = value;
-	if (i2c_smbus_access(file, I2C_SMBUS_WRITE, command,
-			     I2C_SMBUS_PROC_CALL, &data))
-		return -1;
-	else
-		return 0x0FFFF & data.word;
-}
+extern __s32 i2c_smbus_access(int file, char read_write, __u8 command,
+			      int size, union i2c_smbus_data *data);
 
+extern __s32 i2c_smbus_write_quick(int file, __u8 value);
+extern __s32 i2c_smbus_read_byte(int file);
+extern __s32 i2c_smbus_write_byte(int file, __u8 value);
+extern __s32 i2c_smbus_read_byte_data(int file, __u8 command);
+extern __s32 i2c_smbus_write_byte_data(int file, __u8 command, __u8 value);
+extern __s32 i2c_smbus_read_word_data(int file, __u8 command);
+extern __s32 i2c_smbus_write_word_data(int file, __u8 command, __u16 value);
+extern __s32 i2c_smbus_process_call(int file, __u8 command, __u16 value);
 
 /* Returns the number of read bytes */
-static inline __s32 i2c_smbus_read_block_data(int file, __u8 command,
-					      __u8 *values)
-{
-	union i2c_smbus_data data;
-	int i;
-	if (i2c_smbus_access(file, I2C_SMBUS_READ, command,
-			     I2C_SMBUS_BLOCK_DATA, &data))
-		return -1;
-	else {
-		for (i = 1; i <= data.block[0]; i++)
-			values[i-1] = data.block[i];
-		return data.block[0];
-	}
-}
-
-static inline __s32 i2c_smbus_write_block_data(int file, __u8 command,
-					       __u8 length, const __u8 *values)
-{
-	union i2c_smbus_data data;
-	int i;
-	if (length > 32)
-		length = 32;
-	for (i = 1; i <= length; i++)
-		data.block[i] = values[i-1];
-	data.block[0] = length;
-	return i2c_smbus_access(file, I2C_SMBUS_WRITE, command,
-				I2C_SMBUS_BLOCK_DATA, &data);
-}
+extern __s32 i2c_smbus_read_block_data(int file, __u8 command, __u8 *values);
+extern __s32 i2c_smbus_write_block_data(int file, __u8 command, __u8 length,
+					const __u8 *values);
 
 /* Returns the number of read bytes */
 /* Until kernel 2.6.22, the length is hardcoded to 32 bytes. If you
    ask for less than 32 bytes, your code will only work with kernels
    2.6.23 and later. */
-static inline __s32 i2c_smbus_read_i2c_block_data(int file, __u8 command,
-						  __u8 length, __u8 *values)
-{
-	union i2c_smbus_data data;
-	int i;
-
-	if (length > 32)
-		length = 32;
-	data.block[0] = length;
-	if (i2c_smbus_access(file, I2C_SMBUS_READ, command,
-			     length == 32 ? I2C_SMBUS_I2C_BLOCK_BROKEN :
-			      I2C_SMBUS_I2C_BLOCK_DATA, &data))
-		return -1;
-	else {
-		for (i = 1; i <= data.block[0]; i++)
-			values[i-1] = data.block[i];
-		return data.block[0];
-	}
-}
-
-static inline __s32 i2c_smbus_write_i2c_block_data(int file, __u8 command,
-						   __u8 length,
-						   const __u8 *values)
-{
-	union i2c_smbus_data data;
-	int i;
-	if (length > 32)
-		length = 32;
-	for (i = 1; i <= length; i++)
-		data.block[i] = values[i-1];
-	data.block[0] = length;
-	return i2c_smbus_access(file, I2C_SMBUS_WRITE, command,
-				I2C_SMBUS_I2C_BLOCK_BROKEN, &data);
-}
+extern __s32 i2c_smbus_read_i2c_block_data(int file, __u8 command, __u8 length,
+					   __u8 *values);
+extern __s32 i2c_smbus_write_i2c_block_data(int file, __u8 command, __u8 length,
+					    const __u8 *values);
 
 /* Returns the number of read bytes */
-static inline __s32 i2c_smbus_block_process_call(int file, __u8 command,
-						 __u8 length, __u8 *values)
-{
-	union i2c_smbus_data data;
-	int i;
-	if (length > 32)
-		length = 32;
-	for (i = 1; i <= length; i++)
-		data.block[i] = values[i-1];
-	data.block[0] = length;
-	if (i2c_smbus_access(file, I2C_SMBUS_WRITE, command,
-			     I2C_SMBUS_BLOCK_PROC_CALL, &data))
-		return -1;
-	else {
-		for (i = 1; i <= data.block[0]; i++)
-			values[i-1] = data.block[i];
-		return data.block[0];
-	}
-}
+extern __s32 i2c_smbus_block_process_call(int file, __u8 command, __u8 length,
+					  __u8 *values);
 
 #endif /* LIB_I2C_SMBUS_H */
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ i2c-tools/lib/Module.mk	2012-04-23 17:22:20.026327035 +0200
@@ -0,0 +1,102 @@
+# I2C library for Linux
+#
+# Copyright (C) 2012  Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU Lesser General Public License as published
+# by the Free Software Foundation; either version 2.1 of the License, or
+# (at your option) any later version.
+
+LIB_DIR		:= lib
+
+LIB_CFLAGS	:= -Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual \
+		   -Wcast-align -Wwrite-strings -Wnested-externs -Winline \
+		   -W -Wundef -Wmissing-prototypes -Iinclude
+
+# The main and minor version of the library
+# The library soname (major number) must be changed if and only if the
+# interface is changed in a backward incompatible way.  The interface is
+# defined by the public header files - in this case they are only smbus.h.
+LIB_MAINVER	:= 0
+LIB_MINORVER	:= 1.0
+LIB_VER		:= $(LIB_MAINVER).$(LIB_MINORVER)
+
+# The shared and static library names
+LIB_SHBASENAME	:= libi2c.so
+LIB_SHSONAME	:= $(LIB_SHBASENAME).$(LIB_MAINVER)
+LIB_SHLIBNAME	:= $(LIB_SHBASENAME).$(LIB_VER)
+LIB_STLIBNAME	:= libi2c.a
+
+LIB_TARGETS	:= $(LIB_SHLIBNAME)
+LIB_LINKS	:= $(LIB_SHSONAME) $(LIB_SHBASENAME)
+LIB_OBJECTS	:= smbus.o
+ifeq ($(BUILD_STATIC_LIB),1)
+LIB_TARGETS	+= $(LIB_STLIBNAME)
+LIB_OBJECTS	+= smbus.ao
+endif
+
+#
+# Libraries
+#
+
+$(LIB_DIR)/$(LIB_SHLIBNAME): $(LIB_DIR)/smbus.o
+	$(CC) -shared $(LDFLAGS) -Wl,--version-script=$(LIB_DIR)/libi2c.map -Wl,-soname,$(LIB_SHSONAME) -o $@ $^ -lc
+
+$(LIB_DIR)/$(LIB_SHSONAME):
+	$(RM) $@
+	$(LN) $(LIB_SHLIBNAME) $@
+
+$(LIB_DIR)/$(LIB_SHBASENAME):
+	$(RM) $@
+	$(LN) $(LIB_SHLIBNAME) $@
+
+$(LIB_DIR)/$(LIB_STLIBNAME): $(LIB_DIR)/smbus.ao
+	$(RM) $@
+	$(AR) rcvs $@ $^
+
+#
+# Objects
+# Each object must be built twice, once for the shared library and
+# once again for the static library.
+#
+
+$(LIB_DIR)/smbus.o: $(LIB_DIR)/smbus.c $(INCLUDE_DIR)/i2c/smbus.h
+	$(CC) $(SOCFLAGS) $(LIB_CFLAGS) -c $< -o $@
+
+$(LIB_DIR)/smbus.ao: $(LIB_DIR)/smbus.c $(INCLUDE_DIR)/i2c/smbus.h
+	$(CC) $(CFLAGS) $(LIB_CFLAGS) -c $< -o $@
+
+#
+# Commands
+#
+
+all-lib: $(addprefix $(LIB_DIR)/,$(LIB_TARGETS) $(LIB_LINKS))
+
+strip-lib: $(addprefix $(LIB_DIR)/,$(LIB_TARGETS))
+	strip $(addprefix $(LIB_DIR)/,$(LIB_TARGETS))
+
+clean-lib:
+	$(RM) $(addprefix $(LIB_DIR)/,*.o *.ao $(LIB_TARGETS) $(LIB_LINKS))
+
+install-lib: $(addprefix $(LIB_DIR)/,$(LIB_TARGETS))
+	$(INSTALL_DIR) $(DESTDIR)$(libdir)
+	$(INSTALL_PROGRAM) $(LIB_DIR)/$(LIB_SHLIBNAME) $(DESTDIR)$(libdir)
+	$(LN) $(LIB_SHLIBNAME) $(DESTDIR)$(libdir)/$(LIB_SHSONAME)
+	$(LN) $(LIB_SHSONAME) $(DESTDIR)$(libdir)/$(LIB_SHBASENAME)
+ifeq ($(BUILD_STATIC_LIB),1)
+	$(INSTALL_PROGRAM) $(LIB_DIR)/$(LIB_STLIBNAME) $(DESTDIR)$(libdir)
+endif
+
+uninstall-lib:
+	for library in $(LIB_TARGETS) $(LIB_LINKS) ; do \
+	$(RM) $(DESTDIR)$(libdir)/$$library ; done
+
+all: all-lib
+
+strip: strip-lib
+
+clean: clean-lib
+
+install: install-lib
+
+uninstall: uninstall-lib
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ i2c-tools/lib/libi2c.map	2012-04-23 17:19:17.621841792 +0200
@@ -0,0 +1,18 @@
+{
+global:
+  i2c_smbus_access;
+  i2c_smbus_write_quick;
+  i2c_smbus_read_byte;
+  i2c_smbus_write_byte;
+  i2c_smbus_read_byte_data;
+  i2c_smbus_write_byte_data;
+  i2c_smbus_read_word_data;
+  i2c_smbus_write_word_data;
+  i2c_smbus_process_call;
+  i2c_smbus_read_block_data;
+  i2c_smbus_write_block_data;
+  i2c_smbus_read_i2c_block_data;
+  i2c_smbus_write_i2c_block_data;
+  i2c_smbus_block_process_call;
+local: *;
+ };
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ i2c-tools/lib/smbus.c	2012-04-23 17:19:17.621841792 +0200
@@ -0,0 +1,203 @@
+/*
+    smbus.c - SMBus level access helper functions
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
+#include <i2c/smbus.h>
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
+__s32 i2c_smbus_access(int file, char read_write, __u8 command,
+		       int size, union i2c_smbus_data *data)
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
+__s32 i2c_smbus_write_quick(int file, __u8 value)
+{
+	return i2c_smbus_access(file, value, 0, I2C_SMBUS_QUICK, NULL);
+}
+
+__s32 i2c_smbus_read_byte(int file)
+{
+	union i2c_smbus_data data;
+	if (i2c_smbus_access(file, I2C_SMBUS_READ, 0, I2C_SMBUS_BYTE, &data))
+		return -1;
+	else
+		return 0x0FF & data.byte;
+}
+
+__s32 i2c_smbus_write_byte(int file, __u8 value)
+{
+	return i2c_smbus_access(file, I2C_SMBUS_WRITE, value,
+				I2C_SMBUS_BYTE, NULL);
+}
+
+__s32 i2c_smbus_read_byte_data(int file, __u8 command)
+{
+	union i2c_smbus_data data;
+	if (i2c_smbus_access(file, I2C_SMBUS_READ, command,
+			     I2C_SMBUS_BYTE_DATA, &data))
+		return -1;
+	else
+		return 0x0FF & data.byte;
+}
+
+__s32 i2c_smbus_write_byte_data(int file, __u8 command, __u8 value)
+{
+	union i2c_smbus_data data;
+	data.byte = value;
+	return i2c_smbus_access(file, I2C_SMBUS_WRITE, command,
+				I2C_SMBUS_BYTE_DATA, &data);
+}
+
+__s32 i2c_smbus_read_word_data(int file, __u8 command)
+{
+	union i2c_smbus_data data;
+	if (i2c_smbus_access(file, I2C_SMBUS_READ, command,
+			     I2C_SMBUS_WORD_DATA, &data))
+		return -1;
+	else
+		return 0x0FFFF & data.word;
+}
+
+__s32 i2c_smbus_write_word_data(int file, __u8 command, __u16 value)
+{
+	union i2c_smbus_data data;
+	data.word = value;
+	return i2c_smbus_access(file, I2C_SMBUS_WRITE, command,
+				I2C_SMBUS_WORD_DATA, &data);
+}
+
+__s32 i2c_smbus_process_call(int file, __u8 command, __u16 value)
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
+/* Returns the number of read bytes */
+__s32 i2c_smbus_read_block_data(int file, __u8 command, __u8 *values)
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
+__s32 i2c_smbus_write_block_data(int file, __u8 command, __u8 length,
+				 const __u8 *values)
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
+__s32 i2c_smbus_read_i2c_block_data(int file, __u8 command, __u8 length,
+				    __u8 *values)
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
+__s32 i2c_smbus_write_i2c_block_data(int file, __u8 command, __u8 length,
+				     const __u8 *values)
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
+__s32 i2c_smbus_block_process_call(int file, __u8 command, __u8 length,
+				   __u8 *values)
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
--- i2c-tools.orig/tools/Module.mk	2012-04-23 17:17:55.000000000 +0200
+++ i2c-tools/tools/Module.mk	2012-04-23 17:26:39.778141451 +0200
@@ -12,6 +12,7 @@ TOOLS_DIR	:= tools
 TOOLS_CFLAGS	:= -Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual \
 		   -Wcast-align -Wwrite-strings -Wnested-externs -Winline \
 		   -W -Wundef -Wmissing-prototypes -Iinclude
+TOOLS_LDFLAGS	:= -Llib -li2c
 
 TOOLS_TARGETS	:= i2cdetect i2cdump i2cset i2cget
 
@@ -20,16 +21,16 @@ TOOLS_TARGETS	:= i2cdetect i2cdump i2cse
 #
 
 $(TOOLS_DIR)/i2cdetect: $(TOOLS_DIR)/i2cdetect.o $(TOOLS_DIR)/i2cbusses.o
-	$(CC) $(LDFLAGS) -o $@ $^
+	$(CC) $(LDFLAGS) $(TOOLS_LDFLAGS) -o $@ $^
 
 $(TOOLS_DIR)/i2cdump: $(TOOLS_DIR)/i2cdump.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)/util.o
-	$(CC) $(LDFLAGS) -o $@ $^
+	$(CC) $(LDFLAGS) $(TOOLS_LDFLAGS) -o $@ $^
 
 $(TOOLS_DIR)/i2cset: $(TOOLS_DIR)/i2cset.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)/util.o
-	$(CC) $(LDFLAGS) -o $@ $^
+	$(CC) $(LDFLAGS) $(TOOLS_LDFLAGS) -o $@ $^
 
 $(TOOLS_DIR)/i2cget: $(TOOLS_DIR)/i2cget.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)/util.o
-	$(CC) $(LDFLAGS) -o $@ $^
+	$(CC) $(LDFLAGS) $(TOOLS_LDFLAGS) -o $@ $^
 
 #
 # Objects

-- 
Jean Delvare
