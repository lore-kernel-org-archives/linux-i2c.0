From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH 1/6] i2c: rcar: make sure clocks are on when doing clock calculation
Date: Tue, 29 May 2018 14:33:11 +0100
Message-ID: <1527600796-25901-2-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1527600796-25901-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1527600796-25901-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, stable@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit e43e0df13f8528ca55ed79f469c4b2af897fa796 upstream.

When calculating the bus speed, the clock should be on, of course. Most
bootloaders left them on, so this went unnoticed so far.

Move the ioremapping out of this clock-enabled-block and prepare for
adding hw initialization there, too.

Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
[fabrizio: cherry-picked to 4.4]
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
---
 drivers/i2c/busses/i2c-rcar.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 599c0d7..fef53c1 100644
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
2.7.4
