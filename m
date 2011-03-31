From: Konstantin Porotchkin <kostap-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] Support power management in i2c mv64xx driver
Date: Thu, 31 Mar 2011 16:40:10 +0200
Message-ID: <1301582411-2437-4-git-send-email-kostap@marvell.com>
References: <1301582411-2437-1-git-send-email-kostap@marvell.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1301582411-2437-1-git-send-email-kostap-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Konstantin Porotchkin <kostap-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Added resume operation for PM support

Signed-off-by: Konstantin Porotchkin <kostap-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-mv64xxx.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index a6e9a3f..b246dab 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -638,9 +638,23 @@ mv64xxx_i2c_remove(struct platform_device *dev)
 	return rc;
 }
 
+#ifdef CONFIG_PM
+static int
+mv64xxx_i2c_resume(struct platform_device *dev)
+{
+	struct mv64xxx_i2c_data	*drv_data = platform_get_drvdata(dev);
+	mv64xxx_i2c_hw_init(drv_data);
+	return 0;
+}
+
+#else
+#define mv64xxx_i2c_resume NULL
+#endif
+
 static struct platform_driver mv64xxx_i2c_driver = {
 	.probe	= mv64xxx_i2c_probe,
 	.remove	= __devexit_p(mv64xxx_i2c_remove),
+	.resume = mv64xxx_i2c_resume,
 	.driver	= {
 		.owner	= THIS_MODULE,
 		.name	= MV64XXX_I2C_CTLR_NAME,
-- 
1.7.4.1
