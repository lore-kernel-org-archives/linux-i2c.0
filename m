From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c-tools: add .gitignore
Date: Wed,  3 Aug 2016 10:55:47 +0200
Message-ID: <1470214547-3113-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:38883 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752270AbcHCLCE (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 3 Aug 2016 07:02:04 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>

Don't display generated files, so 'git status' becomes useful again.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 .gitignore       | 8 ++++++++
 tools/.gitignore | 4 ++++
 2 files changed, 12 insertions(+)
 create mode 100644 .gitignore
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
diff --git a/tools/.gitignore b/tools/.gitignore
new file mode 100644
index 0000000..18c268a
--- /dev/null
+++ b/tools/.gitignore
@@ -0,0 +1,4 @@
+i2cdump
+i2cset
+i2cget
+i2cdetect
-- 
2.8.1
