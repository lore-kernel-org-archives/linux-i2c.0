From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 01/11] i2c: rcar: not everything needs to be a function
Date: Wed, 28 May 2014 09:44:36 +0200
Message-ID: <1401263086-13720-2-git-send-email-wsa@the-dreams.de>
References: <1401263086-13720-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1401263086-13720-1-git-send-email-wsa@the-dreams.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Very basic operations, just called once, can also go to the caller.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 06d47aafbb79..32df4e1f3738 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -312,18 +312,9 @@ scgd_find:
 	return 0;
 }
 
-static void rcar_i2c_clock_start(struct rcar_i2c_priv *priv)
-{
-	rcar_i2c_write(priv, ICCCR, priv->icccr);
-}
-
 /*
  *		status functions
  */
-static u32 rcar_i2c_status_get(struct rcar_i2c_priv *priv)
-{
-	return rcar_i2c_read(priv, ICMSR);
-}
 
 #define rcar_i2c_status_clear(priv) rcar_i2c_status_bit_clear(priv, 0xffffffff)
 static void rcar_i2c_status_bit_clear(struct rcar_i2c_priv *priv, u32 bit)
@@ -480,7 +471,7 @@ static irqreturn_t rcar_i2c_irq(int irq, void *ptr)
 	/*-------------- spin lock -----------------*/
 	spin_lock(&priv->lock);
 
-	msr = rcar_i2c_status_get(priv);
+	msr = rcar_i2c_read(priv, ICMSR);
 
 	/*
 	 * Arbitration lost
@@ -554,7 +545,8 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 	spin_lock_irqsave(&priv->lock, flags);
 
 	rcar_i2c_init(priv);
-	rcar_i2c_clock_start(priv);
+	/* start clock */
+	rcar_i2c_write(priv, ICCCR, priv->icccr);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 	/*-------------- spin unlock -----------------*/
-- 
2.0.0.rc2

