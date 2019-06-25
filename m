From: AceLan Kao <acelan.kao@canonical.com>
Subject: [PATCH] i2c: designware: Add disable runtime pm quirk
Date: Tue, 25 Jun 2019 16:30:51 +0800
Message-ID: <20190625083051.30332-1-acelan.kao@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Dell machines come with goodix touchpad IC suffer from the double click
issue if the Designware I2C adapter enters runtime suspend.

It's because the goodix re-assert the interrupt if host doesn't read the
data within 100ms and designware takes a longer time to wake up from
runtime suspend. In the case, it got a second interrupt during
resuming, so it thinks it's a double click.

There is no simple way to fix this, it's a firmware issue and goodix
agrees to fix this in their firmware on next release, but this issue
still affects the machines that don't come with an updated firmware. So,
add a quirk to mark those machines and avoid the designware from
entering runtime suspend.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=202683

Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 drivers/i2c/busses/i2c-designware-master.c | 30 ++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index d464799e40a3..4048a66355f6 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -9,6 +9,7 @@
  * Copyright (C) 2009 Provigent Ltd.
  */
 #include <linux/delay.h>
+#include <linux/dmi.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/export.h>
@@ -22,6 +23,25 @@
 
 #include "i2c-designware-core.h"
 
+static int no_runtime_pm;
+static const struct dmi_system_id i2c_dw_no_runtime_pm[] = {
+	{
+		.ident = "Dell Inspiron 5390",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 5390"),
+		},
+	},
+	{
+		.ident = "Dell Vostro 5390",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 5390"),
+		},
+	},
+	{ }
+};
+
 static void i2c_dw_configure_fifo_master(struct dw_i2c_dev *dev)
 {
 	/* Configure Tx/Rx FIFO threshold levels */
@@ -424,7 +444,8 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 	dev_dbg(dev->dev, "%s: msgs: %d\n", __func__, num);
 
-	pm_runtime_get_sync(dev->dev);
+	if (!no_runtime_pm)
+		pm_runtime_get_sync(dev->dev);
 
 	if (dev_WARN_ONCE(dev->dev, dev->suspended, "Transfer while suspended\n")) {
 		ret = -ESHUTDOWN;
@@ -501,7 +522,8 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 done_nolock:
 	pm_runtime_mark_last_busy(dev->dev);
-	pm_runtime_put_autosuspend(dev->dev);
+	if (!no_runtime_pm)
+		pm_runtime_put_autosuspend(dev->dev);
 
 	return ret;
 }
@@ -733,6 +755,10 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 	if (ret)
 		return ret;
 
+	no_runtime_pm = dmi_check_system(i2c_dw_no_runtime_pm);
+	if (no_runtime_pm)
+		__pm_runtime_disable(dev->dev, true);
+
 	/*
 	 * Increment PM usage count during adapter registration in order to
 	 * avoid possible spurious runtime suspend when adapter device is
-- 
2.17.1
