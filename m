From: Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 2/2] i2c: Support for Netlogic XLP9XX/5XX I2C controller.
Date: Fri, 16 Jan 2015 12:53:40 +0530
Message-ID: <1421393020-18807-2-git-send-email-jchandra@broadcom.com>
References: <1421393020-18807-1-git-send-email-jchandra@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1421393020-18807-1-git-send-email-jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Subhendu Sekhar Behera <sbehera-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Subhendu Sekhar Behera <sbehera-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

Add an I2C bus driver i2c-xlp9xx.c to support the I2C block in the
XLP9xx/XLP5xx MIPS SoC. Update Kconfig and Makefile to add the
CONFIG_I2C_XLP9XX option.

Also add document Documentation/devicetree/bindings/i2c/i2c-xlp9xx.txt
for DT compatible string "netlogic,xlp9xx-i2c".

Signed-off-by: Subhendu Sekhar Behera <sbehera-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Signed-off-by: Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
---
 .../devicetree/bindings/i2c/i2c-xlp9xx.txt         |  19 +
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-xlp9xx.c                    | 447 +++++++++++++++++++++
 4 files changed, 477 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-xlp9xx.txt
 create mode 100644 drivers/i2c/busses/i2c-xlp9xx.c

diff --git a/Documentation/devicetree/bindings/i2c/i2c-xlp9xx.txt b/Documentation/devicetree/bindings/i2c/i2c-xlp9xx.txt
new file mode 100644
index 00000000..dca75d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-xlp9xx.txt
@@ -0,0 +1,19 @@
+XLP9XX/5XX I2C Bus Controller Driver
+
+Required properties:
+- compatible : Should be "netlogic,xlp9xx-i2c".
+- reg: Requires register offset and length.
+- interrupts: Should contain irq number.
+- clock-frequency: I2C clock frequency required.
+
+Example:
+
+i2c0: i2c@113100 {
+	compatible = "netlogic,xlp9xx-i2c";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reg = <0 0x113100 0x100>;
+	clock-frequency = <133000000>;
+	interrupts = <30>;
+	interrupt-parent = <&pic>;
+};
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 31e8308..44ba68e 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -878,6 +878,16 @@ config I2C_XLR
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-xlr.
 
+config I2C_XLP9XX
+	tristate "XLP9XX I2C support"
+	depends on CPU_XLP
+	help
+	  This driver enables support for the on-chip I2C interface of
+	  the Broadcom XLP9xx/XLP5xx MIPS processors.
+
+	  This driver can also be built as a module.  If so, the module will
+	  be called i2c-xlp9xx.
+
 config I2C_RCAR
 	tristate "Renesas R-Car I2C Controller"
 	depends on ARCH_SHMOBILE || COMPILE_TEST
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 56388f6..f61a198 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -85,6 +85,7 @@ obj-$(CONFIG_I2C_WMT)		+= i2c-wmt.o
 obj-$(CONFIG_I2C_OCTEON)	+= i2c-octeon.o
 obj-$(CONFIG_I2C_XILINX)	+= i2c-xiic.o
 obj-$(CONFIG_I2C_XLR)		+= i2c-xlr.o
+obj-$(CONFIG_I2C_XLP9XX)	+= i2c-xlp9xx.o
 obj-$(CONFIG_I2C_RCAR)		+= i2c-rcar.o
 
 # External I2C/SMBus adapter drivers
diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
new file mode 100644
index 00000000..8ff1137
--- /dev/null
+++ b/drivers/i2c/busses/i2c-xlp9xx.c
@@ -0,0 +1,447 @@
+/*
+ * Copyright (c) 2003-2015 Broadcom Corporation
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/completion.h>
+
+#define XLP9XX_I2C_DIV			0x0
+#define XLP9XX_I2C_CTRL			0x1
+#define XLP9XX_I2C_CMD			0x2
+#define XLP9XX_I2C_STATUS		0x3
+#define XLP9XX_I2C_MTXFIFO		0x4
+#define XLP9XX_I2C_MRXFIFO		0x5
+#define XLP9XX_I2C_MFIFOCTRL		0x6
+#define XLP9XX_I2C_STXFIFO		0x7
+#define XLP9XX_I2C_SRXFIFO		0x8
+#define XLP9XX_I2C_SFIFOCTRL		0x9
+#define XLP9XX_I2C_SLAVEADDR		0xA
+#define XLP9XX_I2C_OWNADDR		0xB
+#define XLP9XX_I2C_FIFOWCNT		0xC
+#define XLP9XX_I2C_INTEN		0xD
+#define XLP9XX_I2C_INTST		0xE
+#define XLP9XX_I2C_WAITCNT		0xF
+#define XLP9XX_I2C_TIMEOUT		0X10
+#define XLP9XX_I2C_GENCALLADDR		0x11
+
+#define XLP9XX_I2C_TIMEOUT_MS		1000
+#define XLP9XX_I2C_DEFAULT_FREQ		133000000UL
+
+#define XLP9XX_I2C_FIFO_SIZE		0x80U
+
+#define XLP9XX_I2C_FIFO_WCNT_MASK	0xff
+#define XLP9XX_I2C_FIFO_CTRL_MASK	0xffff
+
+#define XLP9XX_I2C_CTRL_MCTLEN_SHIFT		16
+#define XLP9XX_I2C_MFIFOCTRL_HITH_SHIFT		8
+#define XLP9XX_I2C_MFIFOCTRL_LOTH_SHIFT		0
+#define XLP9XX_I2C_SLAVEADDR_ADDR_SHIFT		1
+
+#define XLP9XX_I2C_CTRL_RST		BIT(8)
+#define XLP9XX_I2C_CTRL_EN		BIT(6)
+#define XLP9XX_I2C_CTRL_MASTER		BIT(4)
+#define XLP9XX_I2C_CTRL_FIFORD		BIT(1)
+#define XLP9XX_I2C_CTRL_ADDMODE		BIT(0)
+
+#define XLP9XX_I2C_CMD_START		BIT(7)
+#define XLP9XX_I2C_CMD_STOP		BIT(6)
+#define XLP9XX_I2C_CMD_READ		BIT(5)
+#define XLP9XX_I2C_CMD_WRITE		BIT(4)
+#define XLP9XX_I2C_CMD_ACK		BIT(3)
+
+#define XLP9XX_I2C_INTEN_NACKADDR	BIT(25)
+#define XLP9XX_I2C_INTEN_DATADONE	BIT(12)
+#define XLP9XX_I2C_INTEN_ARLOST		BIT(11)
+#define XLP9XX_I2C_INTEN_MDATARDY	BIT(5)
+#define XLP9XX_I2C_INTEN_MFIFOFULL	BIT(4)
+#define XLP9XX_I2C_INTEN_MFIFOEMTY	BIT(3)
+#define XLP9XX_I2C_INTEN_MFIFOHI	BIT(2)
+#define XLP9XX_I2C_INTEN_BUSERR		BIT(0)
+#define XLP9XX_I2C_STATUS_ERRMASK	(XLP9XX_I2C_INTEN_ARLOST | \
+			XLP9XX_I2C_INTEN_NACKADDR | XLP9XX_I2C_INTEN_BUSERR)
+
+#define XLP9XX_I2C_MFIFOCTRL_RST	BIT(16)
+
+#define XLP9XX_I2C_SLAVEADDR_RW		BIT(0)
+
+struct xlp9xx_i2c_dev {
+	struct device *dev;
+	struct i2c_adapter adapter;
+	struct completion msg_complete;
+	unsigned int msg_buf_remaining;
+	int irq;
+	bool msg_read;
+	u32 __iomem *base;
+	u32 clk_mhz;
+	u32 msg_err;
+	u8 *msg_buf;
+};
+
+static inline void xlp9xx_write_i2c_reg(struct xlp9xx_i2c_dev *priv,
+	unsigned long reg, u32 val)
+{
+	writel(val, priv->base + reg);
+}
+
+static inline u32 xlp9xx_read_i2c_reg(struct xlp9xx_i2c_dev *priv,
+	unsigned long reg)
+{
+	return readl(priv->base + reg);
+}
+
+static void xlp9xx_i2c_mask_irq(struct xlp9xx_i2c_dev *priv, u32 mask)
+{
+	u32 int_mask;
+
+	int_mask  = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_INTEN) & ~mask;
+	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_INTEN, int_mask);
+}
+
+static void xlp9xx_i2c_unmask_irq(struct xlp9xx_i2c_dev *priv, u32 mask)
+{
+	u32 int_unmask;
+
+	int_unmask = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_INTEN) | mask;
+	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_INTEN, int_unmask);
+}
+
+static void xlp9xx_i2c_set_rx_fifo_thres(struct xlp9xx_i2c_dev *priv,
+	uint32_t th)
+{
+	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_MFIFOCTRL,
+		(th << XLP9XX_I2C_MFIFOCTRL_HITH_SHIFT));
+}
+
+static void xlp9xx_i2c_fill_tx_fifo(struct xlp9xx_i2c_dev *priv)
+{
+	int i;
+	unsigned int len;
+	u8 *buf = priv->msg_buf;
+
+	len = min(priv->msg_buf_remaining, XLP9XX_I2C_FIFO_SIZE);
+	for (i = 0; i < len; i++)
+		xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_MTXFIFO, buf[i]);
+	priv->msg_buf_remaining -= len;
+	priv->msg_buf += len;
+}
+
+static void xlp9xx_i2c_drain_rx_fifo(struct xlp9xx_i2c_dev *priv)
+{
+	int i;
+	unsigned int len;
+	u8 *buf = priv->msg_buf;
+
+	len = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_FIFOWCNT) &
+		XLP9XX_I2C_FIFO_WCNT_MASK;
+	len = min(priv->msg_buf_remaining, len);
+	for (i = 0; i < len; i++, buf++)
+		*buf = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_MRXFIFO);
+
+	priv->msg_buf_remaining -= len;
+	priv->msg_buf = buf;
+
+	if (priv->msg_buf_remaining)
+		xlp9xx_i2c_set_rx_fifo_thres(priv,
+			min(priv->msg_buf_remaining, XLP9XX_I2C_FIFO_SIZE));
+}
+
+static irqreturn_t xlp9xx_i2c_isr(int irq, void *dev_id)
+{
+	struct xlp9xx_i2c_dev *priv = dev_id;
+	u32 status;
+
+	status = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_INTST);
+	if ((status == 0) || (status & XLP9XX_I2C_STATUS_ERRMASK))
+		goto isr_err;
+
+	if (!priv->msg_read) {
+		/* TX FIFO got empty, fill it up again */
+		if (status & XLP9XX_I2C_INTEN_MFIFOEMTY) {
+			if (priv->msg_buf_remaining)
+				xlp9xx_i2c_fill_tx_fifo(priv);
+			else
+				xlp9xx_i2c_mask_irq(priv,
+					XLP9XX_I2C_INTEN_MFIFOEMTY);
+		}
+	} else {
+		/* data is in FIFO, read it */
+		if (status & (XLP9XX_I2C_INTEN_MDATARDY |
+				XLP9XX_I2C_INTEN_DATADONE |
+				XLP9XX_I2C_INTEN_MFIFOHI)) {
+			if (status & XLP9XX_I2C_INTEN_MDATARDY)
+				xlp9xx_i2c_mask_irq(priv,
+					XLP9XX_I2C_INTEN_MDATARDY);
+			if (priv->msg_buf_remaining)
+				xlp9xx_i2c_drain_rx_fifo(priv);
+		}
+	}
+
+	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_INTST, status);
+
+	/* Transfer complete */
+	if (status & XLP9XX_I2C_INTEN_DATADONE)
+		complete(&priv->msg_complete);
+
+	return IRQ_HANDLED;
+
+isr_err:
+	priv->msg_err = status;
+	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_INTEN, 0);
+	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_INTST, status);
+	complete(&priv->msg_complete);
+
+	return IRQ_HANDLED;
+}
+
+static int xlp9xx_i2c_init(struct xlp9xx_i2c_dev *priv)
+{
+	u32 prescale;
+
+	prescale = (((priv->clk_mhz * 1000) / 400 - 8) / 5) - 1;
+	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_CTRL, XLP9XX_I2C_CTRL_RST);
+	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_CTRL, XLP9XX_I2C_CTRL_EN |
+		XLP9XX_I2C_CTRL_MASTER);
+	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_DIV, prescale);
+	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_INTEN, 0);
+
+	return 0;
+}
+
+static int xlp9xx_i2c_xfer_msg(struct xlp9xx_i2c_dev *priv, struct i2c_msg *msg)
+{
+	int ret;
+	u32 intr_mask, cmd, val;
+
+	priv->msg_buf = msg->buf;
+	priv->msg_buf_remaining = msg->len;
+	priv->msg_err = 0;
+	priv->msg_read = (msg->flags & I2C_M_RD);
+
+	if (msg->len == 0)
+		return -EINVAL;
+
+	/* Reset FIFO */
+	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_MFIFOCTRL,
+		XLP9XX_I2C_MFIFOCTRL_RST);
+
+	/* set FIFO threshold if reading */
+	if (priv->msg_read) {
+		val = min(priv->msg_buf_remaining, XLP9XX_I2C_FIFO_SIZE);
+		xlp9xx_i2c_set_rx_fifo_thres(priv, val);
+	}
+
+	/* set slave addr */
+	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_SLAVEADDR,
+		(msg->addr << XLP9XX_I2C_SLAVEADDR_ADDR_SHIFT) |
+		(priv->msg_read ? XLP9XX_I2C_SLAVEADDR_RW : 0));
+
+	/* Build control word for transfer */
+	val = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_CTRL);
+	if (!priv->msg_read)
+		val &= ~XLP9XX_I2C_CTRL_FIFORD;
+	else
+		val |= XLP9XX_I2C_CTRL_FIFORD;	/* read */
+	if (msg->flags & I2C_M_TEN)
+		val |= XLP9XX_I2C_CTRL_ADDMODE;	/* 10-bit address mode*/
+
+	/* set data length to be transferred */
+	val = (val & XLP9XX_I2C_FIFO_CTRL_MASK) |
+		(msg->len << XLP9XX_I2C_CTRL_MCTLEN_SHIFT);
+	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_CTRL, val);
+
+	/* fill fifo during tx */
+	if (!priv->msg_read)
+		xlp9xx_i2c_fill_tx_fifo(priv);
+
+	/* set interrupt mask */
+	intr_mask = (XLP9XX_I2C_INTEN_ARLOST | XLP9XX_I2C_INTEN_BUSERR |
+		XLP9XX_I2C_INTEN_NACKADDR | XLP9XX_I2C_INTEN_DATADONE);
+
+	if (priv->msg_read)
+		intr_mask |= (XLP9XX_I2C_INTEN_MDATARDY |
+			XLP9XX_I2C_INTEN_MFIFOHI);
+	else
+		intr_mask |= XLP9XX_I2C_INTEN_MFIFOEMTY;
+
+	xlp9xx_i2c_unmask_irq(priv, intr_mask);
+
+	/* set cmd reg */
+	cmd = XLP9XX_I2C_CMD_START | XLP9XX_I2C_CMD_STOP;
+	cmd |= (priv->msg_read ? XLP9XX_I2C_CMD_READ : XLP9XX_I2C_CMD_WRITE);
+
+	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_CMD, cmd);
+
+	ret = wait_for_completion_timeout(&priv->msg_complete,
+		msecs_to_jiffies(XLP9XX_I2C_TIMEOUT_MS));
+
+	xlp9xx_i2c_mask_irq(priv, intr_mask);
+
+	if (priv->msg_err) {
+		dev_err(priv->dev, "Transfer error %x!\n", priv->msg_err);
+		xlp9xx_i2c_init(priv);
+		return -ERESTART;
+	}
+
+	if (ret == 0) {
+		dev_err(priv->dev, "i2c transfer timed out!\n");
+		xlp9xx_i2c_init(priv);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int xlp9xx_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
+	int num)
+{
+	struct i2c_msg *msg;
+	int i, ret = 0;
+	struct xlp9xx_i2c_dev *priv = i2c_get_adapdata(adap);
+
+	for (i = 0; ret == 0 && i < num; i++) {
+		msg = &msgs[i];
+		ret = xlp9xx_i2c_xfer_msg(priv, msg);
+	}
+
+	return (ret != 0) ? ret : num;
+}
+
+static u32 xlp9xx_i2c_functionality(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_I2C;
+}
+
+static struct i2c_algorithm xlp9xx_i2c_algo = {
+	.master_xfer = xlp9xx_i2c_xfer,
+	.functionality = xlp9xx_i2c_functionality,
+};
+
+static int xlp9xx_i2c_of_probe(struct platform_device *pdev,
+	struct xlp9xx_i2c_dev *priv)
+{
+	struct device_node *np = pdev->dev.of_node;
+
+	if (of_property_read_u32(np, "clock-frequency", &priv->clk_mhz)) {
+		dev_info(&pdev->dev, "setting clock frequency to default\n");
+		priv->clk_mhz = XLP9XX_I2C_DEFAULT_FREQ;
+	}
+	priv->clk_mhz = priv->clk_mhz / (1000 * 1000);
+
+	return 0;
+}
+
+static int xlp9xx_i2c_probe(struct platform_device *pdev)
+{
+	struct xlp9xx_i2c_dev *priv;
+	struct resource *res;
+	int err = 0;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "no mem resource!\n");
+		return -EINVAL;
+	}
+
+	priv->base = devm_ioremap_resource(&pdev->dev, res);
+	if (!priv->base) {
+		dev_err(&pdev->dev, "device io mapping failed!\n");
+		return -EIO;
+	}
+
+	priv->irq = platform_get_irq(pdev, 0);
+	if (priv->irq < 0) {
+		dev_err(&pdev->dev, "invalid irq!\n");
+		return  priv->irq;
+	}
+
+	err = xlp9xx_i2c_of_probe(pdev, priv);
+	if (err) {
+		dev_err(&pdev->dev, "xlp9xx_i2c_of_probe failed!\n");
+		return err;
+	}
+
+	err = xlp9xx_i2c_init(priv);
+	if (err) {
+		dev_err(&pdev->dev, "I2C:%d initialization failed!\n",
+			pdev->id);
+		return err;
+	}
+
+	err = devm_request_irq(&pdev->dev, priv->irq, xlp9xx_i2c_isr, 0,
+		pdev->name, priv);
+	if (err) {
+		dev_err(&pdev->dev, "IRQ request failed!\n");
+		return err;
+	}
+
+	init_completion(&priv->msg_complete);
+	priv->adapter.owner = THIS_MODULE;
+	priv->adapter.dev.parent = &pdev->dev;
+	priv->adapter.algo = &xlp9xx_i2c_algo;
+	priv->adapter.nr = pdev->id;
+	priv->adapter.dev.of_node = pdev->dev.of_node;
+	priv->adapter.class = I2C_CLASS_HWMON;
+	priv->dev = &pdev->dev;
+
+	snprintf(priv->adapter.name, sizeof(priv->adapter.name), "xlp9xx-i2c");
+	i2c_set_adapdata(&priv->adapter, priv);
+
+	err = i2c_add_numbered_adapter(&priv->adapter);
+	if (err) {
+		dev_err(&pdev->dev, "failed to add I2C:%d adapter!\n",
+			pdev->id);
+		return err;
+	}
+
+	platform_set_drvdata(pdev, priv);
+	dev_info(&pdev->dev, "I2C bus:%d added\n", priv->adapter.nr);
+
+	return 0;
+}
+
+static int xlp9xx_i2c_remove(struct platform_device *pdev)
+{
+	struct xlp9xx_i2c_dev *priv;
+
+	priv = platform_get_drvdata(pdev);
+	i2c_del_adapter(&priv->adapter);
+
+	return 0;
+}
+
+static const struct of_device_id xlp9xx_i2c_of_match[] = {
+	{ .compatible = "netlogic,xlp9xx-i2c", .data = NULL, },
+	{},
+};
+
+static struct platform_driver xlp9xx_i2c_driver = {
+	.probe = xlp9xx_i2c_probe,
+	.remove = xlp9xx_i2c_remove,
+	.driver = {
+		.name = "xlp9xx-i2c",
+		.owner = THIS_MODULE,
+		.of_match_table = xlp9xx_i2c_of_match,
+	},
+};
+
+module_platform_driver(xlp9xx_i2c_driver);
+
+MODULE_AUTHOR("Subhendu Sekhar Behera <sbehera-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>");
+MODULE_DESCRIPTION("XLP9XX/5XX I2C Bus Controller Driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
