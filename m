From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v3 09/11] i2c: rcar: revoke START request early
Date: Thu, 19 Nov 2015 16:56:49 +0100
Message-ID: <1447948611-2615-10-git-send-email-wsa@the-dreams.de>
References: <1447948611-2615-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:36950 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933930AbbKSP5C (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 19 Nov 2015 10:57:02 -0500
In-Reply-To: <1447948611-2615-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

If we don't clear START generation as soon as possible, it may cause
another message to be generated, e.g. when receiving NACK in address
phase. To keep the race window as small as possible, we clear it right
at the beginning of the interrupt. We don't need any checks since we
always want to stop START and STOP generation on the next occasion after
we started it.

This patch improves the situation but sadly does not completely fix it.
It is still to be researched if we can do better given this HW design.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index f237b4fc5b5e55..40979130200935 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -83,6 +83,7 @@
 
 #define RCAR_BUS_PHASE_START	(MDBS | MIE | ESG)
 #define RCAR_BUS_PHASE_DATA	(MDBS | MIE)
+#define RCAR_BUS_MASK_DATA	(~(ESG | FSB) & 0xFF)
 #define RCAR_BUS_PHASE_STOP	(MDBS | MIE | FSB)
 
 #define RCAR_IRQ_SEND	(MNR | MAL | MST | MAT | MDE)
@@ -289,13 +290,6 @@ static void rcar_i2c_irq_send(struct rcar_i2c_priv *priv, u32 msr)
 	if (!(msr & MDE))
 		return;
 
-	/*
-	 * If address transfer phase finished,
-	 * goto data phase.
-	 */
-	if (msr & MAT)
-		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_DATA);
-
 	if (priv->pos < msg->len) {
 		/*
 		 * Prepare next data to ICRXTX register.
@@ -345,11 +339,7 @@ static void rcar_i2c_irq_recv(struct rcar_i2c_priv *priv, u32 msr)
 		return;
 
 	if (msr & MAT) {
-		/*
-		 * Address transfer phase finished,
-		 * but, there is no data at this point.
-		 * Do nothing.
-		 */
+		/* Address transfer phase finished, but no data at this point. */
 	} else if (priv->pos < msg->len) {
 		/*
 		 * get received data
@@ -365,8 +355,6 @@ static void rcar_i2c_irq_recv(struct rcar_i2c_priv *priv, u32 msr)
 	 */
 	if (priv->pos + 1 >= msg->len)
 		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_STOP);
-	else
-		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_DATA);
 
 	if (priv->pos == msg->len && !(priv->flags & ID_LAST_MSG))
 		rcar_i2c_next_msg(priv);
@@ -432,7 +420,11 @@ static bool rcar_i2c_slave_irq(struct rcar_i2c_priv *priv)
 static irqreturn_t rcar_i2c_irq(int irq, void *ptr)
 {
 	struct rcar_i2c_priv *priv = ptr;
-	u32 msr;
+	u32 msr, val;
+
+	/* Clear START or STOP as soon as we can */
+	val = rcar_i2c_read(priv, ICMCR);
+	rcar_i2c_write(priv, ICMCR, val & RCAR_BUS_MASK_DATA);
 
 	msr = rcar_i2c_read(priv, ICMSR);
 
@@ -454,7 +446,6 @@ static irqreturn_t rcar_i2c_irq(int irq, void *ptr)
 	/* Nack */
 	if (msr & MNR) {
 		/* HW automatically sends STOP after received NACK */
-		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_DATA);
 		rcar_i2c_write(priv, ICMIER, RCAR_IRQ_STOP);
 		rcar_i2c_flags_set(priv, ID_NACK);
 		goto out;
-- 
2.1.4
