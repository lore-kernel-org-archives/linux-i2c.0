From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2] i2c-tools: add .gitignore
Date: Tue,  9 Aug 2016 22:54:59 +0200
Message-ID: <1470776099-16278-1-git-send-email-wsa+renesas@sang-engineering.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:60158 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752441AbcHIUzS (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 9 Aug 2016 16:55:18 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>

Don't display generated files, so 'git status' becomes useful again.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 .gitignore          | 8 ++++++++
 eeprog/.gitignore   | 1 +
 eepromer/.gitignore | 2 ++
 tools/.gitignore    | 4 ++++
 4 files changed, 15 insertions(+)
 create mode 100644 .gitignore
 create mode 100644 eeprog/.gitignore
 create mode 100644 eepromer/.gitignore
 create mode 100644 tools/.gitignore

diff --git a/.gitignore b/.gitignore
new file mode 100644
index 0000000..0d86cb6
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1,8 @@
+.*
+*.o
+*.o.*
+*.a
+*.so
+*.so.*
+*.so.dbg
+*.ao
diff --git a/eeprog/.gitignore b/eeprog/.gitignore
new file mode 100644
index 0000000..916cb72
--- /dev/null
+++ b/eeprog/.gitignore
@@ -0,0 +1 @@
+/eeprog
diff --git a/eepromer/.gitignore b/eepromer/.gitignore
new file mode 100644
index 0000000..5f76592
--- /dev/null
+++ b/eepromer/.gitignore
@@ -0,0 +1,2 @@
+/eeprom
+/eepromer
diff --git a/tools/.gitignore b/tools/.gitignore
new file mode 100644
index 0000000..b029dd5
--- /dev/null
+++ b/tools/.gitignore
@@ -0,0 +1,4 @@
+/i2cdump
+/i2cset
+/i2cget
+/i2cdetect
-- 
2.8.1
