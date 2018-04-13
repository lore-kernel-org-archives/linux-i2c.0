From: Sam Hansen <hansens@google.com>
Subject: [PATCH v2 3/3] Documentation/i2c: adopt kernel commenting style in examples
Date: Fri, 13 Apr 2018 09:44:05 -0700
Message-ID: <20180413164405.127522-3-hansens@google.com>
References: <CAP9bUy7rONNHYeRkYtaWHcfqoZcGKXJz-JocED26zBj9n+-ZbQ@mail.gmail.com>
 <20180413164405.127522-1-hansens@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180413164405.127522-1-hansens@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Sam Hansen <hansens@google.com>, wsa@the-dreams.de, corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The example I2C code is rewritten to adopt the preferred kernel block
commenting style.

Signed-off-by: Sam Hansen <hansens@google.com>
---
 Documentation/i2c/dev-interface | 57 +++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 14 deletions(-)

diff --git a/Documentation/i2c/dev-interface b/Documentation/i2c/dev-interface
index f92ee1f59914..e17f5814c199 100644
--- a/Documentation/i2c/dev-interface
+++ b/Documentation/i2c/dev-interface
@@ -30,24 +30,34 @@ assume much about them. They can even change from one boot to the next.
 
 Next thing, open the device file, as follows:
 
+  /*
+   * The adapter is probably dynamically determined.
+   */
   int file;
-  int adapter_nr = 2; /* probably dynamically determined */
+  int adapter_nr = 2;
   char filename[20];
 
   snprintf(filename, 19, "/dev/i2c-%d", adapter_nr);
   file = open(filename, O_RDWR);
   if (file < 0) {
-    /* ERROR HANDLING; you can check errno to see what went wrong */
+    /*
+     * ERROR HANDLING; you can check errno to see what went wrong.
+     */
     exit(1);
   }
 
 When you have opened the device, you must specify with what device
 address you want to communicate:
 
-  int addr = 0x40; /* The I2C address */
+  /*
+   * The I2C address.
+   */
+  int addr = 0x40;
 
   if (ioctl(file, I2C_SLAVE, addr) < 0) {
-    /* ERROR HANDLING; you can check errno to see what went wrong */
+    /*
+     * ERROR HANDLING; you can check errno to see what went wrong.
+     */
     exit(1);
   }
 
@@ -55,32 +65,51 @@ Well, you are all set up now. You can now use SMBus commands or plain
 I2C to communicate with your device. SMBus commands are preferred if
 the device supports them. Both are illustrated below.
 
-  __u8 reg = 0x10; /* Device register to access */
+  /*
+   * The device register to access.
+   */
+  __u8 reg = 0x10;
   __s32 res;
   char buf[10];
 
-  /* Using SMBus commands */
+  /*
+   * Using SMBus commands.
+   */
   res = i2c_smbus_read_word_data(file, reg);
   if (res < 0) {
-    /* ERROR HANDLING: i2c transaction failed */
+    /*
+     * ERROR HANDLING: i2c transaction failed.
+     */
   } else {
-    /* res contains the read word */
+    /*
+     * res contains the read word.
+     */
   }
 
-  /* Using I2C Write, equivalent of
-     i2c_smbus_write_word_data(file, reg, 0x6543) */
+  /*
+   * Using I2C Write, equivalent of
+   * i2c_smbus_write_word_data(file, reg, 0x6543).
+   */
   buf[0] = reg;
   buf[1] = 0x43;
   buf[2] = 0x65;
   if (write(file, buf, 3) != 3) {
-    /* ERROR HANDLING: i2c transaction failed */
+    /*
+     * ERROR HANDLING: i2c transaction failed.
+     */
   }
 
-  /* Using I2C Read, equivalent of i2c_smbus_read_byte(file) */
+  /*
+   * Using I2C Read, equivalent of i2c_smbus_read_byte(file).
+   */
   if (read(file, buf, 1) != 1) {
-    /* ERROR HANDLING: i2c transaction failed */
+    /*
+     * ERROR HANDLING: i2c transaction failed.
+     */
   } else {
-    /* buf[0] contains the read byte */
+    /*
+     * buf[0] contains the read byte.
+     */
   }
 
 Note that only a subset of the I2C and SMBus protocols can be achieved by
-- 
2.17.0.484.g0c8726318c-goog
