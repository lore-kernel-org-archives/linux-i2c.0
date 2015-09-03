From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 1/9] i2c: rcar: rework hw init
Date: Thu,  3 Sep 2015 22:20:05 +0200
Message-ID: <1441311613-2681-2-git-send-email-wsa@the-dreams.de>
References: <1441311613-2681-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1441311613-2681-1-git-send-email-wsa@the-dreams.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

We don't need to init HW before every transfer since we know the HW
state then. HW init at probe time is enough. While here, add setting the
clock register which belongs to init HW. Also, set MDBS bit since not
setting it is prohibited according to the manual.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index d8361dada58455..877ce97ac7a580 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -144,9 +144,10 @@ static void rcar_i2c_init(struct rcar_i2c_priv *priv)
 {
 	/* reset master mode */
 	rcar_i2c_write(priv, ICMIER, 0);
-	rcar_i2c_write(priv, ICMCR, 0);
+	rcar_i2c_write(priv, ICMCR, MDBS);
 	rcar_i2c_write(priv, ICMSR, 0);
-	rcar_i2c_write(priv, ICMAR, 0);
+	/* start clock */
+	rcar_i2c_write(priv, ICCCR, priv->icccr);
 }
 
 static int rcar_i2c_bus_barrier(struct rcar_i2c_priv *priv)
@@ -495,16 +496,6 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 
 	pm_runtime_get_sync(dev);
 
-	/*-------------- spin lock -----------------*/
-	spin_lock_irqsave(&priv->lock, flags);
-
-	rcar_i2c_init(priv);
-	/* start clock */
-	rcar_i2c_write(priv, ICCCR, priv->icccr);
-
-	spin_unlock_irqrestore(&priv->lock, flags);
-	/*-------------- spin unlock -----------------*/
-
 	ret = rcar_i2c_bus_barrier(priv);
 	if (ret < 0)
 		goto out;
@@ -669,6 +660,8 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->io))
 		return PTR_ERR(priv->io);
 
+	rcar_i2c_init(priv);
+
 	irq = platform_get_irq(pdev, 0);
 	init_waitqueue_head(&priv->wait);
 	spin_lock_init(&priv->lock);
-- 
2.1.4

