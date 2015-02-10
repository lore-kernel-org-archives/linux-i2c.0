From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 1/5] i2c-designware-baytrail: describe magic numbers
Date: Tue, 10 Feb 2015 19:06:06 +0200
Message-ID: <1423587970-19136-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The patch converts hardcoded numerical constants to a named ones.

While here, align the variable name in get_sem() and reset_semaphore().

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-baytrail.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-baytrail.c b/drivers/i2c/busses/i2c-designware-baytrail.c
index 5f1ff4c..e9cb355 100644
--- a/drivers/i2c/busses/i2c-designware-baytrail.c
+++ b/drivers/i2c/busses/i2c-designware-baytrail.c
@@ -22,22 +22,24 @@
 
 #define SEMAPHORE_TIMEOUT	100
 #define PUNIT_SEMAPHORE		0x7
+#define PUNIT_SEMAPHORE_BIT	BIT(0)
+#define PUNIT_SEMAPHORE_ACQUIRE	BIT(1)
 
 static unsigned long acquired;
 
 static int get_sem(struct device *dev, u32 *sem)
 {
-	u32 reg_val;
+	u32 data;
 	int ret;
 
 	ret = iosf_mbi_read(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_READ, PUNIT_SEMAPHORE,
-			    &reg_val);
+				&data);
 	if (ret) {
 		dev_err(dev, "iosf failed to read punit semaphore\n");
 		return ret;
 	}
 
-	*sem = reg_val & 0x1;
+	*sem = data & PUNIT_SEMAPHORE_BIT;
 
 	return 0;
 }
@@ -52,9 +54,9 @@ static void reset_semaphore(struct device *dev)
 		return;
 	}
 
-	data = data & 0xfffffffe;
+	data &= ~PUNIT_SEMAPHORE_BIT;
 	if (iosf_mbi_write(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_WRITE,
-				 PUNIT_SEMAPHORE, data))
+				PUNIT_SEMAPHORE, data))
 		dev_err(dev, "iosf failed to reset punit semaphore during write\n");
 }
 
@@ -70,9 +72,9 @@ int baytrail_i2c_acquire(struct dw_i2c_dev *dev)
 	if (!dev->acquire_lock)
 		return 0;
 
-	/* host driver writes 0x2 to side band semaphore register */
+	/* host driver writes to side band semaphore register */
 	ret = iosf_mbi_write(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_WRITE,
-				 PUNIT_SEMAPHORE, 0x2);
+				PUNIT_SEMAPHORE, PUNIT_SEMAPHORE_ACQUIRE);
 	if (ret) {
 		dev_err(dev->dev, "iosf punit semaphore request failed\n");
 		return ret;
-- 
2.1.4
