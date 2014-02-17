From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V3 16/17] i2c: nomadik: Remove busy check for transfers at suspend late
Date: Mon, 17 Feb 2014 16:21:02 +0100
Message-ID: <1392650462-14960-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

We should never be busy performing transfers at suspend late, thus
there are no reason to check for it.

Cc: Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 0a6d438..ceb3d05 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -167,7 +167,6 @@ struct i2c_nmk_client {
  * @stop: stop condition.
  * @xfer_complete: acknowledge completion for a I2C message.
  * @result: controller propogated result.
- * @busy: Busy doing transfer.
  */
 struct nmk_i2c_dev {
 	struct i2c_vendor_data		*vendor;
@@ -185,7 +184,6 @@ struct nmk_i2c_dev {
 	int				stop;
 	struct completion		xfer_complete;
 	int				result;
-	bool				busy;
 };
 
 /* controller's abort causes */
@@ -671,8 +669,6 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 	struct nmk_i2c_dev *dev = i2c_get_adapdata(i2c_adap);
 	int j;
 
-	dev->busy = true;
-
 	pm_runtime_get_sync(&dev->adev->dev);
 
 	/* Attempt three times to send the message queue */
@@ -697,8 +693,6 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 
 	pm_runtime_put_sync(&dev->adev->dev);
 
-	dev->busy = false;
-
 	/* return the no. messages processed */
 	if (status)
 		return status;
@@ -888,9 +882,6 @@ static int nmk_i2c_suspend_late(struct device *dev)
 	struct amba_device *adev = to_amba_device(dev);
 	struct nmk_i2c_dev *nmk_i2c = amba_get_drvdata(adev);
 
-	if (nmk_i2c->busy)
-		return -EBUSY;
-
 	pinctrl_pm_select_sleep_state(dev);
 
 	return 0;
@@ -997,7 +988,6 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 		goto err_no_mem;
 	}
 	dev->vendor = vendor;
-	dev->busy = false;
 	dev->adev = adev;
 	nmk_i2c_of_probe(np, dev);
 
-- 
1.7.9.5
