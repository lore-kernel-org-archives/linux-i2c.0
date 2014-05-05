From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: rcar: bail out on zero length transfers
Date: Mon,  5 May 2014 18:36:21 +0200
Message-ID: <1399307781-23614-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-i2c@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

This hardware does not support zero length transfers. Instead, the
driver does one (random) byte transfers currently with undefined results
for the slaves. We now bail out.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 72a400a73cce..66c952e62f0a 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -552,6 +552,13 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 
 	ret = -EINVAL;
 	for (i = 0; i < num; i++) {
+
+		/* This HW can't send STOP after address phase */
+		if (msgs[i].len == 0) {
+			ret = -EOPNOTSUPP;
+			break;
+		}
+
 		/*-------------- spin lock -----------------*/
 		spin_lock_irqsave(&priv->lock, flags);
 
@@ -616,7 +623,8 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 
 static u32 rcar_i2c_func(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+	/* This HW can't do SMBUS_QUICK and NOSTART */
+	return I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
 }
 
 static const struct i2c_algorithm rcar_i2c_algo = {
-- 
1.9.2

