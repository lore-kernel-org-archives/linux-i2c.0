From: Cengiz Can <cengizc@gmail.com>
Subject: [PATCH] i2c: update i2c-dev.h warning in documentation
Date: Sat, 9 Dec 2017 23:10:58 +0300
Message-ID: <20171209231058.270ce75c@nostromo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

`dev-interface` document gives examples for accessing i2c from
userspace.

There's a note warning developers about the different `i2c-dev.h` header
files which were shipped with the kernel and i2c-tools separately.

However, these commits in i2c-tools repository suggests that the header
files are now identical (in functionality) and `i2c_*` functions are now
defined in a separate header called `i2c/smbus.h`, which is distributed
with i2c-tools:

commit 652619121974 ("Minimize differences with kernel flavor")
commit 93caf007f4cb ("Move SMBus helper functions to include/i2c/smbus.h")

Thus, I've converted the warning paragraph into a historical note and
updated the suggested header files.

Signed-off-by: Cengiz Can <cengizc@gmail.com>
---
Sorry for duplicate mails. My email client hard-wrapped previous patch.

Thanks.

 Documentation/i2c/dev-interface | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/Documentation/i2c/dev-interface b/Documentation/i2c/dev-interface
index 5ff19447ac44..04d110697863 100644
--- a/Documentation/i2c/dev-interface
+++ b/Documentation/i2c/dev-interface
@@ -9,21 +9,24 @@ i2c adapters present on your system at a given time. i2cdetect is part of
 the i2c-tools package.
 
 I2C device files are character device files with major device number 89
-and a minor device number corresponding to the number assigned as 
-explained above. They should be called "i2c-%d" (i2c-0, i2c-1, ..., 
+and a minor device number corresponding to the number assigned as
+explained above. They should be called "i2c-%d" (i2c-0, i2c-1, ...,
 i2c-10, ...). All 256 minor device numbers are reserved for i2c.
 
 
 C example
 =========
 
-So let's say you want to access an i2c adapter from a C program. The
-first thing to do is "#include <linux/i2c-dev.h>". Please note that
-there are two files named "i2c-dev.h" out there, one is distributed
-with the Linux kernel and is meant to be included from kernel
-driver code, the other one is distributed with i2c-tools and is
-meant to be included from user-space programs. You obviously want
-the second one here.
+So let's say you want to access an i2c adapter from a C program. First, you
+need to include these two headers:
+
+  #include <linux/i2c-dev.h>
+  #include <i2c/smbus.h>
+
+(Please note that there are two files named "i2c-dev.h" out there. One is
+distributed with the Linux kernel and the other one is included in the
+source tree of i2c-tools. They used to be different in content but since 2012
+they're identical. You should use "linux/i2c-dev.h").
 
 Now, you have to decide which adapter you want to access. You should
 inspect /sys/class/i2c-dev/ or run "i2cdetect -l" to decide this.
@@ -35,7 +38,7 @@ Next thing, open the device file, as follows:
   int file;
   int adapter_nr = 2; /* probably dynamically determined */
   char filename[20];
-  
+
   snprintf(filename, 19, "/dev/i2c-%d", adapter_nr);
   file = open(filename, O_RDWR);
   if (file < 0) {
@@ -69,7 +72,7 @@ the device supports them. Both are illustrated below.
     /* res contains the read word */
   }
 
-  /* Using I2C Write, equivalent of 
+  /* Using I2C Write, equivalent of
      i2c_smbus_write_word_data(file, reg, 0x6543) */
   buf[0] = reg;
   buf[1] = 0x43;
@@ -144,7 +147,7 @@ You can do plain i2c transactions by using read(2) and write(2) calls.
 You do not need to pass the address byte; instead, set it through
 ioctl I2C_SLAVE before you try to access the device.
 
-You can do SMBus level transactions (see documentation file smbus-protocol 
+You can do SMBus level transactions (see documentation file smbus-protocol
 for details) through the following functions:
   __s32 i2c_smbus_write_quick(int file, __u8 value);
   __s32 i2c_smbus_read_byte(int file);
@@ -155,7 +158,7 @@ for details) through the following functions:
   __s32 i2c_smbus_write_word_data(int file, __u8 command, __u16 value);
   __s32 i2c_smbus_process_call(int file, __u8 command, __u16 value);
   __s32 i2c_smbus_read_block_data(int file, __u8 command, __u8 *values);
-  __s32 i2c_smbus_write_block_data(int file, __u8 command, __u8 length, 
+  __s32 i2c_smbus_write_block_data(int file, __u8 command, __u8 length,
                                    __u8 *values);
 All these transactions return -1 on failure; you can read errno to see
 what happened. The 'write' transactions return 0 on success; the
-- 
2.15.1



-- 
	Cengiz Can
