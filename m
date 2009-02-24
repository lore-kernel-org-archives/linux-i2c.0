From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 1/3] i2c/algo-pca: rework waiting for a free bus
Date: Tue, 24 Feb 2009 17:22:14 +0100
Message-ID: <1235492536-31695-2-git-send-email-w.sang@pengutronix.de>
References: <1235492536-31695-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1235492536-31695-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Waiting for a free bus now accepts the timeout value in jiffies and does
proper checking using time_before.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/algos/i2c-algo-pca.c |   18 ++++++++++--------
 drivers/i2c/busses/i2c-pca-isa.c |    2 +-
 include/linux/i2c-pca-platform.h |    2 +-
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-algo-pca.c
index a8e51bd..59ee88a 100644
--- a/drivers/i2c/algos/i2c-algo-pca.c
+++ b/drivers/i2c/algos/i2c-algo-pca.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/delay.h>
+#include <linux/jiffies.h>
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/i2c.h>
@@ -186,14 +187,15 @@ static int pca_xfer(struct i2c_adapter *i2c_adap,
 	int numbytes = 0;
 	int state;
 	int ret;
-	int timeout = i2c_adap->timeout;
+	unsigned long timeout = jiffies + i2c_adap->timeout;
 
-	while ((state = pca_status(adap)) != 0xf8 && timeout--) {
-		msleep(10);
-	}
-	if (state != 0xf8) {
-		dev_dbg(&i2c_adap->dev, "bus is not idle. status is %#04x\n", state);
-		return -EAGAIN;
+	while (pca_status(adap) != 0xf8) {
+		if (time_before(jiffies, timeout)) {
+			msleep(10);
+		} else {
+			dev_dbg(&i2c_adap->dev, "bus is not idle. status is %#04x\n", state);
+			return -EAGAIN;
+		}
 	}
 
 	DEB1("{{{ XFER %d messages\n", num);
diff --git a/drivers/i2c/busses/i2c-pca-isa.c b/drivers/i2c/busses/i2c-pca-isa.c
index 8835de2..84d035c 100644
--- a/drivers/i2c/busses/i2c-pca-isa.c
+++ b/drivers/i2c/busses/i2c-pca-isa.c
@@ -103,7 +103,7 @@ static struct i2c_adapter pca_isa_ops = {
 	.owner          = THIS_MODULE,
 	.algo_data	= &pca_isa_data,
 	.name		= "PCA9564/PCA9665 ISA Adapter",
-	.timeout	= 100,
+	.timeout	= HZ,
 };
 
 static int __devinit pca_isa_match(struct device *dev, unsigned int id)
diff --git a/include/linux/i2c-pca-platform.h b/include/linux/i2c-pca-platform.h
index 3d19187..aba3375 100644
--- a/include/linux/i2c-pca-platform.h
+++ b/include/linux/i2c-pca-platform.h
@@ -6,7 +6,7 @@ struct i2c_pca9564_pf_platform_data {
 				 * not supplied (negative value), but it
 				 * cannot exit some error conditions then */
 	int i2c_clock_speed;	/* values are defined in linux/i2c-algo-pca.h */
-	int timeout;		/* timeout = this value * 10us */
+	int timeout;		/* timeout in jiffies */
 };
 
 #endif /* I2C_PCA9564_PLATFORM_H */
-- 
1.5.6.5
