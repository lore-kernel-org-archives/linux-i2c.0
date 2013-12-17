From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 09/13] i2c: simtec: Use devm_*() functions
Date: Tue, 17 Dec 2013 15:58:44 +0900
Message-ID: <002d01cefaf5$6d22c5d0$47685170$%han@samsung.com>
References: <001601cefaf3$940d0040$bc2700c0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <001601cefaf3$940d0040$bc2700c0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Ben Dooks' <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Use devm_*() functions to make cleanup paths simpler.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-simtec.c |   43 +++++++--------------------------------
 1 file changed, 7 insertions(+), 36 deletions(-)

diff --git a/drivers/i2c/busses/i2c-simtec.c b/drivers/i2c/busses/i2c-simtec.c
index 4fc87e7..8236cbb 100644
--- a/drivers/i2c/busses/i2c-simtec.c
+++ b/drivers/i2c/busses/i2c-simtec.c
@@ -74,10 +74,10 @@ static int simtec_i2c_probe(struct platform_device *dev)
 {
 	struct simtec_i2c_data *pd;
 	struct resource *res;
-	int size;
 	int ret;
 
-	pd = kzalloc(sizeof(struct simtec_i2c_data), GFP_KERNEL);
+	pd = devm_kzalloc(&dev->dev, sizeof(struct simtec_i2c_data),
+			  GFP_KERNEL);
 	if (pd == NULL) {
 		dev_err(&dev->dev, "cannot allocate private data\n");
 		return -ENOMEM;
@@ -88,25 +88,12 @@ static int simtec_i2c_probe(struct platform_device *dev)
 	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	if (res == NULL) {
 		dev_err(&dev->dev, "cannot find IO resource\n");
-		ret = -ENOENT;
-		goto err;
+		return -ENOENT;
 	}
 
-	size = resource_size(res);
-
-	pd->ioarea = request_mem_region(res->start, size, dev->name);
-	if (pd->ioarea == NULL) {
-		dev_err(&dev->dev, "cannot request IO\n");
-		ret = -ENXIO;
-		goto err;
-	}
-
-	pd->reg = ioremap(res->start, size);
-	if (pd->reg == NULL) {
-		dev_err(&dev->dev, "cannot map IO\n");
-		ret = -ENXIO;
-		goto err_res;
-	}
+	pd->reg = devm_ioremap_resource(&dev->dev, res);
+	if (IS_ERR(pd->reg))
+		return PTR_ERR(pd->reg);
 
 	/* setup the private data */
 
@@ -126,20 +113,9 @@ static int simtec_i2c_probe(struct platform_device *dev)
 
 	ret = i2c_bit_add_bus(&pd->adap);
 	if (ret)
-		goto err_all;
+		return ret;
 
 	return 0;
-
- err_all:
-	iounmap(pd->reg);
-
- err_res:
-	release_resource(pd->ioarea);
-	kfree(pd->ioarea);
-
- err:
-	kfree(pd);
-	return ret;
 }
 
 static int simtec_i2c_remove(struct platform_device *dev)
@@ -148,11 +124,6 @@ static int simtec_i2c_remove(struct platform_device *dev)
 
 	i2c_del_adapter(&pd->adap);
 
-	iounmap(pd->reg);
-	release_resource(pd->ioarea);
-	kfree(pd->ioarea);
-	kfree(pd);
-
 	return 0;
 }
 
-- 
1.7.10.4
