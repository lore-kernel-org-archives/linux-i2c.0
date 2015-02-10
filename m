From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 3/5] i2c-designware-baytrail: fix sparse warnings
Date: Tue, 10 Feb 2015 19:06:08 +0200
Message-ID: <1423587970-19136-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1423587970-19136-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1423587970-19136-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

There is no need to export functions that are used as the callbacks in the
struct dw_i2c_dev. Otherwise we get the following warnings:

drivers/i2c/busses/i2c-designware-baytrail.c:63:5: warning: symbol 'baytrail_i2c_acquire' was not declared. Should it be static?
drivers/i2c/busses/i2c-designware-baytrail.c:114:6: warning: symbol 'baytrail_i2c_release' was not declared. Should it be static?

While here, do few indentation fixes, remove i2c_dw_eval_lock_support() from
functions exported to the modules and redundant assignment of local sem
variable.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-baytrail.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-baytrail.c b/drivers/i2c/busses/i2c-designware-baytrail.c
index 9b67655..d334744 100644
--- a/drivers/i2c/busses/i2c-designware-baytrail.c
+++ b/drivers/i2c/busses/i2c-designware-baytrail.c
@@ -17,7 +17,9 @@
 #include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
+
 #include <asm/iosf_mbi.h>
+
 #include "i2c-designware-core.h"
 
 #define SEMAPHORE_TIMEOUT	100
@@ -60,9 +62,9 @@ static void reset_semaphore(struct device *dev)
 		dev_err(dev, "iosf failed to reset punit semaphore during write\n");
 }
 
-int baytrail_i2c_acquire(struct dw_i2c_dev *dev)
+static int baytrail_i2c_acquire(struct dw_i2c_dev *dev)
 {
-	u32 sem = 0;
+	u32 sem;
 	int ret;
 	unsigned long start, end;
 
@@ -109,9 +111,8 @@ int baytrail_i2c_acquire(struct dw_i2c_dev *dev)
 
 	return -ETIMEDOUT;
 }
-EXPORT_SYMBOL(baytrail_i2c_acquire);
 
-void baytrail_i2c_release(struct dw_i2c_dev *dev)
+static void baytrail_i2c_release(struct dw_i2c_dev *dev)
 {
 	if (!dev || !dev->dev)
 		return;
@@ -123,7 +124,6 @@ void baytrail_i2c_release(struct dw_i2c_dev *dev)
 	dev_dbg(dev->dev, "punit semaphore held for %ums\n",
 		jiffies_to_msecs(jiffies - acquired));
 }
-EXPORT_SYMBOL(baytrail_i2c_release);
 
 int i2c_dw_eval_lock_support(struct dw_i2c_dev *dev)
 {
@@ -139,7 +139,6 @@ int i2c_dw_eval_lock_support(struct dw_i2c_dev *dev)
 		return 0;
 
 	status = acpi_evaluate_integer(handle, "_SEM", NULL, &shared_host);
-
 	if (ACPI_FAILURE(status))
 		return 0;
 
@@ -155,7 +154,6 @@ int i2c_dw_eval_lock_support(struct dw_i2c_dev *dev)
 
 	return 0;
 }
-EXPORT_SYMBOL(i2c_dw_eval_lock_support);
 
 MODULE_AUTHOR("David E. Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>");
 MODULE_DESCRIPTION("Baytrail I2C Semaphore driver");
-- 
2.1.4
