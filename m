From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 18/21] i2c: rcar: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:27 +0200
Message-ID: <20180514145330.4857-19-peda@axentia.se>
References: <20180514145330.4857-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180514145330.4857-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Because it looks neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index c6915b835396..17b91ddbe013 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -329,7 +329,7 @@ static void rcar_i2c_prepare_msg(struct rcar_i2c_priv *priv)
 	if (priv->msgs_left == 1)
 		priv->flags |= ID_LAST_MSG;
 
-	rcar_i2c_write(priv, ICMAR, (priv->msg->addr << 1) | read);
+	rcar_i2c_write(priv, ICMAR, i2c_8bit_addr_from_msg(priv->msg));
 	/*
 	 * We don't have a test case but the HW engineers say that the write order
 	 * of ICMSR and ICMCR depends on whether we issue START or REP_START. Since
-- 
2.11.0
