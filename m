From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 02/13] i2c: gpio: Use devm_gpio_request()
Date: Tue, 17 Dec 2013 15:48:19 +0900
Message-ID: <001e01cefaf3$f8b520e0$ea1f62a0$%han@samsung.com>
References: <001601cefaf3$940d0040$bc2700c0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <001601cefaf3$940d0040$bc2700c0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Haavard Skinnemoen' <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 'Bo Shen' <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Use devm_gpio_request() to make cleanup paths simpler.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-gpio.c |   25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index d9f7e18..401be4c 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -144,24 +144,22 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 		scl_pin = pdata->scl_pin;
 	}
 
-	ret = gpio_request(sda_pin, "sda");
+	ret = devm_gpio_request(&pdev->dev, sda_pin, "sda");
 	if (ret) {
 		if (ret == -EINVAL)
 			ret = -EPROBE_DEFER;	/* Try again later */
-		goto err_request_sda;
+		return ret;
 	}
-	ret = gpio_request(scl_pin, "scl");
+	ret = devm_gpio_request(&pdev->dev, scl_pin, "scl");
 	if (ret) {
 		if (ret == -EINVAL)
 			ret = -EPROBE_DEFER;	/* Try again later */
-		goto err_request_scl;
+		return ret;
 	}
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		ret = -ENOMEM;
-		goto err_add_bus;
-	}
+	if (!priv)
+		return -ENOMEM;
 	adap = &priv->adap;
 	bit_data = &priv->bit_data;
 	pdata = &priv->pdata;
@@ -222,7 +220,7 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 	adap->nr = pdev->id;
 	ret = i2c_bit_add_numbered_bus(adap);
 	if (ret)
-		goto err_add_bus;
+		return ret;
 
 	platform_set_drvdata(pdev, priv);
 
@@ -232,13 +230,6 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 		 ? ", no clock stretching" : "");
 
 	return 0;
-
-err_add_bus:
-	gpio_free(scl_pin);
-err_request_scl:
-	gpio_free(sda_pin);
-err_request_sda:
-	return ret;
 }
 
 static int i2c_gpio_remove(struct platform_device *pdev)
@@ -252,8 +243,6 @@ static int i2c_gpio_remove(struct platform_device *pdev)
 	pdata = &priv->pdata;
 
 	i2c_del_adapter(adap);
-	gpio_free(pdata->scl_pin);
-	gpio_free(pdata->sda_pin);
 
 	return 0;
 }
-- 
1.7.10.4
