From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v4 02/14] i2c-octeon: Cleanup resource allocation code
Date: Fri, 18 Mar 2016 09:46:27 +0100
Message-ID: <600b5514b8456f507867633d27f4ade95cecbd35.1458289385.git.jglauber@cavium.com>
References: <cover.1458289385.git.jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33351 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886AbcCRIqx (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 18 Mar 2016 04:46:53 -0400
In-Reply-To: <cover.1458289385.git.jglauber@cavium.com>
In-Reply-To: <cover.1458289385.git.jglauber@cavium.com>
References: <cover.1458289385.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>

Remove resource values from struct i2c_octeon and use
devm_ioremap_resource helper.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index 9787379..9240037 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -75,9 +75,7 @@ struct octeon_i2c {
 	int irq;
 	u32 twsi_freq;
 	int sys_freq;
-	resource_size_t twsi_phys;
 	void __iomem *twsi_base;
-	resource_size_t regsize;
 	struct device *dev;
 };
 
@@ -502,14 +500,11 @@ static int octeon_i2c_probe(struct platform_device *pdev)
 	i2c->dev = &pdev->dev;
 
 	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	if (res_mem == NULL) {
-		dev_err(i2c->dev, "found no memory resource\n");
-		result = -ENXIO;
+	i2c->twsi_base = devm_ioremap_resource(&pdev->dev, res_mem);
+	if (IS_ERR(i2c->twsi_base)) {
+		result = PTR_ERR(i2c->twsi_base);
 		goto out;
 	}
-	i2c->twsi_phys = res_mem->start;
-	i2c->regsize = resource_size(res_mem);
 
 	/*
 	 * "clock-rate" is a legacy binding, the official binding is
@@ -526,13 +521,6 @@ static int octeon_i2c_probe(struct platform_device *pdev)
 
 	i2c->sys_freq = octeon_get_io_clock_rate();
 
-	if (!devm_request_mem_region(&pdev->dev, i2c->twsi_phys, i2c->regsize,
-				     res_mem->name)) {
-		dev_err(i2c->dev, "request_mem_region failed\n");
-		goto out;
-	}
-	i2c->twsi_base = devm_ioremap(&pdev->dev, i2c->twsi_phys, i2c->regsize);
-
 	init_waitqueue_head(&i2c->queue);
 
 	i2c->irq = irq;
-- 
1.9.1
