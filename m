From: Pan Wen <wenpan@hisilicon.com>
Subject: [PATCH resend v4] i2c: hibvt: add Hisilicon BVT I2C controller driver
Date: Fri, 21 Oct 2016 16:17:09 +0800
Message-ID: <20161021081709.7307-1-wenpan@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:14017 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753334AbcJUIZN (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 21 Oct 2016 04:25:13 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, howell.yang@hisilicon.com, xuejiancheng@hisilicon.com, jalen.hsu@hisilicon.com, lvkuanliang@hisilicon.com, suwenping@hisilicon.com, raojun@hisilicon.com, kevin.lixu@hisilicon.com, wenpan@hisilicon.com

add Hisilicon BVT I2C controller driver support.

Signed-off-by: Pan Wen <wenpan@hisilicon.com>
Acked-by: Rob Herring <robh@kernel.org>
---
change log
v4:
Modify the default frequency to 100KHz.
v3:
Add a SoC specific compatible string.
v2:
1)Fixed a compile error.
2)Dropped the clock-names property.
 .../devicetree/bindings/i2c/i2c-hibvt.txt          |  24 +
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-hibvt.c                     | 737 +++++++++++++++++++++
 4 files changed, 772 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-hibvt.txt
 create mode 100644 drivers/i2c/busses/i2c-hibvt.c

diff --git a/Documentation/devicetree/bindings/i2c/i2c-hibvt.txt b/Documentation/devicetree/bindings/i2c/i2c-hibvt.txt
new file mode 100644
index 0000000..db3d2e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-hibvt.txt
@@ -0,0 +1,24 @@
+Hisilicon BVT I2C master controller
+
+Required properties:
+- compatible: should be "hisilicon,hibvt-i2c" and one of the following:
+	"hisilicon,hi3516cv300-i2c"
+- reg: physical base address of the controller and length of memory mapped.
+     region.
+- interrupts: interrupt number to the cpu.
+- clocks: phandles to input clocks.
+
+Optional properties:
+- clock-frequency: Desired I2C bus frequency in Hz, otherwise defaults to 100000.
+
+Other properties:
+see Documentation/devicetree/bindings/i2c/i2c.txt.
+
+Examples:
+i2c_bus0: i2c@12110000 {
+	compatible = "hisilicon,hi3516cv300-i2c", "hisilicon,hibvt-i2c";
+	reg = <0x12110000 0x100>;
+	interrupts = <20>;
+	clocks = <&crg_ctrl HI3516CV300_APB_CLK>;
+	clock-frequency = <100000>;
+};
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 5c3993b..fc1b679 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -555,6 +555,16 @@ config I2C_GPIO
 	  This is a very simple bitbanging I2C driver utilizing the
 	  arch-neutral GPIO API to control the SCL and SDA lines.
 
+config I2C_HIBVT
+	tristate "Hisilicon BVT I2C Controller"
+	depends on ARCH_HISI
+	help
+	  Say Y here to include support for Hisilicon BVT I2C controller in the
+	  Hisilicon BVT SoCs.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-hibvt.
+
 config I2C_HIGHLANDER
 	tristate "Highlander FPGA SMBus interface"
 	depends on SH_HIGHLANDER
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 37f2819..42ef2e0 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_I2C_EG20T)		+= i2c-eg20t.o
 obj-$(CONFIG_I2C_EMEV2)		+= i2c-emev2.o
 obj-$(CONFIG_I2C_EXYNOS5)	+= i2c-exynos5.o
 obj-$(CONFIG_I2C_GPIO)		+= i2c-gpio.o
+obj-$(CONFIG_I2C_HIBVT)		+= i2c-hibvt.o
 obj-$(CONFIG_I2C_HIGHLANDER)	+= i2c-highlander.o
 obj-$(CONFIG_I2C_HIX5HD2)	+= i2c-hix5hd2.o
 obj-$(CONFIG_I2C_IBM_IIC)	+= i2c-ibm_iic.o
diff --git a/drivers/i2c/busses/i2c-hibvt.c b/drivers/i2c/busses/i2c-hibvt.c
new file mode 100644
index 0000000..e8af63e
--- /dev/null
+++ b/drivers/i2c/busses/i2c-hibvt.c
@@ -0,0 +1,737 @@
+/*
+ * Hisilicon BVT I2C Controller Driver
+ *
+ * Copyright (c) 2016 HiSilicon Technologies Co., Ltd.
+ *
+ * Authors: wenpan@hisilicon.com
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+/*
+ * I2C Registers offsets
+ */
+#define HIBVT_I2C_GLB		0x0
+#define HIBVT_I2C_SCL_H		0x4
+#define HIBVT_I2C_SCL_L		0x8
+#define HIBVT_I2C_DATA1		0x10
+#define HIBVT_I2C_TXF		0x20
+#define HIBVT_I2C_RXF		0x24
+#define HIBVT_I2C_CMD_BASE	0x30
+#define HIBVT_I2C_LOOP1		0xb0
+#define HIBVT_I2C_DST1		0xb4
+#define HIBVT_I2C_TX_WATER	0xc8
+#define HIBVT_I2C_RX_WATER	0xcc
+#define HIBVT_I2C_CTRL1		0xd0
+#define HIBVT_I2C_STAT		0xd8
+#define HIBVT_I2C_INTR_RAW	0xe0
+#define HIBVT_I2C_INTR_EN	0xe4
+#define HIBVT_I2C_INTR_STAT	0xe8
+
+/*
+ * I2C Global Config Register -- HIBVT_I2C_GLB
+ */
+#define GLB_EN_MASK		BIT(0)
+#define GLB_SDA_HOLD_MASK	GENMASK(23, 8)
+#define GLB_SDA_HOLD_SHIFT	(8)
+
+/*
+ * I2C Timing CMD Register -- HIBVT_I2C_CMD_BASE + n * 4 (n = 0, 1, 2, ... 31)
+ */
+#define CMD_EXIT	0x0
+#define CMD_TX_S	0x1
+#define CMD_TX_D1_2	0x4
+#define CMD_TX_D1_1	0x5
+#define CMD_TX_FIFO	0x9
+#define CMD_RX_FIFO	0x12
+#define CMD_RX_ACK	0x13
+#define CMD_IGN_ACK	0x15
+#define CMD_TX_ACK	0x16
+#define CMD_TX_NACK	0x17
+#define CMD_JMP1	0x18
+#define CMD_UP_TXF	0x1d
+#define CMD_TX_RS	0x1e
+#define CMD_TX_P	0x1f
+
+/*
+ * I2C Control Register 1 -- HIBVT_I2C_CTRL1
+ */
+#define CTRL1_CMD_START_MASK	BIT(0)
+
+/*
+ * I2C Status Register -- HIBVT_I2C_STAT
+ */
+#define STAT_RXF_NOE_MASK	BIT(16) /* RX FIFO not empty flag */
+#define STAT_TXF_NOF_MASK	BIT(19) /* TX FIFO not full flag */
+
+
+/*
+ * I2C Interrupt status and mask Register --
+ * HIBVT_I2C_INTR_RAW, HIBVT_I2C_STAT, HIBVT_I2C_INTR_STAT
+ */
+#define INTR_ABORT_MASK		(BIT(0) | BIT(11))
+#define INTR_RX_MASK		BIT(2)
+#define INTR_TX_MASK		BIT(4)
+#define INTR_CMD_DONE_MASK	BIT(12)
+#define INTR_USE_MASK		(INTR_ABORT_MASK \
+				|INTR_RX_MASK \
+				| INTR_TX_MASK \
+				| INTR_CMD_DONE_MASK)
+#define INTR_ALL_MASK		GENMASK(31, 0)
+
+#define I2C_DEFAULT_FREQUENCY	100000
+#define I2C_TXF_DEPTH		64
+#define I2C_RXF_DEPTH		64
+#define I2C_TXF_WATER		32
+#define I2C_RXF_WATER		32
+#define I2C_WAIT_TIMEOUT	0x10000
+#define I2C_IRQ_TIMEOUT		(msecs_to_jiffies(1000))
+
+
+struct hibvt_i2c_dev {
+	struct device		*dev;
+	struct i2c_adapter	adap;
+	void __iomem		*base;
+	struct clk		*clk;
+	int			irq;
+
+	unsigned int		freq;
+	struct i2c_msg		*msg;
+	unsigned int		msg_num;
+	unsigned int		msg_idx;
+	unsigned int		msg_buf_ptr;
+	struct completion	msg_complete;
+
+	spinlock_t		lock;
+	int			status;
+};
+
+static inline void hibvt_i2c_disable(struct hibvt_i2c_dev *i2c)
+{
+	unsigned int val;
+
+	val = readl(i2c->base + HIBVT_I2C_GLB);
+	val &= ~GLB_EN_MASK;
+	writel(val, i2c->base + HIBVT_I2C_GLB);
+}
+
+static inline void hibvt_i2c_enable(struct hibvt_i2c_dev *i2c)
+{
+	unsigned int val;
+
+	val = readl(i2c->base + HIBVT_I2C_GLB);
+	val |= GLB_EN_MASK;
+	writel(val, i2c->base + HIBVT_I2C_GLB);
+}
+
+static inline void hibvt_i2c_cfg_irq(struct hibvt_i2c_dev *i2c,
+		unsigned int flag)
+{
+	writel(flag, i2c->base + HIBVT_I2C_INTR_EN);
+}
+
+static inline void hibvt_i2c_disable_irq(struct hibvt_i2c_dev *i2c,
+		unsigned int flag)
+{
+	unsigned int val;
+
+	val = readl(i2c->base + HIBVT_I2C_INTR_EN);
+	val &= ~flag;
+	writel(val, i2c->base + HIBVT_I2C_INTR_EN);
+}
+
+static inline unsigned int hibvt_i2c_clr_irq(struct hibvt_i2c_dev *i2c)
+{
+	unsigned int val;
+
+	val = readl(i2c->base + HIBVT_I2C_INTR_STAT);
+	writel(INTR_ALL_MASK, i2c->base + HIBVT_I2C_INTR_RAW);
+
+	return val;
+}
+
+static inline void hibvt_i2c_cmdreg_set(struct hibvt_i2c_dev *i2c,
+		unsigned int cmd, unsigned int *offset)
+{
+	dev_dbg(i2c->dev, "hii2c reg: offset=0x%x, cmd=0x%x...\n",
+			*offset * 4, cmd);
+	writel(cmd, i2c->base + HIBVT_I2C_CMD_BASE + *offset * 4);
+	(*offset)++;
+}
+
+/*
+ * config i2c slave addr
+ */
+static inline void hibvt_i2c_set_addr(struct hibvt_i2c_dev *i2c)
+{
+	struct i2c_msg *msg = i2c->msg;
+	u16 addr;
+
+	if (msg->flags & I2C_M_TEN) {
+		/* First byte is 11110XX0 where XX is upper 2 bits */
+		addr = ((msg->addr & 0x300) << 1) | 0xf000;
+		if (msg->flags & I2C_M_RD)
+			addr |= 1 << 8;
+
+		/* Second byte is the remaining 8 bits */
+		addr |= msg->addr & 0xff;
+	} else {
+		addr = (msg->addr & 0x7f) << 1;
+		if (msg->flags & I2C_M_RD)
+			addr |= 1;
+	}
+
+	writel(addr, i2c->base + HIBVT_I2C_DATA1);
+}
+
+/*
+ * Start command sequence
+ */
+static inline void hibvt_i2c_start_cmd(struct hibvt_i2c_dev *i2c)
+{
+	unsigned int val;
+
+	val = readl(i2c->base + HIBVT_I2C_CTRL1);
+	val |= CTRL1_CMD_START_MASK;
+	writel(val, i2c->base + HIBVT_I2C_CTRL1);
+}
+
+static int hibvt_i2c_wait_rx_noempty(struct hibvt_i2c_dev *i2c)
+{
+	unsigned int time_cnt = 0;
+	unsigned int val;
+
+	do {
+		val = readl(i2c->base + HIBVT_I2C_STAT);
+		if (val & STAT_RXF_NOE_MASK)
+			return 0;
+
+		udelay(50);
+	} while (time_cnt++ < I2C_WAIT_TIMEOUT);
+
+	dev_err(i2c->dev, "wait rx no empty timeout, RIS: 0x%x, SR: 0x%x\n",
+			readl(i2c->base + HIBVT_I2C_INTR_RAW), val);
+	return -EIO;
+}
+
+static int hibvt_i2c_wait_tx_nofull(struct hibvt_i2c_dev *i2c)
+{
+	unsigned int time_cnt = 0;
+	unsigned int val;
+
+	do {
+		val = readl(i2c->base + HIBVT_I2C_STAT);
+		if (val & STAT_TXF_NOF_MASK)
+			return 0;
+
+		udelay(50);
+	} while (time_cnt++ < I2C_WAIT_TIMEOUT);
+
+	dev_err(i2c->dev, "wait rx no empty timeout, RIS: 0x%x, SR: 0x%x\n",
+			readl(i2c->base + HIBVT_I2C_INTR_RAW), val);
+	return -EIO;
+}
+
+static int hibvt_i2c_wait_idle(struct hibvt_i2c_dev *i2c)
+{
+	unsigned int time_cnt = 0;
+	unsigned int val;
+
+	do {
+		val = readl(i2c->base + HIBVT_I2C_INTR_RAW);
+		if (val & (INTR_ABORT_MASK)) {
+			dev_err(i2c->dev, "wait idle abort!, RIS: 0x%x\n",
+					val);
+			return -EIO;
+		}
+
+		if (val & INTR_CMD_DONE_MASK)
+			return 0;
+
+		udelay(50);
+	} while (time_cnt++ < I2C_WAIT_TIMEOUT);
+
+	dev_err(i2c->dev, "wait idle timeout, RIS: 0x%x, SR: 0x%x\n",
+			val, readl(i2c->base + HIBVT_I2C_STAT));
+
+	return -EIO;
+}
+
+static void hibvt_i2c_set_freq(struct hibvt_i2c_dev *i2c)
+{
+	unsigned int max_freq, freq;
+	unsigned int clk_rate;
+	unsigned int val, sda_hold;
+
+	freq = i2c->freq;
+	clk_rate = clk_get_rate(i2c->clk);
+	max_freq = clk_rate >> 1;
+
+	if (freq > max_freq) {
+		i2c->freq = max_freq;
+		freq = i2c->freq;
+	}
+
+	if (freq <= 100000) {
+		val = clk_rate / (freq * 2) - 1;
+		writel(val, i2c->base + HIBVT_I2C_SCL_H);
+		writel(val, i2c->base + HIBVT_I2C_SCL_L);
+	} else {
+		val = (clk_rate * 36) / (freq * 100);
+		writel(val, i2c->base + HIBVT_I2C_SCL_H);
+		val = (clk_rate * 64) / (freq * 100);
+		writel(val, i2c->base + HIBVT_I2C_SCL_L);
+	}
+
+	sda_hold = val * 3 / 10;
+	sda_hold = (sda_hold << GLB_SDA_HOLD_SHIFT) & GLB_SDA_HOLD_MASK;
+	val = readl(i2c->base + HIBVT_I2C_GLB);
+	val &= ~GLB_SDA_HOLD_MASK;
+	val |= sda_hold;
+	writel(val, i2c->base + HIBVT_I2C_GLB);
+}
+
+/*
+ * set i2c controller TX and RX FIFO water
+ */
+static inline void hibvt_i2c_set_water(struct hibvt_i2c_dev *i2c)
+{
+	writel(I2C_TXF_WATER, i2c->base + HIBVT_I2C_TX_WATER);
+	writel(I2C_RXF_WATER, i2c->base + HIBVT_I2C_RX_WATER);
+}
+
+/*
+ * initialise the controller, set i2c bus interface freq
+ */
+static void hibvt_i2c_hw_init(struct hibvt_i2c_dev *i2c)
+{
+	hibvt_i2c_disable(i2c);
+	hibvt_i2c_disable_irq(i2c, INTR_ALL_MASK);
+	hibvt_i2c_set_freq(i2c);
+	hibvt_i2c_set_water(i2c);
+}
+
+/*
+ * hibvt_i2c_cfg_cmd - config i2c controller command sequence
+ *
+ * After all the timing command is configured,
+ * and then start the command, you can i2c communication,
+ * and then only need to read and write i2c fifo.
+ */
+static void hibvt_i2c_cfg_cmd(struct hibvt_i2c_dev *i2c)
+{
+	struct i2c_msg *msg = i2c->msg;
+	int offset = 0;
+
+	if (i2c->msg_idx == 0)
+		hibvt_i2c_cmdreg_set(i2c, CMD_TX_S, &offset);
+	else
+		hibvt_i2c_cmdreg_set(i2c, CMD_TX_RS, &offset);
+
+	if (msg->flags & I2C_M_TEN) {
+		if (i2c->msg_idx == 0) {
+			hibvt_i2c_cmdreg_set(i2c, CMD_TX_D1_2, &offset);
+			hibvt_i2c_cmdreg_set(i2c, CMD_TX_D1_1, &offset);
+		} else {
+			hibvt_i2c_cmdreg_set(i2c, CMD_TX_D1_2, &offset);
+		}
+	} else {
+		hibvt_i2c_cmdreg_set(i2c, CMD_TX_D1_1, &offset);
+	}
+
+	if (msg->flags & I2C_M_IGNORE_NAK)
+		hibvt_i2c_cmdreg_set(i2c, CMD_IGN_ACK, &offset);
+	else
+		hibvt_i2c_cmdreg_set(i2c, CMD_RX_ACK, &offset);
+
+	if (msg->flags & I2C_M_RD) {
+		if (msg->len >= 2) {
+			writel(offset, i2c->base + HIBVT_I2C_DST1);
+			writel(msg->len - 2, i2c->base + HIBVT_I2C_LOOP1);
+			hibvt_i2c_cmdreg_set(i2c, CMD_RX_FIFO, &offset);
+			hibvt_i2c_cmdreg_set(i2c, CMD_TX_ACK, &offset);
+			hibvt_i2c_cmdreg_set(i2c, CMD_JMP1, &offset);
+		}
+		hibvt_i2c_cmdreg_set(i2c, CMD_RX_FIFO, &offset);
+		hibvt_i2c_cmdreg_set(i2c, CMD_TX_NACK, &offset);
+	} else {
+		writel(offset, i2c->base + HIBVT_I2C_DST1);
+		writel(msg->len - 1, i2c->base + HIBVT_I2C_LOOP1);
+		hibvt_i2c_cmdreg_set(i2c, CMD_UP_TXF, &offset);
+		hibvt_i2c_cmdreg_set(i2c, CMD_TX_FIFO, &offset);
+
+		if (msg->flags & I2C_M_IGNORE_NAK)
+			hibvt_i2c_cmdreg_set(i2c, CMD_IGN_ACK, &offset);
+		else
+			hibvt_i2c_cmdreg_set(i2c, CMD_RX_ACK, &offset);
+
+		hibvt_i2c_cmdreg_set(i2c, CMD_JMP1, &offset);
+	}
+
+	if ((i2c->msg_idx == (i2c->msg_num - 1)) || (msg->flags & I2C_M_STOP)) {
+		dev_dbg(i2c->dev, "run to %s %d...TX STOP\n",
+				__func__, __LINE__);
+		hibvt_i2c_cmdreg_set(i2c, CMD_TX_P, &offset);
+	}
+
+	hibvt_i2c_cmdreg_set(i2c, CMD_EXIT, &offset);
+}
+
+static int hibvt_i2c_polling_xfer_one_msg(struct hibvt_i2c_dev *i2c)
+{
+	int status;
+	unsigned int val;
+	struct i2c_msg *msg = i2c->msg;
+
+	dev_dbg(i2c->dev, "[%s,%d]msg->flags=0x%x, len=0x%x\n",
+			__func__, __LINE__, msg->flags, msg->len);
+
+	hibvt_i2c_enable(i2c);
+	hibvt_i2c_clr_irq(i2c);
+	hibvt_i2c_set_addr(i2c);
+	hibvt_i2c_cfg_cmd(i2c);
+	hibvt_i2c_start_cmd(i2c);
+
+	i2c->msg_buf_ptr = 0;
+
+	if (msg->flags & I2C_M_RD) {
+		while (i2c->msg_buf_ptr < msg->len) {
+			status = hibvt_i2c_wait_rx_noempty(i2c);
+			if (status)
+				goto end;
+
+			val = readl(i2c->base + HIBVT_I2C_RXF);
+			msg->buf[i2c->msg_buf_ptr] = val;
+			i2c->msg_buf_ptr++;
+
+		}
+	} else {
+		while (i2c->msg_buf_ptr < msg->len) {
+			status = hibvt_i2c_wait_tx_nofull(i2c);
+			if (status)
+				goto end;
+
+			val = msg->buf[i2c->msg_buf_ptr];
+			writel(val, i2c->base + HIBVT_I2C_TXF);
+			i2c->msg_buf_ptr++;
+		}
+	}
+
+	status = hibvt_i2c_wait_idle(i2c);
+end:
+	hibvt_i2c_disable(i2c);
+
+	return status;
+}
+
+static irqreturn_t hibvt_i2c_isr(int irq, void *dev_id)
+{
+	struct hibvt_i2c_dev *i2c = dev_id;
+	unsigned int irq_status;
+	struct i2c_msg *msg = i2c->msg;
+
+	spin_lock(&i2c->lock);
+
+	irq_status = hibvt_i2c_clr_irq(i2c);
+	dev_dbg(i2c->dev, "%s RIS:  0x%x\n", __func__, irq_status);
+
+	if (!irq_status) {
+		dev_dbg(i2c->dev, "no irq\n");
+		goto end;
+	}
+
+	if (irq_status & INTR_ABORT_MASK) {
+		dev_err(i2c->dev, "irq handle abort, RIS: 0x%x\n",
+				irq_status);
+		i2c->status = -EIO;
+		hibvt_i2c_disable_irq(i2c, INTR_ALL_MASK);
+
+		complete(&i2c->msg_complete);
+		goto end;
+	}
+
+	if (msg->flags & I2C_M_RD) {
+		while ((readl(i2c->base + HIBVT_I2C_STAT) & STAT_RXF_NOE_MASK)
+				&& (i2c->msg_buf_ptr < msg->len)) {
+			msg->buf[i2c->msg_buf_ptr] =
+				readl(i2c->base + HIBVT_I2C_RXF);
+			i2c->msg_buf_ptr++;
+		}
+	} else {
+		while ((readl(i2c->base + HIBVT_I2C_STAT) & STAT_TXF_NOF_MASK)
+				&& (i2c->msg_buf_ptr < msg->len)) {
+			writel(msg->buf[i2c->msg_buf_ptr],
+					i2c->base + HIBVT_I2C_TXF);
+			i2c->msg_buf_ptr++;
+		}
+	}
+
+	if (i2c->msg_buf_ptr >= msg->len)
+		hibvt_i2c_disable_irq(i2c, INTR_TX_MASK | INTR_RX_MASK);
+
+	if (irq_status & INTR_CMD_DONE_MASK) {
+		dev_dbg(i2c->dev, "cmd done\n");
+		i2c->status =  0;
+		hibvt_i2c_disable_irq(i2c, INTR_ALL_MASK);
+
+		complete(&i2c->msg_complete);
+	}
+
+end:
+	spin_unlock(&i2c->lock);
+
+	return IRQ_HANDLED;
+}
+
+static int hibvt_i2c_interrupt_xfer_one_msg(struct hibvt_i2c_dev *i2c)
+{
+	int status;
+	struct i2c_msg *msg = i2c->msg;
+	unsigned long timeout;
+	unsigned long flags;
+
+	dev_dbg(i2c->dev, "[%s,%d]msg->flags=0x%x, len=0x%x\n",
+			__func__, __LINE__, msg->flags, msg->len);
+
+	reinit_completion(&i2c->msg_complete);
+	i2c->msg_buf_ptr = 0;
+	i2c->status = -EIO;
+
+	spin_lock_irqsave(&i2c->lock, flags);
+	hibvt_i2c_enable(i2c);
+	hibvt_i2c_clr_irq(i2c);
+	if (msg->flags & I2C_M_RD)
+		hibvt_i2c_cfg_irq(i2c, INTR_USE_MASK & ~INTR_TX_MASK);
+	else
+		hibvt_i2c_cfg_irq(i2c, INTR_USE_MASK & ~INTR_RX_MASK);
+
+	hibvt_i2c_set_addr(i2c);
+	hibvt_i2c_cfg_cmd(i2c);
+	hibvt_i2c_start_cmd(i2c);
+	spin_unlock_irqrestore(&i2c->lock, flags);
+
+	timeout = wait_for_completion_timeout(&i2c->msg_complete,
+			I2C_IRQ_TIMEOUT);
+
+	if (timeout == 0) {
+		hibvt_i2c_disable_irq(i2c, INTR_ALL_MASK);
+		status = -EIO;
+		dev_err(i2c->dev, "%s timeout\n",
+			 msg->flags & I2C_M_RD ? "rx" : "tx");
+	} else {
+		status = i2c->status;
+	}
+
+	hibvt_i2c_disable(i2c);
+
+	return status;
+}
+
+/*
+ * Master transfer function
+ */
+static int hibvt_i2c_xfer(struct i2c_adapter *adap,
+			struct i2c_msg *msgs, int num)
+{
+	struct hibvt_i2c_dev *i2c = i2c_get_adapdata(adap);
+	int status;
+
+	if (!msgs) {
+		dev_err(i2c->dev, "msgs == NULL\n");
+		return -EIO;
+	}
+
+	i2c->msg = msgs;
+	i2c->msg_num = num;
+	i2c->msg_idx = 0;
+
+	if (i2c->irq >= 0) {
+		while (i2c->msg_idx < i2c->msg_num) {
+			status = hibvt_i2c_interrupt_xfer_one_msg(i2c);
+			if (status)
+				break;
+
+			i2c->msg++;
+			i2c->msg_idx++;
+		}
+	} else {
+		while (i2c->msg_idx < i2c->msg_num) {
+			status = hibvt_i2c_polling_xfer_one_msg(i2c);
+			if (status)
+				break;
+
+			i2c->msg++;
+			i2c->msg_idx++;
+		}
+	}
+
+	if (!status || i2c->msg_idx > 0)
+		status = i2c->msg_idx;
+
+	return status;
+}
+
+static u32 hibvt_i2c_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR
+		| I2C_FUNC_PROTOCOL_MANGLING;
+}
+
+static const struct i2c_algorithm hibvt_i2c_algo = {
+	.master_xfer		= hibvt_i2c_xfer,
+	.functionality		= hibvt_i2c_func,
+};
+
+static int hibvt_i2c_probe(struct platform_device *pdev)
+{
+	int status;
+	struct hibvt_i2c_dev *i2c;
+	struct i2c_adapter *adap;
+	struct resource *res;
+
+	i2c = devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
+	if (!i2c)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, i2c);
+	i2c->dev = &pdev->dev;
+	spin_lock_init(&i2c->lock);
+	init_completion(&i2c->msg_complete);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	i2c->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(i2c->base)) {
+		dev_err(i2c->dev, "cannot ioremap resource\n");
+		return -ENOMEM;
+	}
+
+	i2c->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(i2c->clk)) {
+		dev_err(i2c->dev, "cannot get clock\n");
+		return -ENOENT;
+	}
+	clk_prepare_enable(i2c->clk);
+
+	if (of_property_read_u32(pdev->dev.of_node, "clock-frequency",
+				&i2c->freq)) {
+		dev_warn(i2c->dev, "setting default clock-frequency@%dHz\n",
+				I2C_DEFAULT_FREQUENCY);
+		i2c->freq = I2C_DEFAULT_FREQUENCY;
+	}
+
+	/* i2c controller initialization, disable interrupt */
+	hibvt_i2c_hw_init(i2c);
+
+	i2c->irq = platform_get_irq(pdev, 0);
+	status = devm_request_irq(&pdev->dev, i2c->irq, hibvt_i2c_isr,
+			IRQF_SHARED, dev_name(&pdev->dev), i2c);
+	if (status) {
+		dev_dbg(i2c->dev, "falling back to polling mode");
+		i2c->irq = -1;
+	}
+
+	adap = &i2c->adap;
+	i2c_set_adapdata(adap, i2c);
+	adap->owner = THIS_MODULE;
+	strlcpy(adap->name, "hibvt-i2c", sizeof(adap->name));
+	adap->dev.parent = &pdev->dev;
+	adap->dev.of_node = pdev->dev.of_node;
+	adap->algo = &hibvt_i2c_algo;
+
+	/* Add the i2c adapter */
+	status = i2c_add_adapter(adap);
+	if (status) {
+		dev_err(i2c->dev, "failed to add bus to i2c core\n");
+		goto err_add_adapter;
+	}
+
+	dev_info(i2c->dev, "%s%d@%dhz registered\n",
+			adap->name, adap->nr, i2c->freq);
+
+	return 0;
+
+err_add_adapter:
+	clk_disable_unprepare(i2c->clk);
+	return status;
+}
+
+static int hibvt_i2c_remove(struct platform_device *pdev)
+{
+	struct hibvt_i2c_dev *i2c = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(i2c->clk);
+	i2c_del_adapter(&i2c->adap);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int hibvt_i2c_suspend(struct device *dev)
+{
+	struct hibvt_i2c_dev *i2c = dev_get_drvdata(dev);
+
+	i2c_lock_adapter(&i2c->adap);
+	clk_disable_unprepare(i2c->clk);
+	i2c_unlock_adapter(&i2c->adap);
+
+	return 0;
+}
+
+static int hibvt_i2c_resume(struct device *dev)
+{
+	struct hibvt_i2c_dev *i2c = dev_get_drvdata(dev);
+
+	i2c_lock_adapter(&i2c->adap);
+	clk_prepare_enable(i2c->clk);
+	hibvt_i2c_hw_init(i2c);
+	i2c_unlock_adapter(&i2c->adap);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(hibvt_i2c_dev_pm, hibvt_i2c_suspend,
+		hibvt_i2c_resume);
+
+static const struct of_device_id hibvt_i2c_match[] = {
+	{ .compatible = "hisilicon,hibvt-i2c"},
+	{ .compatible = "hisilicon,hi3516cv300-i2c"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, hibvt_i2c_match);
+
+static struct platform_driver hibvt_i2c_driver = {
+	.driver		= {
+		.name	= "hibvt-i2c",
+		.of_match_table = hibvt_i2c_match,
+		.pm	= &hibvt_i2c_dev_pm,
+	},
+	.probe		= hibvt_i2c_probe,
+	.remove		= hibvt_i2c_remove,
+};
+
+module_platform_driver(hibvt_i2c_driver);
+
+MODULE_AUTHOR("Pan Wen, <wenpan@hisilicon.com>");
+MODULE_DESCRIPTION("HISILICON BVT I2C Bus driver");
+MODULE_LICENSE("GPL v2");
-- 
2.9.3
