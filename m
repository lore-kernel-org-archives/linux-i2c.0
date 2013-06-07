From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 1/2] i2c-mv64xxx: Fix timing issue on Armada XP (errata FE-8471889)
Date: Fri,  7 Jun 2013 17:48:59 +0200
Message-ID: <1370620140-17177-2-git-send-email-gregory.clement@free-electrons.com>
References: <1370620140-17177-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1370620140-17177-1-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Eran Ben-Avi <benavi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ike Pan <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Chris Van Hoof <vanhoof-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Dan Frazier <dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Leif Lindholm <leif.lindholm-5wv7dgnIgG8@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Marlin <dmarlin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Zbigniew Bodek <zb>
List-Id: linux-i2c@vger.kernel.org

From: Zbigniew Bodek <zbb-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>

All the Armada XP (mv78230, mv78260 and mv78460) have a silicon issue
in the I2C controller which violate the i2c repeated start
timing. The I2C standard requires a minimum of 4.7us for the repeated
start condition whereas the I2C controller of the Armada XP this time
is 2.9us.

So this patch adds a 5us delay for the start case only if the
mv64xxx_i2c_errata_delay flag is set.

[gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org: Merge the incoming commits into
this single one]
[gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org: Reword the commit log]

Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Signed-off-by: Zbigniew Bodek <zbb-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 1a3abd6..60cac9f 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -23,6 +23,7 @@
 #include <linux/of_i2c.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/delay.h>
 
 /* Register defines */
 #define	MV64XXX_I2C_REG_SLAVE_ADDR			0x00
@@ -59,6 +60,12 @@
 #define	MV64XXX_I2C_STATUS_MAST_RD_ADDR_2_NO_ACK	0xe8
 #define	MV64XXX_I2C_STATUS_NO_STATUS			0xf8
 
+/*
+ * 5us delay in order to avoid repeated start
+ * timing violation on Armada XP SoC.
+ */
+static int mv64xxx_i2c_errata_delay;
+
 /* Driver states */
 enum {
 	MV64XXX_I2C_STATE_INVALID,
@@ -252,6 +259,9 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 		writel(drv_data->cntl_bits,
 			drv_data->reg_base + MV64XXX_I2C_REG_CONTROL);
 		drv_data->block = 0;
+		if (mv64xxx_i2c_errata_delay)
+			udelay(5);
+
 		wake_up(&drv_data->waitq);
 		break;
 
@@ -300,6 +310,9 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 		writel(drv_data->cntl_bits | MV64XXX_I2C_REG_CONTROL_STOP,
 			drv_data->reg_base + MV64XXX_I2C_REG_CONTROL);
 		drv_data->block = 0;
+		if (mv64xxx_i2c_errata_delay)
+			udelay(5);
+
 		wake_up(&drv_data->waitq);
 		break;
 
@@ -592,6 +605,10 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 	 * So hard code the value to 1 second.
 	 */
 	drv_data->adapter.timeout = HZ;
+
+	if (!mv64xxx_i2c_errata_delay &&
+	    of_machine_is_compatible("marvell,armadaxp"))
+		mv64xxx_i2c_errata_delay = 1;
 out:
 	return rc;
 #endif
-- 
1.8.1.2
