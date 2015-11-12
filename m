From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v2 01/10] i2c: rcar: make sure clocks are on when doing clock calculation
Date: Thu, 12 Nov 2015 15:31:46 +0100
Message-ID: <1447338715-9955-2-git-send-email-wsa@the-dreams.de>
References: <1447338715-9955-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55548 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751048AbbKLOlb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 12 Nov 2015 09:41:31 -0500
In-Reply-To: <1447338715-9955-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

When calculating the bus speed, the clock should be on, of course. Most
bootloaders left them on, so this went unnoticed so far.

Move the ioremapping out of this clock-enabled-block and prepare for
adding hw initialization there, too.

Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index b0ae560b38c308..dac0f5d1945341 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -650,19 +650,23 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->clk);
 	}
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->io = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->io))
+		return PTR_ERR(priv->io);
+
 	bus_speed = 100000; /* default 100 kHz */
 	of_property_read_u32(dev->of_node, "clock-frequency", &bus_speed);
 
 	priv->devtype = (enum rcar_i2c_type)of_match_device(rcar_i2c_dt_ids, dev)->data;
 
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
 	ret = rcar_i2c_clock_calculate(priv, bus_speed, dev);
 	if (ret < 0)
-		return ret;
+		goto out_pm_put;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->io = devm_ioremap_resource(dev, res);
-	if (IS_ERR(priv->io))
-		return PTR_ERR(priv->io);
+	pm_runtime_put(dev);
 
 	irq = platform_get_irq(pdev, 0);
 	init_waitqueue_head(&priv->wait);
@@ -682,22 +686,26 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 			       dev_name(dev), priv);
 	if (ret < 0) {
 		dev_err(dev, "cannot get irq %d\n", irq);
-		return ret;
+		goto out_pm_disable;
 	}
 
-	pm_runtime_enable(dev);
 	platform_set_drvdata(pdev, priv);
 
 	ret = i2c_add_numbered_adapter(adap);
 	if (ret < 0) {
 		dev_err(dev, "reg adap failed: %d\n", ret);
-		pm_runtime_disable(dev);
-		return ret;
+		goto out_pm_disable;
 	}
 
 	dev_info(dev, "probed\n");
 
 	return 0;
+
+ out_pm_put:
+	pm_runtime_put(dev);
+ out_pm_disable:
+	pm_runtime_disable(dev);
+	return ret;
 }
 
 static int rcar_i2c_remove(struct platform_device *pdev)
-- 
2.1.4
