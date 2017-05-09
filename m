From: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Subject: [PATCH] i2c-mpc: Correct I2C reset procedure
Date: Tue,  9 May 2017 14:03:51 +0200
Message-ID: <20170509120351.28273-1-joakim.tjernlund@infinera.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.transmode.se ([31.15.61.139]:50178 "EHLO smtp.transmode.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752016AbdEIMMM (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 9 May 2017 08:12:12 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, Scott Wood <scottwood@freescale.com>
Cc: Joakim Tjernlund <joakim.tjernlund@infinera.com>

Current I2C reset procedure is broken in two ways:
1) It only generate 1 START instead of 9 STARTs and STOP.
2) It leaves the bus Busy so every I2C xfer after the first
   fixup calls the reset routine again, for every xfer there after.

This fixes both errors. Add an iobarrier_rw() when writing the
I2C control register as well to make sure the register reaches the
controller in time.

Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
---

 Not sure where to sent this as there is no maintainer so adding
 Scott Wood as well.

 drivers/i2c/busses/i2c-mpc.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 8393140..09b826d 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -86,6 +86,7 @@ struct mpc_i2c_data {
 static inline void writeccr(struct mpc_i2c *i2c, u32 x)
 {
 	writeb(x, i2c->base + MPC_I2C_CR);
+	iobarrier_rw();
 }
 
 static irqreturn_t mpc_i2c_isr(int irq, void *dev_id)
@@ -104,23 +105,30 @@ static irqreturn_t mpc_i2c_isr(int irq, void *dev_id)
 /* Sometimes 9th clock pulse isn't generated, and slave doesn't release
  * the bus, because it wants to send ACK.
  * Following sequence of enabling/disabling and sending start/stop generates
- * the 9 pulses, so it's all OK.
+ * the 9 pulses, each with a START then ending with STOP, so it's all OK.
  */
 static void mpc_i2c_fixup(struct mpc_i2c *i2c)
 {
 	int k;
-	u32 delay_val = 1000000 / i2c->real_clk + 1;
-
-	if (delay_val < 2)
-		delay_val = 2;
+	unsigned long flags;
 
 	for (k = 9; k; k--) {
 		writeccr(i2c, 0);
-		writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_MEN);
+		writeb(0, i2c->base + MPC_I2C_SR); /* clear any status bits */
+		writeccr(i2c, CCR_MEN | CCR_MSTA); /* START */
+		readb(i2c->base + MPC_I2C_DR); /* init xfer */
+		udelay(15); /* let it hit the bus */
+		local_irq_save(flags); /* should not be delayed further */
+		writeccr(i2c, CCR_MEN | CCR_MSTA | CCR_RSTA); /* delay SDA */
 		readb(i2c->base + MPC_I2C_DR);
-		writeccr(i2c, CCR_MEN);
-		udelay(delay_val << 1);
+		if (k != 1)
+			udelay(5);
+		local_irq_restore(flags);
 	}
+	writeccr(i2c, CCR_MEN); /* Initiate STOP */
+	readb(i2c->base + MPC_I2C_DR);
+	udelay(15); /* Let STOP propagate */
+	writeccr(i2c, 0);
 }
 
 static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
-- 
2.10.2
