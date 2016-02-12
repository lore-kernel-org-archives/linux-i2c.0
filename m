From: Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v2 1/3] i2c: iproc: Add recovery mechanism in error case
Date: Fri, 12 Feb 2016 13:10:41 -0800
Message-ID: <1455311443-30590-2-git-send-email-ray.jui@broadcom.com>
References: <1455311443-30590-1-git-send-email-ray.jui@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455311443-30590-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Icarus Chau <ichau@broadcom.com>, Ray Jui <rjui@broadcom.com>
List-Id: linux-i2c@vger.kernel.org

From: Ray Jui <rjui@broadcom.com>

Add proper recovery mechanism to the iProc I2C driver in error cases

Signed-off-by: Icarus Chau <ichau@broadcom.com>
Signed-off-by: Ray Jui <rjui@broadcom.com>
Tested-by: Icarus Chau <ichau@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 91 ++++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 43 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index 0419f52..ce062d3 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -119,6 +119,48 @@ static irqreturn_t bcm_iproc_i2c_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static int bcm_iproc_i2c_init(struct bcm_iproc_i2c_dev *iproc_i2c)
+{
+	u32 val;
+
+	/* put controller in reset */
+	val = readl(iproc_i2c->base + CFG_OFFSET);
+	val |= 1 << CFG_RESET_SHIFT;
+	val &= ~(1 << CFG_EN_SHIFT);
+	writel(val, iproc_i2c->base + CFG_OFFSET);
+
+	/* wait 100 usec per spec */
+	udelay(100);
+
+	/* bring controller out of reset */
+	val &= ~(1 << CFG_RESET_SHIFT);
+	writel(val, iproc_i2c->base + CFG_OFFSET);
+
+	/* flush TX/RX FIFOs and set RX FIFO threshold to zero */
+	val = (1 << M_FIFO_RX_FLUSH_SHIFT) | (1 << M_FIFO_TX_FLUSH_SHIFT);
+	writel(val, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
+	/* disable all interrupts */
+	writel(0, iproc_i2c->base + IE_OFFSET);
+
+	/* clear all pending interrupts */
+	writel(0xffffffff, iproc_i2c->base + IS_OFFSET);
+
+	return 0;
+}
+
+static void bcm_iproc_i2c_enable_disable(struct bcm_iproc_i2c_dev *iproc_i2c,
+                                         bool enable)
+{
+	u32 val;
+
+	val = readl(iproc_i2c->base + CFG_OFFSET);
+	if (enable)
+		val |= BIT(CFG_EN_SHIFT);
+	else
+		val &= ~BIT(CFG_EN_SHIFT);
+	writel(val, iproc_i2c->base + CFG_OFFSET);
+}
+
 static int bcm_iproc_i2c_check_status(struct bcm_iproc_i2c_dev *iproc_i2c,
 				      struct i2c_msg *msg)
 {
@@ -149,6 +191,12 @@ static int bcm_iproc_i2c_check_status(struct bcm_iproc_i2c_dev *iproc_i2c,
 
 	default:
 		dev_dbg(iproc_i2c->device, "unknown error code=%d\n", val);
+
+		/* re-initialize i2c for recovery */
+		bcm_iproc_i2c_enable_disable(iproc_i2c, false);
+		bcm_iproc_i2c_init(iproc_i2c);
+		bcm_iproc_i2c_enable_disable(iproc_i2c, true);
+
 		return -EIO;
 	}
 }
@@ -321,49 +369,6 @@ static int bcm_iproc_i2c_cfg_speed(struct bcm_iproc_i2c_dev *iproc_i2c)
 	return 0;
 }
 
-static int bcm_iproc_i2c_init(struct bcm_iproc_i2c_dev *iproc_i2c)
-{
-	u32 val;
-
-	/* put controller in reset */
-	val = readl(iproc_i2c->base + CFG_OFFSET);
-	val |= 1 << CFG_RESET_SHIFT;
-	val &= ~(1 << CFG_EN_SHIFT);
-	writel(val, iproc_i2c->base + CFG_OFFSET);
-
-	/* wait 100 usec per spec */
-	udelay(100);
-
-	/* bring controller out of reset */
-	val &= ~(1 << CFG_RESET_SHIFT);
-	writel(val, iproc_i2c->base + CFG_OFFSET);
-
-	/* flush TX/RX FIFOs and set RX FIFO threshold to zero */
-	val = (1 << M_FIFO_RX_FLUSH_SHIFT) | (1 << M_FIFO_TX_FLUSH_SHIFT);
-	writel(val, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
-
-	/* disable all interrupts */
-	writel(0, iproc_i2c->base + IE_OFFSET);
-
-	/* clear all pending interrupts */
-	writel(0xffffffff, iproc_i2c->base + IS_OFFSET);
-
-	return 0;
-}
-
-static void bcm_iproc_i2c_enable_disable(struct bcm_iproc_i2c_dev *iproc_i2c,
-					 bool enable)
-{
-	u32 val;
-
-	val = readl(iproc_i2c->base + CFG_OFFSET);
-	if (enable)
-		val |= BIT(CFG_EN_SHIFT);
-	else
-		val &= ~BIT(CFG_EN_SHIFT);
-	writel(val, iproc_i2c->base + CFG_OFFSET);
-}
-
 static int bcm_iproc_i2c_probe(struct platform_device *pdev)
 {
 	int irq, ret = 0;
-- 
1.9.1
