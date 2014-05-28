From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 02/11] i2c: rcar: no need to store irq number
Date: Wed, 28 May 2014 09:44:37 +0200
Message-ID: <1401263086-13720-3-git-send-email-wsa@the-dreams.de>
References: <1401263086-13720-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1401263086-13720-1-git-send-email-wsa@the-dreams.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

We use devm, so irq number is only needed during probe.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 32df4e1f3738..88efbf29a182 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -116,7 +116,6 @@ struct rcar_i2c_priv {
 	wait_queue_head_t wait;
 
 	int pos;
-	int irq;
 	u32 icccr;
 	u32 flags;
 	enum rcar_i2c_type	devtype;
@@ -650,7 +649,7 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct device *dev = &pdev->dev;
 	u32 bus_speed;
-	int ret;
+	int irq, ret;
 
 	priv = devm_kzalloc(dev, sizeof(struct rcar_i2c_priv), GFP_KERNEL);
 	if (!priv) {
@@ -684,7 +683,7 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->io))
 		return PTR_ERR(priv->io);
 
-	priv->irq = platform_get_irq(pdev, 0);
+	irq = platform_get_irq(pdev, 0);
 	init_waitqueue_head(&priv->wait);
 	spin_lock_init(&priv->lock);
 
@@ -698,10 +697,10 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	i2c_set_adapdata(adap, priv);
 	strlcpy(adap->name, pdev->name, sizeof(adap->name));
 
-	ret = devm_request_irq(dev, priv->irq, rcar_i2c_irq, 0,
+	ret = devm_request_irq(dev, irq, rcar_i2c_irq, 0,
 			       dev_name(dev), priv);
 	if (ret < 0) {
-		dev_err(dev, "cannot get irq %d\n", priv->irq);
+		dev_err(dev, "cannot get irq %d\n", irq);
 		return ret;
 	}
 
-- 
2.0.0.rc2

