From: Roman Fietze <roman.fietze-rVvtEhYSWBkAey3BTtE3dg@public.gmane.org>
Subject: Const buffer pointers for SMBus/I2C block write functions
Date: Tue, 16 Nov 2010 06:57:10 +0100
Message-ID: <201011160657.11061.roman.fietze@telemotive.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello List Members,

I was asked to post this patch here.

If the SMBus and I2C block write functions in i2c-dev.h (the version
from lm-sensors, not the kernel) would take const buffer pointers,
this would allow callers to use const data to be sent via SMB/I2C.

Please see the diff below.


Index: include/linux/i2c-dev.h
===================================================================
--- include/linux/i2c-dev.h	(revision 5881)
+++ include/linux/i2c-dev.h	(working copy)
@@ -258,7 +258,7 @@
 }
 
 static inline __s32 i2c_smbus_write_block_data(int file, __u8 command, 
-                                               __u8 length, __u8 *values)
+                                               __u8 length, const __u8 *values)
 {
 	union i2c_smbus_data data;
 	int i;
@@ -296,7 +296,7 @@
 }
 
 static inline __s32 i2c_smbus_write_i2c_block_data(int file, __u8 command,
-                                               __u8 length, __u8 *values)
+                                               __u8 length, const __u8 *values)
 {
 	union i2c_smbus_data data;
 	int i;


Roman

-- 
Roman Fietze              Telemotive AG Buero Muehlhausen
Breitwiesen                             73347 Muehlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
