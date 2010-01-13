From: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 3/3] Allow mixed endianness accesses
Date: Wed, 13 Jan 2010 14:32:27 -0500
Message-ID: <20100113193421.212989000@octasic.com>
References: <20100113193224.753273000@octasic.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=allow_mixed_endianness
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Allows CPUs of a given endianness to access a dw controller of a different
endianness. Endianncess difference is detected at run time through the dw
component type register.

---
 drivers/i2c/busses/i2c-designware.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

Index: linux-2.6_i2c/drivers/i2c/busses/i2c-designware.c
===================================================================
--- linux-2.6_i2c.orig/drivers/i2c/busses/i2c-designware.c
+++ linux-2.6_i2c/drivers/i2c/busses/i2c-designware.c
@@ -36,6 +36,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/swab.h>
 
 /*
  * Registers offset
@@ -192,6 +193,7 @@ static char *abort_sources[] = {
  * @status: i2c master status, one of STATUS_*
  * @abort_source: copy of the TX_ABRT_SOURCE register
  * @irq: interrupt number for the i2c master
+ * @swab: true if the instantiated IP is of different endianess
  * @adapter: i2c subsystem adapter node
  * @tx_fifo_depth: depth of the hardware tx fifo
  * @rx_fifo_depth: depth of the hardware rx fifo
@@ -215,6 +217,7 @@ struct dw_i2c_dev {
 	unsigned int		status;
 	u32			abort_source;
 	int			irq;
+	int			swab;
 	struct i2c_adapter	adapter;
 	unsigned int		tx_fifo_depth;
 	unsigned int		rx_fifo_depth;
@@ -222,11 +225,19 @@ struct dw_i2c_dev {
 
 static u32 i2c_dw_readl(struct dw_i2c_dev *dev, int addr)
 {
-	return readl(dev->base + addr);
+	u32 value = readl(dev->base + addr);
+
+	if (dev->swab)
+		return swab32(value);
+	else
+		return value;
 }
 
 static void i2c_dw_writel(struct dw_i2c_dev *dev, u32 b, int addr)
 {
+	if (dev->swab)
+		b = swab32(b);
+
 	writel(b, dev->base + addr);
 }
 
@@ -759,7 +770,9 @@ static int __devinit dw_i2c_probe(struct
 	{
 		u32 comp_type = i2c_dw_readl(dev, DW_IC_COMP_TYPE);
 
-		if (0x44570140 != comp_type) {
+		if (___constant_swab32(0x44570140) == comp_type)
+			dev->swab = 1;
+		else if (0x44570140 != comp_type) {
 			dev_err(&pdev->dev, "Unknown Synopsys component type: "
 					"0x%08x\n",	comp_type);
 			r = -ENODEV;

-- 
