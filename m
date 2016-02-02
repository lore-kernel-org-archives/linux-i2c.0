From: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] Doc: i2c: Fix typo in Documentation/i2c
Date: Tue,  2 Feb 2016 20:41:25 +0900
Message-ID: <1454413285-3499-1-git-send-email-standby24x7@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: corbet@lwn.net, wsa@the-dreams.de, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: Masanari Iida <standby24x7@gmail.com>
List-Id: linux-i2c@vger.kernel.org

This path fix spelling typos found in Documentation/i2c.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 Documentation/i2c/dev-interface        | 2 +-
 Documentation/i2c/slave-eeprom-backend | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/i2c/dev-interface b/Documentation/i2c/dev-interface
index 2ac78ae..bcf919d 100644
--- a/Documentation/i2c/dev-interface
+++ b/Documentation/i2c/dev-interface
@@ -4,7 +4,7 @@ the /dev interface. You need to load module i2c-dev for this.
 
 Each registered i2c adapter gets a number, counting from 0. You can
 examine /sys/class/i2c-dev/ to see what number corresponds to which adapter.
-Alternatively, you can run "i2cdetect -l" to obtain a formated list of all
+Alternatively, you can run "i2cdetect -l" to obtain a formatted list of all
 i2c adapters present on your system at a given time. i2cdetect is part of
 the i2c-tools package.
 
diff --git a/Documentation/i2c/slave-eeprom-backend b/Documentation/i2c/slave-eeprom-backend
index c8444ef..04f8d8a 100644
--- a/Documentation/i2c/slave-eeprom-backend
+++ b/Documentation/i2c/slave-eeprom-backend
@@ -7,8 +7,8 @@ This is a proof-of-concept backend which acts like an EEPROM on the connected
 I2C bus. The memory contents can be modified from userspace via this file
 located in sysfs:
 
-	/sys/bus/i2c/devices/<device-direcory>/slave-eeprom
+	/sys/bus/i2c/devices/<device-directory>/slave-eeprom
 
 As of 2015, Linux doesn't support poll on binary sysfs files, so there is no
-notfication when another master changed the content.
+notification when another master changed the content.
 
-- 
2.7.0.229.g701fa7f
