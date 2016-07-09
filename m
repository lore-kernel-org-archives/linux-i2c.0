From: Axel Lin <axel.lin@ingics.com>
Subject: [RESEND][PATCH 2/2] i2c: versatile: Convert to use resource managed
 devm_* APIs
Date: Sat, 09 Jul 2016 13:32:23 +0800
Message-ID: <1468042343.21863.3.camel@ingics.com>
References: <1468042283.21863.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36201 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbcGIFc3 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sat, 9 Jul 2016 01:32:29 -0400
Received: by mail-pa0-f65.google.com with SMTP id ib6so9275686pad.3
        for <linux-i2c@vger.kernel.org>; Fri, 08 Jul 2016 22:32:28 -0700 (PDT)
In-Reply-To: <1468042283.21863.2.camel@ingics.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Pawel Moll <pawel.moll@arm.com>, linux-i2c@vger.kernel.org

Use devm_* APIs to simplify the code a bit.
This patch also fixes the memory leak when unload the module.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Resend with CC VE maintainers.
 drivers/i2c/busses/i2c-versatile.c | 46 +++++++++++---------------------------
 1 file changed, 13 insertions(+), 33 deletions(-)

diff --git a/drivers/i2c/busses/i2c-versatile.c b/drivers/i2c/busses/i2c-versatile.c
index 240637f..c73d2d2 100644
--- a/drivers/i2c/busses/i2c-versatile.c
+++ b/drivers/i2c/busses/i2c-versatile.c
@@ -70,28 +70,14 @@ static int i2c_versatile_probe(struct platform_device *dev)
 	struct resource *r;
 	int ret;
 
+	i2c = devm_kzalloc(&dev->dev, sizeof(struct i2c_versatile), GFP_KERNEL);
+	if (!i2c)
+		return -ENOMEM;
+
 	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	if (!r) {
-		ret = -EINVAL;
-		goto err_out;
-	}
-
-	if (!request_mem_region(r->start, resource_size(r), "versatile-i2c")) {
-		ret = -EBUSY;
-		goto err_out;
-	}
-
-	i2c = kzalloc(sizeof(struct i2c_versatile), GFP_KERNEL);
-	if (!i2c) {
-		ret = -ENOMEM;
-		goto err_release;
-	}
-
-	i2c->base = ioremap(r->start, resource_size(r));
-	if (!i2c->base) {
-		ret = -ENOMEM;
-		goto err_free;
-	}
+	i2c->base = devm_ioremap_resource(&dev->dev, r);
+	if (IS_ERR(i2c->base))
+		return PTR_ERR(i2c->base);
 
 	writel(SCL | SDA, i2c->base + I2C_CONTROLS);
 
@@ -105,18 +91,12 @@ static int i2c_versatile_probe(struct platform_device *dev)
 
 	i2c->adap.nr = dev->id;
 	ret = i2c_bit_add_numbered_bus(&i2c->adap);
-	if (ret >= 0) {
-		platform_set_drvdata(dev, i2c);
-		return 0;
-	}
-
-	iounmap(i2c->base);
- err_free:
-	kfree(i2c);
- err_release:
-	release_mem_region(r->start, resource_size(r));
- err_out:
-	return ret;
+	if (ret < 0)
+		return ret;
+
+	platform_set_drvdata(dev, i2c);
+
+	return 0;
 }
 
 static int i2c_versatile_remove(struct platform_device *dev)
-- 
2.5.0
