From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 5/5] i2c-designware-baytrail: baytrail_i2c_acquire() might sleep
Date: Tue, 10 Feb 2015 19:06:10 +0200
Message-ID: <1423587970-19136-5-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1423587970-19136-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1423587970-19136-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch marks baytrail_i2c_acquire() that it might sleep. Also it chages
while-loop to do-while and, though it is matter of taste, gives a chance to
check one more time before report a timeout.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-baytrail.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-baytrail.c b/drivers/i2c/busses/i2c-designware-baytrail.c
index 036d9bdc0..7d7ae97 100644
--- a/drivers/i2c/busses/i2c-designware-baytrail.c
+++ b/drivers/i2c/busses/i2c-designware-baytrail.c
@@ -68,6 +68,8 @@ static int baytrail_i2c_acquire(struct dw_i2c_dev *dev)
 	int ret;
 	unsigned long start, end;
 
+	might_sleep();
+
 	if (!dev || !dev->dev)
 		return -ENODEV;
 
@@ -85,7 +87,7 @@ static int baytrail_i2c_acquire(struct dw_i2c_dev *dev)
 	/* host driver waits for bit 0 to be set in semaphore register */
 	start = jiffies;
 	end = start + msecs_to_jiffies(SEMAPHORE_TIMEOUT);
-	while (!time_after(jiffies, end)) {
+	do {
 		ret = get_sem(dev->dev, &sem);
 		if (!ret && sem) {
 			acquired = jiffies;
@@ -95,7 +97,7 @@ static int baytrail_i2c_acquire(struct dw_i2c_dev *dev)
 		}
 
 		usleep_range(1000, 2000);
-	}
+	} while (time_before(jiffies, end));
 
 	dev_err(dev->dev, "punit semaphore timed out, resetting\n");
 	reset_semaphore(dev->dev);
-- 
2.1.4
