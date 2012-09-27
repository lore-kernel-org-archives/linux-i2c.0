From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 1/3] i2c: i2c-mux-gpio: Use devm_kzalloc instead of kzalloc
Date: Thu, 27 Sep 2012 17:13:02 +0200
Message-ID: <1348758784-15245-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1348758784-15245-1-git-send-email-maxime.ripard@free-electrons.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1348758784-15245-1-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, brian-ZKiFAVwZFM2FeswfMrDH8w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Use the devm_kzalloc managed function to stripdown the error and remove
code.

Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Acked-by: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
---
 drivers/i2c/muxes/i2c-mux-gpio.c |   14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 68b1f8e..ecb1d69 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -71,7 +71,7 @@ static int __devinit i2c_mux_gpio_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	mux = devm_kzalloc(&pdev->dev, sizeof(*mux), GFP_KERNEL);
 	if (!mux) {
 		ret = -ENOMEM;
 		goto alloc_failed;
@@ -79,11 +79,12 @@ static int __devinit i2c_mux_gpio_probe(struct platform_device *pdev)
 
 	mux->parent = parent;
 	mux->data = *pdata;
-	mux->adap = kzalloc(sizeof(struct i2c_adapter *) * pdata->n_values,
-			    GFP_KERNEL);
+	mux->adap = devm_kzalloc(&pdev->dev,
+				 sizeof(*mux->adap) * pdata->n_values,
+				 GFP_KERNEL);
 	if (!mux->adap) {
 		ret = -ENOMEM;
-		goto alloc_failed2;
+		goto alloc_failed;
 	}
 
 	if (pdata->idle != I2C_MUX_GPIO_NO_IDLE) {
@@ -128,9 +129,6 @@ add_adapter_failed:
 err_request_gpio:
 	for (; i > 0; i--)
 		gpio_free(pdata->gpios[i - 1]);
-	kfree(mux->adap);
-alloc_failed2:
-	kfree(mux);
 alloc_failed:
 	i2c_put_adapter(parent);
 
@@ -150,8 +148,6 @@ static int __devexit i2c_mux_gpio_remove(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, NULL);
 	i2c_put_adapter(mux->parent);
-	kfree(mux->adap);
-	kfree(mux);
 
 	return 0;
 }
-- 
1.7.9.5
