From: Mans Rullgard <mans@mansr.com>
Subject: [PATCH 1/3] i2c: xlr: add support for Sigma Designs controller variant
Date: Mon,  2 Nov 2015 02:03:36 +0000
Message-ID: <1446429818-24155-1-git-send-email-mans@mansr.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:39744 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751476AbbKBCEB (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 1 Nov 2015 21:04:01 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Sigma Designs chips use a variant of this controller with the following
differences:

- The BUSY bit in the STATUS register is inverted
- Bit 8 of the CONFIG register must be set
- The controller can generate interrupts

This patch adds support for the first two of these.  It also calculates
and sets the correct clock divisor if a clk is provided.  The bus
frequency is optionally speficied in the device tree node.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/i2c/busses/Kconfig   |  6 ++--
 drivers/i2c/busses/i2c-xlr.c | 81 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 80 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index f764e3a..fdedf59 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -944,11 +944,11 @@ config I2C_XILINX
 	  will be called xilinx_i2c.
 
 config I2C_XLR
-	tristate "XLR I2C support"
-	depends on CPU_XLR
+	tristate "Netlogic XLR and Sigma Designs I2C support"
+	depends on CPU_XLR || ARCH_TANGOX
 	help
 	  This driver enables support for the on-chip I2C interface of
-	  the Netlogic XLR/XLS MIPS processors.
+	  the Netlogic XLR/XLS MIPS processors and Sigma Designs SOCs.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-xlr.
diff --git a/drivers/i2c/busses/i2c-xlr.c b/drivers/i2c/busses/i2c-xlr.c
index 8b36bcf..10fb916 100644
--- a/drivers/i2c/busses/i2c-xlr.c
+++ b/drivers/i2c/busses/i2c-xlr.c
@@ -17,6 +17,8 @@
 #include <linux/i2c.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/of_device.h>
+#include <linux/clk.h>
 
 /* XLR I2C REGISTERS */
 #define XLR_I2C_CFG		0x00
@@ -63,11 +65,23 @@ static inline u32 xlr_i2c_rdreg(u32 __iomem *base, unsigned int reg)
 	return __raw_readl(base + reg);
 }
 
+struct xlr_i2c_config {
+	u32 status_busy;	/* value of STATUS[0] when busy */
+	u32 cfg_extra;		/* extra CFG bits to set */
+};
+
 struct xlr_i2c_private {
 	struct i2c_adapter adap;
 	u32 __iomem *iobase;
+	const struct xlr_i2c_config *cfg;
+	struct clk *clk;
 };
 
+static int xlr_i2c_busy(struct xlr_i2c_private *priv, u32 status)
+{
+	return (status & XLR_I2C_BUS_BUSY) == priv->cfg->status_busy;
+}
+
 static int xlr_i2c_tx(struct xlr_i2c_private *priv,  u16 len,
 	u8 *buf, u16 addr)
 {
@@ -80,7 +94,8 @@ static int xlr_i2c_tx(struct xlr_i2c_private *priv,  u16 len,
 	offset = buf[0];
 	xlr_i2c_wreg(priv->iobase, XLR_I2C_ADDR, offset);
 	xlr_i2c_wreg(priv->iobase, XLR_I2C_DEVADDR, addr);
-	xlr_i2c_wreg(priv->iobase, XLR_I2C_CFG, XLR_I2C_CFG_ADDR);
+	xlr_i2c_wreg(priv->iobase, XLR_I2C_CFG,
+			XLR_I2C_CFG_ADDR | priv->cfg->cfg_extra);
 	xlr_i2c_wreg(priv->iobase, XLR_I2C_BYTECNT, len - 1);
 
 	timeout = msecs_to_jiffies(XLR_I2C_TIMEOUT);
@@ -121,7 +136,7 @@ retry:
 		if (i2c_status & XLR_I2C_ACK_ERR)
 			return -EIO;
 
-		if ((i2c_status & XLR_I2C_BUS_BUSY) == 0 && pos >= len)
+		if (!xlr_i2c_busy(priv, i2c_status) && pos >= len)
 			return 0;
 	}
 	dev_err(&adap->dev, "I2C transmit timeout\n");
@@ -136,7 +151,8 @@ static int xlr_i2c_rx(struct xlr_i2c_private *priv, u16 len, u8 *buf, u16 addr)
 	int nbytes, timedout;
 	u8 byte;
 
-	xlr_i2c_wreg(priv->iobase, XLR_I2C_CFG, XLR_I2C_CFG_NOADDR);
+	xlr_i2c_wreg(priv->iobase, XLR_I2C_CFG,
+			XLR_I2C_CFG_NOADDR | priv->cfg->cfg_extra);
 	xlr_i2c_wreg(priv->iobase, XLR_I2C_BYTECNT, len);
 	xlr_i2c_wreg(priv->iobase, XLR_I2C_DEVADDR, addr);
 
@@ -174,7 +190,7 @@ retry:
 		if (i2c_status & XLR_I2C_ACK_ERR)
 			return -EIO;
 
-		if ((i2c_status & XLR_I2C_BUS_BUSY) == 0)
+		if (!xlr_i2c_busy(priv, i2c_status))
 			return 0;
 	}
 
@@ -190,6 +206,10 @@ static int xlr_i2c_xfer(struct i2c_adapter *adap,
 	int ret = 0;
 	struct xlr_i2c_private *priv = i2c_get_adapdata(adap);
 
+	ret = clk_enable(priv->clk);
+	if (ret)
+		return ret;
+
 	for (i = 0; ret == 0 && i < num; i++) {
 		msg = &msgs[i];
 		if (msg->flags & I2C_M_RD)
@@ -200,6 +220,8 @@ static int xlr_i2c_xfer(struct i2c_adapter *adap,
 					msg->addr);
 	}
 
+	clk_disable(priv->clk);
+
 	return (ret != 0) ? ret : num;
 }
 
@@ -214,22 +236,70 @@ static struct i2c_algorithm xlr_i2c_algo = {
 	.functionality	= xlr_func,
 };
 
+static const struct xlr_i2c_config xlr_i2c_config_default = {
+	.status_busy	= XLR_I2C_BUS_BUSY,
+	.cfg_extra	= 0,
+};
+
+static const struct xlr_i2c_config xlr_i2c_config_tangox = {
+	.status_busy	= 0,
+	.cfg_extra	= 1 << 8,
+};
+
+static const struct of_device_id xlr_i2c_dt_ids[] = {
+	{
+		.compatible	= "sigma,smp8642-i2c",
+		.data		= &xlr_i2c_config_tangox,
+	},
+	{ }
+};
+
 static int xlr_i2c_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *match;
 	struct xlr_i2c_private  *priv;
 	struct resource *res;
+	struct clk *clk;
+	unsigned long clk_rate;
+	unsigned long clk_div;
+	u32 busfreq;
 	int ret;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
+	match = of_match_device(xlr_i2c_dt_ids, &pdev->dev);
+	if (match)
+		priv->cfg = match->data;
+	else
+		priv->cfg = &xlr_i2c_config_default;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	priv->iobase = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(priv->iobase))
 		return PTR_ERR(priv->iobase);
 
+	if (of_property_read_u32(pdev->dev.of_node, "clock-frequency",
+				 &busfreq))
+		busfreq = 100000;
+
+	clk = devm_clk_get(&pdev->dev, NULL);
+	if (!IS_ERR(clk)) {
+		ret = clk_prepare_enable(clk);
+		if (ret)
+			return ret;
+
+		clk_rate = clk_get_rate(clk);
+		clk_div = DIV_ROUND_UP(clk_rate, 2 * busfreq);
+		xlr_i2c_wreg(priv->iobase, XLR_I2C_CLKDIV, clk_div);
+
+		clk_disable(clk);
+		priv->clk = clk;
+	}
+
 	priv->adap.dev.parent = &pdev->dev;
+	priv->adap.dev.of_node	= pdev->dev.of_node;
 	priv->adap.owner	= THIS_MODULE;
 	priv->adap.algo_data	= priv;
 	priv->adap.algo		= &xlr_i2c_algo;
@@ -255,6 +325,8 @@ static int xlr_i2c_remove(struct platform_device *pdev)
 
 	priv = platform_get_drvdata(pdev);
 	i2c_del_adapter(&priv->adap);
+	clk_unprepare(priv->clk);
+
 	return 0;
 }
 
@@ -263,6 +335,7 @@ static struct platform_driver xlr_i2c_driver = {
 	.remove = xlr_i2c_remove,
 	.driver = {
 		.name   = "xlr-i2cbus",
+		.of_match_table	= xlr_i2c_dt_ids,
 	},
 };
 
-- 
2.6.2
