From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v2 08/10] i2c: rcar: check master irqs before slave irqs
Date: Thu, 12 Nov 2015 15:42:51 +0100
Message-ID: <1447339372-10060-2-git-send-email-wsa@the-dreams.de>
References: <1447339372-10060-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55596 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752552AbbKLOnL (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 12 Nov 2015 09:43:11 -0500
In-Reply-To: <1447339372-10060-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Due to the HW design, master IRQs are timing critical, so give them
precedence over slave IRQ.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 3880293edc3c72..8ad4c7d1ad8654 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -436,19 +436,17 @@ static bool rcar_i2c_slave_irq(struct rcar_i2c_priv *priv)
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
@@ -485,8 +483,7 @@ out:
 		wake_up(&priv->wait);
 	}
 
-exit:
-	return result;
+	return IRQ_HANDLED;
 }
 
 static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
-- 
2.1.4
