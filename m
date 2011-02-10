From: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 03/13] i2c-designware: Allow mixed endianness accesses
Date: Thu, 10 Feb 2011 08:21:19 -0800
Message-ID: <1297354889-20721-4-git-send-email-dirk.brandewie@gmail.com>
References: <1297354889-20721-1-git-send-email-dirk.brandewie@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297354889-20721-1-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: alan.cox-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>

Allows CPUs of a given endianness to access a dw controller of a different
endianness. Endianncess difference is detected at run time through the dw
component type register.

Signed-off-by: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index b2b2a19..f58f05d 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -37,6 +37,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/swab.h>
 
 /*
  * Registers offset
@@ -193,6 +194,7 @@ static char *abort_sources[] = {
  * @status: i2c master status, one of STATUS_*
  * @abort_source: copy of the TX_ABRT_SOURCE register
  * @irq: interrupt number for the i2c master
+ * @swab: true if the instantiated IP is of different endianess
  * @adapter: i2c subsystem adapter node
  * @tx_fifo_depth: depth of the hardware tx fifo
  * @rx_fifo_depth: depth of the hardware rx fifo
@@ -216,6 +218,7 @@ struct dw_i2c_dev {
 	unsigned int		status;
 	u32			abort_source;
 	int			irq;
+	int			swab;
 	struct i2c_adapter	adapter;
 	unsigned int		tx_fifo_depth;
 	unsigned int		rx_fifo_depth;
@@ -223,11 +226,19 @@ struct dw_i2c_dev {
 
 static u32 dw_readl(struct dw_i2c_dev *dev, int offset)
 {
-	return readl(dev->base + offset);
+	u32 value = readl(dev->base + offset);
+
+	if (dev->swab)
+		return swab32(value);
+	else
+		return value;
 }
 
 static void dw_writel(struct dw_i2c_dev *dev, u32 b, int offset)
 {
+	if (dev->swab)
+		b = swab32(b);
+
 	writel(b, dev->base + offset);
 }
 
@@ -760,7 +771,9 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 	}
 
 	reg = dw_readl(dev, DW_IC_COMP_TYPE);
-	if (reg != 0x44570140) {
+	if (reg == ___constant_swab32(0x44570140))
+		dev->swab = 1;
+	else if (reg != 0x44570140) {
 		dev_err(&pdev->dev, "Unknown Synopsys component type: "
 				"0x%08x\n",	reg);
 		r = -ENODEV;
-- 
1.7.3.4
