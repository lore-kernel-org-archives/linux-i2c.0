Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB47333F38E
	for <linux-i2c@vger.kernel.org>; Wed, 10 Jun 2026 03:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781060669; cv=none; b=HgIMhwxLoJeSZ82k9VuVjND131u0rAkszl8k99JPzxbkNL7ddQPZXVmnPqnqthYEqdG7JgB5bSYbnK27azHc1dDTcBna3geSlVb94ePefxkVKjCrCQ0ba+iwuDrBPRFuWmGV5nLJavDdadhvc/kdV9mnbHMvJ1+EQqVdgHmcgXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781060669; c=relaxed/simple;
	bh=yCL6MBzE7Dl/5EbAPIFF4LGA9zZhCccJ8X4uijmiQ/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gsLp+uoHnFvTtAN9XrQ46cxBoEhQVFrP5qFz/Uo3Jcf73QDKjDAO2qReXjPNR8OhrccMPis4sdh8BD9DwsR5mLhAWPHb4gFbGH+fnb2a6Mhg//w/tUNOzeaI1KYGIMA8gQhNYmCU/GT8ODVUQtELglIk4BMjJVr2Wt01DqNVcFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJJ1Hy0S; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJJ1Hy0S"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c85b2139015so2143513a12.2
        for <linux-i2c@vger.kernel.org>; Tue, 09 Jun 2026 20:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781060667; x=1781665467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5Hc/tjqdVuOb4b4/ulXL7QCu2jXkperHgbFn9acRJE=;
        b=ZJJ1Hy0S5LaTani4/lg6vWLWd66kq+RZSuhhAZz+j+fRISTN8yTB8aOu26YjSBXIrK
         /B43dcp32mqoBeOq57jhMjLPb10Qayx/+qFN1V6XpdfD2i0dcL1HK57V1XDOUV4ZNyBw
         CPmFXAQ78lNsuZGDPpUcAACdHVg+q2/sXgOkFGy/tCOu0TgNJA76UkSLqw3EfMatr67y
         icp1Ka8Q7zsiF+TZWVM8sS1TXjpOalSAf+1OR5ib718kbnUlHMFERUL41wkjF0zaLPbh
         vtkwYDBre6+o9cUiozOfNJvKJCNHfOEXizkspAfpjkpclyFoCpFTy4o2psD/yAX3zgjY
         bZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781060667; x=1781665467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F5Hc/tjqdVuOb4b4/ulXL7QCu2jXkperHgbFn9acRJE=;
        b=b/5CobMsYxlw+U35IAHVzdP79U6kNMVsb7gG8paOhbUeNSKJ7pe+Vwpzm1kZaYkMiA
         v5ymkeX/9+V0F73A0YZpasqQMllvgKCQpTPDxDZDRf5LIvNaR7WRRURjmOYI6+/Yo9nP
         fv+/CMuDb5Yvf18WydwNNyAGMS2s5wEYcoN6VuGqoqqKfQLLJv59bOappif/yYtcUYiy
         7hJv4El/hWOk1istsqKOMO7hsPZq+e/4lWKbHXLRwdJZ82Nx0we3iCzgjTvKGvw21eTC
         SXE02czypNorLgx0iMKoqt4UbSEuPlslZUaHX+m59O9tXkpmFG6lYCG0/5GSm7jDDFxP
         JXgA==
X-Forwarded-Encrypted: i=1; AFNElJ989EUc/+jk93YsWnch/6esHH0TsKPV9CjG+49bNDc6I3BdIbb+A2yEYQtQnsdGOIY8pBtkkT/hqZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz7JCTeP6H5BbtAhjdGOiFfil5OPRW00vBOAJdGjC6hIjhJFa/
	Z+HbSY7y23r9DnYl0xFXn/Jqh0bffwduC4M7BxCNFO+mrKhLP7tcsuh8
X-Gm-Gg: Acq92OGsZJJ6iJQMN1FKM6kngyFG7sG9WLFMG5AWTPx8gdHQAh83pKoi1CDMinRg9e9
	9Cjs3dXZMMsUXeZxDMIn8ywi+VcpWVqn7NlHRn+WPPyWXmdQzaKaH/DXtp+bC0ilxqkhnh06N3y
	SJJ3cQNwHPrJmHtgIwSt2DqKqN3F01NkSzb9BbYK9SSC/oGmXHHPWrwVerF4v+tb05xdfvz4qid
	Wcsx2N1VnqrazkU1DE3xn3cGCuXMGSLNY38fDqaSIiAloia8v/+zoc2TZF+oDv/sQSR6uen1qpu
	lKT2woeSCTJ88QyX0B2N981JTvq4yUS+VvxQl1CFJRZ96DbBjqjf9KOf8GJe+AMEujh+DOT93SL
	CTbBNjGa0QRwEqifl8nau5t7aXRijoalHlWy4SEqzlRz77u3iHQVg+8b77A+0AaEKdEtwI1thfx
	SwZw+38lOI8hRBxSu6iI5KwzRWYbn1cAby8RmduWXDjruN5dk16biqkyax0XJKmrvGQMVITpYlZ
	LrU4LEHpQd7BDXqf+jeLNP72rJclvo=
X-Received: by 2002:a05:6a21:a345:b0:39c:787:f197 with SMTP id adf61e73a8af0-3b53beb47c6mr7646315637.36.1781060666860;
        Tue, 09 Jun 2026 20:04:26 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a61b3sm19927082a12.17.2026.06.09.20.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 20:04:26 -0700 (PDT)
From: Zi-Yu Chen <zychennvt@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zi-Yu Chen <zychennvt@gmail.com>
Subject: [PATCH v4 2/3] i2c: ma35d1: Add Nuvoton MA35D1 I2C driver support
Date: Wed, 10 Jun 2026 11:02:07 +0800
Message-Id: <20260610030208.2020275-3-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610030208.2020275-1-zychennvt@gmail.com>
References: <20260610030208.2020275-1-zychennvt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add I2C support for Nuvoton MA35D1 SoC.
The controller supports standard, fast and fast-plus modes,
and provides controller/target functionality.

Signed-off-by: Zi-Yu Chen <zychennvt@gmail.com>
---
 drivers/i2c/busses/Kconfig      |  13 +
 drivers/i2c/busses/Makefile     |   1 +
 drivers/i2c/busses/i2c-ma35d1.c | 778 ++++++++++++++++++++++++++++++++
 3 files changed, 792 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-ma35d1.c

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 8c935f867a37..816c55814ed4 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -1590,4 +1590,17 @@ config I2C_VIRTIO
           This driver can also be built as a module. If so, the module
           will be called i2c-virtio.
 
+config I2C_MA35D1
+	tristate "Nuvoton MA35D1 I2C driver"
+	depends on ARCH_MA35 || COMPILE_TEST
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
index 000000000000..7b6b20c0996d
--- /dev/null
+++ b/drivers/i2c/busses/i2c-ma35d1.c
@@ -0,0 +1,778 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026 Nuvoton technology corporation.
+ *
+ * Author: Zi-Yu Chen <zychennvt@gmail.com>
+ */
+
+#include <linux/bitfield.h>
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
+#include <linux/property.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+
+/* MA35D1 I2C registers offset */
+#define MA35_CTL0		0x00
+#define MA35_ADDR0		0x04
+#define MA35_DAT		0x08
+#define MA35_STATUS0	0x0c
+#define MA35_CLKDIV		0x10
+#define MA35_TOCTL		0x14
+#define MA35_ADDR1		0x18
+#define MA35_ADDR2		0x1c
+#define MA35_ADDR3		0x20
+#define MA35_ADDRMSK0	0x24
+#define MA35_ADDRMSK1	0x28
+#define MA35_ADDRMSK2	0x2c
+#define MA35_ADDRMSK3	0x30
+#define MA35_WKCTL		0x3c
+#define MA35_WKSTS		0x40
+#define MA35_CTL1		0x44
+#define MA35_STATUS1	0x48
+#define MA35_TMCTL		0x4c
+#define MA35_BUSCTL		0x50
+#define MA35_BUSTCTL	0x54
+#define MA35_BUSSTS		0x58
+#define MA35_PKTSIZE	0x5c
+#define MA35_PKTCRC		0x60
+#define MA35_BUSTOUT	0x64
+#define MA35_CLKTOUT	0x68
+#define MA35_AUTOCNT	0x78
+
+/* MA35D1 I2C Status */
+/* Controller */
+#define MA35_M_START				0x08	/* Start */
+#define MA35_M_REPEAT_START			0x10	/* Controller Repeat Start */
+#define MA35_M_TRAN_ADDR_ACK		0x18	/* Controller Transmit Address ACK */
+#define MA35_M_TRAN_ADDR_NACK		0x20	/* Controller Transmit Address NACK */
+#define MA35_M_TRAN_DATA_ACK		0x28	/* Controller Transmit Data ACK */
+#define MA35_M_TRAN_DATA_NACK		0x30	/* Controller Transmit Data NACK */
+#define MA35_M_ARB_LOST				0x38	/* Controller Arbitration Lost */
+#define MA35_M_RECE_ADDR_ACK		0x40	/* Controller Receive Address ACK */
+#define MA35_M_RECE_ADDR_NACK		0x48	/* Controller Receive Address NACK */
+#define MA35_M_RECE_DATA_ACK		0x50	/* Controller Receive Data ACK */
+#define MA35_M_RECE_DATA_NACK		0x58	/* Controller Receive Data NACK */
+#define MA35_BUS_ERROR				0x00	/* Bus error */
+
+/*  Target */
+#define MA35_S_REPEAT_START_STOP	0xa0	/* Target Transmit Repeat Start or Stop */
+#define MA35_S_TRAN_ADDR_ACK		0xa8	/* Target Transmit Address ACK */
+#define MA35_S_TRAN_DATA_ACK		0xb8	/* Target Transmit Data ACK */
+#define MA35_S_TRAN_DATA_NACK		0xc0	/* Target Transmit Data NACK */
+#define MA35_S_TRAN_LAST_DATA_ACK	0xc8	/* Target Transmit Last Data ACK */
+#define MA35_S_RECE_ADDR_ACK		0x60	/* Target Receive Address ACK */
+#define MA35_S_RECE_ARB_LOST		0x68	/* Target Receive Arbitration Lost */
+#define MA35_S_RECE_DATA_ACK		0x80	/* Target Receive Data ACK */
+#define MA35_S_RECE_DATA_NACK		0x88	/* Target Receive Data NACK */
+
+/* GC Mode */
+#define MA35_GC_ADDR_ACK			0x70	/* GC mode Address ACK */
+#define MA35_GC_ARB_LOST			0x78	/* GC mode Arbitration Lost */
+#define MA35_GC_DATA_ACK			0x90	/* GC mode Data ACK */
+#define MA35_GC_DATA_NACK			0x98	/* GC mode Data NACK */
+
+/* Other */
+#define MA35_ADDR_TRAN_ARB_LOST		0xb0	/* Address Transmit Arbitration Lost */
+#define MA35_BUS_RELEASED			0xf8	/* Bus Released */
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
+/* Constants */
+#define MA35_CLKDIV_MSK		GENMASK(15, 0)
+#define MA35_I2C_ADDR_MASK	(0x7f << 1)
+#define I2C_PM_TIMEOUT_MS	5000
+#define STOP_TIMEOUT_MS		50
+#define MA35_I2C_GC_EN		1
+#define MA35_I2C_GC_DIS		0
+
+struct ma35d1_i2c {
+	wait_queue_head_t wait;
+	struct i2c_msg *msg;
+	unsigned int msg_num;
+	unsigned int msg_idx;
+	unsigned int msg_ptr;
+	int err;
+	int irq;
+	void __iomem *regs;
+	struct clk *clk;
+	struct device *dev;
+	struct i2c_adapter adap;
+	struct i2c_client *target;
+	struct reset_control *rst;
+};
+
+static inline bool ma35d1_is_controller_status(unsigned int status)
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
+static void ma35d1_i2c_write_CTL(struct ma35d1_i2c *i2c, unsigned int ctl)
+{
+	unsigned int val;
+
+	val = readl(i2c->regs + MA35_CTL0);
+	val &= ~(MA35_CTL_STA_SI_AA | MA35_CTL_STO);
+	val |= ctl;
+	writel(val, i2c->regs + MA35_CTL0);
+}
+
+static void ma35d1_i2c_set_addr(struct ma35d1_i2c *i2c)
+{
+	unsigned int rw = i2c->msg->flags & I2C_M_RD;
+
+	writel(((i2c->msg->addr & 0x7f) << 1) | rw, i2c->regs + MA35_DAT);
+}
+
+static void ma35d1_i2c_controller_complete(struct ma35d1_i2c *i2c)
+{
+	dev_dbg(i2c->dev, "controller_complete\n");
+
+	i2c->msg_ptr = 0;
+	i2c->msg = NULL;
+	i2c->msg_idx++;
+	i2c->msg_num = 0;
+
+	wake_up(&i2c->wait);
+}
+
+static void ma35d1_i2c_disable_irq(struct ma35d1_i2c *i2c)
+{
+	unsigned long tmp;
+
+	tmp = readl(i2c->regs + MA35_CTL0);
+	writel(tmp & ~MA35_CTL_INTEN, i2c->regs + MA35_CTL0);
+}
+
+static void ma35d1_i2c_enable_irq(struct ma35d1_i2c *i2c)
+{
+	unsigned long tmp;
+
+	tmp = readl(i2c->regs + MA35_CTL0);
+	writel(tmp | MA35_CTL_INTEN, i2c->regs + MA35_CTL0);
+}
+
+static void ma35d1_i2c_reset(struct ma35d1_i2c *i2c)
+{
+	unsigned int clkdiv, slvaddr;
+
+	clkdiv = readl(i2c->regs + MA35_CLKDIV);
+	slvaddr = readl(i2c->regs + MA35_ADDR0);
+
+	reset_control_assert(i2c->rst);
+	reset_control_deassert(i2c->rst);
+
+	writel(clkdiv, (i2c->regs + MA35_CLKDIV));
+	ma35d1_i2c_write_CTL(i2c, MA35_CTL_I2CEN);
+
+	if (i2c->target)
+		writel(slvaddr, i2c->regs + MA35_ADDR0);
+}
+
+static void ma35d1_i2c_stop(struct ma35d1_i2c *i2c, int ret)
+{
+	ma35d1_i2c_write_CTL(i2c, MA35_CTL_STO_SI);
+
+	if (ret)
+		i2c->err = ret;
+
+	ma35d1_i2c_controller_complete(i2c);
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
+ * i2c_ma35d1_irq_target_trx - I2C Target state machine handler
+ * @i2c: ma35d1 i2c instance
+ * @i2c_status: hardware status code from MA35_STATUS0
+ */
+static void i2c_ma35d1_irq_target_trx(struct ma35d1_i2c *i2c,
+				      unsigned long i2c_status)
+{
+	unsigned char byte;
+
+	switch (i2c_status) {
+	case MA35_S_RECE_ADDR_ACK:
+		/* Own SLA+W has been receive; ACK has been return */
+		i2c_slave_event(i2c->target, I2C_SLAVE_WRITE_REQUESTED, &byte);
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
+		i2c_slave_event(i2c->target, I2C_SLAVE_WRITE_RECEIVED, &byte);
+		break;
+
+	case MA35_S_TRAN_ADDR_ACK:
+		/* Own SLA+R has been receive; ACK has been return */
+		i2c_slave_event(i2c->target, I2C_SLAVE_READ_REQUESTED, &byte);
+
+		writel(byte, i2c->regs + MA35_DAT);
+		break;
+
+	case MA35_S_TRAN_DATA_ACK:
+		i2c_slave_event(i2c->target, I2C_SLAVE_READ_PROCESSED, &byte);
+		writel(byte, i2c->regs + MA35_DAT);
+		break;
+
+	case MA35_S_REPEAT_START_STOP:
+	/* A STOP or repeated START has been received
+	 *  while still addressed as Target/Receiver
+	 */
+		i2c_slave_event(i2c->target, I2C_SLAVE_STOP, &byte);
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
+ * i2c_ma35d1_irq_controller_trx - I2C Controller state machine handler
+ * @i2c: ma35d1 i2c instance
+ * @i2c_status: hardware status code from MA35_STATUS0
+ */
+static void i2c_ma35d1_irq_controller_trx(struct ma35d1_i2c *i2c,
+					  unsigned long i2c_status)
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
+		ma35d1_i2c_stop(i2c, -EIO);
+		break;
+
+	case MA35_M_TRAN_ADDR_NACK:
+	case MA35_M_RECE_ADDR_NACK:
+		/* Controller Transmit Address NACK */
+		/* 0x20: SLA+W has been transmitted and NACK has been received */
+		/* 0x48: SLA+R has been transmitted and NACK has been received */
+		if (i2c->msg->flags & I2C_M_IGNORE_NAK) {
+			ma35d1_i2c_stop(i2c, 0);
+		} else {
+			dev_dbg(i2c->dev, "\n i2c: ack was not received\n");
+			ma35d1_i2c_stop(i2c, -ENXIO);
+		}
+		break;
+
+	case MA35_M_RECE_ADDR_ACK:
+		if (is_msgend(i2c)) {
+			if (is_last_msg(i2c)) {
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
+		} else if (i2c->msg->len == 1) {
+			ma35d1_i2c_write_CTL(i2c, MA35_CTL_SI);
+		} else {
+			ma35d1_i2c_write_CTL(i2c, MA35_CTL_SI_AA);
+		}
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
+		ma35d1_i2c_stop(i2c, -EIO);
+		break;
+	}
+}
+
+static irqreturn_t ma35d1_i2c_irq(int irqno, void *dev_id)
+{
+	struct ma35d1_i2c *i2c = dev_id;
+	unsigned long status;
+
+	status = readl(i2c->regs + MA35_STATUS0);
+
+	if (status == MA35_M_ARB_LOST) {
+		dev_err(i2c->dev, "Arbitration lost\n");
+		ma35d1_i2c_stop(i2c, -EAGAIN);
+		goto out;
+	}
+
+	else if (status == MA35_BUS_ERROR) {
+		dev_err(i2c->dev, "Bus error during transfer\n");
+		ma35d1_i2c_stop(i2c, -EIO);
+		goto out;
+	}
+
+	if (ma35d1_is_controller_status(status))
+		i2c_ma35d1_irq_controller_trx(i2c, status);
+	else
+		i2c_ma35d1_irq_target_trx(i2c, status);
+
+out:
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
+	i2c->msg = msgs;
+	i2c->msg_num = num;
+	i2c->msg_ptr = 0;
+	i2c->msg_idx = 0;
+	i2c->err = 0;
+
+	ma35d1_i2c_enable_irq(i2c);
+	ma35d1_i2c_write_CTL(i2c, MA35_CTL_STA_SI);
+	timeout = wait_event_timeout(i2c->wait, i2c->msg_num == 0, HZ * 5);
+	ma35d1_i2c_disable_irq(i2c);
+	ret = i2c->msg_idx;
+
+	if (timeout == 0) {
+		dev_dbg(i2c->dev, "xfer timeout\n");
+		ret = -ETIMEDOUT;
+		goto reset;
+	}
+
+	err = readl_poll_timeout(i2c->regs + MA35_CTL0, val,
+				 !(val & MA35_CTL_STO), 100,
+				 STOP_TIMEOUT_MS * 10000);
+	if (err) {
+		dev_err(i2c->dev, "bus idle timeout\n");
+		ret = -EBUSY;
+		goto reset;
+	} else if (i2c->err) {
+		dev_dbg(i2c->dev, "xfer error %d\n", i2c->err);
+		ret = i2c->err;
+	} else if (ret != num) {
+		dev_dbg(i2c->dev, "incomplete xfer (%d)\n", ret);
+	}
+	return ret;
+
+reset:
+	ma35d1_i2c_reset(i2c);
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
+	if (ret)
+		return ret;
+
+	for (retry = 0; retry < adap->retries; retry++) {
+		ret = ma35d1_i2c_doxfer(i2c, msgs, num);
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
+	if (i2c->target) {
+		ma35d1_i2c_write_CTL(i2c, MA35_CTL_SI_AA);
+		ma35d1_i2c_enable_irq(i2c);
+	}
+	pm_runtime_put_autosuspend(i2c->dev);
+
+	return ret;
+}
+
+static int ma35d1_reg_target(struct i2c_client *target)
+{
+	struct ma35d1_i2c *i2c = i2c_get_adapdata(target->adapter);
+	unsigned int val, slvaddr;
+	int ret;
+
+	if (i2c->target)
+		return -EBUSY;
+
+	if (target->flags & I2C_CLIENT_TEN)
+		return -EAFNOSUPPORT;
+
+	ret = pm_runtime_resume_and_get(i2c->dev);
+	if (ret) {
+		dev_err(i2c->dev, "failed to resume i2c controller\n");
+		return ret;
+	}
+
+	ma35d1_i2c_enable_irq(i2c);
+
+	i2c->target = target;
+
+	val = readl(i2c->regs + MA35_CTL0);
+	val |= MA35_CTL_I2CEN;
+	writel(val, i2c->regs + MA35_CTL0);
+	slvaddr = target->addr << 1;
+	writel(slvaddr, i2c->regs + MA35_ADDR0);
+
+	/* I2C enter SLV mode */
+	ma35d1_i2c_write_CTL(i2c, MA35_CTL_SI_AA);
+
+	return 0;
+}
+
+static int ma35d1_unreg_target(struct i2c_client *target)
+{
+	struct ma35d1_i2c *i2c = i2c_get_adapdata(target->adapter);
+	unsigned int val;
+	int ret;
+
+	if (!i2c->target)
+		return -EINVAL;
+
+	/* Disable I2C interrupt */
+	ma35d1_i2c_disable_irq(i2c);
+
+	/* Disable I2C */
+	val = readl(i2c->regs + MA35_CTL0);
+	val &= ~MA35_CTL_I2CEN;
+	writel(val, i2c->regs + MA35_CTL0);
+
+	i2c->target = NULL;
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
+static const struct i2c_algorithm ma35d1_i2c_algorithm = {
+	.xfer = ma35d1_i2c_xfer,
+	.functionality = ma35d1_i2c_func,
+	.reg_target = ma35d1_reg_target,
+	.unreg_target = ma35d1_unreg_target,
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
+	init_waitqueue_head(&i2c->wait);
+
+	i2c->dev = dev;
+
+	i2c->clk = devm_clk_get_prepared(dev, NULL);
+	if (IS_ERR(i2c->clk))
+		return dev_err_probe(dev, PTR_ERR(i2c->clk),
+				     "failed to get core clk\n");
+
+	i2c->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(i2c->regs))
+		return PTR_ERR(i2c->regs);
+
+	i2c->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
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
+	/* Default to 100kHz if not specified in DT */
+	busfreq = 100000;
+	device_property_read_u32(dev, "clock-frequency", &busfreq);
+
+	/* Calculate divider based on the current peripheral clock rate */
+	clkdiv = DIV_ROUND_CLOSEST(clk_get_rate(i2c->clk), busfreq * 4) - 1;
+	if (clkdiv < 0 || clkdiv > 0xffff)
+		return dev_err_probe(dev, -EINVAL, "invalid clkdiv value: %d\n",
+				     clkdiv);
+
+	i2c->irq = platform_get_irq(pdev, 0);
+	if (i2c->irq < 0)
+		return dev_err_probe(dev, i2c->irq, "failed to get irq\n");
+
+	platform_set_drvdata(pdev, i2c);
+
+	pm_runtime_set_autosuspend_delay(dev, I2C_PM_TIMEOUT_MS);
+	pm_runtime_use_autosuspend(dev);
+	devm_pm_runtime_enable(dev);
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to resume device\n");
+
+	writel(FIELD_PREP(MA35_CLKDIV_MSK, clkdiv), i2c->regs + MA35_CLKDIV);
+
+	ret = devm_request_irq(dev, i2c->irq, ma35d1_i2c_irq, 0, dev_name(dev),
+			       i2c);
+	if (ret) {
+		dev_err_probe(dev, ret, "cannot claim IRQ %d\n", i2c->irq);
+		goto rpm_put;
+	}
+
+	ret = devm_i2c_add_adapter(dev, &i2c->adap);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to add bus to i2c core\n");
+		goto rpm_put;
+	}
+
+	pm_runtime_put_autosuspend(dev);
+
+	dev_info(&i2c->adap.dev, "%08llx MA35D1 I2C adapter registered\n",
+		 res->start);
+	return 0;
+
+rpm_put:
+	pm_runtime_dont_use_autosuspend(dev);
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+	return ret;
+}
+
+static int ma35d1_i2c_suspend(struct device *dev)
+{
+	struct ma35d1_i2c *i2c = dev_get_drvdata(dev);
+	unsigned int val;
+
+	/* Prepare for wake-up from I2C events if target mode is active */
+	if (i2c->target) {
+		val = readl(i2c->regs + MA35_CTL0);
+		val |= (MA35_CTL_SI | MA35_CTL_AA);
+		writel(val, i2c->regs + MA35_CTL0);
+
+		/* Setup wake-up control */
+		writel(0x1, i2c->regs + MA35_WKCTL);
+
+		/* Clear pending wake-up flags */
+		val = readl(i2c->regs + MA35_WKSTS);
+		writel(val, i2c->regs + MA35_WKSTS);
+
+		enable_irq_wake(i2c->irq);
+
+		ma35d1_i2c_enable_irq(i2c);
+	}
+
+	return 0;
+}
+
+static int ma35d1_i2c_resume(struct device *dev)
+{
+	struct ma35d1_i2c *i2c = dev_get_drvdata(dev);
+	unsigned int val;
+
+	if (i2c->target) {
+		/* Disable wake-up */
+		writel(0x0, i2c->regs + MA35_WKCTL);
+
+		/* Clear pending wake-up flags */
+		val = readl(i2c->regs + MA35_WKSTS);
+		writel(val, i2c->regs + MA35_WKSTS);
+
+		disable_irq_wake(i2c->irq);
+	}
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
+	clk_disable(i2c->clk);
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
+	ret = clk_enable(i2c->clk);
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
+	.driver     = {
+		.name   = "ma35d1-i2c",
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

