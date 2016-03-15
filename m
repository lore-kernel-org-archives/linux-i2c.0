From: Gao Pan <pandy.gao@nxp.com>
Subject: [Patch v1] i2c: imx7ulp: add i.MX7ULP i2c controller bus driver
Date: Tue, 15 Mar 2016 17:51:22 +0800
Message-ID: <1458035482-14905-1-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-am1on0094.outbound.protection.outlook.com ([157.56.112.94]:58464
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753783AbcCOLYu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 15 Mar 2016 07:24:50 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, u.kleine-koenig@pengutronix.de
Cc: linux-i2c@vger.kernel.org, frank.li@nxp.com, fugang.duan@nxp.com, pandy.gao@nxp.com

Add i.MX7ULP i2c bus driver which can continue operating
in stop modes provided an appropriate clock is available.

It is also designed for low CPU overhead with DMA offloading
of FIFO register accesses.

Signed-off-by: Gao Pan <pandy.gao@nxp.com>
---
 drivers/i2c/busses/Kconfig       |  10 +
 drivers/i2c/busses/Makefile      |   1 +
 drivers/i2c/busses/i2c-imx7ulp.c | 810 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 821 insertions(+)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 0299dfa..9d3fee0 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -594,6 +594,16 @@ config I2C_IMX
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-imx.
 
+config I2C_IMX7ULP
+	tristate "IMX7ULP I2C interface"
+	depends on ARCH_MXC
+	help
+	  Say Y here if you want to use the IIC bus controller on
+	  the Freescale i.MX7ULP processors.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-imx7ulp.
+
 config I2C_IOP3XX
 	tristate "Intel IOPx3xx and IXP4xx on-chip I2C interface"
 	depends on ARCH_IOP32X || ARCH_IOP33X || ARCH_IXP4XX || ARCH_IOP13XX
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 37f2819..ef8607b 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_I2C_HIX5HD2)	+= i2c-hix5hd2.o
 obj-$(CONFIG_I2C_IBM_IIC)	+= i2c-ibm_iic.o
 obj-$(CONFIG_I2C_IMG)		+= i2c-img-scb.o
 obj-$(CONFIG_I2C_IMX)		+= i2c-imx.o
+obj-$(CONFIG_I2C_IMX7ULP)	+= i2c-imx7ulp.o
 obj-$(CONFIG_I2C_IOP3XX)	+= i2c-iop3xx.o
 obj-$(CONFIG_I2C_JZ4780)	+= i2c-jz4780.o
 obj-$(CONFIG_I2C_KEMPLD)	+= i2c-kempld.o
diff --git a/drivers/i2c/busses/i2c-imx7ulp.c b/drivers/i2c/busses/i2c-imx7ulp.c
new file mode 100644
index 0000000..bf4b1e8
--- /dev/null
+++ b/drivers/i2c/busses/i2c-imx7ulp.c
@@ -0,0 +1,810 @@
+/*
+ * This is i.MX7ULP low power i2c controller driver.
+ *
+ * Copyright 2016 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_data/i2c-imx.h>
+#include <linux/platform_device.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+
+/* This will be the driver name the kernel reports */
+#define DRIVER_NAME "imx7ulp-i2c"
+
+/* IMX I2C registers */
+#define	IMX7ULP_I2C_PARAM	0x04	/* i2c RX/TX FIFO size */
+#define	IMX7ULP_I2C_MCR		0x10	/* i2c contrl register */
+#define	IMX7ULP_I2C_MSR		0x14	/* i2c status register */
+#define	IMX7ULP_I2C_MIER	0x18	/* i2c interrupt enable */
+#define	IMX7ULP_I2C_MCFGR0	0x20	/* i2c master configuration */
+#define	IMX7ULP_I2C_MCFGR1	0x24	/* i2c master configuration */
+#define	IMX7ULP_I2C_MCFGR2	0x28	/* i2c master configuration */
+#define	IMX7ULP_I2C_MCFGR3	0x2C	/* i2c master configuration */
+#define	IMX7ULP_I2C_MCCR0	0x48	/* i2c master clk configuration */
+#define	IMX7ULP_I2C_MCCR1	0x50	/* i2c master clk configuration */
+#define	IMX7ULP_I2C_MFCR	0x58	/* i2c master FIFO control */
+#define	IMX7ULP_I2C_MFSR	0x5C	/* i2c master FIFO status */
+#define	IMX7ULP_I2C_MTDR	0x60	/* i2c master TX data register */
+#define	IMX7ULP_I2C_MRDR	0x70	/* i2c master RX data register */
+
+
+/* i2c command data */
+#define	TRAN_DATA	0X00
+#define	RECV_DATA	0X01
+#define	GEN_STOP	0X02
+#define	RECV_DISCARD	0X03
+#define	GEN_START	0X04
+#define	START_NACK	0X05
+#define	START_HIGH	0X06
+#define	START_HIGH_NACK	0X07
+
+
+/* Bits of I2C controller registers */
+#define	MCR_MEN		0X001
+#define	MCR_RST		0X002
+#define	MCR_DOZEN	0X004
+#define	MCR_DBGEN	0X008
+#define	MCR_RTF		0X100
+#define	MCR_RRF		0X200
+
+/* Bits of I2C status registers */
+#define	MSR_TDF		(1 << 0)
+#define	MSR_RDF		(1 << 1)
+#define	MSR_NDF		(1 << 10)
+#define	MSR_ALF		(1 << 11)
+#define	MSR_MBF		(1 << 24)
+#define	MSR_BBF		(1 << 25)
+
+/* Bits of I2C interrupt enable registers */
+#define	MIER_TDIE	0X0001
+#define	MIER_RDIE	0X0002
+#define	MIER_NDIE	0X0400
+
+/* Bits of I2C MCFGR1 registers */
+#define	MCFGR1_IGNACK	0X0200
+
+#define	FILTSDA_SHIFT	24
+#define	FILTSCL_SHIFT	16
+#define	DATAVD_SHIFT	24
+#define	SETHOLD_SHIFT	16
+#define	CLKHI_SHIFT	8
+
+#define	I2C_CLK_RATIO	2
+#define	CHUNK_DATA	256
+
+#define	LPI2C_DEFAULT_RATE	100000
+#define	STARDARD_MAX_BITRATE	400000
+#define	FAST_MAX_BITRATE	1000000
+#define	FAST_PLUS_MAX_BITRATE	3400000
+#define	HIGHSPEED_MAX_BITRATE	5000000
+
+
+enum imx7ulp_i2c_mode {
+	STANDARD,	/* 100+Kbps */
+	FAST,		/* 400+Kbps */
+	FAST_PLUS,	/* 1.0+Mbps */
+	ULTRA_FAST,	/* 5.0+Mbps */
+	HS,		/* 3.4+Mbps */
+};
+
+enum imx7ulp_i2c_pincfg {
+	TWO_PIN_OD,	/* 2-pin open drain mode */
+	TWO_PIN_OO,	/* 2-pin output only mode (utra-fast mode) */
+	TWO_PIN_PP,	/* 2-pin push-pull mode */
+	FOUR_PIN_PP,	/* 4-pin push-pull mode */
+	TWO_PIN_OD_SS,	/* 2-pin open drain mode with separate slave */
+	TWO_PIN_OO_SS,	/* 2-pin output only mode with separate slave */
+	TWO_PIN_PP_SS,	/* 2-pin push-pull mode with separate slave */
+	FOUR_PIN_PP_IO,	/* 4-pin push-pull mode (inverted output) */
+};
+
+struct imx7ulp_i2c_modecfg {
+	u8	prescale;
+	u8	filtscl;
+	u8	filtsda;
+	u8	sethold;
+	u8	clklo;
+	u8	clkhi;
+	u8	datavd;
+};
+
+struct imx7ulp_i2c_struct {
+	struct i2c_adapter	adapter;
+	struct clk		*bus_clk;
+	struct clk		*per_clk;
+	void __iomem		*base;
+	wait_queue_head_t	queue;
+	unsigned long		msr;
+	__u8			*rx_buf;
+	__u8			*tx_buf;
+	unsigned int		rx_water;
+	unsigned int		tx_water;
+	unsigned int		msg_len;
+	unsigned int		rx_len;
+	unsigned int		tx_len;
+	unsigned int		msg_done;
+	unsigned int		block_data;
+	unsigned int		rxfifo_size;
+	unsigned int		txfifo_size;
+	unsigned int		bitrate;
+	enum imx7ulp_i2c_mode	mode;
+};
+
+static inline void imx7ulp_i2c_write_reg(unsigned int val,
+		struct imx7ulp_i2c_struct *i2c_imx7ulp, unsigned int reg)
+{
+	writel(val, i2c_imx7ulp->base + reg);
+}
+
+static inline unsigned int imx7ulp_i2c_read_reg(
+		struct imx7ulp_i2c_struct *i2c_imx7ulp, unsigned int reg)
+{
+	return readl(i2c_imx7ulp->base + reg);
+}
+
+static int i2c_imx7ulp_bus_busy(
+		struct imx7ulp_i2c_struct *i2c_imx7ulp, int for_busy)
+{
+	unsigned long orig_jiffies = jiffies;
+	unsigned int temp;
+
+	dev_dbg(&i2c_imx7ulp->adapter.dev, "<%s>\n", __func__);
+
+	while (1) {
+		temp = imx7ulp_i2c_read_reg(i2c_imx7ulp, IMX7ULP_I2C_MSR);
+
+		/* check for arbitration lost, clear if set */
+		if (temp & MSR_ALF) {
+			imx7ulp_i2c_write_reg(temp, i2c_imx7ulp, IMX7ULP_I2C_MSR);
+			return -EAGAIN;
+		}
+
+		if (for_busy && (temp & MSR_BBF))
+			break;
+		if (!for_busy && !(temp & MSR_BBF))
+			break;
+		if (time_after(jiffies, orig_jiffies + msecs_to_jiffies(500))) {
+			dev_dbg(&i2c_imx7ulp->adapter.dev,
+				"<%s> I2C bus is busy\n", __func__);
+			return -ETIMEDOUT;
+		}
+		schedule();
+	}
+
+	return 0;
+}
+
+static void i2c_imx7ulp_set_mode(struct imx7ulp_i2c_struct *i2c_imx7ulp)
+{
+	enum imx7ulp_i2c_mode mode;
+	unsigned int bitrate = i2c_imx7ulp->bitrate;
+
+	if (bitrate < STARDARD_MAX_BITRATE)
+		mode = STANDARD;
+	else if (bitrate < FAST_MAX_BITRATE)
+		mode = FAST;
+	else if (bitrate < FAST_PLUS_MAX_BITRATE)
+		mode = FAST_PLUS;
+	else if (bitrate < HIGHSPEED_MAX_BITRATE)
+		mode = HS;
+	else
+		mode = ULTRA_FAST;
+
+	i2c_imx7ulp->mode = mode;
+
+	dev_dbg(&i2c_imx7ulp->adapter.dev, "I2C MODE = %d\n", mode);
+}
+
+/* CLKLO = I2C_CLK_RATIO * CLKHI, SETHOLD = CLKHI, DATAVD = CLKHI/2 */
+static void i2c_imx7ulp_set_bitrate(struct imx7ulp_i2c_struct *i2c_imx7ulp)
+{
+	unsigned int per_clk_rate;
+	unsigned int clk_high, clk_low, clk_cycle;
+	unsigned int temp;
+	struct imx7ulp_i2c_modecfg modecfg;
+
+	per_clk_rate = clk_get_rate(i2c_imx7ulp->per_clk);
+
+	/* filtsda/filtscl = 0 in high speed mode */
+	if (i2c_imx7ulp->mode == HS || i2c_imx7ulp->mode == ULTRA_FAST)
+		modecfg.filtscl = modecfg.filtsda = 0;
+	else
+		modecfg.filtscl = modecfg.filtsda = 2;
+
+	clk_cycle = per_clk_rate / (2 * i2c_imx7ulp->bitrate) - 3
+		     - (modecfg.filtscl >> 1);
+	clk_high = (clk_cycle + I2C_CLK_RATIO) / (I2C_CLK_RATIO + 1);
+	clk_low = clk_cycle - clk_high;
+
+	modecfg.prescale = 1;
+	modecfg.sethold = clk_high;
+	modecfg.clklo = clk_low;
+	modecfg.clkhi = clk_high;
+	modecfg.datavd = clk_high >> 1;
+
+	temp = modecfg.prescale;
+	imx7ulp_i2c_write_reg(temp, i2c_imx7ulp, IMX7ULP_I2C_MCFGR1);
+
+	temp = modecfg.filtscl << FILTSCL_SHIFT |
+				modecfg.filtsda << FILTSDA_SHIFT;
+	imx7ulp_i2c_write_reg(temp, i2c_imx7ulp, IMX7ULP_I2C_MCFGR2);
+
+	temp = modecfg.datavd << DATAVD_SHIFT |
+				modecfg.sethold << SETHOLD_SHIFT;
+	temp |= modecfg.clkhi << CLKHI_SHIFT | modecfg.clklo;
+
+	/* IMX7ULP_I2C_MCCR1 used for HS mode */
+	if (i2c_imx7ulp->mode == HS)
+		imx7ulp_i2c_write_reg(temp, i2c_imx7ulp, IMX7ULP_I2C_MCCR1);
+	else
+		imx7ulp_i2c_write_reg(temp, i2c_imx7ulp, IMX7ULP_I2C_MCCR0);
+}
+
+static void i2c_imx7ulp_set_pincfg(struct imx7ulp_i2c_struct *i2c_imx7ulp)
+{
+	unsigned int temp = 0;
+	enum imx7ulp_i2c_pincfg pincfg;
+	enum imx7ulp_i2c_mode mode = i2c_imx7ulp->mode;
+
+	if (mode == ULTRA_FAST)
+		pincfg = TWO_PIN_OO;
+	else
+		pincfg = TWO_PIN_OD;
+
+	temp = imx7ulp_i2c_read_reg(i2c_imx7ulp, IMX7ULP_I2C_MCFGR1);
+	temp |= pincfg << 24;
+	imx7ulp_i2c_write_reg(temp, i2c_imx7ulp, IMX7ULP_I2C_MCFGR1);
+}
+
+static int i2c_imx7ulp_tx_addr(struct imx7ulp_i2c_struct *i2c_imx7ulp,
+						struct i2c_msg *msgs, u8 read)
+{
+	unsigned int temp;
+
+	/* 10 bit addressing(B1:11110A9A8R/W, B0:A7-A0)*/
+	if (msgs->flags & I2C_M_TEN) {
+		temp = (msgs->addr & 0x300) >> 7;
+		temp |= read | (GEN_START << 8);
+		imx7ulp_i2c_write_reg(temp, i2c_imx7ulp, IMX7ULP_I2C_MTDR);
+
+		temp = msgs->addr & 0xff;
+		imx7ulp_i2c_write_reg(temp, i2c_imx7ulp, IMX7ULP_I2C_MTDR);
+	} else {
+		temp = (msgs->addr << 1 | read) | (GEN_START << 8);
+		imx7ulp_i2c_write_reg(temp, i2c_imx7ulp, IMX7ULP_I2C_MTDR);
+	}
+
+	return i2c_imx7ulp_bus_busy(i2c_imx7ulp, 1);
+}
+
+static int i2c_imx7ulp_start(struct imx7ulp_i2c_struct *i2c_imx7ulp)
+{
+	int ret;
+	unsigned int temp;
+
+	dev_dbg(&i2c_imx7ulp->adapter.dev, "<%s>\n", __func__);
+
+	ret = clk_prepare_enable(i2c_imx7ulp->bus_clk);
+	if (ret) {
+		dev_err(&i2c_imx7ulp->adapter.dev,
+			"can't enable I2C bus clock, ret=%d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(i2c_imx7ulp->per_clk);
+	if (ret) {
+		dev_err(&i2c_imx7ulp->adapter.dev,
+			"can't enable I2C peripheral clock, ret=%d\n", ret);
+		return ret;
+	}
+
+	/* mater logic register reset */
+	temp = imx7ulp_i2c_read_reg(i2c_imx7ulp, IMX7ULP_I2C_MCR);
+	temp |= MCR_RST;
+	imx7ulp_i2c_write_reg(temp, i2c_imx7ulp, IMX7ULP_I2C_MCR);
+
+	if (i2c_imx7ulp->mode == ULTRA_FAST) {
+		temp = imx7ulp_i2c_read_reg(i2c_imx7ulp, IMX7ULP_I2C_MCFGR1);
+		temp |= MCFGR1_IGNACK;
+		imx7ulp_i2c_write_reg(temp, i2c_imx7ulp, IMX7ULP_I2C_MCFGR1);
+	}
+
+	/* enable master, clear TX/RX FIFO */
+	temp = imx7ulp_i2c_read_reg(i2c_imx7ulp, IMX7ULP_I2C_MCR);
+	temp |= MCR_MEN | MCR_RRF | MCR_RTF;
+	imx7ulp_i2c_write_reg(temp, i2c_imx7ulp, IMX7ULP_I2C_MCR);
+
+	return 0;
+}
+
+static void i2c_imx7ulp_stop(struct imx7ulp_i2c_struct *i2c_imx7ulp)
+{
+	unsigned int temp = 0;
+
+	dev_dbg(&i2c_imx7ulp->adapter.dev, "<%s>\n", __func__);
+
+	/* generate stop */
+	temp = GEN_STOP << 8;
+	imx7ulp_i2c_write_reg(temp, i2c_imx7ulp, IMX7ULP_I2C_MTDR);
+
+	/* disable master */
+	temp = imx7ulp_i2c_read_reg(i2c_imx7ulp, IMX7ULP_I2C_MCR);
+	temp &= ~MCR_MEN;
+	imx7ulp_i2c_write_reg(temp, i2c_imx7ulp, IMX7ULP_I2C_MCR);
+
+	i2c_imx7ulp_bus_busy(i2c_imx7ulp, 0);
+
+	clk_disable_unprepare(i2c_imx7ulp->bus_clk);
+	clk_disable_unprepare(i2c_imx7ulp->per_clk);
+}
+
+static int i2c_imx7ulp_msg_complete(struct imx7ulp_i2c_struct *i2c_imx7ulp)
+{
+	wait_event_timeout(i2c_imx7ulp->queue,
+		i2c_imx7ulp->msg_done || (i2c_imx7ulp->msr & MSR_NDF), HZ);
+
+	if (unlikely(i2c_imx7ulp->msr & MSR_NDF)) {
+		dev_dbg(&i2c_imx7ulp->adapter.dev,
+				"<%s> NACK Detected\n", __func__);
+		return -EIO;
+	} else if (unlikely(!i2c_imx7ulp->msg_done)) {
+		dev_dbg(&i2c_imx7ulp->adapter.dev, "<%s> Timeout\n", __func__);
+		return -ETIMEDOUT;
+	}
+
+	dev_dbg(&i2c_imx7ulp->adapter.dev, "<%s> msg complete\n", __func__);
+
+	i2c_imx7ulp->msr = 0;
+	return 0;
+}
+
+static void i2c_imx7ulp_read_rxfifo(struct imx7ulp_i2c_struct *i2c_imx7ulp)
+{
+	unsigned int i, temp;
+	unsigned int block_len, rcvlen, left;
+	unsigned int data;
+
+	rcvlen = i2c_imx7ulp->rx_len;
+
+	/* disable receive data interrupt */
+	temp = imx7ulp_i2c_read_reg(i2c_imx7ulp, IMX7ULP_I2C_MIER);
+	temp &= ~MIER_RDIE;
+	imx7ulp_i2c_write_reg(temp, i2c_imx7ulp, IMX7ULP_I2C_MIER);
+
+	for (i = 0; i < i2c_imx7ulp->rx_water; i++) {
+		data = imx7ulp_i2c_read_reg(i2c_imx7ulp, IMX7ULP_I2C_MRDR);
+		i2c_imx7ulp->rx_buf[i + rcvlen] = data & 0xff;
+	}
+
+	/* enable receive data interrupt */
+	temp = imx7ulp_i2c_read_reg(i2c_imx7ulp, IMX7ULP_I2C_MIER);
+	temp |= MIER_RDIE;
+	imx7ulp_i2c_write_reg(temp, i2c_imx7ulp, IMX7ULP_I2C_MIER);
+
+	i2c_imx7ulp->rx_len += i2c_imx7ulp->rx_water;
+
+	/*
+	 * First byte is the length of remaining packet in the SMBus block
+	 * data read. Add it to msgs->len.
+	 */
+	if (i2c_imx7ulp->block_data) {
+		block_len = i2c_imx7ulp->rx_buf[0];
+		if ((block_len == 0) || (block_len > I2C_SMBUS_BLOCK_MAX)) {
+			wake_up(&i2c_imx7ulp->queue);
+			return;
+		}
+		i2c_imx7ulp->msg_len += block_len;
+		i2c_imx7ulp->block_data = 0;
+	}
+
+	if (i2c_imx7ulp->rx_len < i2c_imx7ulp->msg_len) {
+		left = i2c_imx7ulp->msg_len - i2c_imx7ulp->rx_len;
+		if (left <= i2c_imx7ulp->rxfifo_size)
+			i2c_imx7ulp->rx_water = left;
+		else
+			i2c_imx7ulp->rx_water = i2c_imx7ulp->rxfifo_size >> 1;
+
+		temp = i2c_imx7ulp->rx_water << 16;
+		imx7ulp_i2c_write_reg(temp, i2c_imx7ulp, IMX7ULP_I2C_MFCR);
+
+		/* msg_len > 256, multiple receive commands */
+		if (!(i2c_imx7ulp->rx_len && 0xff)) {
+			/* receive data[7:0]+1 bytes */
+			temp = left > CHUNK_DATA ? CHUNK_DATA - 1 : (left - 1);
+			temp |= (RECV_DATA << 8);
+			imx7ulp_i2c_write_reg(temp, i2c_imx7ulp, IMX7ULP_I2C_MTDR);
+		}
+	} else {
+		i2c_imx7ulp->msg_done = 1;
+		wake_up(&i2c_imx7ulp->queue);
+	}
+}
+
+static void i2c_imx7ulp_write_txfifo(struct imx7ulp_i2c_struct *i2c_imx7ulp)
+{
+	unsigned int i;
+	unsigned int txlen, left, loadnum;
+	unsigned int data;
+
+	txlen = i2c_imx7ulp->tx_len;
+	if (txlen < i2c_imx7ulp->msg_len) {
+		left = i2c_imx7ulp->msg_len - txlen;
+		if (left <= i2c_imx7ulp->txfifo_size)
+			loadnum = left;
+		else
+			loadnum = i2c_imx7ulp->txfifo_size;
+
+		for (i = 0; i < loadnum; i++) {
+			data = i2c_imx7ulp->tx_buf[txlen + i];
+			imx7ulp_i2c_write_reg(data, i2c_imx7ulp, IMX7ULP_I2C_MTDR);
+		}
+
+		i2c_imx7ulp->tx_len += loadnum;
+	} else {
+		i2c_imx7ulp->msg_done = 1;
+		wake_up(&i2c_imx7ulp->queue);
+	}
+}
+
+static irqreturn_t i2c_imx7ulp_isr(int irq, void *dev_id)
+{
+	unsigned int temp;
+	struct imx7ulp_i2c_struct *i2c_imx7ulp = dev_id;
+
+	temp = imx7ulp_i2c_read_reg(i2c_imx7ulp, IMX7ULP_I2C_MSR);
+	i2c_imx7ulp->msr = temp;
+
+	if (temp & MSR_RDF) {
+		i2c_imx7ulp_read_rxfifo(i2c_imx7ulp);
+		return IRQ_HANDLED;
+	}
+
+	if (temp & MSR_TDF) {
+		i2c_imx7ulp_write_txfifo(i2c_imx7ulp);
+		return IRQ_HANDLED;
+	}
+
+	if (temp & MSR_NDF) {
+		/* write 1 to clear MSR_NDF */
+		imx7ulp_i2c_write_reg(temp, i2c_imx7ulp, IMX7ULP_I2C_MSR);
+		wake_up(&i2c_imx7ulp->queue);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static int i2c_imx7ulp_write(struct imx7ulp_i2c_struct *i2c_imx7ulp,
+							struct i2c_msg *msgs)
+{
+	int result;
+	unsigned int i, loadnum;
+	unsigned int data, temp;
+
+	dev_dbg(&i2c_imx7ulp->adapter.dev,  "<%s> write slave address: addr=0x%x\n",
+		__func__, msgs->addr << 1);
+
+	i2c_imx7ulp->msr = 0;
+	i2c_imx7ulp->tx_len = 0;
+	i2c_imx7ulp->msg_done = 0;
+	i2c_imx7ulp->tx_buf = msgs->buf;
+	i2c_imx7ulp->msg_len = msgs->len;
+
+	temp = imx7ulp_i2c_read_reg(i2c_imx7ulp, IMX7ULP_I2C_MIER);
+	temp |= MIER_NDIE;
+	imx7ulp_i2c_write_reg(temp, i2c_imx7ulp, IMX7ULP_I2C_MIER);
+
+	/* set TXWATER */
+	i2c_imx7ulp->tx_water = 0;
+	temp = i2c_imx7ulp->tx_water;
+	imx7ulp_i2c_write_reg(temp, i2c_imx7ulp, IMX7ULP_I2C_MFCR);
+
+	/* generate start and transmit address */
+	result = i2c_imx7ulp_tx_addr(i2c_imx7ulp, msgs, 0);
+	if (result)
+		goto ret;
+
+	/* load txfifo */
+	if (i2c_imx7ulp->msg_len > i2c_imx7ulp->txfifo_size)
+		loadnum = i2c_imx7ulp->txfifo_size;
+	else
+		loadnum = i2c_imx7ulp->msg_len;
+
+	for (i = 0; i < loadnum; i++) {
+		data = i2c_imx7ulp->tx_buf[i];
+		imx7ulp_i2c_write_reg(data, i2c_imx7ulp, IMX7ULP_I2C_MTDR);
+	}
+	i2c_imx7ulp->tx_len += loadnum;
+
+	/* transmit data interrupt enable */
+	temp = imx7ulp_i2c_read_reg(i2c_imx7ulp, IMX7ULP_I2C_MIER);
+	temp |= MIER_TDIE;
+	imx7ulp_i2c_write_reg(temp, i2c_imx7ulp, IMX7ULP_I2C_MIER);
+
+	result = i2c_imx7ulp_msg_complete(i2c_imx7ulp);
+ret:
+	return  result;
+}
+
+static int i2c_imx7ulp_read(struct imx7ulp_i2c_struct *i2c_imx7ulp,
+							struct i2c_msg *msgs)
+{
+	int result;
+	unsigned int temp;
+
+	dev_dbg(&i2c_imx7ulp->adapter.dev,
+		"<%s> write slave address: addr=0x%x\n",
+		__func__, (msgs->addr << 1) | 0x01);
+
+	i2c_imx7ulp->msr = 0;
+	i2c_imx7ulp->rx_len = 0;
+	i2c_imx7ulp->msg_done = 0;
+	i2c_imx7ulp->rx_buf = msgs->buf;
+	i2c_imx7ulp->msg_len = msgs->len;
+	i2c_imx7ulp->block_data = msgs->flags & I2C_M_RECV_LEN;
+
+	/* receive data interrupt enable */
+	temp = imx7ulp_i2c_read_reg(i2c_imx7ulp, IMX7ULP_I2C_MIER);
+	temp |= MIER_RDIE | MIER_NDIE;
+	imx7ulp_i2c_write_reg(temp, i2c_imx7ulp, IMX7ULP_I2C_MIER);
+
+	/* set RXWATER */
+	if (i2c_imx7ulp->msg_len > i2c_imx7ulp->rxfifo_size)
+		i2c_imx7ulp->rx_water = i2c_imx7ulp->rxfifo_size >> 1;
+	else
+		i2c_imx7ulp->rx_water = i2c_imx7ulp->msg_len;
+	temp = i2c_imx7ulp->rx_water << 16;
+	imx7ulp_i2c_write_reg(temp, i2c_imx7ulp, IMX7ULP_I2C_MFCR);
+
+	/* generate start and transmit address */
+	result = i2c_imx7ulp_tx_addr(i2c_imx7ulp, msgs, 1);
+	if (result)
+		goto ret;
+
+	/* receive data[7:0]+1 bytes */
+	temp = msgs->len > CHUNK_DATA ? CHUNK_DATA - 1 : msgs->len - 1;
+	temp |= (RECV_DATA << 8);
+	imx7ulp_i2c_write_reg(temp, i2c_imx7ulp, IMX7ULP_I2C_MTDR);
+
+	result = i2c_imx7ulp_msg_complete(i2c_imx7ulp);
+	if (result)
+		goto ret;
+
+	/* if block length is invalid, the flag can not cleared*/
+	if (i2c_imx7ulp->block_data)
+		result = -EPROTO;
+
+	/* msgs->len is changed when read block data */
+	msgs->len = i2c_imx7ulp->msg_len;
+
+ret:
+	return  result;
+}
+
+static int i2c_imx7ulp_xfer(struct i2c_adapter *adapter,
+						struct i2c_msg *msgs, int num)
+{
+	unsigned int i;
+	int result;
+	struct imx7ulp_i2c_struct *i2c_imx7ulp = i2c_get_adapdata(adapter);
+
+#ifdef CONFIG_I2C_DEBUG_BUS
+	unsigned int temp;
+#endif
+
+	dev_dbg(&i2c_imx7ulp->adapter.dev, "<%s>\n", __func__);
+
+	result = i2c_imx7ulp_start(i2c_imx7ulp);
+	if (result)
+		return result;
+
+	/* read/write data */
+	for (i = 0; i < num; i++) {
+		dev_dbg(&i2c_imx7ulp->adapter.dev,
+			"<%s> transfer message: %d\n", __func__, i);
+
+#ifdef CONFIG_I2C_DEBUG_BUS
+		temp = imx7ulp_i2c_read_reg(i2c_imx7ulp, IMX7ULP_I2C_MCR);
+		dev_dbg(&i2c_imx7ulp->adapter.dev,
+			"<%s> CONTROL: MEN=%d, RST=%d, DOZEN=%d, DBGEN=%d, RTF=%d, RRF=%d\n",
+			__func__,
+			(temp & MCR_MEN ? 1 : 0), (temp & MCR_RST ? 1 : 0),
+			(temp & MCR_DOZEN ? 1 : 0), (temp & MCR_DBGEN  ? 1 : 0),
+			(temp & MCR_RTF ? 1 : 0), (temp & MCR_RRF ? 1 : 0));
+#endif
+
+		if (msgs[i].flags & I2C_M_RD)
+			result = i2c_imx7ulp_read(i2c_imx7ulp, &msgs[i]);
+		else
+			result = i2c_imx7ulp_write(i2c_imx7ulp, &msgs[i]);
+		if (result)
+			goto fail0;
+	}
+
+fail0:
+	/* Stop I2C transfer */
+	i2c_imx7ulp_stop(i2c_imx7ulp);
+
+	dev_dbg(&i2c_imx7ulp->adapter.dev, "<%s> exit with: %s: %d\n", __func__,
+		(result < 0) ? "error" : "success msg",
+			(result < 0) ? result : num);
+	return (result < 0) ? result : num;
+}
+
+static u32 i2c_imx7ulp_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL
+		| I2C_FUNC_SMBUS_READ_BLOCK_DATA;
+}
+
+static struct i2c_algorithm i2c_imx7ulp_algo = {
+	.master_xfer	= i2c_imx7ulp_xfer,
+	.functionality	= i2c_imx7ulp_func,
+};
+
+static int i2c_imx7ulp_probe(struct platform_device *pdev)
+{
+	struct imx7ulp_i2c_struct *i2c_imx7ulp;
+	struct resource *res;
+	void __iomem *base;
+	int irq, ret;
+	unsigned int temp;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "can't get irq number\n");
+		return irq;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	i2c_imx7ulp = devm_kzalloc(&pdev->dev,
+				sizeof(*i2c_imx7ulp), GFP_KERNEL);
+	if (!i2c_imx7ulp)
+		return -ENOMEM;
+
+	/* Setup i2c_imx7ulp driver structure */
+	strlcpy(i2c_imx7ulp->adapter.name, pdev->name,
+				sizeof(i2c_imx7ulp->adapter.name));
+	i2c_imx7ulp->adapter.owner	= THIS_MODULE;
+	i2c_imx7ulp->adapter.algo	= &i2c_imx7ulp_algo;
+	i2c_imx7ulp->adapter.dev.parent	= &pdev->dev;
+	i2c_imx7ulp->adapter.nr		= pdev->id;
+	i2c_imx7ulp->base		= base;
+	i2c_imx7ulp->adapter.dev.of_node = pdev->dev.of_node;
+
+	/* Get I2C bus clock */
+	i2c_imx7ulp->bus_clk = devm_clk_get(&pdev->dev, "bus_clk");
+	if (IS_ERR(i2c_imx7ulp->bus_clk)) {
+		dev_err(&pdev->dev, "can't get I2C bus clock\n");
+		return PTR_ERR(i2c_imx7ulp->bus_clk);
+	}
+
+	/* Get I2C peripheral clock */
+	i2c_imx7ulp->per_clk = devm_clk_get(&pdev->dev, "per_clk");
+	if (IS_ERR(i2c_imx7ulp->per_clk)) {
+		dev_err(&pdev->dev, "can't get I2C peripheral clock\n");
+		return PTR_ERR(i2c_imx7ulp->per_clk);
+	}
+
+	ret = clk_prepare_enable(i2c_imx7ulp->bus_clk);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"can't enable I2C bus clock, ret=%d\n", ret);
+		return ret;
+	}
+
+	/* Request IRQ */
+	ret = devm_request_irq(&pdev->dev, irq, i2c_imx7ulp_isr, 0,
+				pdev->name, i2c_imx7ulp);
+	if (ret) {
+		dev_err(&pdev->dev, "can't claim irq %d\n", irq);
+		goto clk_disable;
+	}
+
+	/* Init queue */
+	init_waitqueue_head(&i2c_imx7ulp->queue);
+
+	/* Set up adapter data */
+	i2c_set_adapdata(&i2c_imx7ulp->adapter, i2c_imx7ulp);
+
+	/* Set up platform driver data */
+	platform_set_drvdata(pdev, i2c_imx7ulp);
+
+	/* Read i2c fifosize parameter, unit: words */
+	temp = imx7ulp_i2c_read_reg(i2c_imx7ulp, IMX7ULP_I2C_PARAM);
+	i2c_imx7ulp->txfifo_size = 1 <<  (temp & 0X000F);
+	i2c_imx7ulp->rxfifo_size = 1 <<  (temp & 0X0F00);
+
+	ret = of_property_read_u32(pdev->dev.of_node,
+				   "clock-frequency", &i2c_imx7ulp->bitrate);
+	if (ret)
+		i2c_imx7ulp->bitrate = LPI2C_DEFAULT_RATE;
+
+	/*i2c imx7ulp basic config */
+	i2c_imx7ulp_set_mode(i2c_imx7ulp);
+	i2c_imx7ulp_set_bitrate(i2c_imx7ulp);
+	i2c_imx7ulp_set_pincfg(i2c_imx7ulp);
+
+	/* Add I2C adapter */
+	ret = i2c_add_numbered_adapter(&i2c_imx7ulp->adapter);
+	if (ret) {
+		dev_err(&pdev->dev, "registration failed\n");
+		goto clk_disable;
+	}
+
+	dev_dbg(&i2c_imx7ulp->adapter.dev, "claimed irq %d\n", irq);
+	dev_dbg(&i2c_imx7ulp->adapter.dev, "device resources: %pR\n", res);
+	dev_dbg(&i2c_imx7ulp->adapter.dev, "adapter name: \"%s\"\n",
+		i2c_imx7ulp->adapter.name);
+	dev_info(&i2c_imx7ulp->adapter.dev, "IMX I2C adapter registered\n");
+
+clk_disable:
+	clk_disable_unprepare(i2c_imx7ulp->bus_clk);
+	return ret;
+}
+
+static int i2c_imx7ulp_remove(struct platform_device *pdev)
+{
+	struct imx7ulp_i2c_struct *i2c_imx7ulp = platform_get_drvdata(pdev);
+
+	i2c_del_adapter(&i2c_imx7ulp->adapter);
+	clk_disable_unprepare(i2c_imx7ulp->bus_clk);
+	clk_disable_unprepare(i2c_imx7ulp->per_clk);
+
+	dev_dbg(&i2c_imx7ulp->adapter.dev, "adapter removed\n");
+
+	return 0;
+}
+
+static struct platform_driver i2c_imx7ulp_driver = {
+	.probe = i2c_imx7ulp_probe,
+	.remove = i2c_imx7ulp_remove,
+	.driver = {
+		.name = DRIVER_NAME,
+	},
+};
+
+static int __init i2c_adap_imx_init(void)
+{
+	return platform_driver_register(&i2c_imx7ulp_driver);
+}
+subsys_initcall(i2c_adap_imx_init);
+
+static void __exit i2c_adap_imx_exit(void)
+{
+	platform_driver_unregister(&i2c_imx7ulp_driver);
+}
+module_exit(i2c_adap_imx_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Gao Pan <pandy.gao@nxp.com>");
+MODULE_DESCRIPTION("I2C adapter driver for IMX7ULP I2C bus");
+MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
1.9.1
