From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH RFT] i2c: au1550: Convert to devm_kzalloc and
 devm_ioremap_resource
Date: Tue, 09 Jun 2015 15:52:49 +0800
Message-ID: <1433836369.27915.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Domen Puncer <domen.puncer-eMt1OdnfsGc@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Use devm_* APIs to simplify the code.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
I don't have the h/w for testing, only compile test.
 drivers/i2c/busses/i2c-au1550.c | 52 +++++++++++------------------------------
 1 file changed, 13 insertions(+), 39 deletions(-)

diff --git a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-au1550.c
index a6aae84..029b382 100644
--- a/drivers/i2c/busses/i2c-au1550.c
+++ b/drivers/i2c/busses/i2c-au1550.c
@@ -48,7 +48,6 @@ struct i2c_au1550_data {
 	void __iomem *psc_base;
 	int	xfer_timeout;
 	struct i2c_adapter adap;
-	struct resource *ioarea;
 };
 
 static inline void WR(struct i2c_au1550_data *a, int r, unsigned long v)
@@ -315,30 +314,16 @@ i2c_au1550_probe(struct platform_device *pdev)
 	struct resource *r;
 	int ret;
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r) {
-		ret = -ENODEV;
-		goto out;
-	}
+	priv = devm_kzalloc(&pdev->dev, sizeof(struct i2c_au1550_data),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
 
-	priv = kzalloc(sizeof(struct i2c_au1550_data), GFP_KERNEL);
-	if (!priv) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	priv->ioarea = request_mem_region(r->start, resource_size(r),
-					  pdev->name);
-	if (!priv->ioarea) {
-		ret = -EBUSY;
-		goto out_mem;
-	}
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->psc_base = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(priv->psc_base))
+		return PTR_ERR(priv->psc_base);
 
-	priv->psc_base = ioremap(r->start, resource_size(r));
-	if (!priv->psc_base) {
-		ret = -EIO;
-		goto out_map;
-	}
 	priv->xfer_timeout = 200;
 
 	priv->adap.nr = pdev->id;
@@ -351,20 +336,13 @@ i2c_au1550_probe(struct platform_device *pdev)
 	i2c_au1550_setup(priv);
 
 	ret = i2c_add_numbered_adapter(&priv->adap);
-	if (ret == 0) {
-		platform_set_drvdata(pdev, priv);
-		return 0;
+	if (ret) {
+		i2c_au1550_disable(priv);
+		return ret;
 	}
 
-	i2c_au1550_disable(priv);
-	iounmap(priv->psc_base);
-out_map:
-	release_resource(priv->ioarea);
-	kfree(priv->ioarea);
-out_mem:
-	kfree(priv);
-out:
-	return ret;
+	platform_set_drvdata(pdev, priv);
+	return 0;
 }
 
 static int i2c_au1550_remove(struct platform_device *pdev)
@@ -373,10 +351,6 @@ static int i2c_au1550_remove(struct platform_device *pdev)
 
 	i2c_del_adapter(&priv->adap);
 	i2c_au1550_disable(priv);
-	iounmap(priv->psc_base);
-	release_resource(priv->ioarea);
-	kfree(priv->ioarea);
-	kfree(priv);
 	return 0;
 }
 
-- 
2.1.0
