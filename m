From: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 04/13] i2c-designware: Move checking of IP core version to i2c_dw_init()
Date: Sat, 12 Mar 2011 12:23:18 -0800
Message-ID: <1299961407-26852-5-git-send-email-dirk.brandewie@gmail.com>
References: <1299961407-26852-1-git-send-email-dirk.brandewie@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1299961407-26852-1-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Move checking IP core version to i2c_dw_init() in preparation for
splitting i2c-designware.c into core and bus specific portions.

Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware.c |   30 +++++++++++++++++++-----------
 1 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index f58f05d..85517c5 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -305,10 +305,24 @@ static u32 i2c_dw_scl_lcnt(u32 ic_clk, u32 tLOW, u32 tf, int offset)
  * This function is called during I2C init function, and in case of timeout at
  * run time.
  */
-static void i2c_dw_init(struct dw_i2c_dev *dev)
+static int i2c_dw_init(struct dw_i2c_dev *dev)
 {
 	u32 input_clock_khz = clk_get_rate(dev->clk) / 1000;
 	u32 ic_con, hcnt, lcnt;
+	u32 reg;
+
+	/* Configure register endianess access */
+	reg = dw_readl(dev, DW_IC_COMP_TYPE);
+	if (reg == ___constant_swab32(DW_IC_COMP_TYPE_VALUE)) {
+		dev->swab = 1;
+		reg = DW_IC_COMP_TYPE_VALUE;
+	}
+
+	if (reg != DW_IC_COMP_TYPE_VALUE) {
+		dev_err(dev->dev, "Unknown Synopsys component type: "
+			"0x%08x\n", reg);
+		return -ENODEV;
+	}
 
 	/* Disable the adapter */
 	dw_writel(dev, 0, DW_IC_ENABLE);
@@ -351,6 +365,7 @@ static void i2c_dw_init(struct dw_i2c_dev *dev)
 	ic_con = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
 		DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;
 	dw_writel(dev, ic_con, DW_IC_CON);
+	return 0;
 }
 
 /*
@@ -770,21 +785,14 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 		goto err_unuse_clocks;
 	}
 
-	reg = dw_readl(dev, DW_IC_COMP_TYPE);
-	if (reg == ___constant_swab32(0x44570140))
-		dev->swab = 1;
-	else if (reg != 0x44570140) {
-		dev_err(&pdev->dev, "Unknown Synopsys component type: "
-				"0x%08x\n",	reg);
-		r = -ENODEV;
-		goto err_iounmap;
-	}
+	r = i2c_dw_init(dev);
+	if (r)
+		goto err_unuse_clocks;
 
 	reg = dw_readl(dev, DW_IC_COMP_PARAM_1);
 	dev->tx_fifo_depth = ((reg >> 16) & 0xff) + 1;
 	dev->rx_fifo_depth = ((reg >> 8)  & 0xff) + 1;
 
-	i2c_dw_init(dev);
 
 	dw_writel(dev, 0, DW_IC_INTR_MASK); /* disable IRQ */
 	r = request_irq(dev->irq, i2c_dw_isr, IRQF_DISABLED, pdev->name, dev);
-- 
1.7.3.4
