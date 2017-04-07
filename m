From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH i2c-tools-3.1] i2c-tools: add new tool 'i2ctransfer'
Date: Fri,  7 Apr 2017 14:44:03 +0200
Message-ID: <20170407124403.1880-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

This tool allows to construct and concat multiple I2C messages into one
single transfer. Its aim is to test I2C master controllers, and so there
is no SMBus fallback.

I've been missing such a tool a number of times now, so I finally got
around to writing it myself. As with all I2C tools, it can be dangerous,
but it can also be very useful when developing.

It has been tested with various Renesas I2C IP cores as well as Tegra,
i.MX and AT91.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

This is the same tool from the master branch based on top of the i2c-tools-3.1
branch. This branch is what most people use and maybe we can release 3.1.3 or
3.2. after a while so 'i2ctransfer' can go into the wild? This is a plain copy
of the latest version of the master branch with mainly Module.mk modifications
to match the slightly different build process. Codewise, only changes are
"linux/i2c.h" won't get #included, and *buf is here char instead of __u8 to
match the declaration of the provided header file. Not as extensively tested
as the master-branch version yet, will do in the next days. Assistance in that
would be much appreciated!

 tools/Module.mk     |   8 +-
 tools/i2ctransfer.8 | 159 ++++++++++++++++++++++++
 tools/i2ctransfer.c | 341 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 507 insertions(+), 1 deletion(-)
 create mode 100644 tools/i2ctransfer.8
 create mode 100644 tools/i2ctransfer.c

diff --git a/tools/Module.mk b/tools/Module.mk
index 8ad8fc0..05ad2ac 100644
--- a/tools/Module.mk
+++ b/tools/Module.mk
@@ -13,7 +13,7 @@ TOOLS_CFLAGS	:= -Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual \
 		   -Wcast-align -Wwrite-strings -Wnested-externs -Winline \
 		   -W -Wundef -Wmissing-prototypes -Iinclude
 
-TOOLS_TARGETS	:= i2cdetect i2cdump i2cset i2cget
+TOOLS_TARGETS	:= i2cdetect i2cdump i2cset i2cget i2ctransfer
 
 #
 # Programs
@@ -31,6 +31,9 @@ $(TOOLS_DIR)/i2cset: $(TOOLS_DIR)/i2cset.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)
 $(TOOLS_DIR)/i2cget: $(TOOLS_DIR)/i2cget.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)/util.o
 	$(CC) $(LDFLAGS) -o $@ $^
 
+$(TOOLS_DIR)/i2ctransfer: $(TOOLS_DIR)/i2ctransfer.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)/util.o
+	$(CC) $(LDFLAGS) -o $@ $^ $(TOOLS_LDFLAGS)
+
 #
 # Objects
 #
@@ -47,6 +50,9 @@ $(TOOLS_DIR)/i2cset.o: $(TOOLS_DIR)/i2cset.c $(TOOLS_DIR)/i2cbusses.h $(TOOLS_DI
 $(TOOLS_DIR)/i2cget.o: $(TOOLS_DIR)/i2cget.c $(TOOLS_DIR)/i2cbusses.h $(TOOLS_DIR)/util.h version.h $(INCLUDE_DIR)/linux/i2c-dev.h
 	$(CC) $(CFLAGS) $(TOOLS_CFLAGS) -c $< -o $@
 
+$(TOOLS_DIR)/i2ctransfer.o: $(TOOLS_DIR)/i2ctransfer.c $(TOOLS_DIR)/i2cbusses.h $(TOOLS_DIR)/util.h version.h $(INCLUDE_DIR)/linux/i2c-dev.h
+	$(CC) $(CFLAGS) $(TOOLS_CFLAGS) -c $< -o $@
+
 $(TOOLS_DIR)/i2cbusses.o: $(TOOLS_DIR)/i2cbusses.c $(TOOLS_DIR)/i2cbusses.h $(INCLUDE_DIR)/linux/i2c-dev.h
 	$(CC) $(CFLAGS) $(TOOLS_CFLAGS) -c $< -o $@
 
diff --git a/tools/i2ctransfer.8 b/tools/i2ctransfer.8
new file mode 100644
index 0000000..0dd43c9
--- /dev/null
+++ b/tools/i2ctransfer.8
@@ -0,0 +1,159 @@
+.TH i2ctransfer 8 "February 2017"
+.SH "NAME"
+i2ctransfer \- send user-defined I2C messages in one transfer
+
+.SH SYNOPSIS
+.B i2ctransfer
+.RB [ -f ]
+.RB [ -y ]
+.RB [ -v ]
+.I i2cbus desc
+.RI [ data ]
+.RI [ desc
+.RI [ data ]]
+.RI ...
+.br
+.B i2ctransfer
+.B -V
+
+.SH DESCRIPTION
+.B i2ctransfer
+is a program to create I2C messages and send them combined as one transfer.
+For read messages, the contents of the received buffers are printed to stdout, one line per read message.
+.br
+Please note the difference between a
+.I transfer
+and a
+.I message
+here.
+A transfer may consist of multiple messages and is started with a START condition and ends with a STOP condition as described in the I2C specification.
+Messages within the transfer are concatenated using the REPEATED START condition which is described there as well.
+There are some advantages of having multiple messages in one transfer.
+First, some devices keep their internal states for REPEATED START but reset them after a STOP.
+Second, you cannot get interrupted during one transfer, but it might happen between multiple transfers.
+Interruption could happen on hardware level by another I2C master on the bus, or at software level by another I2C user who got its transfer scheduled between yours.
+This program helps you to create proper transfers for your needs.
+
+.SH OPTIONS
+.TP
+.B -f
+Force access to the device even if it is already busy.
+By default,
+.B i2ctransfer
+will refuse to access addresses marked as reserved by the I2C standard or to a device which is already under the control of a kernel driver.
+Using this flag is dangerous, it can seriously confuse the kernel driver in question.
+It can also cause
+.B i2ctransfer
+to silently write to the wrong register.
+So use at your own risk and only if you know what you're doing.
+.TP
+.B -y
+Disable interactive mode.
+By default,
+.B i2ctransfer
+will wait for a confirmation from the user before messing with the I2C bus.
+When this flag is used, it will perform the operation directly.
+This is mainly meant to be used in scripts.
+.TP
+.B -v
+Enable verbose output.
+It will print infos about all messages sent, i.e. not only for read messages but also for write messages.
+.TP
+.B -V
+Display the version and exit.
+
+.SH ARGUMENTS
+.PP
+The first parameter
+.I i2cbus
+indicates the number or name of the I2C bus to be used.
+This number should correspond to one of the busses listed by
+.B i2cdetect -l.
+
+.PP
+The next parameter is one or multiple
+.I desc
+blocks.
+The number of blocks is limited by the Linux Kernel and defined by I2C_RDWR_IOCTL_MAX_MSGS (42 as of v4.10).
+.I desc
+blocks are composed like this:
+
+.I {r|w}<length_of_message>[@address]
+
+.TP
+.B {r|w}
+specifies if the message is read or write
+.TP
+.B <length_of_message>
+specifies the number of bytes read or written in this message.
+It is parsed as an unsigned 16 bit integer, but note that the Linux Kernel applies an additional upper limit (8192 as of v4.10).
+.TP
+.B [@address]
+specifies the 7-bit address of the chip to be accessed for this message, and is an integer.
+If omitted, reuse the previous address.
+Normally, addresses outside the range of 0x03-0x77 and addresses with a kernel driver attached to them will be blocked.
+With
+.I -f
+(force), all addresses can be used.
+Be very careful when using that!
+10-bit addresses are currently not supported at all.
+
+.PP
+If the I2C message is a write, then a
+.I data
+block with the data to be written follows.
+It consists of
+.I <length_of_message>
+bytes which can be marked with the usual prefixes for hexadecimal, octal, etc.
+To make it easier to create larger data blocks easily, the data byte can have a suffix.
+
+.TP
+=
+keep value constant until end of message (i.e. 0= means 0, 0, 0, ...)
+.TP
++
+increase value by 1 until end of message (i.e. 0+ means 0, 1, 2, ...)
+.TP
+-
+decrease value by 1 until end of message (i.e. 0xff- means 0xff, 0xfe, 0xfd, ...)
+.TP
+p
+use value as seed for an 8 bit pseudo random sequence (i.e. 0p means 0x00, 0x50, 0xb0, ...)
+
+.SH EXAMPLES
+.PP
+On bus 0, from an EEPROM at address 0x50, read 8 byte from offset 0x64
+(first message writes one byte to set the memory pointer to 0x64, second message reads from the same chip):
+.nf
+.RS
+# i2ctransfer 0 w1@0x50 0x64 r8
+.RE
+.fi
+.PP
+For the same EEPROM, at offset 0x42 write 0xff 0xfe ... 0xf0
+(one write message; first byte sets the memory pointer to 0x42, 0xff is the first data byte, all following data bytes are decreased by one):
+.nf
+.RS
+# i2ctransfer 0 w17@0x50 0x42 0xff-
+.RE
+.fi
+
+.SH WARNING
+.B i2ctransfer
+can be extremely dangerous if used improperly.
+It can confuse your I2C bus, cause data loss, or have more serious side effects.
+Writing to a serial EEPROM on a memory DIMM (chip addresses between 0x50 and 0x57) may DESTROY your memory, leaving your system unbootable!
+Be extremely careful using this program.
+
+.SH AUTHORS
+Wolfram Sang, based on
+.B i2cget
+by Jean Delvare
+
+This manual page was originally written by Wolfram Sang based on the manual
+for
+.B i2cset
+by David Z Maze <dmaze@debian.org>.
+
+.SH SEE ALSO
+.BR i2cdetect (8), i2cdump (8), i2cget (8), i2cset (8)
diff --git a/tools/i2ctransfer.c b/tools/i2ctransfer.c
new file mode 100644
index 0000000..0b23d9d
--- /dev/null
+++ b/tools/i2ctransfer.c
@@ -0,0 +1,341 @@
+/*
+    i2ctransfer.c - A user-space program to send concatenated i2c messages
+    Copyright (C) 2015-17 Wolfram Sang <wsa@sang-engineering.com>
+    Copyright (C) 2015-17 Renesas Electronics Corporation
+
+    Based on i2cget.c:
+    Copyright (C) 2005-2012  Jean Delvare <jdelvare@suse.de>
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
+*/
+
+#include <sys/ioctl.h>
+#include <errno.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <linux/i2c-dev.h>
+#include "i2cbusses.h"
+#include "util.h"
+#include "../version.h"
+
+enum parse_state {
+	PARSE_GET_DESC,
+	PARSE_GET_DATA,
+};
+
+#define PRINT_STDERR	(1 << 0)
+#define PRINT_READ_BUF	(1 << 1)
+#define PRINT_WRITE_BUF	(1 << 2)
+#define PRINT_HEADER	(1 << 3)
+
+static void help(void)
+{
+	fprintf(stderr,
+		"Usage: i2ctransfer [-f] [-y] [-v] [-V] I2CBUS DESC [DATA] [DESC [DATA]]...\n"
+		"  I2CBUS is an integer or an I2C bus name\n"
+		"  DESC describes the transfer in the form: {r|w}LENGTH[@address]\n"
+		"    1) read/write-flag 2) LENGTH (range 0-65535) 3) I2C address (use last one if omitted)\n"
+		"  DATA are LENGTH bytes for a write message. They can be shortened by a suffix:\n"
+		"    = (keep value constant until LENGTH)\n"
+		"    + (increase value by 1 until LENGTH)\n"
+		"    - (decrease value by 1 until LENGTH)\n"
+		"    p (use pseudo random generator until LENGTH with value as seed)\n\n"
+		"Example (bus 0, read 8 byte at offset 0x64 from EEPROM at 0x50):\n"
+		"  # i2ctransfer 0 w1@0x50 0x64 r8\n"
+		"Example (same EEPROM, at offset 0x42 write 0xff 0xfe ... 0xf0):\n"
+		"  # i2ctransfer 0 w17@0x50 0x42 0xff-\n");
+}
+
+static int check_funcs(int file)
+{
+	unsigned long funcs;
+
+	/* check adapter functionality */
+	if (ioctl(file, I2C_FUNCS, &funcs) < 0) {
+		fprintf(stderr, "Error: Could not get the adapter "
+			"functionality matrix: %s\n", strerror(errno));
+		return -1;
+	}
+
+	if (!(funcs & I2C_FUNC_I2C)) {
+		fprintf(stderr, MISSING_FUNC_FMT, "I2C transfers");
+		return -1;
+	}
+
+	return 0;
+}
+
+static void print_msgs(struct i2c_msg *msgs, __u32 nmsgs, unsigned flags)
+{
+	FILE *output = flags & PRINT_STDERR ? stderr : stdout;
+	unsigned i;
+	__u16 j;
+
+	for (i = 0; i < nmsgs; i++) {
+		int read = msgs[i].flags & I2C_M_RD;
+		int print_buf = (read && (flags & PRINT_READ_BUF)) ||
+				(!read && (flags & PRINT_WRITE_BUF));
+
+		if (flags & PRINT_HEADER)
+			fprintf(output, "msg %u: addr 0x%02x, %s, len %u",
+				i, msgs[i].addr, read ? "read" : "write", msgs[i].len);
+
+		if (msgs[i].len && print_buf) {
+			if (flags & PRINT_HEADER)
+				fprintf(output, ", buf ");
+			for (j = 0; j < msgs[i].len - 1; j++)
+				fprintf(output, "0x%02x ", msgs[i].buf[j]);
+			/* Print final byte with newline */
+			fprintf(output, "0x%02x\n", msgs[i].buf[j]);
+		} else if (flags & PRINT_HEADER) {
+			fprintf(output, "\n");
+		}
+	}
+}
+
+static int confirm(const char *filename, struct i2c_msg *msgs, __u32 nmsgs)
+{
+	fprintf(stderr, "WARNING! This program can confuse your I2C bus, cause data loss and worse!\n");
+	fprintf(stderr, "I will send the following messages to device file %s:\n", filename);
+	print_msgs(msgs, nmsgs, PRINT_STDERR | PRINT_HEADER | PRINT_WRITE_BUF);
+
+	fprintf(stderr, "Continue? [y/N] ");
+	fflush(stderr);
+	if (!user_ack(0)) {
+		fprintf(stderr, "Aborting on user request.\n");
+		return 0;
+	}
+
+	return 1;
+}
+
+int main(int argc, char *argv[])
+{
+	char filename[20];
+	int i2cbus, address = -1, file, arg_idx = 1, nmsgs = 0, nmsgs_sent, i;
+	int force = 0, yes = 0, version = 0, verbose = 0;
+	struct i2c_msg msgs[I2C_RDRW_IOCTL_MAX_MSGS];
+	enum parse_state state = PARSE_GET_DESC;
+	unsigned buf_idx = 0;
+
+	for (i = 0; i < I2C_RDRW_IOCTL_MAX_MSGS; i++)
+		msgs[i].buf = NULL;
+
+	/* handle (optional) arg_idx first */
+	while (arg_idx < argc && argv[arg_idx][0] == '-') {
+		switch (argv[arg_idx][1]) {
+		case 'V': version = 1; break;
+		case 'v': verbose = 1; break;
+		case 'f': force = 1; break;
+		case 'y': yes = 1; break;
+		default:
+			fprintf(stderr, "Error: Unsupported option \"%s\"!\n",
+				argv[arg_idx]);
+			help();
+			exit(1);
+		}
+		arg_idx++;
+	}
+
+	if (version) {
+		fprintf(stderr, "i2ctransfer version %s\n", VERSION);
+		exit(0);
+	}
+
+	if (arg_idx == argc) {
+		help();
+		exit(1);
+	}
+
+	i2cbus = lookup_i2c_bus(argv[arg_idx++]);
+	if (i2cbus < 0)
+		exit(1);
+
+	file = open_i2c_dev(i2cbus, filename, sizeof(filename), 0);
+	if (file < 0 || check_funcs(file))
+		exit(1);
+
+	while (arg_idx < argc) {
+		char *arg_ptr = argv[arg_idx];
+		unsigned long len, raw_data;
+		__u16 flags;
+		__u8 data;
+		char *end, *buf;
+
+		if (nmsgs > I2C_RDRW_IOCTL_MAX_MSGS) {
+			fprintf(stderr, "Error: Too many messages (max: %d)\n",
+				I2C_RDRW_IOCTL_MAX_MSGS);
+			goto err_out;
+		}
+
+		switch (state) {
+		case PARSE_GET_DESC:
+			flags = 0;
+
+			switch (*arg_ptr++) {
+			case 'r': flags |= I2C_M_RD; break;
+			case 'w': break;
+			default:
+				fprintf(stderr, "Error: Invalid direction\n");
+				goto err_out_with_arg;
+			}
+
+			len = strtoul(arg_ptr, &end, 0);
+			if (len > 0xffff || arg_ptr == end) {
+				fprintf(stderr, "Error: Length invalid\n");
+				goto err_out_with_arg;
+			}
+
+			arg_ptr = end;
+			if (*arg_ptr) {
+				if (*arg_ptr++ != '@') {
+					fprintf(stderr, "Error: Unknown separator after length\n");
+					goto err_out_with_arg;
+				}
+
+				/* We skip 10-bit support for now. If we want it,
+				 * it should be marked with a 't' flag before
+				 * the address here.
+				 */
+
+				if (!force) {
+					address = parse_i2c_address(arg_ptr);
+					if (address < 0)
+						goto err_out_with_arg;
+
+					/* Ensure address is not busy */
+					if (set_slave_addr(file, address, 0))
+						goto err_out_with_arg;
+				} else {
+					/* 'force' allows whole address range */
+					address = strtol(arg_ptr, &end, 0);
+					if (arg_ptr == end || *end || address > 0x7f) {
+						fprintf(stderr, "Error: Invalid chip address\n");
+						goto err_out_with_arg;
+					}
+				}
+			} else {
+				/* Reuse last address if possible */
+				if (address < 0) {
+					fprintf(stderr, "Error: No address given\n");
+					goto err_out_with_arg;
+				}
+			}
+
+			msgs[nmsgs].addr = address;
+			msgs[nmsgs].flags = flags;
+			msgs[nmsgs].len = len;
+
+			if (len) {
+				buf = malloc(len);
+				if (!buf) {
+					fprintf(stderr, "Error: No memory for buffer\n");
+					goto err_out_with_arg;
+				}
+				memset(buf, 0, len);
+				msgs[nmsgs].buf = buf;
+			}
+
+			if (flags & I2C_M_RD || len == 0) {
+				nmsgs++;
+			} else {
+				buf_idx = 0;
+				state = PARSE_GET_DATA;
+			}
+
+			break;
+
+		case PARSE_GET_DATA:
+			raw_data = strtoul(arg_ptr, &end, 0);
+			if (raw_data > 0xff || arg_ptr == end) {
+				fprintf(stderr, "Error: Invalid data byte\n");
+				goto err_out_with_arg;
+			}
+			data = raw_data;
+			len = msgs[nmsgs].len;
+
+			while (buf_idx < len) {
+				msgs[nmsgs].buf[buf_idx++] = data;
+
+				if (!*end)
+					break;
+
+				switch (*end) {
+				/* Pseudo randomness (8 bit AXR with a=13 and b=27) */
+				case 'p':
+					data = (data ^ 27) + 13;
+					data = (data << 1) | (data >> 7);
+					break;
+				case '+': data++; break;
+				case '-': data--; break;
+				case '=': break;
+				default:
+					fprintf(stderr, "Error: Invalid data byte suffix\n");
+					goto err_out_with_arg;
+				}
+			}
+
+			if (buf_idx == len) {
+				nmsgs++;
+				state = PARSE_GET_DESC;
+			}
+
+			break;
+
+		default:
+			/* Should never happen */
+			fprintf(stderr, "Internal Error: Unknown state in state machine!\n");
+			goto err_out;
+		}
+
+		arg_idx++;
+	}
+
+	if (state != PARSE_GET_DESC || nmsgs == 0) {
+		fprintf(stderr, "Error: Incomplete message\n");
+		goto err_out;
+	}
+
+	if (yes || confirm(filename, msgs, nmsgs)) {
+		struct i2c_rdwr_ioctl_data rdwr;
+
+		rdwr.msgs = msgs;
+		rdwr.nmsgs = nmsgs;
+		nmsgs_sent = ioctl(file, I2C_RDWR, &rdwr);
+		if (nmsgs_sent < 0) {
+			fprintf(stderr, "Error: Sending messages failed: %s\n", strerror(errno));
+			goto err_out;
+		} else if (nmsgs_sent < nmsgs) {
+			fprintf(stderr, "Warning: only %d/%d messages were sent\n", nmsgs_sent, nmsgs);
+		}
+
+		print_msgs(msgs, nmsgs_sent, PRINT_READ_BUF | (verbose ? PRINT_HEADER | PRINT_WRITE_BUF : 0));
+	}
+
+	close(file);
+
+	for (i = 0; i < nmsgs; i++)
+		free(msgs[i].buf);
+
+	exit(0);
+
+ err_out_with_arg:
+	fprintf(stderr, "Error: faulty argument is '%s'\n", argv[arg_idx]);
+ err_out:
+	close(file);
+
+	for (i = 0; i <= nmsgs; i++)
+		free(msgs[i].buf);
+
+	exit(1);
+}
-- 
2.11.0
