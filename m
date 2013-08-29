From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: [PATCH 2/2] i2c: New bus driver for the QUP I2C controller
Date: Thu, 29 Aug 2013 16:27:53 +0300
Message-ID: <1377782873-31931-2-git-send-email-iivanov@mm-sol.com>
References: <1377782873-31931-1-git-send-email-iivanov@mm-sol.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1377782873-31931-1-git-send-email-iivanov@mm-sol.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, rob@landley.net, grant.likely@linaro.org, gavidov@codeaurora.org, sdharia@codeaurora.org, alokc@codeaurora.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel, linux-arm-msm@vger.kernel.org, "Ivan T. Ivanov" <iivanov@mm-sol.com>
List-Id: linux-i2c@vger.kernel.org

From: "Ivan T. Ivanov" <iivanov@mm-sol.com>

This bus driver supports the QUP i2c hardware controller in the Qualcomm
MSM SOCs.  The Qualcomm Universal Peripheral Engine (QUP) is a general
purpose data path engine with input/output FIFOs and an embedded i2c
mini-core. The driver supports FIFO mode (for low bandwidth	applications)
and block mode (interrupt generated for each block-size data transfer).
The driver currently does not support DMA transfers.

Shamelessly based on codeaurora version of the driver.

This controller could be found in the following chip-sets:
msm9625, msm8974, msm8610, msm8226, mpq8092.

Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
---
 drivers/i2c/busses/Kconfig   |   10 +
 drivers/i2c/busses/Makefile  |    1 +
 drivers/i2c/busses/i2c-qup.c |  909 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 920 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-qup.c

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index fcdd321..c76ddd4 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -777,6 +777,16 @@ config I2C_RCAR
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-rcar.
 
+config I2C_QUP
+	tristate "Qualcomm QUP based I2C controller"
+	depends on ARCH_MSM
+	help
+	  If you say yes to this option, support will be included for the
+	  built-in I2C interface on the MSM family processors.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-qup.
+
 comment "External I2C/SMBus adapter drivers"
 
 config I2C_DIOLAN_U2C
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index d00997f..77127df 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_I2C_OCTEON)	+= i2c-octeon.o
 obj-$(CONFIG_I2C_XILINX)	+= i2c-xiic.o
 obj-$(CONFIG_I2C_XLR)		+= i2c-xlr.o
 obj-$(CONFIG_I2C_RCAR)		+= i2c-rcar.o
+obj-$(CONFIG_I2C_QUP)		+= i2c-qup.o
 
 # External I2C/SMBus adapter drivers
 obj-$(CONFIG_I2C_DIOLAN_U2C)	+= i2c-diolan-u2c.o
diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
new file mode 100644
index 0000000..3b5ef91
--- /dev/null
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -0,0 +1,909 @@
+/* Copyright (c) 2009-2013, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+/*
+ * QUP driver for Qualcomm MSM platforms
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_i2c.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+
+/* QUP Registers */
+#define QUP_CONFIG		0x000
+#define QUP_STATE		0x004
+#define QUP_IO_MODE		0x008
+#define QUP_SW_RESET		0x00c
+#define QUP_OPERATIONAL		0x018
+#define QUP_ERROR_FLAGS		0x01c
+#define QUP_ERROR_FLAGS_EN	0x020
+#define QUP_HW_VERSION		0x030
+#define QUP_MX_OUTPUT_CNT	0x100
+#define QUP_OUT_FIFO_BASE	0x110
+#define QUP_MX_WRITE_CNT	0x150
+#define QUP_MX_INPUT_CNT	0x200
+#define QUP_MX_READ_CNT		0x208
+#define QUP_IN_FIFO_BASE	0x218
+#define QUP_I2C_CLK_CTL		0x400
+#define QUP_I2C_STATUS		0x404
+
+/* QUP States and reset values */
+#define QUP_RESET_STATE		0
+#define QUP_RUN_STATE		1
+#define QUP_PAUSE_STATE		3
+#define QUP_STATE_MASK		3
+
+#define QUP_STATE_VALID		BIT(2)
+#define QUP_I2C_MAST_GEN	BIT(4)
+
+#define QUP_OPERATIONAL_RESET	0x000ff0
+#define QUP_I2C_STATUS_RESET	0xfffffc
+
+/* QUP OPERATIONAL FLAGS */
+#define QUP_OUT_SVC_FLAG	BIT(8)
+#define QUP_IN_SVC_FLAG		BIT(9)
+#define QUP_MX_INPUT_DONE	BIT(11)
+
+/* I2C mini core related values */
+#define I2C_MINI_CORE		(2 << 8)
+#define I2C_N_VAL		15
+/* Most significant word offset in FIFO port */
+#define QUP_MSW_SHIFT		(I2C_N_VAL + 1)
+#define QUP_CLOCK_AUTO_GATE	BIT(13)
+
+/* Packing/Unpacking words in FIFOs, and IO modes */
+#define QUP_UNPACK_EN		BIT(14)
+#define QUP_PACK_EN		BIT(15)
+#define QUP_OUTPUT_BLK_MODE	(1 << 10)
+#define QUP_INPUT_BLK_MODE	(1 << 12)
+
+#define QUP_REPACK_EN		(QUP_UNPACK_EN | QUP_PACK_EN)
+
+#define QUP_OUTPUT_BLOCK_SIZE(x)(((x) & (0x03 << 0)) >> 0)
+#define QUP_OUTPUT_FIFO_SIZE(x)	(((x) & (0x07 << 2)) >> 2)
+#define QUP_INPUT_BLOCK_SIZE(x)	(((x) & (0x03 << 5)) >> 5)
+#define QUP_INPUT_FIFO_SIZE(x)	(((x) & (0x07 << 7)) >> 7)
+
+/* QUP tags */
+#define QUP_OUT_NOP		(0 << 8)
+#define QUP_OUT_START		(1 << 8)
+#define QUP_OUT_DATA		(2 << 8)
+#define QUP_OUT_STOP		(3 << 8)
+#define QUP_OUT_REC		(4 << 8)
+#define QUP_IN_DATA		(5 << 8)
+#define QUP_IN_STOP		(6 << 8)
+#define QUP_IN_NACK		(7 << 8)
+
+/* Status, Error flags */
+#define I2C_STATUS_WR_BUFFER_FULL	BIT(0)
+#define I2C_STATUS_BUS_ACTIVE	BIT(8)
+#define I2C_STATUS_BUS_MASTER	BIT(9)
+#define I2C_STATUS_ERROR_MASK	0x38000fc
+#define QUP_I2C_NACK_FLAG	BIT(3)
+#define QUP_IN_NOT_EMPTY	BIT(5)
+#define QUP_STATUS_ERROR_FLAGS	0x7c
+
+/* Master bus_err clock states */
+#define I2C_CLK_RESET_BUSIDLE_STATE	0
+#define I2C_CLK_FORCED_LOW_STATE	5
+
+#define QUP_MAX_CLK_STATE_RETRIES	300
+#define DEFAULT_CLK_RATE		19200000
+#define I2C_STATUS_CLK_STATE		13
+#define QUP_OUT_FIFO_NOT_EMPTY		0x10
+#define QUP_READ_LIMIT			256
+
+struct qup_i2c_dev {
+	struct device		*dev;
+	void __iomem		*base;
+	struct pinctrl		*pctrl;
+	int			irq;
+	struct clk		*clk;
+	struct clk		*pclk;
+	struct i2c_adapter	adap;
+
+	int			src_clk_freq;
+	int			clk_freq;
+	int			clk_ctl;
+	int			one_bit_t;
+	int			out_fifo_sz;
+	int			in_fifo_sz;
+	int			out_blk_sz;
+	int			in_blk_sz;
+	unsigned long		xfer_time;
+	unsigned long		wait_idle;
+
+	struct i2c_msg		*msg;
+	/* Current possion in user message buffer */
+	int			pos;
+	/* Keep number of bytes left to be transmitted */
+	int			cnt;
+	/* I2C protocol errors */
+	u32			bus_err;
+	/* QUP core errors */
+	u32			qup_err;
+	/*
+	 * maximum bytes that could be send (per iterration). could be
+	 * equal of fifo size or block size (in block mode)
+	 */
+	int			chunk_sz;
+	struct completion	xfer;
+};
+
+static irqreturn_t qup_i2c_interrupt(int irq, void *dev)
+{
+	struct qup_i2c_dev *qup = dev;
+	u32 bus_err;
+	u32 qup_err;
+	u32 opflags;
+
+	bus_err = readl(qup->base + QUP_I2C_STATUS);
+	qup_err = readl(qup->base + QUP_ERROR_FLAGS);
+	opflags = readl(qup->base + QUP_OPERATIONAL);
+
+	if (!qup->msg) {
+		/* Clear Error interrupt */
+		writel(QUP_RESET_STATE, qup->base + QUP_STATE);
+		return IRQ_HANDLED;
+	}
+
+	bus_err &= I2C_STATUS_ERROR_MASK;
+	qup_err &= QUP_STATUS_ERROR_FLAGS;
+
+	if (qup_err) {
+		/* Clear Error interrupt */
+		writel(qup_err & QUP_STATUS_ERROR_FLAGS,
+			qup->base + QUP_ERROR_FLAGS);
+		goto done;
+	}
+
+	if (bus_err) {
+		/* Clear Error interrupt */
+		writel(QUP_RESET_STATE, qup->base + QUP_STATE);
+		goto done;
+	}
+
+	if (opflags & QUP_OUT_SVC_FLAG)
+		writel(QUP_OUT_SVC_FLAG, qup->base + QUP_OPERATIONAL);
+
+	if (!(qup->msg->flags == I2C_M_RD))
+		return IRQ_HANDLED;
+
+	if ((opflags & QUP_MX_INPUT_DONE) || (opflags & QUP_IN_SVC_FLAG))
+		writel(QUP_IN_SVC_FLAG, qup->base + QUP_OPERATIONAL);
+
+done:
+	qup->qup_err = qup_err;
+	qup->bus_err = bus_err;
+	complete(&qup->xfer);
+	return IRQ_HANDLED;
+}
+
+static int
+qup_i2c_poll_state(struct qup_i2c_dev *qup, u32 req_state, bool only_valid)
+{
+	int retries = 0;
+	u32 state;
+
+	do {
+		state = readl(qup->base + QUP_STATE);
+
+		/*
+		 * If only valid bit needs to be checked, requested state is
+		 * 'don't care'
+		 */
+		if (state & QUP_STATE_VALID) {
+			if (only_valid)
+				return 0;
+			if ((req_state & QUP_I2C_MAST_GEN)
+			    && (state & QUP_I2C_MAST_GEN))
+				return 0;
+			if ((state & QUP_STATE_MASK) == req_state)
+				return 0;
+		}
+
+		if (retries++ == 1000)
+			udelay(100);
+
+	} while (retries != 2000);
+
+	return -ETIMEDOUT;
+}
+
+static int qup_i2c_change_state(struct qup_i2c_dev *qup, u32 state)
+{
+	if (qup_i2c_poll_state(qup, 0, true) != 0)
+		return -EIO;
+
+	writel(state, qup->base + QUP_STATE);
+
+	if (qup_i2c_poll_state(qup, state, false) != 0)
+		return -EIO;
+	return 0;
+}
+
+static void qup_i2c_enable(struct qup_i2c_dev *qup, bool state)
+{
+	u32 config;
+
+	if (state) {
+		clk_prepare_enable(qup->clk);
+		clk_prepare_enable(qup->pclk);
+	} else {
+		qup_i2c_change_state(qup, QUP_RESET_STATE);
+		clk_disable_unprepare(qup->clk);
+		config = readl(qup->base + QUP_CONFIG);
+		config |= QUP_CLOCK_AUTO_GATE;
+		writel(config, qup->base + QUP_CONFIG);
+		clk_disable_unprepare(qup->pclk);
+	}
+}
+
+static int qup_i2c_wait_idle(struct qup_i2c_dev *qup, struct i2c_msg *msg)
+{
+	bool buf_full, bus_active;
+	int retries = 0;
+	u32 status;
+
+	do {
+		status = readl(qup->base + QUP_I2C_STATUS);
+		buf_full = status & I2C_STATUS_WR_BUFFER_FULL;
+		bus_active = status & I2C_STATUS_BUS_ACTIVE;
+
+		if (!buf_full) {
+			if ((msg->flags & I2C_M_RD) && !bus_active)
+				return 0;
+			else if (msg->flags == 0)
+				return 0;
+			else /* 1-bit delay before we check for bus busy */
+				udelay(qup->one_bit_t);
+		}
+
+		if (retries++ == 1000)
+			usleep_range(qup->wait_idle, qup->wait_idle + 10);
+
+	} while (retries != 2000);
+
+	dev_err(qup->dev, "Timeout waiting bus idle\n");
+	return -ETIMEDOUT;
+}
+
+static void qup_i2c_wait_clock_ready(struct qup_i2c_dev *qup)
+{
+	u32 have_data, clk_state, bus_state;
+	int retries = 0;
+
+	/*
+	 * Wait for the clock state to transition to either IDLE or FORCED
+	 * LOW. This will usually happen within one cycle of the i2c clock.
+	 */
+	do {
+		bus_state = readl(qup->base + QUP_I2C_STATUS);
+		clk_state = (bus_state >> I2C_STATUS_CLK_STATE) & 0x7;
+
+		have_data = readl(qup->base + QUP_OPERATIONAL);
+		have_data &= QUP_OUT_FIFO_NOT_EMPTY;
+
+		/*
+		 * In very corner case when slave do clock stretching and
+		 * output fifo will have 1 block of data space have_data at
+		 * the same time.  So i2c dev will get output service
+		 * interrupt and as it doesn't have more data to be written.
+		 * This can lead to issue where output fifo is not have_data.
+		 */
+		if (!have_data &&
+		    (clk_state == I2C_CLK_RESET_BUSIDLE_STATE ||
+		    clk_state == I2C_CLK_FORCED_LOW_STATE)) {
+			return;
+		}
+
+		/* 1-bit delay before we check again */
+		udelay(qup->one_bit_t);
+	} while (retries++ < QUP_MAX_CLK_STATE_RETRIES);
+
+	dev_warn(qup->dev, "Timeout clk_state: %x buffer %sempty\n", clk_state,
+		 have_data ? "not-" : "");
+}
+
+static void qup_i2c_set_read_mode(struct qup_i2c_dev *qup)
+{
+	/*
+	 * QUP limit QUP_READ_LIMIT bytes per read. By HW design, 0 in the
+	 * 8-bit field is treated as QUP_READ_LIMIT byte read.
+	 */
+	u16 len = (qup->cnt >= QUP_READ_LIMIT) ? QUP_READ_LIMIT : qup->cnt;
+
+	if (len <= qup->in_fifo_sz) {
+		/* FIFO mode */
+		writel(QUP_REPACK_EN, qup->base + QUP_IO_MODE);
+		writel(len, qup->base + QUP_MX_READ_CNT);
+	} else {
+		/* BLOCK mode (transfer data on chunks) */
+		writel(QUP_INPUT_BLK_MODE | QUP_REPACK_EN,
+				qup->base + QUP_IO_MODE);
+		writel(len, qup->base + QUP_MX_INPUT_CNT);
+	}
+}
+
+static void qup_i2c_issue_read(struct qup_i2c_dev *qup, struct i2c_msg *msg)
+{
+	u32 addr = (msg->addr << 1) | 1;
+	/*
+	 * QUP limit 256 bytes per read. By HW design, 0 in the
+	 * 8-bit field is treated as 256 byte read.
+	 */
+	u32 len = (qup->cnt >= QUP_READ_LIMIT) ? 0 : qup->cnt;
+	u32 val;
+
+	val = ((QUP_OUT_REC | len) << QUP_MSW_SHIFT) | QUP_OUT_START | addr;
+
+	writel(val, qup->base + QUP_OUT_FIFO_BASE);
+}
+
+
+static void qup_i2c_read_fifo(struct qup_i2c_dev *qup, struct i2c_msg *msg)
+{
+	u32 val, stat;
+	int idx;
+
+	val = 0;
+	for (idx = 0; qup->pos < msg->len; idx++, qup->pos++, qup->cnt--) {
+		if ((idx & 1) == 0) {
+			/* Check that FIFO have_data */
+			stat = readl(qup->base + QUP_OPERATIONAL);
+			if ((stat & QUP_IN_NOT_EMPTY) == 0)
+				break;
+
+			/* Reading 2 words at time */
+			val = readl(qup->base + QUP_IN_FIFO_BASE);
+
+			msg->buf[qup->pos] = val & 0xFF;
+		} else {
+			msg->buf[qup->pos] = val >> QUP_MSW_SHIFT;
+		}
+	}
+}
+
+static bool
+qup_i2c_set_write_mode(struct qup_i2c_dev *qup, struct i2c_msg *msg)
+{
+	bool block = false;
+	int total;
+
+	if (msg->len <= qup->out_fifo_sz) {
+		/* FIFO mode */
+		writel(QUP_REPACK_EN, qup->base + QUP_IO_MODE);
+	} else {
+		/* BLOCK mode (transfer data on chunks) */
+		total = msg->len + 1 + (msg->len / (qup->out_blk_sz - 1));
+		writel(QUP_OUTPUT_BLK_MODE | QUP_REPACK_EN,
+				qup->base + QUP_IO_MODE);
+		writel(total, qup->base + QUP_MX_OUTPUT_CNT);
+		block = true;
+	}
+
+	return block;
+}
+
+static void qup_i2c_issue_write(struct qup_i2c_dev *qup, struct i2c_msg *msg)
+{
+	u32 addr = msg->addr << 1;
+	u32 val, qup_tag;
+	int idx, entries;
+
+	if (qup->pos == 0) {
+		val = QUP_OUT_START | addr;
+	} else {
+		/*
+		 * Avoid setup time issue by adding 1 NOP when number of bytes
+		 * are more than FIFO/BLOCK size. setup time issue can't appear
+		 * otherwise since next byte to be written will always be ready
+		 */
+		val = (QUP_OUT_NOP | 1);
+	}
+
+	entries = qup->cnt + 1;
+
+	if (entries > qup->chunk_sz)
+		entries = qup->chunk_sz;
+
+	qup_tag = QUP_OUT_DATA;
+
+	/* Reserve one entry for STOP */
+	for (idx = 1; idx < (entries - 1); idx++, qup->pos++) {
+
+		if (idx & 1) {
+			val |= (qup_tag | msg->buf[qup->pos]) << QUP_MSW_SHIFT;
+			writel(val, qup->base + QUP_OUT_FIFO_BASE);
+		} else {
+			val = qup_tag | msg->buf[qup->pos];
+		}
+	}
+
+	if (qup->pos == (msg->len - 1))
+		qup_tag = QUP_OUT_STOP;
+
+	if (idx & 1)
+		val |= (qup_tag | msg->buf[qup->pos]) << QUP_MSW_SHIFT;
+	else
+		val = qup_tag | msg->buf[qup->pos];
+
+	writel(val, qup->base + QUP_OUT_FIFO_BASE);
+
+	qup->pos++;
+	qup->cnt = msg->len - qup->pos;
+}
+
+static int qup_i2c_write_one(struct qup_i2c_dev *qup, struct i2c_msg *msg)
+{
+	unsigned long left;
+	bool block;
+	int ret;
+
+	if (!msg->len)
+		return -EINVAL;
+
+	qup->msg = msg;
+	qup->cnt = msg->len;
+
+	qup->chunk_sz = qup->out_fifo_sz;
+	qup->bus_err = 0;
+	qup->qup_err = 0;
+	qup->pos = 0;
+
+	enable_irq(qup->irq);
+
+	block = qup_i2c_set_write_mode(qup, msg);
+
+	INIT_COMPLETION(qup->xfer);
+	ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
+	if (ret < 0)
+		goto err;
+
+	writel(qup->clk_ctl, qup->base + QUP_I2C_CLK_CTL);
+
+	if (block) {
+		/* Don't fill block till we get interrupt */
+		qup->chunk_sz = qup->out_blk_sz;
+		left = wait_for_completion_timeout(&qup->xfer, qup->xfer_time);
+		if (!left) {
+			writel(1, qup->base + QUP_SW_RESET);
+			ret = -ETIMEDOUT;
+			goto err;
+		}
+	}
+
+	do {
+		/* Note: transition to PAUSE state only possible from RUN */
+		ret = qup_i2c_change_state(qup, QUP_PAUSE_STATE);
+		if (ret < 0)
+			goto err;
+
+		qup_i2c_issue_write(qup, msg);
+
+		INIT_COMPLETION(qup->xfer);
+		ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
+		if (ret < 0)
+			goto err;
+
+		left = wait_for_completion_timeout(&qup->xfer, qup->xfer_time);
+		if (!left) {
+			writel(1, qup->base + QUP_SW_RESET);
+			ret = -ETIMEDOUT;
+			goto err;
+		}
+
+		if (qup->bus_err || qup->qup_err) {
+			if (qup->bus_err & QUP_I2C_NACK_FLAG)
+				dev_err(qup->dev, "NACK from %x\n", msg->addr);
+			ret = -EIO;
+			goto err;
+		}
+	} while (qup->cnt > 0);
+
+ err:
+	disable_irq(qup->irq);
+	qup->msg = NULL;
+
+	qup_i2c_wait_clock_ready(qup);
+
+	ret = qup_i2c_change_state(qup, QUP_RESET_STATE);
+	if (!ret)
+		ret = qup_i2c_wait_idle(qup, msg);
+
+	return ret;
+}
+
+static int qup_i2c_read_one(struct qup_i2c_dev *qup, struct i2c_msg *msg)
+{
+	unsigned long left;
+	int ret;
+
+	if (!msg->len)
+		return -EINVAL;
+
+	qup->cnt = msg->len;
+	qup->msg = msg;
+
+	qup->chunk_sz = qup->in_fifo_sz;
+	qup->bus_err = 0;
+	qup->qup_err = 0;
+	qup->pos  = 0;
+
+	enable_irq(qup->irq);
+
+	do {
+		qup_i2c_set_read_mode(qup);
+
+		INIT_COMPLETION(qup->xfer);
+		ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
+		if (ret < 0)
+			goto err;
+
+		writel(qup->clk_ctl, qup->base + QUP_I2C_CLK_CTL);
+
+		/* Note: transition to PAUSE state only possible from RUN */
+		ret = qup_i2c_change_state(qup, QUP_PAUSE_STATE);
+		if (ret < 0)
+			goto err;
+
+		/*
+		 * HW limits READ up to QUP_READ_LIMIT bytes in 1
+		 * read without stop
+		 */
+		qup_i2c_issue_read(qup, msg);
+
+		ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
+		if (ret < 0)
+			goto err;
+
+		left = wait_for_completion_timeout(&qup->xfer, qup->xfer_time);
+		if (!left) {
+			writel(1, qup->base + QUP_SW_RESET);
+			ret = -ETIMEDOUT;
+			goto err;
+		}
+
+		if (qup->bus_err || qup->qup_err) {
+			if (qup->bus_err & QUP_I2C_NACK_FLAG)
+				dev_err(qup->dev, "NACK from %x\n", msg->addr);
+			ret = -EIO;
+			goto err;
+		}
+
+		qup_i2c_read_fifo(qup, msg);
+	} while (qup->cnt > 0);
+
+ err:
+	disable_irq(qup->irq);
+	qup->msg = NULL;
+
+	ret = qup_i2c_change_state(qup, QUP_RESET_STATE);
+	if (!ret)
+		ret = qup_i2c_wait_idle(qup, msg);
+
+	return ret;
+}
+
+/*
+ * Prepare controller for a transaction and call omap_i2c_xfer_msg
+ * to do the work during IRQ processing.
+ */
+static int
+qup_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
+{
+	struct qup_i2c_dev *qup = i2c_get_adapdata(adap);
+	int ret, idx;
+
+	ret = pm_runtime_get_sync(qup->dev);
+	if (IS_ERR_VALUE(ret))
+		goto out;
+
+	writel(1, qup->base + QUP_SW_RESET);
+	ret = qup_i2c_poll_state(qup, QUP_RESET_STATE, false);
+	if (ret) {
+		dev_err(qup->dev, "cannot goto reset state\n");
+		goto out;
+	}
+
+	/* Initialize QUP registers */
+	writel(0, qup->base + QUP_CONFIG);
+	writel(QUP_OPERATIONAL_RESET, qup->base + QUP_OPERATIONAL);
+	writel(QUP_STATUS_ERROR_FLAGS, qup->base + QUP_ERROR_FLAGS_EN);
+	writel(I2C_MINI_CORE | I2C_N_VAL, qup->base + QUP_CONFIG);
+
+	/* Initialize I2C mini core registers */
+	writel(0, qup->base + QUP_I2C_CLK_CTL);
+	writel(QUP_I2C_STATUS_RESET, qup->base + QUP_I2C_STATUS);
+
+	for (idx = 0; idx < num; idx++) {
+
+		if (qup_i2c_poll_state(qup, QUP_I2C_MAST_GEN, false) != 0) {
+			ret = -EIO;
+			goto out;
+		}
+
+		if (msgs[idx].flags & I2C_M_RD)
+			ret = qup_i2c_read_one(qup, &msgs[idx]);
+		else
+			ret = qup_i2c_write_one(qup, &msgs[idx]);
+
+		if (ret)
+			break;
+	}
+
+	if (ret == 0)
+		ret = num;
+out:
+	pm_runtime_mark_last_busy(qup->dev);
+	pm_runtime_put_autosuspend(qup->dev);
+	return ret;
+}
+
+static u32 qup_i2c_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
+}
+
+static const struct i2c_algorithm qup_i2c_algo = {
+	.master_xfer	= qup_i2c_xfer,
+	.functionality	= qup_i2c_func,
+};
+
+static int qup_i2c_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct qup_i2c_dev *qup;
+	struct resource *res;
+	u32 val, io_mode, hw_ver, size;
+	int ret, fs_div, hs_div;
+
+	qup = devm_kzalloc(&pdev->dev, sizeof(*qup), GFP_KERNEL);
+	if (!qup)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, qup);
+
+	ret = of_alias_get_id(node, "i2c");
+	if (ret >= 0)
+		pdev->id = ret;
+
+	qup->dev = &pdev->dev;
+
+	qup->pctrl = devm_pinctrl_get_select_default(qup->dev);
+	if (IS_ERR(qup->pctrl)) {
+		dev_err(qup->dev, "failed to request pinctrl\n");
+		return PTR_ERR(qup->pctrl);
+	}
+
+	qup->clk_freq = 100000;
+	if (!of_property_read_u32(node, "clock-frequency", &val))
+		qup->clk_freq = val;
+
+	qup->src_clk_freq = DEFAULT_CLK_RATE;
+	if (!of_property_read_u32(node, "qcom,src-freq", &val))
+		qup->src_clk_freq = val;
+
+	/* We support frequencies up to FAST Mode(400KHz) */
+	if (qup->clk_freq <= 0 || qup->clk_freq > 400000) {
+		dev_err(qup->dev, "clock frequency not supported %d\n",
+			qup->clk_freq);
+		return -EIO;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	qup->base = devm_ioremap_resource(qup->dev, res);
+	if (IS_ERR(qup->base))
+		return PTR_ERR(qup->base);
+
+	qup->irq = platform_get_irq(pdev, 0);
+	if (qup->irq < 0) {
+		dev_err(qup->dev, "No IRQ defined\n");
+		return qup->irq;
+	}
+
+	qup->clk = devm_clk_get(qup->dev, "core");
+	if (IS_ERR(qup->clk)) {
+		dev_err(qup->dev, "Could not get core clock\n");
+		return PTR_ERR(qup->clk);
+	}
+
+	qup->pclk = devm_clk_get(qup->dev, "iface");
+	if (IS_ERR(qup->pclk)) {
+		dev_err(qup->dev, "Could not get iface clock\n");
+		return PTR_ERR(qup->pclk);
+	}
+
+	ret = devm_request_irq(qup->dev, qup->irq, qup_i2c_interrupt,
+			       IRQF_TRIGGER_HIGH, "i2c_qup", qup);
+	if (ret) {
+		dev_err(qup->dev, "Request %d IRQ failed\n", qup->irq);
+		return ret;
+	}
+
+	disable_irq(qup->irq);
+
+	init_completion(&qup->xfer);
+
+	ret = clk_set_rate(qup->clk, qup->src_clk_freq);
+	if (ret)
+		dev_info(qup->dev, "Fail to set core clk, %dHz:%d\n",
+			 qup->src_clk_freq, ret);
+
+	qup_i2c_enable(qup, true);
+
+	/*
+	 * If bootloaders leave a pending interrupt on certain QUP's,
+	 * then we reset the core before registering for interrupts.
+	 */
+	writel(1, qup->base + QUP_SW_RESET);
+	ret = qup_i2c_poll_state(qup, 0, true);
+	if (ret)
+		goto fail;
+
+	hw_ver = readl(qup->base + QUP_HW_VERSION);
+	dev_dbg(qup->dev, "%d Revision %x\n", pdev->id, hw_ver);
+
+	fs_div = ((qup->src_clk_freq / qup->clk_freq) / 2) - 3;
+	hs_div = 3;
+	qup->clk_ctl = (hs_div << 8) | (fs_div & 0xff);
+	qup->one_bit_t = (USEC_PER_SEC / qup->clk_freq) + 1;
+
+	io_mode = readl(qup->base + QUP_IO_MODE);
+
+	size = QUP_OUTPUT_BLOCK_SIZE(io_mode);
+	if (size)
+		qup->out_blk_sz = size * 16;
+	else
+		qup->out_blk_sz = 16;
+
+	size = QUP_INPUT_BLOCK_SIZE(io_mode);
+	if (size)
+		qup->in_blk_sz = size * 16;
+	else
+		qup->in_blk_sz = 16;
+
+	qup->xfer_time = msecs_to_jiffies(qup->out_fifo_sz);
+
+	/*
+	 * The block/fifo size w.r.t. 'actual data' is 1/2 due to 'tag'
+	 * associated with each byte written/received
+	 */
+	qup->out_blk_sz /= 2;
+	qup->in_blk_sz /= 2;
+
+	size = QUP_OUTPUT_FIFO_SIZE(io_mode);
+	qup->out_fifo_sz = qup->out_blk_sz * (2 << size);
+
+	size = QUP_INPUT_FIFO_SIZE(io_mode);
+	qup->in_fifo_sz = qup->in_blk_sz * (2 << size);
+
+	/*
+	 * Wait for FIFO number of bytes to be absolutely sure
+	 * that I2C write state machine is not idle. Each byte
+	 * takes 9 clock cycles. (8 bits + 1 ack)
+	 */
+	qup->wait_idle = qup->one_bit_t * 9;
+	qup->wait_idle *= qup->out_fifo_sz;
+
+	dev_info(qup->dev, "IN:block:%d, fifo:%d, OUT:block:%d, fifo:%d\n",
+		qup->in_blk_sz, qup->in_fifo_sz,
+		qup->out_blk_sz, qup->out_fifo_sz);
+
+	i2c_set_adapdata(&qup->adap, qup);
+	qup->adap.algo = &qup_i2c_algo;
+	qup->adap.nr = pdev->id;
+	qup->adap.dev.parent = qup->dev;
+	qup->adap.dev.of_node = pdev->dev.of_node;
+	strlcpy(qup->adap.name, "QUP I2C adapter", sizeof(qup->adap.name));
+
+	ret = i2c_add_numbered_adapter(&qup->adap);
+	if (!ret) {
+		of_i2c_register_devices(&qup->adap);
+		pm_runtime_set_autosuspend_delay(qup->dev, MSEC_PER_SEC);
+		pm_runtime_use_autosuspend(qup->dev);
+		pm_runtime_enable(qup->dev);
+		return 0;
+	}
+fail:
+	qup_i2c_enable(qup, false);
+	return ret;
+}
+
+static int qup_i2c_remove(struct platform_device *pdev)
+{
+	struct qup_i2c_dev *qup = platform_get_drvdata(pdev);
+
+	disable_irq(qup->irq);
+	qup_i2c_enable(qup, false);
+	i2c_del_adapter(&qup->adap);
+	pm_runtime_disable(qup->dev);
+	pm_runtime_set_suspended(qup->dev);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int qup_i2c_pm_suspend_runtime(struct device *device)
+{
+	struct qup_i2c_dev *qup = dev_get_drvdata(device);
+
+	dev_dbg(device, "pm_runtime: suspending...\n");
+	qup_i2c_enable(qup, false);
+	return 0;
+}
+
+static int qup_i2c_pm_resume_runtime(struct device *device)
+{
+	struct qup_i2c_dev *qup = dev_get_drvdata(device);
+
+	dev_dbg(device, "pm_runtime: resuming...\n");
+	qup_i2c_enable(qup, true);
+	return 0;
+}
+
+static int qup_i2c_suspend(struct device *device)
+{
+	dev_dbg(device, "system suspend");
+	qup_i2c_pm_suspend_runtime(device);
+	return 0;
+}
+
+static int qup_i2c_resume(struct device *device)
+{
+	dev_dbg(device, "system resume");
+	qup_i2c_pm_resume_runtime(device);
+	pm_runtime_mark_last_busy(device);
+	pm_request_autosuspend(device);
+	return 0;
+}
+#endif /* CONFIG_PM */
+
+static const struct dev_pm_ops qup_i2c_qup_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(
+		qup_i2c_suspend,
+		qup_i2c_resume)
+	SET_RUNTIME_PM_OPS(
+		qup_i2c_pm_suspend_runtime,
+		qup_i2c_pm_resume_runtime,
+		NULL)
+};
+
+static struct of_device_id qup_i2c_dt_match[] = {
+	{.compatible = "qcom,i2c-qup"},
+	{}
+};
+
+static struct platform_driver qup_i2c_driver = {
+	.probe  = qup_i2c_probe,
+	.remove = qup_i2c_remove,
+	.driver = {
+		.name = "i2c_qup",
+		.owner = THIS_MODULE,
+		.pm = &qup_i2c_qup_pm_ops,
+		.of_match_table = qup_i2c_dt_match,
+	},
+};
+
+module_platform_driver(qup_i2c_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:i2c_qup");
-- 
1.7.9.5
