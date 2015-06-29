From: "Matwey V. Kornilov" <matwey.kornilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] i2c-tools: Implement Module.mk for eeprog subdir
Date: Mon, 29 Jun 2015 21:14:47 +0300
Message-ID: <1435601687-6177-1-git-send-email-matwey.kornilov@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jdelvare-l3A5Bk7waGM@public.gmane.org, npajkovs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: "Matwey V. Kornilov" <matwey.kornilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Move eeprog to separate subdir and implement Module.mk for it

Signed-off-by: Matwey V. Kornilov <matwey.kornilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 eeprog/24cXX.c         | 185 ++++++++++++++++++++++++++++++++
 eeprog/24cXX.h         |  58 ++++++++++
 eeprog/Module.mk       |  67 ++++++++++++
 eeprog/README.eeprog   |  12 +++
 eeprog/eeprog.8        | 103 ++++++++++++++++++
 eeprog/eeprog.c        | 283 +++++++++++++++++++++++++++++++++++++++++++++++++
 eepromer/24cXX.c       | 185 --------------------------------
 eepromer/24cXX.h       |  58 ----------
 eepromer/Makefile      |   6 +-
 eepromer/README.eeprog |  12 ---
 eepromer/eeprog.8      | 103 ------------------
 eepromer/eeprog.c      | 283 -------------------------------------------------
 12 files changed, 710 insertions(+), 645 deletions(-)
 create mode 100644 eeprog/24cXX.c
 create mode 100644 eeprog/24cXX.h
 create mode 100644 eeprog/Module.mk
 create mode 100644 eeprog/README.eeprog
 create mode 100644 eeprog/eeprog.8
 create mode 100644 eeprog/eeprog.c
 delete mode 100644 eepromer/24cXX.c
 delete mode 100644 eepromer/24cXX.h
 delete mode 100644 eepromer/README.eeprog
 delete mode 100644 eepromer/eeprog.8
 delete mode 100644 eepromer/eeprog.c

diff --git a/eeprog/24cXX.c b/eeprog/24cXX.c
new file mode 100644
index 0000000..6a0b610
--- /dev/null
+++ b/eeprog/24cXX.c
@@ -0,0 +1,185 @@
+/***************************************************************************
+    copyright            : (C) by 2002-2003 Stefano Barbato
+    email                : stefano-IOMW/CzKI+Ng9hUCZPvPmw@public.gmane.org
+
+    $Id$
+ ***************************************************************************/
+
+/***************************************************************************
+ *                                                                         *
+ *   This program is free software; you can redistribute it and/or modify  *
+ *   it under the terms of the GNU General Public License as published by  *
+ *   the Free Software Foundation; either version 2 of the License, or     *
+ *   (at your option) any later version.                                   *
+ *                                                                         *
+ ***************************************************************************/
+#include <stdio.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <linux/fs.h>
+#include <linux/i2c.h>
+#include <linux/i2c-dev.h>
+#include <sys/types.h>
+#include <sys/ioctl.h>
+#include <errno.h>
+#include <assert.h>
+#include <string.h>
+#include <i2c/smbus.h>
+#include "24cXX.h"
+
+static int i2c_write_1b(struct eeprom *e, __u8 buf)
+{
+	int r;
+	// we must simulate a plain I2C byte write with SMBus functions
+	r = i2c_smbus_write_byte(e->fd, buf);
+	if(r < 0)
+		fprintf(stderr, "Error i2c_write_1b: %s\n", strerror(errno));
+	usleep(10);
+	return r;
+}
+
+static int i2c_write_2b(struct eeprom *e, __u8 buf[2])
+{
+	int r;
+	// we must simulate a plain I2C byte write with SMBus functions
+	r = i2c_smbus_write_byte_data(e->fd, buf[0], buf[1]);
+	if(r < 0)
+		fprintf(stderr, "Error i2c_write_2b: %s\n", strerror(errno));
+	usleep(10);
+	return r;
+}
+
+static int i2c_write_3b(struct eeprom *e, __u8 buf[3])
+{
+	int r;
+	// we must simulate a plain I2C byte write with SMBus functions
+	// the __u16 data field will be byte swapped by the SMBus protocol
+	r = i2c_smbus_write_word_data(e->fd, buf[0], buf[2] << 8 | buf[1]);
+	if(r < 0)
+		fprintf(stderr, "Error i2c_write_3b: %s\n", strerror(errno));
+	usleep(10);
+	return r;
+}
+
+
+#define CHECK_I2C_FUNC( var, label ) \
+	do { 	if(0 == (var & label)) { \
+		fprintf(stderr, "\nError: " \
+			#label " function is required. Program halted.\n\n"); \
+		exit(1); } \
+	} while(0);
+
+int eeprom_open(char *dev_fqn, int addr, int type, struct eeprom* e)
+{
+	int fd, r;
+	unsigned long funcs;
+	e->fd = e->addr = 0;
+	e->dev = 0;
+	
+	fd = open(dev_fqn, O_RDWR);
+	if(fd <= 0)
+		return -1;
+
+	// get funcs list
+	if((r = ioctl(fd, I2C_FUNCS, &funcs) < 0))
+		return r;
+
+	
+	// check for req funcs
+	CHECK_I2C_FUNC( funcs, I2C_FUNC_SMBUS_READ_BYTE );
+	CHECK_I2C_FUNC( funcs, I2C_FUNC_SMBUS_WRITE_BYTE );
+	CHECK_I2C_FUNC( funcs, I2C_FUNC_SMBUS_READ_BYTE_DATA );
+	CHECK_I2C_FUNC( funcs, I2C_FUNC_SMBUS_WRITE_BYTE_DATA );
+	CHECK_I2C_FUNC( funcs, I2C_FUNC_SMBUS_READ_WORD_DATA );
+	CHECK_I2C_FUNC( funcs, I2C_FUNC_SMBUS_WRITE_WORD_DATA );
+
+	// set working device
+	if( ( r = ioctl(fd, I2C_SLAVE, addr)) < 0)
+		return r;
+	e->fd = fd;
+	e->addr = addr;
+	e->dev = dev_fqn;
+	e->type = type;
+	return 0;
+}
+
+int eeprom_close(struct eeprom *e)
+{
+	close(e->fd);
+	e->fd = -1;
+	e->dev = 0;
+	e->type = EEPROM_TYPE_UNKNOWN;
+	return 0;
+}
+
+#if 0
+int eeprom_24c32_write_byte(struct eeprom *e, __u16 mem_addr, __u8 data)
+{
+	__u8 buf[3] = { (mem_addr >> 8) & 0x00ff, mem_addr & 0x00ff, data };
+	return i2c_write_3b(e, buf);
+}
+
+
+int eeprom_24c32_read_current_byte(struct eeprom* e)
+{
+	ioctl(e->fd, BLKFLSBUF); // clear kernel read buffer
+	return i2c_smbus_read_byte(e->fd);
+}
+
+int eeprom_24c32_read_byte(struct eeprom* e, __u16 mem_addr)
+{
+	int r;
+	ioctl(e->fd, BLKFLSBUF); // clear kernel read buffer
+	__u8 buf[2] = { (mem_addr >> 8) & 0x0ff, mem_addr & 0x0ff };
+	r = i2c_write_2b(e, buf);
+	if (r < 0)
+		return r;
+	r = i2c_smbus_read_byte(e->fd);
+	return r;
+}
+#endif
+
+
+int eeprom_read_current_byte(struct eeprom* e)
+{
+	ioctl(e->fd, BLKFLSBUF); // clear kernel read buffer
+	return i2c_smbus_read_byte(e->fd);
+}
+
+int eeprom_read_byte(struct eeprom* e, __u16 mem_addr)
+{
+	int r;
+	ioctl(e->fd, BLKFLSBUF); // clear kernel read buffer
+	if(e->type == EEPROM_TYPE_8BIT_ADDR)
+	{
+		__u8 buf =  mem_addr & 0x0ff;
+		r = i2c_write_1b(e, buf);
+	} else if(e->type == EEPROM_TYPE_16BIT_ADDR) {
+		__u8 buf[2] = { (mem_addr >> 8) & 0x0ff, mem_addr & 0x0ff };
+		r = i2c_write_2b(e, buf);
+	} else {
+		fprintf(stderr, "ERR: unknown eeprom type\n");
+		return -1;
+	}
+	if (r < 0)
+		return r;
+	r = i2c_smbus_read_byte(e->fd);
+	return r;
+}
+
+int eeprom_write_byte(struct eeprom *e, __u16 mem_addr, __u8 data)
+{
+	if(e->type == EEPROM_TYPE_8BIT_ADDR) {
+		__u8 buf[2] = { mem_addr & 0x00ff, data };
+		return i2c_write_2b(e, buf);
+	} else if(e->type == EEPROM_TYPE_16BIT_ADDR) {
+		__u8 buf[3] = 
+			{ (mem_addr >> 8) & 0x00ff, mem_addr & 0x00ff, data };
+		return i2c_write_3b(e, buf);
+	} else {
+		fprintf(stderr, "ERR: unknown eeprom type\n");
+		return -1;
+	}
+}
+
diff --git a/eeprog/24cXX.h b/eeprog/24cXX.h
new file mode 100644
index 0000000..6b3885b
--- /dev/null
+++ b/eeprog/24cXX.h
@@ -0,0 +1,58 @@
+/***************************************************************************
+    copyright            : (C) by 2002-2003 Stefano Barbato
+    email                : stefano-IOMW/CzKI+Ng9hUCZPvPmw@public.gmane.org
+
+    $Id$
+ ***************************************************************************/
+
+/***************************************************************************
+ *                                                                         *
+ *   This program is free software; you can redistribute it and/or modify  *
+ *   it under the terms of the GNU General Public License as published by  *
+ *   the Free Software Foundation; either version 2 of the License, or     *
+ *   (at your option) any later version.                                   *
+ *                                                                         *
+ ***************************************************************************/
+#ifndef _24CXX_H_
+#define _24CXX_H_
+#include <linux/types.h>
+
+#define EEPROM_TYPE_UNKNOWN	0
+#define EEPROM_TYPE_8BIT_ADDR	1
+#define EEPROM_TYPE_16BIT_ADDR 	2
+
+struct eeprom
+{
+	char *dev; 	// device file i.e. /dev/i2c-N
+	int addr;	// i2c address
+	int fd;		// file descriptor
+	int type; 	// eeprom type
+};
+
+/*
+ * opens the eeprom device at [dev_fqn] (i.e. /dev/i2c-N) whose address is
+ * [addr] and set the eeprom_24c32 [e]
+ */
+int eeprom_open(char *dev_fqn, int addr, int type, struct eeprom*);
+/*
+ * closees the eeprom device [e] 
+ */
+int eeprom_close(struct eeprom *e);
+/*
+ * read and returns the eeprom byte at memory address [mem_addr] 
+ * Note: eeprom must have been selected by ioctl(fd,I2C_SLAVE,address) 
+ */
+int eeprom_read_byte(struct eeprom* e, __u16 mem_addr);
+/*
+ * read the current byte
+ * Note: eeprom must have been selected by ioctl(fd,I2C_SLAVE,address) 
+ */
+int eeprom_read_current_byte(struct eeprom *e);
+/*
+ * writes [data] at memory address [mem_addr] 
+ * Note: eeprom must have been selected by ioctl(fd,I2C_SLAVE,address) 
+ */
+int eeprom_write_byte(struct eeprom *e, __u16 mem_addr, __u8 data);
+
+#endif
+
diff --git a/eeprog/Module.mk b/eeprog/Module.mk
new file mode 100644
index 0000000..bad3794
--- /dev/null
+++ b/eeprog/Module.mk
@@ -0,0 +1,67 @@
+# eeprog
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+
+EEPROG_DIR	:= eeprog
+
+EEPROG_CFLAGS	:= -O2 -Iinclude -Wall 
+ifeq ($(USE_STATIC_LIB),1)
+EEPROG_LDFLAGS	:= $(LIB_DIR)/$(LIB_STLIBNAME)
+else
+EEPROG_LDFLAGS	:= -L$(LIB_DIR) -li2c
+endif
+
+EEPROG_TARGETS	:= eeprog
+
+#
+# Programs
+#
+
+$(EEPROG_DIR)/eeprog: $(EEPROG_DIR)/eeprog.o $(EEPROG_DIR)/24cXX.o
+	$(CC) $(LDFLAGS) -o $@ $^ $(EEPROG_LDFLAGS)
+
+#
+# Objects
+#
+
+$(EEPROG_DIR)/eeprog.o: $(EEPROG_DIR)/eeprog.c $(EEPROG_DIR)/24cXX.h
+	$(CC) $(CFLAGS) $(EEPROG_CFLAGS) -c $< -o $@
+
+$(EEPROG_DIR)/24cXX.o: $(EEPROG_DIR)/24cXX.c $(EEPROG_DIR)/24cXX.h $(INCLUDE_DIR)/i2c/smbus.h
+	$(CC) $(CFLAGS) $(EEPROG_CFLAGS) -c $< -o $@
+
+#
+# Commands
+#
+
+all-eeprog: $(addprefix $(EEPROG_DIR)/,$(EEPROG_TARGETS))
+
+strip-eeprog: $(addprefix $(EEPROG_DIR)/,$(EEPROG_TARGETS))
+	strip $(addprefix $(EEPROG_DIR)/,$(EEPROG_TARGETS))
+
+clean-eeprog:
+	$(RM) $(addprefix $(EEPROG_DIR)/,*.o $(EEPROG_TARGETS))
+
+install-eeprog: $(addprefix $(EEPROG_DIR)/,$(EEPROG_TARGETS))
+	$(INSTALL_DIR) $(DESTDIR)$(sbindir) $(DESTDIR)$(man8dir)
+	for program in $(EEPROG_TARGETS) ; do \
+	$(INSTALL_PROGRAM) $(EEPROG_DIR)/$$program $(DESTDIR)$(sbindir) ; \
+	$(INSTALL_DATA) $(EEPROG_DIR)/$$program.8 $(DESTDIR)$(man8dir) ; done
+
+uninstall-eeprog:
+	for program in $(EEPROG_TARGETS) ; do \
+	$(RM) $(DESTDIR)$(sbindir)/$$program ; \
+	$(RM) $(DESTDIR)$(man8dir)/$$program.8 ; done
+
+all: all-eeprog
+
+strip: strip-eeprog
+
+clean: clean-eeprog
+
+install: install-eeprog
+
+uninstall: uninstall-eeprog
diff --git a/eeprog/README.eeprog b/eeprog/README.eeprog
new file mode 100644
index 0000000..6cccd00
--- /dev/null
+++ b/eeprog/README.eeprog
@@ -0,0 +1,12 @@
+Important! See the README file for important warnings.
+
+eeprog reads and writes 24Cxx EEPROMs connected to I2C serial bus.
+
+It uses the SMBus protocol used by most of the recent chipsets. Don't forget to load 
+your i2c chipset and the i2c-dev drivers.
+
+Use -16 switch for EEPROM larger then 24C16 (16 bit addressing mode). 
+
+Again, it's really important that you read the README file.
+
+Type "make" to compile.
diff --git a/eeprog/eeprog.8 b/eeprog/eeprog.8
new file mode 100644
index 0000000..6257cc5
--- /dev/null
+++ b/eeprog/eeprog.8
@@ -0,0 +1,103 @@
+.\"
+.\"  eeprog.8 - manpage for the i2c-tools/eeprog utility
+.\"  Copyright (C) 2013  Jaromir Capik
+.\"
+.\"  This program is free software; you can redistribute it and/or modify
+.\"  it under the terms of the GNU General Public License as published by
+.\"  the Free Software Foundation; either version 2 of the License, or
+.\"  (at your option) any later version.
+.\"
+.\"  This program is distributed in the hope that it will be useful,
+.\"  but WITHOUT ANY WARRANTY; without even the implied warranty of
+.\"  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+.\"  GNU General Public License for more details.
+.\"
+.\"  You should have received a copy of the GNU General Public License along
+.\"  with this program; if not, write to the Free Software Foundation, Inc.,
+.\"  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+.\"
+.TH eeprog "8" "Jul 2013" "i2c-tools" "System Administration"
+.SH NAME
+eeprog \- reads and writes 24Cxx EEPROMs connected to I2C serial bus
+.SH SYNOPSIS
+.B eeprog
+[-fqxdh] [-16|-8] [-r addr[:count]|-w addr] <device> <i2c-addr>
+.SH DESCRIPTION
+.B eeprog
+uses the SMBus protocol used by most of the recent chipsets.
+.SH NOTE
+Don't forget to load your i2c chipset and the i2c-dev drivers.
+.P
+The following environment variables could be set instead of the command line arguments:
+.P
+    EEPROG_DEV              device
+.br
+    EEPROG_I2C_ADDR         i2c-addr
+.SH PARAMETERS
+.I Address modes
+.TP
+.B \-8
+Use 8bit address mode for 24c0x...24C16 [default]
+.TP
+.B \-16
+Use 16bit address mode for 24c32...24C256
+.TP
+.I Actions
+.TP
+.B \-r addr[:count]
+Read
+.B count
+(1 if omitted) bytes from
+.B addr
+and print them to the standard output
+.TP
+.B \-w addr
+Write input (stdin) at address
+.B addr
+of the EEPROM
+.TP
+.B \-h
+Print this help
+.TP
+.I Options
+.TP
+.B \-x
+Set hex output mode
+.TP
+.B \-d
+Dummy mode, display what *would* have been done
+.TP
+.B \-f
+Disable warnings and don't ask confirmation
+.TP
+.B \-q
+Quiet mode
+.TP
+.I Bus
+.TP
+.B device
+Device file representing the I2C bus (eg. /dev/i2c-0)
+.TP
+.B i2c-addr
+I2C bus address of the EEPROM (eg. 0x3A)
+.SH EXAMPLES
+Read 64 bytes from the EEPROM at address 0x54 on bus 0 starting at address 123 (decimal)
+.P
+.B 	eeprog
+/dev/i2c-0 0x54 -r 123:64
+.P
+Print the hex codes of the first 32 bytes read from bus 1 at address 0x22
+.P
+.B 	eeprog
+/dev/i2c-1 0x51 -x -r 0x22:0x20
+.P
+Write the current timestamp at address 0x200 of the EEPROM on bus 0 at address 0x33
+.P
+ 	date |
+.B eeprog
+/dev/i2c-0 0x33 -w 0x200
+.SH SEE ALSO
+.BR eeprom (8),
+.BR eepromer (8)
+.SH AUTHOR
+Stefano Barbato
diff --git a/eeprog/eeprog.c b/eeprog/eeprog.c
new file mode 100644
index 0000000..95579b6
--- /dev/null
+++ b/eeprog/eeprog.c
@@ -0,0 +1,283 @@
+/***************************************************************************
+    copyright            : (C) by 2002-2003 Stefano Barbato
+    email                : stefano-IOMW/CzKI+Ng9hUCZPvPmw@public.gmane.org
+
+    $Id$
+ ***************************************************************************/
+
+/***************************************************************************
+ *                                                                         *
+ *   This program is free software; you can redistribute it and/or modify  *
+ *   it under the terms of the GNU General Public License as published by  *
+ *   the Free Software Foundation; either version 2 of the License, or     *
+ *   (at your option) any later version.                                   *
+ *                                                                         *
+ ***************************************************************************/
+#include <stdio.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include "24cXX.h"
+
+#define VERSION 	"0.7.5"
+
+#define ENV_DEV		"EEPROG_DEV"
+#define ENV_I2C_ADDR	"EEPROG_I2C_ADDR"
+
+int g_quiet;
+
+#define usage_if(a) do { do_usage_if( a , __LINE__); } while(0);
+void do_usage_if(int b, int line)
+{
+	static const char *eeprog_usage =
+"eeprog " VERSION ", a 24Cxx EEPROM reader/writer\n"
+"Copyright (c) 2003 by Stefano Barbato - All rights reserved.\n"
+"Usage: eeprog [-fqxdh] [-16|-8] [ -r addr[:count] | -w addr ]  /dev/i2c-N  i2c-address\n" 
+"\n"
+"  Address modes:\n"
+"	-8		Use 8bit address mode for 24c0x...24C16 [default]\n"
+"	-16		Use 16bit address mode for 24c32...24C256\n"
+"  Actions:\n"
+"	-r addr[:count]	Read [count] (1 if omitted) bytes from [addr]\n" 
+"			and print them to the standard output\n" 
+"	-w addr		Write input (stdin) at address [addr] of the EEPROM\n"
+"	-h		Print this help\n"
+"  Options:\n"
+"	-x		Set hex output mode\n" 
+"	-d		Dummy mode, display what *would* have been done\n" 
+"	-f		Disable warnings and don't ask confirmation\n"
+"	-q		Quiet mode\n"
+"\n"
+"The following environment variables could be set instead of the command\n"
+"line arguments:\n"
+"	EEPROG_DEV		device name(/dev/i2c-N)\n"
+"	EEPROG_I2C_ADDR		i2c-address\n"
+"\n"
+"	Examples\n"
+"	1- read 64 bytes from the EEPROM at address 0x54 on bus 0 starting\n"
+"	   at address 123 (decimal)\n"
+"		eeprog /dev/i2c-0 0x54 -r 123:64\n"
+"	2- prints the hex codes of the first 32 bytes read from bus 1\n"
+"	   at address 0x22\n"
+"		eeprog /dev/i2c-1 0x51 -x -r 0x22:0x20\n"
+"	3- write the current timestamp at address 0x200 of the EEPROM on\n"
+"	   bus 0 at address 0x33\n"
+"		date | eeprog /dev/i2c-0 0x33 -w 0x200\n";
+
+	if(!b)
+		return;
+	fprintf(stderr, "%s\n[line %d]\n", eeprog_usage, line);
+	exit(1);
+}
+
+
+#define die_if(a, msg) do { do_die_if( a , msg, __LINE__); } while(0);
+void do_die_if(int b, char* msg, int line)
+{
+	if(!b)
+		return;
+	fprintf(stderr, "Error at line %d: %s\n", line, msg);
+	//fprintf(stderr, "	sysmsg: %s\n", strerror(errno));
+	exit(1);
+}
+
+#define print_info(args...) do { if(!g_quiet) fprintf(stderr, args); } while(0);
+
+void parse_arg(char *arg, int* paddr, int *psize)
+{
+	char *end;
+	*paddr = strtoul(arg, &end, 0);
+	if(*end == ':')
+		*psize = strtoul(++end, 0, 0);
+}
+
+int confirm_action()
+{
+	fprintf(stderr, 
+	"\n"
+	"____________________________WARNING____________________________\n"
+	"Erroneously writing to a system EEPROM (like DIMM SPD modules)\n"
+	"can break your system.  It will NOT boot anymore so you'll not\n"
+	"be able to fix it.\n"
+	"\n"
+	"Reading from 8bit EEPROMs (like that in your DIMM) without using\n"
+	"the -8 switch can also UNEXPECTEDLY write to them, so be sure to\n"
+	"use the -8 command param when required.\n"
+	"\n"
+	"Use -f to disable this warning message\n"
+	"\n"
+	"Press ENTER to continue or hit CTRL-C to exit\n"
+	"\n"
+	);
+	getchar();
+	return 1; 
+}
+
+
+int read_from_eeprom(struct eeprom *e, int addr, int size, int hex)
+{
+
+	int ch, i;
+	// hex print out
+	die_if((ch = eeprom_read_byte(e, addr)) < 0, "read error");
+	i = 1;
+	if(hex)
+		printf("\n %.4x|  %.2x ", addr, ch);
+	else
+		putchar(ch);
+	while(--size)
+	{
+		die_if((ch = eeprom_read_current_byte(e)) < 0, "read error");
+		if(hex)
+		{
+			addr++;
+			if( (i % 16) == 0 ) 
+				printf("\n %.4x|  ", addr);
+			else if( (i % 8) == 0 ) 
+				printf("  ");
+			i++;
+			printf("%.2x ", ch);
+		} else {
+			putchar(ch);
+		}
+	}
+	if(hex)
+		printf("\n\n");
+	fflush(stdout);
+	return 0;
+}
+
+int write_to_eeprom(struct eeprom *e, int addr)
+{
+	int c;
+	while((c = getchar()) != EOF)
+	{
+		print_info(".");
+		fflush(stdout);
+		die_if(eeprom_write_byte(e, addr++, c), "write error");
+	}
+	print_info("\n\n");
+	return 0;
+}
+
+int main(int argc, char** argv)
+{
+	struct eeprom e;
+	int ret, op, i2c_addr, memaddr, size, want_hex, dummy, force, sixteen;
+	char *device, *arg = 0, *i2c_addr_s;
+	struct stat st;
+	int eeprom_type = 0;
+
+	op = want_hex = dummy = force = sixteen = 0;
+	g_quiet = 0;
+
+	while((ret = getopt(argc, argv, "1:8fr:qhw:xd")) != -1)
+	{
+		switch(ret)
+		{
+		case '1':
+			usage_if(*optarg != '6' || strlen(optarg) != 1);
+			die_if(eeprom_type, "EEPROM type switch (-8 or -16) used twice");
+			eeprom_type = EEPROM_TYPE_16BIT_ADDR;	
+			break;
+		case 'x':
+			want_hex++;
+			break;
+		case 'd':
+			dummy++;
+			break;
+		case '8':
+			die_if(eeprom_type, "EEPROM type switch (-8 or -16) used twice");
+			eeprom_type = EEPROM_TYPE_8BIT_ADDR;
+			break;
+		case 'f':
+			force++;
+			break;
+		case 'q':
+			g_quiet++;
+			break;
+		case 'h':
+			usage_if(1);
+			break;
+		default:
+			die_if(op != 0, "Both read and write requested"); 
+			arg = optarg;
+			op = ret;
+		}
+	}
+	if(!eeprom_type)
+		eeprom_type = EEPROM_TYPE_8BIT_ADDR; // default
+
+	usage_if(op == 0); // no switches 
+	// set device and i2c_addr reading from cmdline or env
+	device = i2c_addr_s = 0;
+	switch(argc - optind)
+	{
+	case 0:
+		device = getenv(ENV_DEV);
+		i2c_addr_s = getenv(ENV_I2C_ADDR);
+		break;
+	case 1:
+		if(stat(argv[optind], &st) != -1)
+		{
+			device = argv[optind];
+			i2c_addr_s = getenv(ENV_I2C_ADDR);
+		} else {
+			device = getenv(ENV_DEV);
+			i2c_addr_s = argv[optind];
+		}
+		break;
+	case 2:
+		device = argv[optind++];
+		i2c_addr_s = argv[optind];
+		break;
+	default:
+		usage_if(1);
+	}
+	usage_if(!device || !i2c_addr_s);
+	i2c_addr = strtoul(i2c_addr_s, 0, 0);
+
+	print_info("eeprog %s, a 24Cxx EEPROM reader/writer\n", VERSION);
+	print_info("Copyright (c) 2003 by Stefano Barbato - All rights reserved.\n");
+	print_info("  Bus: %s, Address: 0x%x, Mode: %dbit\n", 
+			device, i2c_addr, 
+			(eeprom_type == EEPROM_TYPE_8BIT_ADDR ? 8 : 16) );
+	if(dummy)
+	{
+		fprintf(stderr, "Dummy mode selected, nothing done.\n");
+		return 0;
+	}
+	die_if(eeprom_open(device, i2c_addr, eeprom_type, &e) < 0, 
+			"unable to open eeprom device file (check that the file exists and that it's readable)");
+	switch(op)
+	{
+	case 'r':
+		if(force == 0)
+			confirm_action();
+		size = 1; // default
+		parse_arg(arg, &memaddr, &size);
+		print_info("  Reading %d bytes from 0x%x\n", size, memaddr);
+		read_from_eeprom(&e, memaddr, size, want_hex);
+		break;
+	case 'w':
+		if(force == 0)
+			confirm_action();
+		parse_arg(arg, &memaddr, &size);
+		print_info("  Writing stdin starting at address 0x%x\n", 
+			memaddr);
+		write_to_eeprom(&e, memaddr);
+		break;
+	default:
+		usage_if(1);
+		exit(1);
+	}
+	eeprom_close(&e);
+
+	return 0;
+}
+
diff --git a/eepromer/24cXX.c b/eepromer/24cXX.c
deleted file mode 100644
index 6a0b610..0000000
--- a/eepromer/24cXX.c
+++ /dev/null
@@ -1,185 +0,0 @@
-/***************************************************************************
-    copyright            : (C) by 2002-2003 Stefano Barbato
-    email                : stefano-IOMW/CzKI+Ng9hUCZPvPmw@public.gmane.org
-
-    $Id$
- ***************************************************************************/
-
-/***************************************************************************
- *                                                                         *
- *   This program is free software; you can redistribute it and/or modify  *
- *   it under the terms of the GNU General Public License as published by  *
- *   the Free Software Foundation; either version 2 of the License, or     *
- *   (at your option) any later version.                                   *
- *                                                                         *
- ***************************************************************************/
-#include <stdio.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <linux/fs.h>
-#include <linux/i2c.h>
-#include <linux/i2c-dev.h>
-#include <sys/types.h>
-#include <sys/ioctl.h>
-#include <errno.h>
-#include <assert.h>
-#include <string.h>
-#include <i2c/smbus.h>
-#include "24cXX.h"
-
-static int i2c_write_1b(struct eeprom *e, __u8 buf)
-{
-	int r;
-	// we must simulate a plain I2C byte write with SMBus functions
-	r = i2c_smbus_write_byte(e->fd, buf);
-	if(r < 0)
-		fprintf(stderr, "Error i2c_write_1b: %s\n", strerror(errno));
-	usleep(10);
-	return r;
-}
-
-static int i2c_write_2b(struct eeprom *e, __u8 buf[2])
-{
-	int r;
-	// we must simulate a plain I2C byte write with SMBus functions
-	r = i2c_smbus_write_byte_data(e->fd, buf[0], buf[1]);
-	if(r < 0)
-		fprintf(stderr, "Error i2c_write_2b: %s\n", strerror(errno));
-	usleep(10);
-	return r;
-}
-
-static int i2c_write_3b(struct eeprom *e, __u8 buf[3])
-{
-	int r;
-	// we must simulate a plain I2C byte write with SMBus functions
-	// the __u16 data field will be byte swapped by the SMBus protocol
-	r = i2c_smbus_write_word_data(e->fd, buf[0], buf[2] << 8 | buf[1]);
-	if(r < 0)
-		fprintf(stderr, "Error i2c_write_3b: %s\n", strerror(errno));
-	usleep(10);
-	return r;
-}
-
-
-#define CHECK_I2C_FUNC( var, label ) \
-	do { 	if(0 == (var & label)) { \
-		fprintf(stderr, "\nError: " \
-			#label " function is required. Program halted.\n\n"); \
-		exit(1); } \
-	} while(0);
-
-int eeprom_open(char *dev_fqn, int addr, int type, struct eeprom* e)
-{
-	int fd, r;
-	unsigned long funcs;
-	e->fd = e->addr = 0;
-	e->dev = 0;
-	
-	fd = open(dev_fqn, O_RDWR);
-	if(fd <= 0)
-		return -1;
-
-	// get funcs list
-	if((r = ioctl(fd, I2C_FUNCS, &funcs) < 0))
-		return r;
-
-	
-	// check for req funcs
-	CHECK_I2C_FUNC( funcs, I2C_FUNC_SMBUS_READ_BYTE );
-	CHECK_I2C_FUNC( funcs, I2C_FUNC_SMBUS_WRITE_BYTE );
-	CHECK_I2C_FUNC( funcs, I2C_FUNC_SMBUS_READ_BYTE_DATA );
-	CHECK_I2C_FUNC( funcs, I2C_FUNC_SMBUS_WRITE_BYTE_DATA );
-	CHECK_I2C_FUNC( funcs, I2C_FUNC_SMBUS_READ_WORD_DATA );
-	CHECK_I2C_FUNC( funcs, I2C_FUNC_SMBUS_WRITE_WORD_DATA );
-
-	// set working device
-	if( ( r = ioctl(fd, I2C_SLAVE, addr)) < 0)
-		return r;
-	e->fd = fd;
-	e->addr = addr;
-	e->dev = dev_fqn;
-	e->type = type;
-	return 0;
-}
-
-int eeprom_close(struct eeprom *e)
-{
-	close(e->fd);
-	e->fd = -1;
-	e->dev = 0;
-	e->type = EEPROM_TYPE_UNKNOWN;
-	return 0;
-}
-
-#if 0
-int eeprom_24c32_write_byte(struct eeprom *e, __u16 mem_addr, __u8 data)
-{
-	__u8 buf[3] = { (mem_addr >> 8) & 0x00ff, mem_addr & 0x00ff, data };
-	return i2c_write_3b(e, buf);
-}
-
-
-int eeprom_24c32_read_current_byte(struct eeprom* e)
-{
-	ioctl(e->fd, BLKFLSBUF); // clear kernel read buffer
-	return i2c_smbus_read_byte(e->fd);
-}
-
-int eeprom_24c32_read_byte(struct eeprom* e, __u16 mem_addr)
-{
-	int r;
-	ioctl(e->fd, BLKFLSBUF); // clear kernel read buffer
-	__u8 buf[2] = { (mem_addr >> 8) & 0x0ff, mem_addr & 0x0ff };
-	r = i2c_write_2b(e, buf);
-	if (r < 0)
-		return r;
-	r = i2c_smbus_read_byte(e->fd);
-	return r;
-}
-#endif
-
-
-int eeprom_read_current_byte(struct eeprom* e)
-{
-	ioctl(e->fd, BLKFLSBUF); // clear kernel read buffer
-	return i2c_smbus_read_byte(e->fd);
-}
-
-int eeprom_read_byte(struct eeprom* e, __u16 mem_addr)
-{
-	int r;
-	ioctl(e->fd, BLKFLSBUF); // clear kernel read buffer
-	if(e->type == EEPROM_TYPE_8BIT_ADDR)
-	{
-		__u8 buf =  mem_addr & 0x0ff;
-		r = i2c_write_1b(e, buf);
-	} else if(e->type == EEPROM_TYPE_16BIT_ADDR) {
-		__u8 buf[2] = { (mem_addr >> 8) & 0x0ff, mem_addr & 0x0ff };
-		r = i2c_write_2b(e, buf);
-	} else {
-		fprintf(stderr, "ERR: unknown eeprom type\n");
-		return -1;
-	}
-	if (r < 0)
-		return r;
-	r = i2c_smbus_read_byte(e->fd);
-	return r;
-}
-
-int eeprom_write_byte(struct eeprom *e, __u16 mem_addr, __u8 data)
-{
-	if(e->type == EEPROM_TYPE_8BIT_ADDR) {
-		__u8 buf[2] = { mem_addr & 0x00ff, data };
-		return i2c_write_2b(e, buf);
-	} else if(e->type == EEPROM_TYPE_16BIT_ADDR) {
-		__u8 buf[3] = 
-			{ (mem_addr >> 8) & 0x00ff, mem_addr & 0x00ff, data };
-		return i2c_write_3b(e, buf);
-	} else {
-		fprintf(stderr, "ERR: unknown eeprom type\n");
-		return -1;
-	}
-}
-
diff --git a/eepromer/24cXX.h b/eepromer/24cXX.h
deleted file mode 100644
index 6b3885b..0000000
--- a/eepromer/24cXX.h
+++ /dev/null
@@ -1,58 +0,0 @@
-/***************************************************************************
-    copyright            : (C) by 2002-2003 Stefano Barbato
-    email                : stefano-IOMW/CzKI+Ng9hUCZPvPmw@public.gmane.org
-
-    $Id$
- ***************************************************************************/
-
-/***************************************************************************
- *                                                                         *
- *   This program is free software; you can redistribute it and/or modify  *
- *   it under the terms of the GNU General Public License as published by  *
- *   the Free Software Foundation; either version 2 of the License, or     *
- *   (at your option) any later version.                                   *
- *                                                                         *
- ***************************************************************************/
-#ifndef _24CXX_H_
-#define _24CXX_H_
-#include <linux/types.h>
-
-#define EEPROM_TYPE_UNKNOWN	0
-#define EEPROM_TYPE_8BIT_ADDR	1
-#define EEPROM_TYPE_16BIT_ADDR 	2
-
-struct eeprom
-{
-	char *dev; 	// device file i.e. /dev/i2c-N
-	int addr;	// i2c address
-	int fd;		// file descriptor
-	int type; 	// eeprom type
-};
-
-/*
- * opens the eeprom device at [dev_fqn] (i.e. /dev/i2c-N) whose address is
- * [addr] and set the eeprom_24c32 [e]
- */
-int eeprom_open(char *dev_fqn, int addr, int type, struct eeprom*);
-/*
- * closees the eeprom device [e] 
- */
-int eeprom_close(struct eeprom *e);
-/*
- * read and returns the eeprom byte at memory address [mem_addr] 
- * Note: eeprom must have been selected by ioctl(fd,I2C_SLAVE,address) 
- */
-int eeprom_read_byte(struct eeprom* e, __u16 mem_addr);
-/*
- * read the current byte
- * Note: eeprom must have been selected by ioctl(fd,I2C_SLAVE,address) 
- */
-int eeprom_read_current_byte(struct eeprom *e);
-/*
- * writes [data] at memory address [mem_addr] 
- * Note: eeprom must have been selected by ioctl(fd,I2C_SLAVE,address) 
- */
-int eeprom_write_byte(struct eeprom *e, __u16 mem_addr, __u8 data);
-
-#endif
-
diff --git a/eepromer/Makefile b/eepromer/Makefile
index 4893f97..b7d38f4 100644
--- a/eepromer/Makefile
+++ b/eepromer/Makefile
@@ -2,13 +2,11 @@
 
 CFLAGS = -O2 -I../include -Wall
 
-all:  eepromer eeprom eeprog
+all:  eepromer eeprom
 
 eepromer:  eepromer.o
 
 eeprom:  eeprom.o
 
-eeprog: eeprog.o 24cXX.o
-
 clean:
-	rm -rf *~ *.o eepromer eeprom eeprog
+	rm -rf *~ *.o eepromer eeprom
diff --git a/eepromer/README.eeprog b/eepromer/README.eeprog
deleted file mode 100644
index 6cccd00..0000000
--- a/eepromer/README.eeprog
+++ /dev/null
@@ -1,12 +0,0 @@
-Important! See the README file for important warnings.
-
-eeprog reads and writes 24Cxx EEPROMs connected to I2C serial bus.
-
-It uses the SMBus protocol used by most of the recent chipsets. Don't forget to load 
-your i2c chipset and the i2c-dev drivers.
-
-Use -16 switch for EEPROM larger then 24C16 (16 bit addressing mode). 
-
-Again, it's really important that you read the README file.
-
-Type "make" to compile.
diff --git a/eepromer/eeprog.8 b/eepromer/eeprog.8
deleted file mode 100644
index 6257cc5..0000000
--- a/eepromer/eeprog.8
+++ /dev/null
@@ -1,103 +0,0 @@
-.\"
-.\"  eeprog.8 - manpage for the i2c-tools/eeprog utility
-.\"  Copyright (C) 2013  Jaromir Capik
-.\"
-.\"  This program is free software; you can redistribute it and/or modify
-.\"  it under the terms of the GNU General Public License as published by
-.\"  the Free Software Foundation; either version 2 of the License, or
-.\"  (at your option) any later version.
-.\"
-.\"  This program is distributed in the hope that it will be useful,
-.\"  but WITHOUT ANY WARRANTY; without even the implied warranty of
-.\"  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-.\"  GNU General Public License for more details.
-.\"
-.\"  You should have received a copy of the GNU General Public License along
-.\"  with this program; if not, write to the Free Software Foundation, Inc.,
-.\"  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-.\"
-.TH eeprog "8" "Jul 2013" "i2c-tools" "System Administration"
-.SH NAME
-eeprog \- reads and writes 24Cxx EEPROMs connected to I2C serial bus
-.SH SYNOPSIS
-.B eeprog
-[-fqxdh] [-16|-8] [-r addr[:count]|-w addr] <device> <i2c-addr>
-.SH DESCRIPTION
-.B eeprog
-uses the SMBus protocol used by most of the recent chipsets.
-.SH NOTE
-Don't forget to load your i2c chipset and the i2c-dev drivers.
-.P
-The following environment variables could be set instead of the command line arguments:
-.P
-    EEPROG_DEV              device
-.br
-    EEPROG_I2C_ADDR         i2c-addr
-.SH PARAMETERS
-.I Address modes
-.TP
-.B \-8
-Use 8bit address mode for 24c0x...24C16 [default]
-.TP
-.B \-16
-Use 16bit address mode for 24c32...24C256
-.TP
-.I Actions
-.TP
-.B \-r addr[:count]
-Read
-.B count
-(1 if omitted) bytes from
-.B addr
-and print them to the standard output
-.TP
-.B \-w addr
-Write input (stdin) at address
-.B addr
-of the EEPROM
-.TP
-.B \-h
-Print this help
-.TP
-.I Options
-.TP
-.B \-x
-Set hex output mode
-.TP
-.B \-d
-Dummy mode, display what *would* have been done
-.TP
-.B \-f
-Disable warnings and don't ask confirmation
-.TP
-.B \-q
-Quiet mode
-.TP
-.I Bus
-.TP
-.B device
-Device file representing the I2C bus (eg. /dev/i2c-0)
-.TP
-.B i2c-addr
-I2C bus address of the EEPROM (eg. 0x3A)
-.SH EXAMPLES
-Read 64 bytes from the EEPROM at address 0x54 on bus 0 starting at address 123 (decimal)
-.P
-.B 	eeprog
-/dev/i2c-0 0x54 -r 123:64
-.P
-Print the hex codes of the first 32 bytes read from bus 1 at address 0x22
-.P
-.B 	eeprog
-/dev/i2c-1 0x51 -x -r 0x22:0x20
-.P
-Write the current timestamp at address 0x200 of the EEPROM on bus 0 at address 0x33
-.P
- 	date |
-.B eeprog
-/dev/i2c-0 0x33 -w 0x200
-.SH SEE ALSO
-.BR eeprom (8),
-.BR eepromer (8)
-.SH AUTHOR
-Stefano Barbato
diff --git a/eepromer/eeprog.c b/eepromer/eeprog.c
deleted file mode 100644
index 95579b6..0000000
--- a/eepromer/eeprog.c
+++ /dev/null
@@ -1,283 +0,0 @@
-/***************************************************************************
-    copyright            : (C) by 2002-2003 Stefano Barbato
-    email                : stefano-IOMW/CzKI+Ng9hUCZPvPmw@public.gmane.org
-
-    $Id$
- ***************************************************************************/
-
-/***************************************************************************
- *                                                                         *
- *   This program is free software; you can redistribute it and/or modify  *
- *   it under the terms of the GNU General Public License as published by  *
- *   the Free Software Foundation; either version 2 of the License, or     *
- *   (at your option) any later version.                                   *
- *                                                                         *
- ***************************************************************************/
-#include <stdio.h>
-#include <fcntl.h>
-#include <getopt.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <errno.h>
-#include <string.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include "24cXX.h"
-
-#define VERSION 	"0.7.5"
-
-#define ENV_DEV		"EEPROG_DEV"
-#define ENV_I2C_ADDR	"EEPROG_I2C_ADDR"
-
-int g_quiet;
-
-#define usage_if(a) do { do_usage_if( a , __LINE__); } while(0);
-void do_usage_if(int b, int line)
-{
-	static const char *eeprog_usage =
-"eeprog " VERSION ", a 24Cxx EEPROM reader/writer\n"
-"Copyright (c) 2003 by Stefano Barbato - All rights reserved.\n"
-"Usage: eeprog [-fqxdh] [-16|-8] [ -r addr[:count] | -w addr ]  /dev/i2c-N  i2c-address\n" 
-"\n"
-"  Address modes:\n"
-"	-8		Use 8bit address mode for 24c0x...24C16 [default]\n"
-"	-16		Use 16bit address mode for 24c32...24C256\n"
-"  Actions:\n"
-"	-r addr[:count]	Read [count] (1 if omitted) bytes from [addr]\n" 
-"			and print them to the standard output\n" 
-"	-w addr		Write input (stdin) at address [addr] of the EEPROM\n"
-"	-h		Print this help\n"
-"  Options:\n"
-"	-x		Set hex output mode\n" 
-"	-d		Dummy mode, display what *would* have been done\n" 
-"	-f		Disable warnings and don't ask confirmation\n"
-"	-q		Quiet mode\n"
-"\n"
-"The following environment variables could be set instead of the command\n"
-"line arguments:\n"
-"	EEPROG_DEV		device name(/dev/i2c-N)\n"
-"	EEPROG_I2C_ADDR		i2c-address\n"
-"\n"
-"	Examples\n"
-"	1- read 64 bytes from the EEPROM at address 0x54 on bus 0 starting\n"
-"	   at address 123 (decimal)\n"
-"		eeprog /dev/i2c-0 0x54 -r 123:64\n"
-"	2- prints the hex codes of the first 32 bytes read from bus 1\n"
-"	   at address 0x22\n"
-"		eeprog /dev/i2c-1 0x51 -x -r 0x22:0x20\n"
-"	3- write the current timestamp at address 0x200 of the EEPROM on\n"
-"	   bus 0 at address 0x33\n"
-"		date | eeprog /dev/i2c-0 0x33 -w 0x200\n";
-
-	if(!b)
-		return;
-	fprintf(stderr, "%s\n[line %d]\n", eeprog_usage, line);
-	exit(1);
-}
-
-
-#define die_if(a, msg) do { do_die_if( a , msg, __LINE__); } while(0);
-void do_die_if(int b, char* msg, int line)
-{
-	if(!b)
-		return;
-	fprintf(stderr, "Error at line %d: %s\n", line, msg);
-	//fprintf(stderr, "	sysmsg: %s\n", strerror(errno));
-	exit(1);
-}
-
-#define print_info(args...) do { if(!g_quiet) fprintf(stderr, args); } while(0);
-
-void parse_arg(char *arg, int* paddr, int *psize)
-{
-	char *end;
-	*paddr = strtoul(arg, &end, 0);
-	if(*end == ':')
-		*psize = strtoul(++end, 0, 0);
-}
-
-int confirm_action()
-{
-	fprintf(stderr, 
-	"\n"
-	"____________________________WARNING____________________________\n"
-	"Erroneously writing to a system EEPROM (like DIMM SPD modules)\n"
-	"can break your system.  It will NOT boot anymore so you'll not\n"
-	"be able to fix it.\n"
-	"\n"
-	"Reading from 8bit EEPROMs (like that in your DIMM) without using\n"
-	"the -8 switch can also UNEXPECTEDLY write to them, so be sure to\n"
-	"use the -8 command param when required.\n"
-	"\n"
-	"Use -f to disable this warning message\n"
-	"\n"
-	"Press ENTER to continue or hit CTRL-C to exit\n"
-	"\n"
-	);
-	getchar();
-	return 1; 
-}
-
-
-int read_from_eeprom(struct eeprom *e, int addr, int size, int hex)
-{
-
-	int ch, i;
-	// hex print out
-	die_if((ch = eeprom_read_byte(e, addr)) < 0, "read error");
-	i = 1;
-	if(hex)
-		printf("\n %.4x|  %.2x ", addr, ch);
-	else
-		putchar(ch);
-	while(--size)
-	{
-		die_if((ch = eeprom_read_current_byte(e)) < 0, "read error");
-		if(hex)
-		{
-			addr++;
-			if( (i % 16) == 0 ) 
-				printf("\n %.4x|  ", addr);
-			else if( (i % 8) == 0 ) 
-				printf("  ");
-			i++;
-			printf("%.2x ", ch);
-		} else {
-			putchar(ch);
-		}
-	}
-	if(hex)
-		printf("\n\n");
-	fflush(stdout);
-	return 0;
-}
-
-int write_to_eeprom(struct eeprom *e, int addr)
-{
-	int c;
-	while((c = getchar()) != EOF)
-	{
-		print_info(".");
-		fflush(stdout);
-		die_if(eeprom_write_byte(e, addr++, c), "write error");
-	}
-	print_info("\n\n");
-	return 0;
-}
-
-int main(int argc, char** argv)
-{
-	struct eeprom e;
-	int ret, op, i2c_addr, memaddr, size, want_hex, dummy, force, sixteen;
-	char *device, *arg = 0, *i2c_addr_s;
-	struct stat st;
-	int eeprom_type = 0;
-
-	op = want_hex = dummy = force = sixteen = 0;
-	g_quiet = 0;
-
-	while((ret = getopt(argc, argv, "1:8fr:qhw:xd")) != -1)
-	{
-		switch(ret)
-		{
-		case '1':
-			usage_if(*optarg != '6' || strlen(optarg) != 1);
-			die_if(eeprom_type, "EEPROM type switch (-8 or -16) used twice");
-			eeprom_type = EEPROM_TYPE_16BIT_ADDR;	
-			break;
-		case 'x':
-			want_hex++;
-			break;
-		case 'd':
-			dummy++;
-			break;
-		case '8':
-			die_if(eeprom_type, "EEPROM type switch (-8 or -16) used twice");
-			eeprom_type = EEPROM_TYPE_8BIT_ADDR;
-			break;
-		case 'f':
-			force++;
-			break;
-		case 'q':
-			g_quiet++;
-			break;
-		case 'h':
-			usage_if(1);
-			break;
-		default:
-			die_if(op != 0, "Both read and write requested"); 
-			arg = optarg;
-			op = ret;
-		}
-	}
-	if(!eeprom_type)
-		eeprom_type = EEPROM_TYPE_8BIT_ADDR; // default
-
-	usage_if(op == 0); // no switches 
-	// set device and i2c_addr reading from cmdline or env
-	device = i2c_addr_s = 0;
-	switch(argc - optind)
-	{
-	case 0:
-		device = getenv(ENV_DEV);
-		i2c_addr_s = getenv(ENV_I2C_ADDR);
-		break;
-	case 1:
-		if(stat(argv[optind], &st) != -1)
-		{
-			device = argv[optind];
-			i2c_addr_s = getenv(ENV_I2C_ADDR);
-		} else {
-			device = getenv(ENV_DEV);
-			i2c_addr_s = argv[optind];
-		}
-		break;
-	case 2:
-		device = argv[optind++];
-		i2c_addr_s = argv[optind];
-		break;
-	default:
-		usage_if(1);
-	}
-	usage_if(!device || !i2c_addr_s);
-	i2c_addr = strtoul(i2c_addr_s, 0, 0);
-
-	print_info("eeprog %s, a 24Cxx EEPROM reader/writer\n", VERSION);
-	print_info("Copyright (c) 2003 by Stefano Barbato - All rights reserved.\n");
-	print_info("  Bus: %s, Address: 0x%x, Mode: %dbit\n", 
-			device, i2c_addr, 
-			(eeprom_type == EEPROM_TYPE_8BIT_ADDR ? 8 : 16) );
-	if(dummy)
-	{
-		fprintf(stderr, "Dummy mode selected, nothing done.\n");
-		return 0;
-	}
-	die_if(eeprom_open(device, i2c_addr, eeprom_type, &e) < 0, 
-			"unable to open eeprom device file (check that the file exists and that it's readable)");
-	switch(op)
-	{
-	case 'r':
-		if(force == 0)
-			confirm_action();
-		size = 1; // default
-		parse_arg(arg, &memaddr, &size);
-		print_info("  Reading %d bytes from 0x%x\n", size, memaddr);
-		read_from_eeprom(&e, memaddr, size, want_hex);
-		break;
-	case 'w':
-		if(force == 0)
-			confirm_action();
-		parse_arg(arg, &memaddr, &size);
-		print_info("  Writing stdin starting at address 0x%x\n", 
-			memaddr);
-		write_to_eeprom(&e, memaddr);
-		break;
-	default:
-		usage_if(1);
-		exit(1);
-	}
-	eeprom_close(&e);
-
-	return 0;
-}
-
-- 
2.1.4
