From: Mans Rullgard <mans@mansr.com>
Subject: [PATCH 3/3] i2c: xlr: add interrupt support for Sigma Designs chips
Date: Mon,  2 Nov 2015 02:03:38 +0000
Message-ID: <1446429818-24155-3-git-send-email-mans@mansr.com>
References: <1446429818-24155-1-git-send-email-mans@mansr.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446429818-24155-1-git-send-email-mans@mansr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The Sigma Designs variant of this controller has the ability to generate
interrupts.  This is controlled using two additional registers, oddly
enough overlapping with the defined but unused HDSTATIM.

This patch adds support for using this feature instead of busy-looping
if an IRQ is specified.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/i2c/busses/i2c-xlr.c | 119 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/drivers/i2c/busses/i2c-xlr.c b/drivers/i2c/busses/i2c-xlr.c
index c1afc3e..dd48c1e 100644
--- a/drivers/i2c/busses/i2c-xlr.c
+++ b/drivers/i2c/busses/i2c-xlr.c
@@ -19,6 +19,8 @@
 #include <linux/platform_device.h>
 #include <linux/of_device.h>
 #include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/wait.h>
 
 /* XLR I2C REGISTERS */
 #define XLR_I2C_CFG		0x00
@@ -32,6 +34,10 @@
 #define XLR_I2C_BYTECNT		0x08
 #define XLR_I2C_HDSTATIM	0x09
 
+/* Sigma Designs additional registers */
+#define XLR_I2C_INT_EN		0x09
+#define XLR_I2C_INT_STAT	0x0a
+
 /* XLR I2C REGISTERS FLAGS */
 #define XLR_I2C_BUS_BUSY	0x01
 #define XLR_I2C_SDOEMPTY	0x02
@@ -65,7 +71,10 @@ static inline u32 xlr_i2c_rdreg(u32 __iomem *base, unsigned int reg)
 	return __raw_readl(base + reg);
 }
 
+#define XLR_I2C_FLAG_IRQ	1
+
 struct xlr_i2c_config {
+	u32 flags;		/* optional feature support */
 	u32 status_busy;	/* value of STATUS[0] when busy */
 	u32 cfg_extra;		/* extra CFG bits to set */
 };
@@ -73,7 +82,11 @@ struct xlr_i2c_config {
 struct xlr_i2c_private {
 	struct i2c_adapter adap;
 	u32 __iomem *iobase;
+	int irq;
+	int pos;
+	struct i2c_msg *msg;
 	const struct xlr_i2c_config *cfg;
+	wait_queue_head_t wait;
 	struct clk *clk;
 };
 
@@ -82,6 +95,74 @@ static int xlr_i2c_busy(struct xlr_i2c_private *priv, u32 status)
 	return (status & XLR_I2C_BUS_BUSY) == priv->cfg->status_busy;
 }
 
+static int xlr_i2c_idle(struct xlr_i2c_private *priv)
+{
+	return !xlr_i2c_busy(priv, xlr_i2c_rdreg(priv->iobase, XLR_I2C_STATUS));
+}
+
+static int xlr_i2c_wait(struct xlr_i2c_private *priv, unsigned long timeout)
+{
+	int status;
+	int t;
+
+	t = wait_event_timeout(priv->wait, xlr_i2c_idle(priv),
+				msecs_to_jiffies(timeout));
+	if (!t)
+		return -ETIMEDOUT;
+
+	status = xlr_i2c_rdreg(priv->iobase, XLR_I2C_STATUS);
+
+	return status & XLR_I2C_ACK_ERR ? -EIO : 0;
+}
+
+static void xlr_i2c_tx_irq(struct xlr_i2c_private *priv, u32 status)
+{
+	struct i2c_msg *msg = priv->msg;
+
+	if (status & XLR_I2C_SDOEMPTY)
+		xlr_i2c_wreg(priv->iobase, XLR_I2C_DATAOUT,
+				msg->buf[priv->pos++]);
+}
+
+static void xlr_i2c_rx_irq(struct xlr_i2c_private *priv, u32 status)
+{
+	struct i2c_msg *msg = priv->msg;
+
+	if (status & XLR_I2C_RXRDY)
+		msg->buf[priv->pos++] =
+			xlr_i2c_rdreg(priv->iobase, XLR_I2C_DATAIN);
+}
+
+static irqreturn_t xlr_i2c_irq(int irq, void *dev_id)
+{
+	struct xlr_i2c_private *priv = dev_id;
+	struct i2c_msg *msg = priv->msg;
+	u32 int_stat, status;
+
+	int_stat = xlr_i2c_rdreg(priv->iobase, XLR_I2C_INT_STAT);
+	if (!int_stat)
+		return IRQ_NONE;
+
+	xlr_i2c_wreg(priv->iobase, XLR_I2C_INT_STAT, int_stat);
+
+	if (!msg)
+		return IRQ_HANDLED;
+
+	status = xlr_i2c_rdreg(priv->iobase, XLR_I2C_STATUS);
+
+	if (priv->pos < msg->len) {
+		if (msg->flags & I2C_M_RD)
+			xlr_i2c_rx_irq(priv, status);
+		else
+			xlr_i2c_tx_irq(priv, status);
+	}
+
+	if (!xlr_i2c_busy(priv, status))
+		wake_up(&priv->wait);
+
+	return IRQ_HANDLED;
+}
+
 static int xlr_i2c_tx(struct xlr_i2c_private *priv,  u16 len,
 	u8 *buf, u16 addr)
 {
@@ -119,10 +200,15 @@ static int xlr_i2c_tx(struct xlr_i2c_private *priv,  u16 len,
 		pos = 2;
 	}
 
+	priv->pos = pos;
+
 retry:
 	/* retry can only happen on the first byte */
 	xlr_i2c_wreg(priv->iobase, XLR_I2C_STARTXFR, xfer);
 
+	if (priv->irq > 0)
+		return xlr_i2c_wait(priv, XLR_I2C_TIMEOUT * len);
+
 	while (!timedout) {
 		checktime = jiffies;
 		i2c_status = xlr_i2c_rdreg(priv->iobase, XLR_I2C_STATUS);
@@ -170,6 +256,8 @@ static int xlr_i2c_rx(struct xlr_i2c_private *priv, u16 len, u8 *buf, u16 addr)
 	xlr_i2c_wreg(priv->iobase, XLR_I2C_BYTECNT, len - 1);
 	xlr_i2c_wreg(priv->iobase, XLR_I2C_DEVADDR, addr);
 
+	priv->pos = 0;
+
 	timeout = msecs_to_jiffies(XLR_I2C_TIMEOUT);
 	stoptime = jiffies + timeout;
 	timedout = 0;
@@ -177,6 +265,9 @@ static int xlr_i2c_rx(struct xlr_i2c_private *priv, u16 len, u8 *buf, u16 addr)
 retry:
 	xlr_i2c_wreg(priv->iobase, XLR_I2C_STARTXFR, XLR_I2C_STARTXFR_RD);
 
+	if (priv->irq > 0)
+		return xlr_i2c_wait(priv, XLR_I2C_TIMEOUT * len);
+
 	while (!timedout) {
 		checktime = jiffies;
 		i2c_status = xlr_i2c_rdreg(priv->iobase, XLR_I2C_STATUS);
@@ -221,8 +312,13 @@ static int xlr_i2c_xfer(struct i2c_adapter *adap,
 	if (ret)
 		return ret;
 
+	if (priv->irq)
+		xlr_i2c_wreg(priv->iobase, XLR_I2C_INT_EN, 0xf);
+
+
 	for (i = 0; ret == 0 && i < num; i++) {
 		msg = &msgs[i];
+		priv->msg = msg;
 		if (msg->flags & I2C_M_RD)
 			ret = xlr_i2c_rx(priv, msg->len, &msg->buf[0],
 					msg->addr);
@@ -231,7 +327,11 @@ static int xlr_i2c_xfer(struct i2c_adapter *adap,
 					msg->addr);
 	}
 
+	if (priv->irq)
+		xlr_i2c_wreg(priv->iobase, XLR_I2C_INT_EN, 0);
+
 	clk_disable(priv->clk);
+	priv->msg = NULL;
 
 	return (ret != 0) ? ret : num;
 }
@@ -253,6 +353,7 @@ static const struct xlr_i2c_config xlr_i2c_config_default = {
 };
 
 static const struct xlr_i2c_config xlr_i2c_config_tangox = {
+	.flags		= XLR_I2C_FLAG_IRQ,
 	.status_busy	= 0,
 	.cfg_extra	= 1 << 8,
 };
@@ -274,6 +375,7 @@ static int xlr_i2c_probe(struct platform_device *pdev)
 	unsigned long clk_rate;
 	unsigned long clk_div;
 	u32 busfreq;
+	int irq;
 	int ret;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -291,6 +393,23 @@ static int xlr_i2c_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->iobase))
 		return PTR_ERR(priv->iobase);
 
+	irq = platform_get_irq(pdev, 0);
+
+	if (irq > 0 && (priv->cfg->flags & XLR_I2C_FLAG_IRQ)) {
+		priv->irq = irq;
+
+		xlr_i2c_wreg(priv->iobase, XLR_I2C_INT_EN, 0);
+		xlr_i2c_wreg(priv->iobase, XLR_I2C_INT_STAT, 0xf);
+
+		ret = devm_request_irq(&pdev->dev, priv->irq, xlr_i2c_irq,
+					IRQF_SHARED, dev_name(&pdev->dev),
+					priv);
+		if (ret)
+			return ret;
+
+		init_waitqueue_head(&priv->wait);
+	}
+
 	if (of_property_read_u32(pdev->dev.of_node, "clock-frequency",
 				 &busfreq))
 		busfreq = 100000;
-- 
2.6.2
