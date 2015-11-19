From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v3 05/11] i2c: rcar: refactor setup of a msg
Date: Thu, 19 Nov 2015 16:56:45 +0100
Message-ID: <1447948611-2615-6-git-send-email-wsa@the-dreams.de>
References: <1447948611-2615-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:36915 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933930AbbKSP46 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 19 Nov 2015 10:56:58 -0500
In-Reply-To: <1447948611-2615-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

We want to reuse this function later.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 0f2dc74ab8bcc1..4bd3099865b485 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -106,7 +106,8 @@ enum rcar_i2c_type {
 struct rcar_i2c_priv {
 	void __iomem *io;
 	struct i2c_adapter adap;
-	struct i2c_msg	*msg;
+	struct i2c_msg *msg;
+	int msgs_left;
 	struct clk *clk;
 
 	wait_queue_head_t wait;
@@ -255,6 +256,11 @@ static void rcar_i2c_prepare_msg(struct rcar_i2c_priv *priv)
 {
 	int read = !!rcar_i2c_is_recv(priv);
 
+	priv->pos = 0;
+	priv->flags = 0;
+	if (priv->msgs_left == 1)
+		rcar_i2c_flags_set(priv, ID_LAST_MSG);
+
 	rcar_i2c_write(priv, ICMAR, (priv->msg->addr << 1) | read);
 	rcar_i2c_write(priv, ICMSR, 0);
 	rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_START);
@@ -499,11 +505,8 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 		}
 
 		/* init each data */
-		priv->msg	= &msgs[i];
-		priv->pos	= 0;
-		priv->flags	= 0;
-		if (i == num - 1)
-			rcar_i2c_flags_set(priv, ID_LAST_MSG);
+		priv->msg = &msgs[i];
+		priv->msgs_left = num - i;
 
 		rcar_i2c_prepare_msg(priv);
 
-- 
2.1.4
