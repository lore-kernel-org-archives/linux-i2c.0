From: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 5/5] intel_mid_i2c: Minor changes after verification
Date: Thu, 17 Jun 2010 15:06:32 +0100
Message-ID: <20100617140621.17861.30097.stgit@localhost.localdomain>
References: <20100617140352.17861.29664.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100617140352.17861.29664.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Wen Wang <wen.w.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Added some minor changes/fixes after verification on the board.

Signed-off-by: Wen Wang <wen.w.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---

 drivers/i2c/busses/i2c-mrst.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)


diff --git a/drivers/i2c/busses/i2c-mrst.c b/drivers/i2c/busses/i2c-mrst.c
index 974c189..5da3ca5 100644
--- a/drivers/i2c/busses/i2c-mrst.c
+++ b/drivers/i2c/busses/i2c-mrst.c
@@ -90,6 +90,7 @@ static int mrst_i2c_disable(struct i2c_adapter *adap)
 
 	int count = 0;
 	int ret1, ret2;
+	static const u16 delay[NUM_SPEEDS] = {100, 25, 3};
 
 	/* Set IC_ENABLE to 0 */
 	mrst_i2c_write(i2c->base + IC_ENABLE, 0);
@@ -98,7 +99,7 @@ static int mrst_i2c_disable(struct i2c_adapter *adap)
 	dev_dbg(&adap->dev, "mrst i2c disable\n");
 	while ((ret1 = mrst_i2c_read(i2c->base + IC_ENABLE_STATUS) & 0x1)
 		|| (ret2 = mrst_i2c_read(i2c->base + IC_STATUS) & 0x1)) {
-		udelay(i2c->speed);
+		udelay(delay[i2c->speed]);
 		mrst_i2c_write(i2c->base + IC_ENABLE, 0);
 		dev_dbg(&adap->dev, "i2c is busy, count is %d speed %d\n",
 			count, i2c->speed);
@@ -159,9 +160,9 @@ static int mrst_i2c_hwinit(struct mrst_i2c_private *i2c)
 
 	mrst_i2c_write(i2c->base + IC_CON,
 		(i2c->speed + 1) << 1 | SLV_DIS | RESTART | MASTER_EN);
-	mrst_i2c_write(i2c->base + IC_SS_SCL_HCNT,
+	mrst_i2c_write(i2c->base + (IC_SS_SCL_HCNT + (i2c->speed << 3)),
 		hcnt[i2c->platform][i2c->speed]);
-	mrst_i2c_write(i2c->base + IC_SS_SCL_LCNT,
+	mrst_i2c_write(i2c->base + (IC_SS_SCL_LCNT + (i2c->speed << 3)),
 		lcnt[i2c->platform][i2c->speed]);
 
 	/* Set tranmit & receive FIFO threshold to zero */
@@ -410,7 +411,7 @@ static int mrst_i2c_setup(struct i2c_adapter *adap,  struct i2c_msg *pmsg)
 		return -ETIMEDOUT;
 	}
 
-	mode = 1 + (i2c->speed << 1);
+	mode = (1 + i2c->speed) << 1;
 	/* set the speed mode */
 	reg_val = mrst_i2c_read(i2c->base + IC_CON);
 	if ((reg_val & 0x06) != mode) {
