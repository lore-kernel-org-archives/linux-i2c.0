From: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 06/10] i2c-designware: move controller config to bus specific portion of driver
Date: Wed,  2 Feb 2011 18:20:04 -0800
Message-ID: <1296699608-13227-7-git-send-email-dirk.brandewie@gmail.com>
References: <1296699608-13227-1-git-send-email-dirk.brandewie@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1296699608-13227-1-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
 drivers/i2c/busses/i2c-designware-core.c    |    4 ++--
 drivers/i2c/busses/i2c-designware-core.h    |    1 +
 drivers/i2c/busses/i2c-designware-pcidrv.c  |    1 +
 drivers/i2c/busses/i2c-designware-platdrv.c |    2 ++
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 0bb0d2b..8d911e8 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -151,7 +151,7 @@ static u32 i2c_dw_scl_lcnt(u32 ic_clk, u32 tLOW, u32 tf, int offset)
 int i2c_dw_init(struct dw_i2c_dev *dev)
 {
 	u32 input_clock_khz;
-	u32 ic_con, hcnt, lcnt;
+	u32 hcnt, lcnt;
 	u32 reg;
 
 	input_clock_khz = i2c_dw_clk_get_rate(dev);
@@ -209,7 +209,7 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 	/* configure the i2c master */
 	ic_con = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
 		DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;
-	dw_writel(dev, ic_con, DW_IC_CON);
+	dw_writel(dev, dev->master_cfg , DW_IC_CON);
 	return 0;
 }
 
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 88c5aa1..8d715b9 100644
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
diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 7db115c..f548064 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -205,6 +205,7 @@ const struct pci_device_id *id)
 		I2C_FUNC_SMBUS_BYTE_DATA |
 		I2C_FUNC_SMBUS_WORD_DATA |
 		I2C_FUNC_SMBUS_I2C_BLOCK;
+	dev->master_cfg =  controller->bus_cfg;
 
 	pci_set_drvdata(pdev, dev);
 
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 55f1ce4..964494e 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -97,6 +97,8 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 		I2C_FUNC_SMBUS_BYTE_DATA |
 		I2C_FUNC_SMBUS_WORD_DATA |
 		I2C_FUNC_SMBUS_I2C_BLOCK;
+	dev->master_cfg =  DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
+		DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;
 
 	dev->base = ioremap(mem->start, resource_size(mem));
 	if (dev->base == NULL) {
-- 
1.7.3.4
