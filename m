From: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v3 2/3] i2c-designware: Check component type register
Date: Wed, 27 Jan 2010 14:19:51 -0500
Message-ID: <20100127191949.759985000@octasic.com>
References: <20100127191949.575931000@octasic.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=check_dw_component
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Designware component type register is checked before attaching to the device.

Signed-off-by: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>

---
 drivers/i2c/busses/i2c-designware.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: linux-2.6_i2c/drivers/i2c/busses/i2c-designware.c
===================================================================
--- linux-2.6_i2c.orig/drivers/i2c/busses/i2c-designware.c
+++ linux-2.6_i2c/drivers/i2c/busses/i2c-designware.c
@@ -68,6 +68,7 @@
 #define DW_IC_TXFLR		0x74
 #define DW_IC_RXFLR		0x78
 #define DW_IC_COMP_PARAM_1	0xf4
+#define DW_IC_COMP_TYPE		0xfc
 #define DW_IC_TX_ABRT_SOURCE	0x80
 
 #define DW_IC_CON_MASTER		0x1
@@ -709,6 +710,7 @@ static int __devinit dw_i2c_probe(struct
 	struct i2c_adapter *adap;
 	struct resource *mem, *ioarea;
 	int irq, r;
+	u32 reg;
 
 	/* NOTE: driver uses the static register mapping */
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -755,12 +757,19 @@ static int __devinit dw_i2c_probe(struct
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
