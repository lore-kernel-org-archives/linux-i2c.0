From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] i2c: rcar: fix some trivial typos in comments
Date: Sun, 21 Jan 2018 15:45:11 +0100
Message-ID: <20180121144511.20350-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:41415 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750825AbeAUOpU (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 21 Jan 2018 09:45:20 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>

Nothing big, but they get annoying after a while ;)

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index d4b7b5380c2983..4159ebcec2bb61 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -62,7 +62,7 @@
 #define MIE	(1 << 3)	/* master if enable */
 #define TSBE	(1 << 2)
 #define FSB	(1 << 1)	/* force stop bit */
-#define ESG	(1 << 0)	/* en startbit gen */
+#define ESG	(1 << 0)	/* enable start bit gen */
 
 /* ICSSR (also for ICSIER) */
 #define GCAR	(1 << 6)	/* general call received */
@@ -331,7 +331,7 @@ static void rcar_i2c_prepare_msg(struct rcar_i2c_priv *priv)
 
 	rcar_i2c_write(priv, ICMAR, (priv->msg->addr << 1) | read);
 	/*
-	 * We don't have a testcase but the HW engineers say that the write order
+	 * We don't have a test case but the HW engineers say that the write order
 	 * of ICMSR and ICMCR depends on whether we issue START or REP_START. Since
 	 * it didn't cause a drawback for me, let's rather be safe than sorry.
 	 */
@@ -489,7 +489,7 @@ static void rcar_i2c_irq_send(struct rcar_i2c_priv *priv, u32 msr)
 
 		/*
 		 * Try to use DMA to transmit the rest of the data if
-		 * address transfer pashe just finished.
+		 * address transfer phase just finished.
 		 */
 		if (msr & MAT)
 			rcar_i2c_dma(priv);
-- 
2.11.0
