From: <ying.zhang22455@nxp.com>
Subject: [PATCH] power/mpc85xx: Add delay after enabling I2C master
Date: Tue, 19 Jan 2016 15:57:05 +0800
Message-ID: <1453190225-37736-1-git-send-email-ying.zhang22455@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-by2on0090.outbound.protection.outlook.com ([207.46.100.90]:39744
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752191AbcASIUM (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 19 Jan 2016 03:20:12 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: xiaobo.xie@nxp.com, york.sun@nxp.com, Ying Zhang <b40530@freescale.com>

From: Ying Zhang <b40530@freescale.com>

Erratum A-006037 indicates I2C controller executes the write to I2CCR only
after it sees SCL idle for 64K cycle of internal I2C controller clocks. If
during this waiting period, I2C controller is disabled (I2CCR[MEN] set to
0), then the controller could end in bad state, and hang the future access
to I2C register.
The mpc_i2c_fixup() function tries to recover the bus from a stalled state
where the 9th clock pulse wasn't generated. However, this workaround
disables and enables I2C controller without meeting waiting requirement of
this erratum.
This erratum applies to some 85xx SoCs. It is safe to apply to all of them
for mpc_i2c_fixup().

Signed-off-by: york.sun@nxp.com
---
 drivers/i2c/busses/i2c-mpc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 48ecffe..85c1f5c 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -109,7 +109,13 @@ static irqreturn_t mpc_i2c_isr(int irq, void *dev_id)
 static void mpc_i2c_fixup(struct mpc_i2c *i2c)
 {
 	int k;
-	u32 delay_val = 1000000 / i2c->real_clk + 1;
+	u32 delay_val;
+
+#ifdef CONFIG_PPC_85xx
+	delay_val = 65536 / (fsl_get_sys_freq() / 2000000);
+#else
+	delay_val = 1000000 / i2c->real_clk + 1;
+#endif
 
 	if (delay_val < 2)
 		delay_val = 2;
@@ -119,7 +125,11 @@ static void mpc_i2c_fixup(struct mpc_i2c *i2c)
 		writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_MEN);
 		readb(i2c->base + MPC_I2C_DR);
 		writeccr(i2c, CCR_MEN);
+#ifdef CONFIG_PPC_85xx
+		udelay(delay_val);
+#else
 		udelay(delay_val << 1);
+#endif
 	}
 }
 
-- 
2.1.0.27.g96db324
