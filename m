From: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH v3] i2c: designware: Add support for 16bit register access
Date: Wed, 18 Apr 2012 15:01:41 +0200
Message-ID: <1334754101-25802-1-git-send-email-sr@denx.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The STM SPEAr platform can only access the i2c controller register
via 16bit read/write functions. This patch adds support to
automatically detect this 16bit access mode.

Signed-off-by: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
---
v3:
- Changed multiple if statements into one if/elseif/etc statement
  to remove the "reg overwriting abuse".

v2:
- Removed parenthesis for single-statement block
- Moved "swab" and "access_16bit" into "accessor_flags"

 drivers/i2c/busses/i2c-designware-core.c |   31 ++++++++++++++++++++----------
 drivers/i2c/busses/i2c-designware-core.h |    5 ++++-
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index df87992..1e48bec 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -164,9 +164,15 @@ static char *abort_sources[] = {
 
 u32 dw_readl(struct dw_i2c_dev *dev, int offset)
 {
-	u32 value = readl(dev->base + offset);
+	u32 value;
 
-	if (dev->swab)
+	if (dev->accessor_flags & ACCESS_16BIT)
+		value = readw(dev->base + offset) |
+			(readw(dev->base + offset + 2) << 16);
+	else
+		value = readl(dev->base + offset);
+
+	if (dev->accessor_flags & ACCESS_SWAP)
 		return swab32(value);
 	else
 		return value;
@@ -174,10 +180,15 @@ u32 dw_readl(struct dw_i2c_dev *dev, int offset)
 
 void dw_writel(struct dw_i2c_dev *dev, u32 b, int offset)
 {
-	if (dev->swab)
+	if (dev->accessor_flags & ACCESS_SWAP)
 		b = swab32(b);
 
-	writel(b, dev->base + offset);
+	if (dev->accessor_flags & ACCESS_16BIT) {
+		writew((u16)b, dev->base + offset);
+		writew((u16)(b >> 16), dev->base + offset + 2);
+	} else {
+		writel(b, dev->base + offset);
+	}
 }
 
 static u32
@@ -251,14 +262,14 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 
 	input_clock_khz = dev->get_clk_rate_khz(dev);
 
-	/* Configure register endianess access */
 	reg = dw_readl(dev, DW_IC_COMP_TYPE);
 	if (reg == ___constant_swab32(DW_IC_COMP_TYPE_VALUE)) {
-		dev->swab = 1;
-		reg = DW_IC_COMP_TYPE_VALUE;
-	}
-
-	if (reg != DW_IC_COMP_TYPE_VALUE) {
+		/* Configure register endianess access */
+		dev->accessor_flags |= ACCESS_SWAP;
+	} else if (reg == (DW_IC_COMP_TYPE_VALUE & 0x0000ffff)) {
+		/* Configure register access mode 16bit */
+		dev->accessor_flags |= ACCESS_16BIT;
+	} else if (reg != DW_IC_COMP_TYPE_VALUE) {
 		dev_err(dev->dev, "Unknown Synopsys component type: "
 			"0x%08x\n", reg);
 		return -ENODEV;
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 02d1a2d..9c1840e 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -82,7 +82,7 @@ struct dw_i2c_dev {
 	unsigned int		status;
 	u32			abort_source;
 	int			irq;
-	int			swab;
+	u32			accessor_flags;
 	struct i2c_adapter	adapter;
 	u32			functionality;
 	u32			master_cfg;
@@ -90,6 +90,9 @@ struct dw_i2c_dev {
 	unsigned int		rx_fifo_depth;
 };
 
+#define ACCESS_SWAP		0x00000001
+#define ACCESS_16BIT		0x00000002
+
 extern u32 dw_readl(struct dw_i2c_dev *dev, int offset);
 extern void dw_writel(struct dw_i2c_dev *dev, u32 b, int offset);
 extern int i2c_dw_init(struct dw_i2c_dev *dev);
-- 
1.7.10
