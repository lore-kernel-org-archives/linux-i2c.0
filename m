From: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
Subject: [PATCH] i2c-ocores: basic PM support.
Date: Thu, 19 Jun 2008 10:30:22 +0200
Message-ID: <20080619083022.GB20058@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>

Basic PM support: reinit the core on resume, disable it on suspend.

Signed-off-by: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
---
 drivers/i2c/busses/i2c-ocores.c |   42 ++++++++++++++++++++++++++++++++------
 1 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 876d3f8..f530ec7 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -29,6 +29,7 @@ struct ocores_i2c {
 	int pos;
 	int nmsgs;
 	int state; /* see STATE_ */
+	int clock_khz;
 };
 
 /* registers */
@@ -173,8 +174,7 @@ static int ocores_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 		return -ETIMEDOUT;
 }
 
-static void ocores_init(struct ocores_i2c *i2c,
-			struct ocores_i2c_platform_data *pdata)
+static void ocores_init(struct ocores_i2c *i2c)
 {
 	int prescale;
 	u8 ctrl = oc_getreg(i2c, OCI2C_CONTROL);
@@ -182,7 +182,7 @@ static void ocores_init(struct ocores_i2c *i2c,
 	/* make sure the device is disabled */
 	oc_setreg(i2c, OCI2C_CONTROL, ctrl & ~(OCI2C_CTRL_EN|OCI2C_CTRL_IEN));
 
-	prescale = (pdata->clock_khz / (5*100)) - 1;
+	prescale = (i2c->clock_khz / (5*100)) - 1;
 	oc_setreg(i2c, OCI2C_PRELOW, prescale & 0xff);
 	oc_setreg(i2c, OCI2C_PREHIGH, prescale >> 8);
 
@@ -248,7 +248,8 @@ static int __devinit ocores_i2c_probe(struct platform_device *pdev)
 	}
 
 	i2c->regstep = pdata->regstep;
-	ocores_init(i2c, pdata);
+	i2c->clock_khz = pdata->clock_khz;
+	ocores_init(i2c);
 
 	init_waitqueue_head(&i2c->wait);
 	ret = request_irq(res2->start, ocores_isr, 0, pdev->name, i2c);
@@ -313,13 +314,40 @@ static int __devexit ocores_i2c_remove(struct platform_device* pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int ocores_i2c_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct ocores_i2c *i2c = platform_get_drvdata(pdev);
+	u8 ctrl = oc_getreg(i2c, OCI2C_CONTROL);
+
+	/* make sure the device is disabled */
+	oc_setreg(i2c, OCI2C_CONTROL, ctrl & ~(OCI2C_CTRL_EN|OCI2C_CTRL_IEN));
+
+	return 0;
+}
+
+static int ocores_i2c_resume(struct platform_device *pdev)
+{
+	struct ocores_i2c *i2c = platform_get_drvdata(pdev);
+
+	ocores_init(i2c);
+
+	return 0;
+}
+#else
+#define ocores_i2c_suspend	NULL
+#define ocores_i2c_resume	NULL
+#endif
+
 /* work with hotplug and coldplug */
 MODULE_ALIAS("platform:ocores-i2c");
 
 static struct platform_driver ocores_i2c_driver = {
-	.probe  = ocores_i2c_probe,
-	.remove = __devexit_p(ocores_i2c_remove),
-	.driver = {
+	.probe   = ocores_i2c_probe,
+	.remove  = __devexit_p(ocores_i2c_remove),
+	.suspend = ocores_i2c_suspend,
+	.resume  = ocores_i2c_resume,
+	.driver  = {
 		.owner = THIS_MODULE,
 		.name = "ocores-i2c",
 	},
-- 
1.5.5.4


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
