From: Kieran Bingham <kieran@ksquared.org.uk>
Subject: [PATCH] cocci: Find i2c drivers with an of_device table that isn't exported
Date: Tue, 10 May 2016 15:39:25 +0100
Message-ID: <1462891165-25013-1-git-send-email-kieran@bingham.xyz>
References: <8df98822-22d4-7d03-2b84-6e96e0b6f8af@osg.samsung.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32927 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395AbcEJOjb (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 10 May 2016 10:39:31 -0400
In-Reply-To: <8df98822-22d4-7d03-2b84-6e96e0b6f8af@osg.samsung.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: javier@osg.samsung.com, lee.jones@linaro.org
Cc: kieran@ksquared.org.uk, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, sameo@linux.intel.com

This script will then add the MODULE_DEVICE_TABLE(of, ...) to correctly export
the device tree table

Usage: spatch --sp-file scripts/coccinelle/i2c/i2c_table_missing_export.cocci . --in-place
---

Javier,

I've been working on scripts to automate some of the conversion processes
involved in this DT_I2C project.

This one adds missing exports for i2c device tables.

Feel free to use it if it helps.

I have another one which searches for drivers which have both an I2C device table, and an OF device table,
and a probe function which does not use the second parameter.

It then performs the conversion to the probe_new() and removes the I2C device table.

Should help with the bulk of the conversion

--
Kieran

 .../coccinelle/i2c/of_table_missing_export.cocci   | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 scripts/coccinelle/i2c/of_table_missing_export.cocci

diff --git a/scripts/coccinelle/i2c/of_table_missing_export.cocci b/scripts/coccinelle/i2c/of_table_missing_export.cocci
new file mode 100644
index 000000000000..5d1950fdf8a3
--- /dev/null
+++ b/scripts/coccinelle/i2c/of_table_missing_export.cocci
@@ -0,0 +1,34 @@
+// Look for I2C drivers without an exported of_device_id table
+//
+
+// C1 : Identify the i2c_device_id array
+
+@ i2c_dev_id @
+identifier arr;
+@@
+struct i2c_device_id arr[] = { ... };
+
+// C2 : For now, we only want to match on I2C drivers
+
+@ dev_id depends on i2c_dev_id @
+identifier arr;
+@@
+struct of_device_id arr[] = { ... };
+
+// C2 : Check if we already export the MODULE_DEVICE_TABLE
+
+@ of_dev_table depends on dev_id @
+declarer name MODULE_DEVICE_TABLE;
+identifier of;
+identifier dev_id.arr;
+@@
+ MODULE_DEVICE_TABLE(of, arr);
+
+
+// A1: Export it!
+
+@ add_mod_dev_table depends on !of_dev_table @
+identifier dev_id.arr;
+@@
+struct of_device_id arr[] = { ... };
++ MODULE_DEVICE_TABLE(of, arr);
-- 
2.5.0
