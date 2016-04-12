From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] i2c: simtec: Convert to use devm_* APIs
Date: Tue, 12 Apr 2016 16:30:14 +0800
Message-ID: <1460449814.28557.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34736 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbcDLIbH (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 12 Apr 2016 04:31:07 -0400
Received: by mail-pa0-f46.google.com with SMTP id ot11so9549702pab.1
        for <linux-i2c@vger.kernel.org>; Tue, 12 Apr 2016 01:31:07 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ben Dooks <ben@simtec.co.uk>, linux-i2c@vger.kernel.org

Use devm_* APIs to simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/i2c/busses/i2c-simtec.c | 52 +++++------------------------------------
 1 file changed, 6 insertions(+), 46 deletions(-)

diff --git a/drivers/i2c/busses/i2c-simtec.c b/drivers/i2c/busses/i2c-simtec.c
index b4685bb..46b88d5 100644
--- a/drivers/i2c/busses/i2c-simtec.c
+++ b/drivers/i2c/busses/i2c-simtec.c
@@ -25,7 +25,6 @@
 #include <linux/i2c-algo-bit.h>
 
 struct simtec_i2c_data {
-	struct resource		*ioarea;
 	void __iomem		*reg;
 	struct i2c_adapter	 adap;
 	struct i2c_algo_bit_data bit;
@@ -69,37 +68,18 @@ static int simtec_i2c_probe(struct platform_device *dev)
 {
 	struct simtec_i2c_data *pd;
 	struct resource *res;
-	int size;
-	int ret;
 
-	pd = kzalloc(sizeof(struct simtec_i2c_data), GFP_KERNEL);
+	pd = devm_kzalloc(&dev->dev, sizeof(struct simtec_i2c_data),
+			  GFP_KERNEL);
 	if (pd == NULL)
 		return -ENOMEM;
 
 	platform_set_drvdata(dev, pd);
 
 	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	if (res == NULL) {
-		dev_err(&dev->dev, "cannot find IO resource\n");
-		ret = -ENOENT;
-		goto err;
-	}
-
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
 
@@ -117,22 +97,7 @@ static int simtec_i2c_probe(struct platform_device *dev)
 	pd->bit.timeout = HZ;
 	pd->bit.udelay = 20;
 
-	ret = i2c_bit_add_bus(&pd->adap);
-	if (ret)
-		goto err_all;
-
-	return 0;
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
+	return i2c_bit_add_bus(&pd->adap);
 }
 
 static int simtec_i2c_remove(struct platform_device *dev)
@@ -141,11 +106,6 @@ static int simtec_i2c_remove(struct platform_device *dev)
 
 	i2c_del_adapter(&pd->adap);
 
-	iounmap(pd->reg);
-	release_resource(pd->ioarea);
-	kfree(pd->ioarea);
-	kfree(pd);
-
 	return 0;
 }
 
-- 
2.5.0
