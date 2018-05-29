From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH 2/6] i2c: rcar: rework hw init
Date: Tue, 29 May 2018 14:33:12 +0100
Message-ID: <1527600796-25901-3-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1527600796-25901-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1527600796-25901-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, stable@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 2c78cdc1c06308a59d6ed4145cdba73fdeff8c0d upstream.

We don't need to init HW before every transfer since we know the HW
state then. HW init at probe time is enough. While here, add setting the
clock register which belongs to init HW. Also, set MDBS bit since not
setting it is prohibited according to the manual.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
[fabrizio: cherry-pick to 4.4]
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
---
 drivers/i2c/busses/i2c-rcar.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index fef53c1..b8ff5f2 100644
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
@@ -496,16 +497,6 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 
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
@@ -666,6 +657,7 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto out_pm_put;
 
+	rcar_i2c_init(priv);
 	pm_runtime_put(dev);
 
 	irq = platform_get_irq(pdev, 0);
-- 
2.7.4
