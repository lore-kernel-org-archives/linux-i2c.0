From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH] i2c-gpio: Drop dead code in i2c_gpio_remove
Date: Mon, 28 Jul 2014 14:33:14 +0200
Message-ID: <20140728143314.691999a5@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Violeta Menendez <violeta.menendez-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, Ian Molton <ian.molton-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Commit a0682a31 ("i2c: gpio: Use devm_gpio_request()") left unused
code behind, clean it up.

Fixes: a0682a315889 ("i2c: gpio: Use devm_gpio_request()")
Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Violeta Menendez <violeta.menendez-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Cc: Ian Molton <ian.molton-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/busses/i2c-gpio.c |    2 --
 1 file changed, 2 deletions(-)

--- linux-3.16-rc6.orig/drivers/i2c/busses/i2c-gpio.c	2014-06-16 05:45:28.000000000 +0200
+++ linux-3.16-rc6/drivers/i2c/busses/i2c-gpio.c	2014-07-28 14:26:07.821013275 +0200
@@ -238,12 +238,10 @@ static int i2c_gpio_probe(struct platfor
 static int i2c_gpio_remove(struct platform_device *pdev)
 {
 	struct i2c_gpio_private_data *priv;
-	struct i2c_gpio_platform_data *pdata;
 	struct i2c_adapter *adap;
 
 	priv = platform_get_drvdata(pdev);
 	adap = &priv->adap;
-	pdata = &priv->pdata;
 
 	i2c_del_adapter(adap);
 


-- 
Jean Delvare
SUSE L3 Support
