From: qiwuchen55@gmail.com
Subject: [PATCH] i2c: omap: use devm_platform_ioremap_resource()
Date: Sat, 15 Feb 2020 16:36:43 +0800
Message-ID: <1581755803-11242-1-git-send-email-qiwuchen55@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39890 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgBOIgs (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 15 Feb 2020 03:36:48 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: vigneshr@ti.com, tony@atomide.com, aaro.koskinen@iki.fi
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>

From: chenqiwu <chenqiwu@xiaomi.com>

Use a new API devm_platform_ioremap_resource() to simplify code.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 drivers/i2c/busses/i2c-omap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 2dfea35..47d994a 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1355,7 +1355,6 @@ static void omap_i2c_unprepare_recovery(struct i2c_adapter *adap)
 {
 	struct omap_i2c_dev	*omap;
 	struct i2c_adapter	*adap;
-	struct resource		*mem;
 	const struct omap_i2c_bus_platform_data *pdata =
 		dev_get_platdata(&pdev->dev);
 	struct device_node	*node = pdev->dev.of_node;
@@ -1375,8 +1374,7 @@ static void omap_i2c_unprepare_recovery(struct i2c_adapter *adap)
 	if (!omap)
 		return -ENOMEM;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	omap->base = devm_ioremap_resource(&pdev->dev, mem);
+	omap->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(omap->base))
 		return PTR_ERR(omap->base);
 
-- 
1.9.1
