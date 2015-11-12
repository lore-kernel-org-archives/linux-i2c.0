From: LABBE Corentin <clabbe.montjoie@gmail.com>
Subject: [PATCH] i2c: rcar: fix a possible NULL dereference
Date: Thu, 12 Nov 2015 08:25:09 +0100
Message-ID: <1447313109-23583-1-git-send-email-clabbe.montjoie@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34868 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158AbbKLHZm (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 12 Nov 2015 02:25:42 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: LABBE Corentin <clabbe.montjoie@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

of_match_device could return NULL, and so cause a NULL pointer
dereference later.

Reported-by: coverity (CID 1130036)
Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 drivers/i2c/busses/i2c-rcar.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index b0ae560..d2bdbda 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -639,6 +639,7 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	u32 bus_speed;
 	int irq, ret;
+	const struct of_device_id *of_id;
 
 	priv = devm_kzalloc(dev, sizeof(struct rcar_i2c_priv), GFP_KERNEL);
 	if (!priv)
@@ -653,7 +654,10 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	bus_speed = 100000; /* default 100 kHz */
 	of_property_read_u32(dev->of_node, "clock-frequency", &bus_speed);
 
-	priv->devtype = (enum rcar_i2c_type)of_match_device(rcar_i2c_dt_ids, dev)->data;
+	of_id = of_match_device(rcar_i2c_dt_ids, dev);
+	if (!of_id)
+		return -ENODEV;
+	priv->devtype = (enum rcar_i2c_type)of_id->data;
 
 	ret = rcar_i2c_clock_calculate(priv, bus_speed, dev);
 	if (ret < 0)
-- 
2.4.10
