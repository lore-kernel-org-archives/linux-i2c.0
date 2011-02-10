From: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 08/13] i2c-designware: move controller config to bus specific portion of driver
Date: Thu, 10 Feb 2011 08:21:24 -0800
Message-ID: <1297354889-20721-9-git-send-email-dirk.brandewie@gmail.com>
References: <1297354889-20721-1-git-send-email-dirk.brandewie@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297354889-20721-1-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: alan.cox-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

With multiple I2C adapters possible in the system each running at
(possibly) different speeds we need to move the controller
configuration bit field to the adapter.

Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-core.c    |    6 ++----
 drivers/i2c/busses/i2c-designware-core.h    |    1 +
 drivers/i2c/busses/i2c-designware-platdrv.c |    2 ++
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 5741b1a..d521b43 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -142,7 +142,7 @@ static u32 i2c_dw_scl_lcnt(u32 ic_clk, u32 tLOW, u32 tf, int offset)
 int i2c_dw_init(struct dw_i2c_dev *dev)
 {
 	u32 input_clock_khz;
-	u32 ic_con, hcnt, lcnt;
+	u32 hcnt, lcnt;
 	u32 reg;
 
 	input_clock_khz = dev->get_clk_rate_khz(dev);
@@ -198,9 +198,7 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 	dw_writel(dev, 0, DW_IC_RX_TL);
 
 	/* configure the i2c master */
-	ic_con = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
-		DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;
-	dw_writel(dev, ic_con, DW_IC_CON);
+	dw_writel(dev, dev->master_cfg , DW_IC_CON);
 	return 0;
 }
 
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index ab4e655..2938621 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -183,6 +183,7 @@ struct dw_i2c_dev {
 	int			swab;
 	struct i2c_adapter	adapter;
 	u32			functionality;
+	u32			master_cfg;
 	unsigned int		tx_fifo_depth;
 	unsigned int		rx_fifo_depth;
 };
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 36db7a8..1258cae 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -103,6 +103,8 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 		I2C_FUNC_SMBUS_BYTE_DATA |
 		I2C_FUNC_SMBUS_WORD_DATA |
 		I2C_FUNC_SMBUS_I2C_BLOCK;
+	dev->master_cfg =  DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
+		DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;
 
 	dev->base = ioremap(mem->start, resource_size(mem));
 	if (dev->base == NULL) {
-- 
1.7.3.4
