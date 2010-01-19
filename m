From: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 2/3] i2c-designware: Check component type register
Date: Tue, 19 Jan 2010 09:02:36 -0500
Message-ID: <20100119140234.870830000@octasic.com>
References: <20100119140234.689304000@octasic.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=check_dw_component
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>, Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
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
@@ -756,6 +757,16 @@ static int __devinit dw_i2c_probe(struct
 		goto err_unuse_clocks;
 	}
 	{
+		u32 comp_type = dw_readl(dev, DW_IC_COMP_TYPE);
+
+		if (comp_type != 0x44570140) {
+			dev_err(&pdev->dev, "Unknown Synopsys component type: "
+					"0x%08x\n",	comp_type);
+			r = -ENODEV;
+			goto err_iounmap;
+		}
+	}
+	{
 		u32 param1 = dw_readl(dev, DW_IC_COMP_PARAM_1);
 
 		dev->tx_fifo_depth = ((param1 >> 16) & 0xff) + 1;

-- 
