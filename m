From: Kieran Bingham <kieran@ksquared.org.uk>
Subject: [PATCH] cocci: Provide script to find i2c_tables missing exports
Date: Tue, 10 May 2016 16:07:23 +0100
Message-ID: <1462892843-32409-1-git-send-email-kieran@bingham.xyz>
References: <8df98822-22d4-7d03-2b84-6e96e0b6f8af@osg.samsung.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36106 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbcEJPH3 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 10 May 2016 11:07:29 -0400
In-Reply-To: <8df98822-22d4-7d03-2b84-6e96e0b6f8af@osg.samsung.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: javier@osg.samsung.com, lee.jones@linaro.org
Cc: kieran@ksquared.org.uk, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, sameo@linux.intel.com

Adds MODULE_DEVICE_TABLE(i2c, ...) to correctly export tables in i2c drivers
---
Ahem, My appologies, I wrongly sent the patch I was working on for OF tables,

Of course this is the correct patch for adding the i2c_device_id exports,
which I think is what you are currently looking at
--
Kieran

 .../coccinelle/i2c/i2c_table_missing_export.cocci  | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 scripts/coccinelle/i2c/i2c_table_missing_export.cocci

diff --git a/scripts/coccinelle/i2c/i2c_table_missing_export.cocci b/scripts/coccinelle/i2c/i2c_table_missing_export.cocci
new file mode 100644
index 000000000000..58c06856e4d4
--- /dev/null
+++ b/scripts/coccinelle/i2c/i2c_table_missing_export.cocci
@@ -0,0 +1,30 @@
+// Look for I2C drivers without an exported i2c_device_id table,
+// and export it using the MODULE_DEVICE_TABLE();
+//
+// Usage:
+// spatch --sp-file scripts/coccinelle/i2c/i2c_table_missing_export.cocci . --in-place
+
+// C1 : Identify the i2c_device_id array
+
+@ dev_id @
+identifier arr;
+@@
+struct i2c_device_id arr[] = { ... };
+
+// C2 : Check if we already export the MODULE_DEVICE_TABLE
+
+@ i2c_dev_table depends on dev_id @
+declarer name MODULE_DEVICE_TABLE;
+identifier i2c;
+identifier dev_id.arr;
+@@
+ MODULE_DEVICE_TABLE(i2c, arr);
+
+
+// A1: Export it!
+
+@ add_mod_dev_table depends on !i2c_dev_table @
+identifier dev_id.arr;
+@@
+struct i2c_device_id arr[] = { ... };
++ MODULE_DEVICE_TABLE(i2c, arr);
-- 
2.5.0
