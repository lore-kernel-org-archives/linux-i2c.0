Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352DE1FA272
	for <linux-i2c@vger.kernel.org>; Mon,  2 Mar 2026 02:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772417334; cv=none; b=q0kUXUb6g8NDqtmJQutx2ATl5megO91pGsxTbzz1CtZa28RfpkZ6z63EtaxGTKUs+WZcwIGnRq0U4bVLytIFsc9EJ7Jfu3GXDHsmwEMRoakWjWUTJXSy0If014WKhZfN5lWKc/TTAzrQ/y8qSdFSX6R0MfRhiIuGLamtHMflXBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772417334; c=relaxed/simple;
	bh=f0LwUzn+CTFlVSneXXr20yw3ZGzW/O5UtPx/MYS9ztg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MQocTMH+UEj/cXIG4rF6dMBZWcmLsWtuGzV8AD3ZIXQUCzy2j7F04kWjC5SN7arcoih4sKQCkgt+ffJXL7ziUrMU4Zl5b66wQSFzElafNHZ8X2UKRNEGoROeemVCWOKAgneD9aSbyvK/A+GEx6QVcZYW33l/doU0lJKRWeQo/zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQpqFtwz; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQpqFtwz"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c6e734ba92bso1742171a12.3
        for <linux-i2c@vger.kernel.org>; Sun, 01 Mar 2026 18:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772417331; x=1773022131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAiRnxNawBLozwr1RQWvSytcrnot4tDBwXBqxdM0Av4=;
        b=FQpqFtwz4R0rpyxxSSsnOTZjy55A0y9wZjGG7/+z44meHcPMaXWxrUGUf5GrIv3mXX
         ex9micubPbF/tKeTQzm4tX6aJkmh8KdtA3EC9ytGTSuVLQaoChyE1nkUf7VvGXF7pMaQ
         E1m0hz0TuFYd7eXsWrx9oUFSSGHcGeNQHrXwE4WafCihGMgLnelvNZus0IMRP1HzcB9D
         lnY4GRFfYyOOpPxuW48lwfEJ+senvv1I81Qjdc2WaplhoVEOHn8PbLDqielnVG1+XAl8
         3VA6HUkN7YxD4kTi1EIAfXvbKCVADEzglLooYd30GISNnIaJQuYJzfQkJgvjQuE1uQQu
         Meug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772417331; x=1773022131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kAiRnxNawBLozwr1RQWvSytcrnot4tDBwXBqxdM0Av4=;
        b=FxaXxxIaKar0kVh6RrpV1ymWJ51IYpvzV+R0lQrX2rFu4gH8qZYNd+cr7TMj+Uwgpp
         yXi2j8nLMFwcp25H3HJdGR8D9KNGk4ACiz8QEIfY3jj7W5JZdwlPFeJiGDqNpJgwoU1O
         IjRAMTZu1CYF6J7Kp+Nh47gSIqQqi9lhYVm6RtvjPuv1iyYKBqqEdl6rzRUm6VmSgqlc
         yx/U9iwX36gO+Jci6uoXrVc3677YD7MaTxXd2ATiADffV4dakhZi3tlxDTIz0oKnpAgd
         G2Pbk/7+FYVYQ6NOHDhLuuqmW76++Dz4nQmuvqLXW61gHm1spLsPMAVTYMitaSMqljjh
         pACg==
X-Forwarded-Encrypted: i=1; AJvYcCUDEs4w29BwfBrjLNtrijh/KOmXU7dfIqAVmX6HfRM3V9EZcaaGdBSpdUv9bSlhxmXgBux/6RtkSTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFJUoPm90bipK2CKO9ghfL0sHQ4bZ6kMmBgebCC8KJ/Q2vlVuh
	0/UcfXUtinByN6ZN1fWaJQbmZX075+e7lseuE0QNy6qWwwImhzaBsT27
X-Gm-Gg: ATEYQzwMBtAHfAB+kPKorE6J3WHgqbzUTIWTyYQ4P1wsBwGoSsINLpIBwPZlSQxQKRu
	4ZO46sYuTx0OrHzIGkySegF+mSLyE41m9AFblL32KSwqwGIRQFXf683qsukQ+7VTs1Ku+h7jW7H
	jQV62pkpDFxrGD34IgwUGfQzZMGn5TjFCVN/FW1joGpCq6uI1oQYSJH3Mh8khBVCfu2x9c+9IZt
	HtmAu96sz+ITF/RaJgwJXtLGYDi1YNCk2w7mEUKMOUjl4Oc/aVD4eo7RYpaIUtFBA8CVguvu2Fg
	c87sKPPCxRWEp72c+zXGxl2cBjum1htAok6EpeZRRPiQcWpVZlVq2PHuyQq3a4Q1EHAYBfn0f32
	3VoIw1fez6KmGYRdS5MBrrPsXHrGeu4vfwwMpslI9CEfGSwF2oEdEVsyMBmTVAWJwOzhPZ6/Cgs
	lvU6VOsu8T1frIaIQWl43xg9WlY75S/d/o5czdB642/KRfkOjUC3dhb9fLy1kxO1CnU8MuFPhFE
	zZrgrnAIg==
X-Received: by 2002:a17:90b:3d81:b0:359:8bb5:fb3d with SMTP id 98e67ed59e1d1-3598bb5fe02mr2122543a91.6.1772417331341;
        Sun, 01 Mar 2026 18:08:51 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35987523629sm2764697a91.7.2026.03.01.18.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 18:08:50 -0800 (PST)
From: Zi-Yu Chen <zychennvt@gmail.com>
To: andi.shyti@kernel.org,
	ychuang3@nuvoton.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	zychennvt@gmail.com
Subject: [PATCH 2/3] i2c: ma35d1: Add Nuvoton MA35D1 I2C driver support
Date: Mon,  2 Mar 2026 02:08:21 +0000
Message-Id: <20260302020822.13936-3-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302020822.13936-1-zychennvt@gmail.com>
References: <20260302020822.13936-1-zychennvt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add I2C support for Nuvoton MA35D1 SoC.
The controller supports standard, fast and fast-plus modes,
and provides master/slave functionality.

Signed-off-by: Zi-Yu Chen <zychennvt@gmail.com>
---
 drivers/i2c/busses/Kconfig      |  13 +
 drivers/i2c/busses/Makefile     |   1 +
 drivers/i2c/busses/i2c-ma35d1.c | 819 ++++++++++++++++++++++++++++++++
 3 files changed, 833 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-ma35d1.c

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index e11d50750e63..6bf8be1d2575 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -1589,4 +1589,17 @@ config I2C_VIRTIO
           This driver can also be built as a module. If so, the module
           will be called i2c-virtio.
 
+config I2C_MA35D1
+	tristate "Nuvoton MA35D1 I2C driver"
+	depends on ARCH_MA35
+	select I2C_SLAVE
+	help
+	  If you say yes to this option, support will be included for the
+	  I2C controller in the Nuvoton MA35D1 SoC. This driver
+	  supports the standard I2C bus protocols, including master and
+	  slave modes.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called i2c-ma35d1.
+
 endmenu
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 547123ab351f..264f6f3f608d 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -130,6 +130,7 @@ obj-$(CONFIG_I2C_XILINX)	+= i2c-xiic.o
 obj-$(CONFIG_I2C_XLP9XX)	+= i2c-xlp9xx.o
 obj-$(CONFIG_I2C_RCAR)		+= i2c-rcar.o
 obj-$(CONFIG_I2C_GXP)		+= i2c-gxp.o
+obj-$(CONFIG_I2C_MA35D1)	+= i2c-ma35d1.o
 
 # External I2C/SMBus adapter drivers
 obj-$(CONFIG_I2C_DIOLAN_U2C)	+= i2c-diolan-u2c.o
diff --git a/drivers/i2c/busses/i2c-ma35d1.c b/drivers/i2c/busses/i2c-ma35d1.c
new file mode 100644
index 000000000000..da2707c31463
--- /dev/null
+++ b/drivers/i2c/busses/i2c-ma35d1.c
@@ -0,0 +1,819 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026 Nuvoton technology corporation.
+ *
+ * Author: Zi-Yu Chen <zychennvt@gmail.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+
+/* MA35D1 I2C registers offset */
+#define MA35_CTL0		0x00
+#define MA35_ADDR0		0x04
+#define MA35_DAT		0x08
+#define MA35_STATUS0	0x0C
+#define MA35_CLKDIV		0x10
+#define MA35_TOCTL		0x14
+#define MA35_ADDR1		0x18
+#define MA35_ADDR2		0x1C
+#define MA35_ADDR3		0x20
+#define MA35_ADDRMSK0	0x24
+#define MA35_ADDRMSK1	0x28
+#define MA35_ADDRMSK2	0x2C
+#define MA35_ADDRMSK3	0x30
+#define MA35_WKCTL		0x3C
+#define MA35_WKSTS		0x40
+#define MA35_CTL1		0x44
+#define MA35_STATUS1	0x48
+#define MA35_TMCTL		0x4C
+#define MA35_BUSCTL		0x50
+#define MA35_BUSTCTL	0x54
+#define MA35_BUSSTS		0x58
+#define MA35_PKTSIZE	0x5C
+#define MA35_PKTCRC		0x60
+#define MA35_BUSTOUT	0x64
+#define MA35_CLKTOUT	0x68
+#define MA35_AUTOCNT	0x78
+
+/* MA35D1 I2C Status */
+/* Master */
+#define MA35_M_START				0x08
+#define MA35_M_REPEAT_START			0x10	/* Master Repeat Start */
+#define MA35_M_TRAN_ADDR_ACK		0x18	/* Master Transmit Address ACK */
+#define MA35_M_TRAN_ADDR_NACK		0x20	/* Master Transmit Address NACK */
+#define MA35_M_TRAN_DATA_ACK		0x28	/* Master Transmit Data ACK */
+#define MA35_M_TRAN_DATA_NACK		0x30	/* Master Transmit Data NACK */
+#define MA35_M_ARB_LOST				0x38	/* Master Arbitration Los */
+#define MA35_M_RECE_ADDR_ACK		0x40	/* Master Receive Address ACK */
+#define MA35_M_RECE_ADDR_NACK		0x48	/* Master Receive Address NACK */
+#define MA35_M_RECE_DATA_ACK		0x50	/* Master Receive Data ACK */
+#define MA35_M_RECE_DATA_NACK		0x58	/* Master Receive Data NACK */
+#define MA35_BUS_ERROR				0x00
+
+/*  Slave */
+#define MA35_S_REPEAT_START_STOP	0xA0	/* Slave Transmit Repeat Start or Stop */
+#define MA35_S_TRAN_ADDR_ACK		0xA8	/* Slave Transmit Address ACK */
+#define MA35_S_TRAN_DATA_ACK		0xB8	/* Slave Transmit Data ACK */
+#define MA35_S_TRAN_DATA_NACK		0xC0	/* Slave Transmit Data NACK */
+#define MA35_S_TRAN_LAST_DATA_ACK	0xC8	/* Slave Transmit Last Data ACK */
+#define MA35_S_RECE_ADDR_ACK		0x60	/* Slave Receive Address ACK */
+#define MA35_S_RECE_ARB_LOST		0x68	/* Slave Receive Arbitration Lost */
+#define MA35_S_RECE_DATA_ACK		0x80	/* Slave Receive Data ACK */
+#define MA35_S_RECE_DATA_NACK		0x88	/* Slave Receive Data NACK */
+
+/* GC Mode */
+#define MA35_GC_ADDR_ACK			0x70	/* GC mode Address ACK */
+#define MA35_GC_ARB_LOST			0x78	/* GC mode Arbitration Lost */
+#define MA35_GC_DATA_ACK			0x90	/* GC mode Data ACK */
+#define MA35_GC_DATA_NACK			0x98	/* GC mode Data NACK */
+
+/* Other */
+#define MA35_ADDR_TRAN_ARB_LOST		0xB0	/* Address Transmit Arbitration Lost */
+#define MA35_BUS_RELEASED			0xF8	/* Bus Released */
+
+/*  I2C_CTL constant definitions. */
+#define MA35_CTL_AA			BIT(2)
+#define MA35_CTL_SI			BIT(3)
+#define MA35_CTL_STO		BIT(4)
+#define MA35_CTL_STA		BIT(5)
+#define MA35_CTL_I2CEN		BIT(6)
+#define MA35_CTL_INTEN		BIT(7)
+#define MA35_CTL_SI_AA		(MA35_CTL_SI | MA35_CTL_AA)
+#define MA35_CTL_STO_SI		(MA35_CTL_STO | MA35_CTL_SI)
+#define MA35_CTL_STA_SI		(MA35_CTL_STA | MA35_CTL_SI)
+#define MA35_CTL_STA_SI_AA	(MA35_CTL_STA | MA35_CTL_SI | MA35_CTL_AA)
+#define MA35_CTL_STO_SI_AA	(MA35_CTL_STO | MA35_CTL_SI | MA35_CTL_AA)
+
+#define MA35_I2C_GC_EN		1
+#define MA35_I2C_GC_DIS		0
+
+#define MA35_I2C_ADDR_MASK	(0x7f << 1)
+#define STOP_TIMEOUT_MS		50
+#define I2C_PM_TIMEOUT		5000
+
+struct ma35d1_i2c {
+	spinlock_t lock; /* Protects I2C register access and state */
+	wait_queue_head_t wait;
+	struct i2c_msg *msg;
+	unsigned int msg_num;
+	unsigned int msg_idx;
+	unsigned int msg_ptr;
+	unsigned int irq;
+	unsigned int arblost;
+	void __iomem *regs;
+	struct clk *clk;
+	struct device *dev;
+	struct i2c_adapter adap;
+	struct i2c_client *slave;
+	struct reset_control *rst;
+};
+
+static inline bool ma35d1_is_master_status(unsigned int status)
+{
+	return status >= MA35_M_START && status <= MA35_M_RECE_DATA_NACK;
+}
+
+/*
+ * ma35d1_i2c_write_CTL - Update the I2C control register
+ * @i2c: Pointer to the ma35d1 i2c instance
+ * @ctl: Control bits to set (e.g., MA35_CTL_STA, SI, AA)
+ *
+ * This helper reads CTL0, clears the sticky state-change bits (STA, STO, SI, AA),
+ * and then applies the new control bits provided by @ctl.
+ */
+static inline void ma35d1_i2c_write_CTL(struct ma35d1_i2c *i2c,
+					unsigned int ctl)
+{
+	unsigned int val;
+
+	val = readl(i2c->regs + MA35_CTL0);
+	val &= ~(MA35_CTL_STA_SI_AA | MA35_CTL_STO);
+	val |= ctl;
+	writel(val, i2c->regs + MA35_CTL0);
+}
+
+static inline void ma35d1_i2c_set_addr(struct ma35d1_i2c *i2c)
+{
+	unsigned int rw = i2c->msg->flags & I2C_M_RD;
+
+	writel(((i2c->msg->addr & 0x7f) << 1) | rw, i2c->regs + MA35_DAT);
+}
+
+static inline void ma35d1_i2c_master_complete(struct ma35d1_i2c *i2c, int ret)
+{
+	dev_dbg(i2c->dev, "master_complete %d\n", ret);
+
+	i2c->msg_ptr = 0;
+	i2c->msg = NULL;
+	i2c->msg_idx++;
+	i2c->msg_num = 0;
+	if (ret)
+		i2c->msg_idx = ret;
+
+	wake_up(&i2c->wait);
+}
+
+static inline void ma35d1_i2c_disable_irq(struct ma35d1_i2c *i2c)
+{
+	unsigned long tmp;
+
+	tmp = readl(i2c->regs + MA35_CTL0);
+	writel(tmp & ~MA35_CTL_INTEN, i2c->regs + MA35_CTL0);
+}
+
+static inline void ma35d1_i2c_enable_irq(struct ma35d1_i2c *i2c)
+{
+	unsigned long tmp;
+
+	tmp = readl(i2c->regs + MA35_CTL0);
+	writel(tmp | MA35_CTL_INTEN, i2c->regs + MA35_CTL0);
+}
+
+static void ma35d1_i2c_message_start(struct ma35d1_i2c *i2c)
+{
+	ma35d1_i2c_write_CTL(i2c, MA35_CTL_SI | MA35_CTL_STA);
+}
+
+static inline void ma35d1_i2c_reset(struct ma35d1_i2c *i2c)
+{
+	unsigned int tmp;
+
+	tmp = readl(i2c->regs + MA35_CLKDIV);
+
+	reset_control_assert(i2c->rst);
+	usleep_range(10, 20);
+	reset_control_deassert(i2c->rst);
+
+	writel(tmp, (i2c->regs + MA35_CLKDIV));
+	ma35d1_i2c_write_CTL(i2c, MA35_CTL_I2CEN);
+
+	if (i2c->slave)
+		ma35d1_i2c_write_CTL(i2c, MA35_CTL_SI_AA);
+}
+
+static inline void ma35d1_i2c_stop(struct ma35d1_i2c *i2c, int ret)
+{
+	unsigned int val;
+	int err;
+
+	/* Ensure AA is cleared to prevent the master
+	 * from re-claiming the bus unnecessarily
+	 */
+	if (readl(i2c->regs + MA35_CTL0) & MA35_CTL_AA) {
+		val = readl(i2c->regs + MA35_CTL0);
+		val &= ~MA35_CTL_AA;
+		writel(val, (i2c->regs + MA35_CTL0));
+
+		err = readl_poll_timeout_atomic(i2c->regs + MA35_CTL0, val,
+						!(val & MA35_CTL_AA), 1, 1000);
+		if (err)
+			dev_warn(i2c->dev,
+				 "AA bit could not be cleared in time\n");
+	}
+
+	ma35d1_i2c_write_CTL(i2c, MA35_CTL_STO_SI);
+
+	err = readl_poll_timeout_atomic(i2c->regs + MA35_CTL0, val,
+					!(val & MA35_CTL_STO), 1, 1 * 1000);
+	if (err)
+		dev_warn(i2c->dev, "I2C Stop Timeout\n");
+
+	if (i2c->slave)
+		ma35d1_i2c_write_CTL(i2c, MA35_CTL_SI_AA);
+	else
+		ma35d1_i2c_disable_irq(i2c);
+
+	ma35d1_i2c_master_complete(i2c, ret);
+}
+
+/* Check if this is the last message in the set */
+static inline bool is_last_msg(struct ma35d1_i2c *i2c)
+{
+	return i2c->msg_idx >= (i2c->msg_num - 1);
+}
+
+/* Check if this is the last byte in the current message */
+static inline bool is_last_byte(struct ma35d1_i2c *i2c)
+{
+	return i2c->msg_ptr == i2c->msg->len - 1;
+}
+
+/* Check if reached the end of the current message */
+static inline bool is_msgend(struct ma35d1_i2c *i2c)
+{
+	return i2c->msg_ptr >= i2c->msg->len;
+}
+
+/*
+ * i2c_ma35d1_irq_slave_trx - I2C Slave state machine handler
+ * @i2c: ma35d1 i2c instance
+ * @i2c_status: hardware status code from MA35_STATUS0
+ */
+static void i2c_ma35d1_irq_slave_trx(struct ma35d1_i2c *i2c,
+				     unsigned long i2c_status)
+{
+	unsigned char byte;
+
+	switch (i2c_status) {
+	case MA35_S_RECE_ADDR_ACK:
+		/* Own SLA+W has been receive; ACK has been return */
+		i2c_slave_event(i2c->slave, I2C_SLAVE_WRITE_REQUESTED, &byte);
+		break;
+	case MA35_S_TRAN_DATA_NACK:
+	/* Data byte or last data in I2CDAT has been transmitted.
+	 * Not ACK has been received
+	 */
+	case MA35_S_RECE_DATA_NACK:
+	/* Previously addressed with own SLA address;
+	 * NOT ACK has been returned
+	 */
+		break;
+
+	case MA35_S_RECE_DATA_ACK:
+		/* Previously address with own SLA address Data has been received;
+		 * ACK has been returned
+		 */
+		byte = readb(i2c->regs + MA35_DAT);
+		i2c_slave_event(i2c->slave, I2C_SLAVE_WRITE_RECEIVED, &byte);
+		break;
+
+	case MA35_S_TRAN_ADDR_ACK:
+		/* Own SLA+R has been receive; ACK has been return */
+		i2c_slave_event(i2c->slave, I2C_SLAVE_READ_REQUESTED, &byte);
+
+		writel(byte, i2c->regs + MA35_DAT);
+		break;
+
+	case MA35_S_TRAN_DATA_ACK:
+		i2c_slave_event(i2c->slave, I2C_SLAVE_READ_PROCESSED, &byte);
+		writel(byte, i2c->regs + MA35_DAT);
+		break;
+
+	case MA35_S_REPEAT_START_STOP:
+		/* A STOP or repeated START has been received
+		 *	while still addressed as Slave/Receiver
+		 */
+		i2c_slave_event(i2c->slave, I2C_SLAVE_STOP, &byte);
+		break;
+
+	default:
+		dev_err(i2c->dev, "Status 0x%02lx is NOT processed\n",
+			i2c_status);
+		break;
+	}
+	ma35d1_i2c_write_CTL(i2c, MA35_CTL_SI_AA);
+}
+
+/*
+ * i2c_ma35d1_irq_master_trx - I2C Master state machine handler
+ * @i2c: ma35d1 i2c instance
+ * @i2c_status: hardware status code from MA35_STATUS0
+ */
+static void i2c_ma35d1_irq_master_trx(struct ma35d1_i2c *i2c,
+				      unsigned long i2c_status)
+{
+	unsigned char byte;
+
+	switch (i2c_status) {
+	case MA35_M_START:
+	case MA35_M_REPEAT_START:
+		ma35d1_i2c_set_addr(i2c);
+		ma35d1_i2c_write_CTL(i2c, MA35_CTL_SI);
+		break;
+
+	case MA35_M_TRAN_ADDR_ACK:
+	case MA35_M_TRAN_DATA_ACK:
+		/* SLA+W has been transmitted and ACK has been received */
+		if (i2c_status == MA35_M_TRAN_ADDR_ACK) {
+			if (is_last_msg(i2c) && i2c->msg->len == 0) {
+				ma35d1_i2c_stop(i2c, 0);
+				return;
+			}
+		}
+
+		if (!is_msgend(i2c)) {
+			byte = i2c->msg->buf[i2c->msg_ptr++];
+			writel(byte, i2c->regs + MA35_DAT);
+			ma35d1_i2c_write_CTL(i2c, MA35_CTL_SI);
+		} else if (!is_last_msg(i2c)) {
+			dev_dbg(i2c->dev, "WRITE: Next Message\n");
+
+			i2c->msg_ptr = 0;
+			i2c->msg_idx++;
+			i2c->msg++;
+
+			ma35d1_i2c_write_CTL(i2c, MA35_CTL_STA | MA35_CTL_SI);
+		} else {
+			ma35d1_i2c_stop(i2c, 0);
+		}
+		break;
+
+	case MA35_M_TRAN_DATA_NACK:
+		ma35d1_i2c_stop(i2c, 0);
+		break;
+
+	case MA35_M_TRAN_ADDR_NACK:
+	case MA35_M_RECE_ADDR_NACK:
+		/* Master Transmit Address NACK */
+		/* 0x20: SLA+W has been transmitted and NACK has been received */
+		/* 0x48: SLA+R has been transmitted and NACK has been received */
+		if (!(i2c->msg->flags & I2C_M_IGNORE_NAK)) {
+			dev_dbg(i2c->dev, "\n i2c: ack was not received\n");
+			ma35d1_i2c_stop(i2c, -ENXIO);
+		}
+		break;
+
+	case MA35_M_RECE_ADDR_ACK:
+		if (is_last_msg(i2c) && i2c->msg->len == 0)
+			ma35d1_i2c_stop(i2c, 0);
+		else if (is_last_msg(i2c) && (i2c->msg->len == 1))
+			ma35d1_i2c_write_CTL(i2c, MA35_CTL_SI);
+		else
+			ma35d1_i2c_write_CTL(i2c, MA35_CTL_SI_AA);
+		break;
+
+	case MA35_M_RECE_DATA_ACK:
+	case MA35_M_RECE_DATA_NACK:
+		/* DATA has been transmitted and ACK has been received */
+		byte = readb(i2c->regs + MA35_DAT);
+		i2c->msg->buf[i2c->msg_ptr++] = byte;
+
+		if (is_last_byte(i2c)) {
+			ma35d1_i2c_write_CTL(i2c, MA35_CTL_SI);
+		} else if (is_msgend(i2c)) {
+			if (is_last_msg(i2c)) {
+				dev_dbg(i2c->dev, "READ: Send Stop\n");
+
+				ma35d1_i2c_stop(i2c, 0);
+			} else {
+				dev_dbg(i2c->dev, "READ: Next Transfer\n");
+
+				i2c->msg_ptr = 0;
+				i2c->msg_idx++;
+				i2c->msg++;
+
+				ma35d1_i2c_write_CTL(i2c, MA35_CTL_STA_SI);
+			}
+		} else {
+			ma35d1_i2c_write_CTL(i2c, MA35_CTL_SI_AA);
+		}
+		break;
+
+	default:
+		dev_err(i2c->dev, "Status 0x%02lx is NOT processed\n",
+			i2c_status);
+		ma35d1_i2c_disable_irq(i2c);
+		ma35d1_i2c_stop(i2c, 0);
+		break;
+	}
+}
+
+static irqreturn_t ma35d1_i2c_irq(int irqno, void *dev_id)
+{
+	struct ma35d1_i2c *i2c = dev_id;
+	unsigned long status, flags;
+
+	status = readl(i2c->regs + MA35_STATUS0);
+
+	spin_lock_irqsave(&i2c->lock, flags);
+
+	if (status == MA35_M_ARB_LOST) {
+		dev_err(i2c->dev, "Arbitration lost\n");
+		i2c->arblost = 1;
+
+		ma35d1_i2c_disable_irq(i2c);
+		ma35d1_i2c_stop(i2c, -EAGAIN);
+		goto out;
+	}
+
+	else if (status == MA35_BUS_ERROR) {
+		dev_err(i2c->dev, "IRQ: error i2c->state == IDLE\n");
+		ma35d1_i2c_disable_irq(i2c);
+		ma35d1_i2c_stop(i2c, 0);
+		goto out;
+	}
+
+	if (ma35d1_is_master_status(status))
+		i2c_ma35d1_irq_master_trx(i2c, status);
+	else
+		i2c_ma35d1_irq_slave_trx(i2c, status);
+
+out:
+	spin_unlock_irqrestore(&i2c->lock, flags);
+	return IRQ_HANDLED;
+}
+
+static int ma35d1_i2c_doxfer(struct ma35d1_i2c *i2c, struct i2c_msg *msgs,
+			     int num)
+{
+	unsigned long timeout;
+	unsigned int val;
+	int ret, err;
+
+	spin_lock_irq(&i2c->lock);
+
+	ma35d1_i2c_enable_irq(i2c);
+
+	i2c->msg = msgs;
+	i2c->msg_num = num;
+	i2c->msg_ptr = 0;
+	i2c->msg_idx = 0;
+
+	ma35d1_i2c_message_start(i2c);
+	spin_unlock_irq(&i2c->lock);
+
+	timeout = wait_event_timeout(i2c->wait, i2c->msg_num == 0, HZ * 5);
+	ret = i2c->msg_idx;
+
+	if (timeout == 0)
+		dev_dbg(i2c->dev, "timeout\n");
+	else if (ret != num)
+		dev_dbg(i2c->dev, "incomplete xfer (%d)\n", ret);
+
+	err = readl_poll_timeout(i2c->regs + MA35_CTL0, val,
+				 !(val & MA35_CTL_STO), 100,
+				 STOP_TIMEOUT_MS * 1000);
+
+	if (err) {
+		dev_err(i2c->dev, "Bus stuck! Resetting controller...\n");
+		ma35d1_i2c_reset(i2c);
+	}
+
+	if (i2c->arblost) {
+		dev_dbg(i2c->dev, "arb lost, stop\n");
+		i2c->arblost = 0;
+	}
+
+	return ret;
+}
+
+static int ma35d1_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
+			   int num)
+{
+	struct ma35d1_i2c *i2c = i2c_get_adapdata(adap);
+	int retry, ret;
+
+	ret = pm_runtime_resume_and_get(i2c->dev);
+	if (ret < 0)
+		return ret;
+
+	for (retry = 0; retry < adap->retries; retry++) {
+		ret = ma35d1_i2c_doxfer(i2c, msgs, num);
+
+		if (ret != -EAGAIN)
+			break;
+
+		dev_dbg(i2c->dev, "Retrying transmission (%d)\n", retry);
+		fsleep(100);
+	}
+
+	if (ret == -EAGAIN)
+		ret = -EREMOTEIO;
+
+	pm_runtime_put_autosuspend(i2c->dev);
+
+	return ret;
+}
+
+static int ma35d1_reg_slave(struct i2c_client *slave)
+{
+	struct ma35d1_i2c *i2c = i2c_get_adapdata(slave->adapter);
+	unsigned int val, slvaddr;
+	int ret;
+
+	if (i2c->slave)
+		return -EBUSY;
+
+	if (slave->flags & I2C_CLIENT_TEN)
+		return -EAFNOSUPPORT;
+
+	ma35d1_i2c_enable_irq(i2c);
+
+	ret = pm_runtime_resume_and_get(i2c->dev);
+	if (ret < 0) {
+		dev_err(i2c->dev, "failed to resume i2c controller\n");
+		return ret;
+	}
+
+	i2c->slave = slave;
+
+	val = readl(i2c->regs + MA35_CTL0);
+	val |= MA35_CTL_I2CEN;
+	writel(val, i2c->regs + MA35_CTL0);
+	slvaddr = slave->addr << 1;
+	writel(slvaddr, i2c->regs + MA35_ADDR0);
+
+	/* I2C enter SLV mode */
+	ma35d1_i2c_write_CTL(i2c, MA35_CTL_SI_AA);
+
+	return 0;
+}
+
+static int ma35d1_unreg_slave(struct i2c_client *slave)
+{
+	struct ma35d1_i2c *i2c = i2c_get_adapdata(slave->adapter);
+	unsigned int val;
+	int ret;
+
+	/* Disable I2C */
+	val = readl(i2c->regs + MA35_CTL0);
+	val &= ~MA35_CTL_I2CEN;
+	writel(val, i2c->regs + MA35_CTL0);
+
+	/* Disable I2C interrupt */
+	ma35d1_i2c_disable_irq(i2c);
+
+	i2c->slave = NULL;
+
+	ret = pm_runtime_put_sync(i2c->dev);
+	if (ret < 0)
+		dev_err(i2c->dev, "failed to suspend i2c controller");
+
+	return 0;
+}
+
+/* Declare Our I2C Functionality */
+static u32 ma35d1_i2c_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_PROTOCOL_MANGLING | I2C_FUNC_SMBUS_EMUL;
+}
+
+/* I2C Bus Registration Info */
+
+static const struct i2c_algorithm ma35d1_i2c_algorithm = {
+	.master_xfer = ma35d1_i2c_xfer,
+	.functionality = ma35d1_i2c_func,
+	.reg_slave = ma35d1_reg_slave,
+	.unreg_slave = ma35d1_unreg_slave,
+};
+
+static int ma35d1_i2c_probe(struct platform_device *pdev)
+{
+	struct ma35d1_i2c *i2c;
+	struct resource *res;
+	int ret, clkdiv;
+	unsigned int busfreq;
+	struct device *dev = &pdev->dev;
+
+	i2c = devm_kzalloc(dev, sizeof(*i2c), GFP_KERNEL);
+	if (!i2c)
+		return -ENOMEM;
+
+	spin_lock_init(&i2c->lock);
+	init_waitqueue_head(&i2c->wait);
+
+	i2c->dev = dev;
+
+	i2c->clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(i2c->clk))
+		return dev_err_probe(dev, PTR_ERR(i2c->clk),
+				     "failed to get core clk\n");
+
+	i2c->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(i2c->regs))
+		return PTR_ERR(i2c->regs);
+
+	i2c->rst = devm_reset_control_get(&pdev->dev, NULL);
+	if (IS_ERR(i2c->rst))
+		return dev_err_probe(dev, PTR_ERR(i2c->rst),
+				     "failed to get reset control\n");
+
+	/* Setup info block for the I2C core */
+	strscpy(i2c->adap.name, "ma35d1-i2c", sizeof(i2c->adap.name));
+	i2c->adap.owner = THIS_MODULE;
+	i2c->adap.algo = &ma35d1_i2c_algorithm;
+	i2c->adap.retries = 2;
+	i2c->adap.algo_data = i2c;
+	i2c->adap.dev.parent = &pdev->dev;
+	i2c->adap.dev.of_node = pdev->dev.of_node;
+	i2c_set_adapdata(&i2c->adap, i2c);
+
+	ret = of_property_read_u32(pdev->dev.of_node, "clock-frequency",
+				   &busfreq);
+	if (ret) {
+		dev_err(i2c->dev, "clock-frequency not specified in DT\n");
+		return ret;
+	}
+
+	/* Calculate divider based on the current peripheral clock rate */
+	clkdiv = DIV_ROUND_CLOSEST(clk_get_rate(i2c->clk), busfreq * 4) - 1;
+	if (clkdiv < 0 || clkdiv > 0xffff) {
+		dev_err(dev, "invalid clkdiv value: %d\n", clkdiv);
+		return -EINVAL;
+	}
+
+	i2c->irq = platform_get_irq(pdev, 0);
+	if (i2c->irq < 0)
+		return i2c->irq;
+
+	platform_set_drvdata(pdev, i2c);
+
+	pm_runtime_set_autosuspend_delay(dev, I2C_PM_TIMEOUT);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0)
+		goto rpm_disable;
+
+	writel(clkdiv & 0xffff, i2c->regs + MA35_CLKDIV);
+
+	ret = devm_request_irq(dev, i2c->irq, ma35d1_i2c_irq, IRQF_SHARED,
+			       dev_name(dev), i2c);
+
+	if (ret != 0) {
+		dev_err(dev, "cannot claim IRQ %d\n", i2c->irq);
+		goto rpm_disable;
+	}
+
+	/* Give it another chance if pinctrl used is not ready yet */
+	if (ret == -EPROBE_DEFER)
+		goto rpm_disable;
+
+	ret = i2c_add_adapter(&i2c->adap);
+	if (ret) {
+		dev_err(dev, "failed to add bus to i2c core: %d\n", ret);
+		goto rpm_disable;
+	}
+
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+
+rpm_disable:
+	pm_runtime_put_noidle(dev);
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_dont_use_autosuspend(dev);
+	return ret;
+}
+
+static void ma35d1_i2c_remove(struct platform_device *pdev)
+{
+	struct ma35d1_i2c *i2c = platform_get_drvdata(pdev);
+
+	i2c_del_adapter(&i2c->adap);
+	pm_runtime_disable(&pdev->dev);
+}
+
+static int ma35d1_i2c_suspend(struct device *dev)
+{
+	struct ma35d1_i2c *i2c = dev_get_drvdata(dev);
+	unsigned int val;
+
+	spin_lock_irq(&i2c->lock);
+
+	/* Prepare for wake-up from I2C events if slave mode is active */
+	if (i2c->slave) {
+		val = readl(i2c->regs + MA35_CTL0);
+		val |= (MA35_CTL_SI | MA35_CTL_AA);
+		writel(val, i2c->regs + MA35_CTL0);
+		ma35d1_i2c_enable_irq(i2c);
+	}
+
+	spin_unlock_irq(&i2c->lock);
+
+	/* Setup wake-up control */
+	writel(0x1, i2c->regs + MA35_WKCTL);
+
+	/* Clear pending wake-up flags */
+	val = readl(i2c->regs + MA35_WKSTS);
+	writel(val, i2c->regs + MA35_WKSTS);
+
+	enable_irq_wake(i2c->irq);
+
+	return 0;
+}
+
+static int ma35d1_i2c_resume(struct device *dev)
+{
+	struct ma35d1_i2c *i2c = dev_get_drvdata(dev);
+	unsigned int val;
+
+	/* Disable wake-up */
+	writel(0x0, i2c->regs + MA35_WKCTL);
+
+	/* Clear pending wake-up flags */
+	val = readl(i2c->regs + MA35_WKSTS);
+	writel(val, i2c->regs + MA35_WKSTS);
+
+	disable_irq_wake(i2c->irq);
+	return 0;
+}
+
+static int ma35d1_i2c_runtime_suspend(struct device *dev)
+{
+	struct ma35d1_i2c *i2c = dev_get_drvdata(dev);
+	unsigned int val;
+
+	/* Disable I2C controller */
+	val = readl(i2c->regs + MA35_CTL0);
+	val &= ~MA35_CTL_I2CEN;
+	writel(val, i2c->regs + MA35_CTL0);
+
+	clk_disable_unprepare(i2c->clk);
+
+	return 0;
+}
+
+static int ma35d1_i2c_runtime_resume(struct device *dev)
+{
+	struct ma35d1_i2c *i2c = dev_get_drvdata(dev);
+	unsigned int val;
+	int ret;
+
+	ret = clk_prepare_enable(i2c->clk);
+	if (ret) {
+		dev_err(dev, "failed to enable clock in resume\n");
+		return ret;
+	}
+
+	/* Enable I2C controller */
+	val = readl(i2c->regs + MA35_CTL0);
+	val |= MA35_CTL_I2CEN;
+	writel(val, i2c->regs + MA35_CTL0);
+
+	return 0;
+}
+
+static const struct dev_pm_ops ma35d1_i2c_pmops = {
+	SYSTEM_SLEEP_PM_OPS(ma35d1_i2c_suspend, ma35d1_i2c_resume)
+		RUNTIME_PM_OPS(ma35d1_i2c_runtime_suspend,
+			       ma35d1_i2c_runtime_resume, NULL)
+};
+
+static const struct of_device_id ma35d1_i2c_of_match[] = {
+	{ .compatible = "nuvoton,ma35d1-i2c" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ma35d1_i2c_of_match);
+
+static struct platform_driver ma35d1_i2c_driver = {
+	.probe      = ma35d1_i2c_probe,
+	.remove     = ma35d1_i2c_remove,
+	.driver     = {
+		.name   = "ma35d1-i2c",
+		.owner  = THIS_MODULE,
+		.of_match_table = ma35d1_i2c_of_match,
+		.pm = pm_ptr(&ma35d1_i2c_pmops),
+	},
+};
+module_platform_driver(ma35d1_i2c_driver);
+
+MODULE_AUTHOR("Zi-Yu Chen <zychennvt@gmail.com>");
+MODULE_DESCRIPTION("MA35D1 I2C Bus Driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

