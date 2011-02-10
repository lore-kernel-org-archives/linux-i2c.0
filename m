From: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 02/13] i2c-designware: Check component type register
Date: Thu, 10 Feb 2011 08:21:18 -0800
Message-ID: <1297354889-20721-3-git-send-email-dirk.brandewie@gmail.com>
References: <1297354889-20721-1-git-send-email-dirk.brandewie@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297354889-20721-1-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: alan.cox-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>

Designware component type register is checked before attaching to the device.

Signed-off-by: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index 040cf51..b2b2a19 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -69,6 +69,7 @@
 #define DW_IC_TXFLR		0x74
 #define DW_IC_RXFLR		0x78
 #define DW_IC_COMP_PARAM_1	0xf4
+#define DW_IC_COMP_TYPE		0xfc
 #define DW_IC_TX_ABRT_SOURCE	0x80
 
 #define DW_IC_CON_MASTER		0x1
@@ -710,6 +711,7 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 	struct i2c_adapter *adap;
 	struct resource *mem, *ioarea;
 	int irq, r;
+	u32 reg;
 
 	/* NOTE: driver uses the static register mapping */
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -756,12 +758,19 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 		r = -EBUSY;
 		goto err_unuse_clocks;
 	}
-	{
-		u32 param1 = dw_readl(dev, DW_IC_COMP_PARAM_1);
 
-		dev->tx_fifo_depth = ((param1 >> 16) & 0xff) + 1;
-		dev->rx_fifo_depth = ((param1 >> 8)  & 0xff) + 1;
+	reg = dw_readl(dev, DW_IC_COMP_TYPE);
+	if (reg != 0x44570140) {
+		dev_err(&pdev->dev, "Unknown Synopsys component type: "
+				"0x%08x\n",	reg);
+		r = -ENODEV;
+		goto err_iounmap;
 	}
+
+	reg = dw_readl(dev, DW_IC_COMP_PARAM_1);
+	dev->tx_fifo_depth = ((reg >> 16) & 0xff) + 1;
+	dev->rx_fifo_depth = ((reg >> 8)  & 0xff) + 1;
+
 	i2c_dw_init(dev);
 
 	dw_writel(dev, 0, DW_IC_INTR_MASK); /* disable IRQ */
-- 
1.7.3.4
