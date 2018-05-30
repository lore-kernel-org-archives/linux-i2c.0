From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH 2/3] i2c: rcar: check master irqs before slave irqs
Date: Wed, 30 May 2018 11:07:12 +0100
Message-ID: <1527674833-13122-3-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1527674833-13122-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1527674833-13122-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, stable@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit c3be0af15959e11fa535d5332ab3d7cf34abd09b upstream.

Due to the HW design, master IRQs are timing critical, so give them
precedence over slave IRQ.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
[fabrizio: cherry-pick to 4.4]
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/i2c/busses/i2c-rcar.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 6f23b97..ee3e02a 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -432,19 +432,17 @@ static bool rcar_i2c_slave_irq(struct rcar_i2c_priv *priv)
 static irqreturn_t rcar_i2c_irq(int irq, void *ptr)
 {
 	struct rcar_i2c_priv *priv = ptr;
-	irqreturn_t result = IRQ_HANDLED;
 	u32 msr;
 
-	if (rcar_i2c_slave_irq(priv))
-		goto exit;
-
 	msr = rcar_i2c_read(priv, ICMSR);
 
 	/* Only handle interrupts that are currently enabled */
 	msr &= rcar_i2c_read(priv, ICMIER);
 	if (!msr) {
-		result = IRQ_NONE;
-		goto exit;
+		if (rcar_i2c_slave_irq(priv))
+			return IRQ_HANDLED;
+
+		return IRQ_NONE;
 	}
 
 	/* Arbitration lost */
@@ -481,8 +479,7 @@ out:
 		wake_up(&priv->wait);
 	}
 
-exit:
-	return result;
+	return IRQ_HANDLED;
 }
 
 static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
-- 
2.7.4
