Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4026E3264E9
	for <linux-i2c@vger.kernel.org>; Fri, 16 Oct 2026 01:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792112711; cv=none; b=rpi08FFuijuHOys4vlEHP0c5vz9uFlhiqFvMEtpyUhb4F0K/tXBcqB023VJF6WQpJve1JJzYvlDPDB3i/7vRrxFfiYw0ECvqqPlEb+yzZhg/jD/E99nWpQx52DaFJnIO0BweSnHq51whE9FFkTYVlaFp0fENySZ3odIygNQRjn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792112711; c=relaxed/simple;
	bh=UPrREf9/fn+4PFmqwltIbz9T370hPz/LqGInhzJ4/cw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZeRQFQGh2S4TohJo1lYx/CbQ7Fsjdn1+PVhQJ+7Ho+stGxpDWL0mqpf0C+A1NdMIUzyAXikZnAMUIuR0lTBv1zYxJswAkJJgYfXSMpXSpmRXBdg33RKZb0G0jZAbED0+kXOYkAWewdP4zL6/JV5MaTo9HvaOEbv8ooO/MMDufIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNdbQ4W4; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNdbQ4W4"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-88cfa501c5cso1170594b3a.3
        for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 18:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792112708; x=1792717508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xSV1RidUhWdjAlwEGGR9d1Ctk0KX7kEtMuGSFnfKci4=;
        b=JNdbQ4W4sEKCbBd1yb9NVC7zmCoRMNoVhZnLLvkFbK7nS8Uy4+LG6RcQl4K2QM9DYc
         gvazrpUe9Pn+Whwf8XQCthF876B2nCuqsTZt11ffqroRWUcw3uDCS98+TW+fcJUKMF9x
         /u41x8VI/zy+Ie855sRh/kPE2DNdQSjlTv+2F2ZGe1m48AO8Pp1pxeTNQyGnwwa2afQQ
         GuUN6fB10kCENjWdUUKHOPWQZVv3NTWUhfXpZcRQzxzj6DZLjNK9bMNa33ZGTlFzn9Dk
         JhY1g7L5IZ9evW2cZe3kntNQQPnTmqfPrtuJuAg4s+d9iB5/IYWrqFpqg/r6p4F32nJ0
         sHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792112708; x=1792717508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xSV1RidUhWdjAlwEGGR9d1Ctk0KX7kEtMuGSFnfKci4=;
        b=GXpSD0e1rPodDfrx718+Ks6wEthSqznR1bmigiNnCrTxTqkTJSKMiYhRcNmLGKX1G9
         PVRYKdRcrRlmg9AtjJC3rxRj+Cs1Ku4ryXiz7mLwMBhLHlxXc70DexnL9LDxbQweRIn/
         IuvvBrUEHOpUqsqPc8qx8F1w2WgmvW6um/Os/Vkake809DWwFqLSQrJwLOXyi7z1MWwy
         uXuDlbb/BVfBLjQjZ2LT1fzUm8N7Irh0wnqixLE5zs/enfP6qv1E/ibtni10Y8iwTlWU
         IpQBmtbkB7dnyIVwvmYRNxh/XHKYVYOoCJt+cFLZAmQ9RO9I8O2bJF9wRJcU+eNXzyAt
         bYLA==
X-Forwarded-Encrypted: i=1; AKwUvBzndmnOMfxY6I1t6tq02fHKldSmpOl8VujiDEVkFiYYTwqTjyy43XdTjVa0gx+Np68RmJnppBWCjrE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqeac9S1M2HXCsWXsCS4N8KP0JFI9f/OlN9GEd0Xc0f6YNYET1
	cz0voGlxGTyx6sTIe4WQg8LM+419FUxOeJT30hKNbSDyUv5UM4gK6aZ6
X-Gm-Gg: AYBFou3nBDG6KvzzSRcs0zQfpFXVWmwU+JS7YucR6SGLN2Gn1kC41dlB7ETIctibr07
	OegJH/EhsLh1AHa0dEDgE9tZNGeKG7ivdE0V6BfcYIjYgwLPz5wfeOrvWM93AYEG6EBI9IsPetG
	hSJ9d78J3H2ywKTDRPOVT2UCM0riI32b0z7pIgHYr+o6DXOfNj5ednd/zUwZ3HnslH0Lf/CZ4jo
	9WbBhPsG4Joy3s2a9ozQZL43r4hTWg4qaXD9Wxd4NN5qRWFAuR7ol42Qs3grFRzKUygOkUWxOp5
	lgjn6uXfuyZk0htzULm/w6L5O5WMqBBr4/oyiD3PJ9DO5Uuqzd0pSlgGFHuv2YO5UGWnL1Dx88R
	Ng5X2c3432rxSw7HsI83kHey3GWwuS/Z9PIpdSXZXZSpuLy72ilS0wLbCKDrCAnMPOWMTtAwzas
	xaHWiqT3wsk4l4AcOhD6iOB6scgIsFTok2Kar1cOZaGPG4Y88d6UxxUilsRiTGtxyp4rdU2laXK
	BT0nvpzliwLO4WzFAeAJRPfG6zhraG3iq8CyPDu3smyQi5AbN4JNeuLOxZLVFo4rkc=
X-Received: by 2002:a05:6a00:178e:b0:897:4932:5098 with SMTP id d2e1a72fcca58-897c6e1b741mr18585889b3a.27.1792112708159;
        Thu, 15 Oct 2026 18:05:08 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f5735e513sm302821b3a.27.2026.10.15.18.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 18:05:07 -0700 (PDT)
From: Zi-Yu Chen <zychennvt@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Zi-Yu Chen <zychennvt@gmail.com>
Subject: [PATCH v12 2/3] i2c: ma35d1: Add Nuvoton MA35D1 I2C driver support
Date: Fri, 16 Oct 2026 09:04:47 +0800
Message-Id: <20261016010448.324856-3-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261016010448.324856-1-zychennvt@gmail.com>
References: <20261016010448.324856-1-zychennvt@gmail.com>
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
 drivers/i2c/busses/i2c-ma35d1.c | 800 ++++++++++++++++++++++++++++++++
 3 files changed, 814 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-ma35d1.c

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index d7b89508311f..e69120d46977 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -1602,4 +1602,17 @@ config I2C_VIRTIO
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
index 3755c54b3d82..ca75dae4955c 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -131,6 +131,7 @@ obj-$(CONFIG_I2C_XILINX)	+= i2c-xiic.o
 obj-$(CONFIG_I2C_XLP9XX)	+= i2c-xlp9xx.o
 obj-$(CONFIG_I2C_RCAR)		+= i2c-rcar.o
 obj-$(CONFIG_I2C_GXP)		+= i2c-gxp.o
+obj-$(CONFIG_I2C_MA35D1)	+= i2c-ma35d1.o
 
 # External I2C/SMBus adapter drivers
 obj-$(CONFIG_I2C_DIOLAN_U2C)	+= i2c-diolan-u2c.o
diff --git a/drivers/i2c/busses/i2c-ma35d1.c b/drivers/i2c/busses/i2c-ma35d1.c
new file mode 100644
index 000000000000..29bed9eb28f6
--- /dev/null
+++ b/drivers/i2c/busses/i2c-ma35d1.c
@@ -0,0 +1,800 @@
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
+#include <linux/pm_runtime.h>
+#include <linux/property.h>
+#include <linux/reset.h>
+#include <linux/units.h>
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
+
+/* Constants */
+#define MA35_CLKDIV_MSK		GENMASK(9, 0)
+#define MA35_I2C_PM_TIMEOUT_MS	5000
+#define MA35_STOP_TIMEOUT_MS	50
+
+struct ma35d1_i2c {
+	spinlock_t lock;
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
+	bool target_reject;
+};
+
+static inline bool ma35d1_is_controller_status(unsigned int status)
+{
+	return status >= MA35_M_START && status <= MA35_M_RECE_DATA_NACK;
+}
+
+/*
+ * ma35d1_i2c_write_ctl - Update the I2C control register
+ * @i2c: Pointer to the ma35d1 i2c instance
+ * @ctl: Control bits to set (e.g., MA35_CTL_STA, SI, AA)
+ *
+ * Read-modify-write the CTL0 register while preserving unrelated bits.
+ */
+static void ma35d1_i2c_write_ctl(struct ma35d1_i2c *i2c, unsigned int ctl)
+{
+	unsigned int val;
+
+	guard(spinlock_irqsave)(&i2c->lock);
+	val = readl(i2c->regs + MA35_CTL0);
+	val &= ~(MA35_CTL_SI_AA);
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
+	i2c->msg_ptr = 0;
+	i2c->msg = NULL;
+	i2c->msg_idx++;
+	i2c->msg_num = 0;
+
+	wake_up(&i2c->wait);
+}
+
+static void ma35d1_i2c_reset(struct ma35d1_i2c *i2c)
+{
+	unsigned int clkdiv, slvaddr;
+
+	clkdiv = readl(i2c->regs + MA35_CLKDIV);
+	slvaddr = readl(i2c->regs + MA35_ADDR0);
+
+	disable_irq(i2c->irq);
+	i2c->msg = NULL;
+	reset_control_assert(i2c->rst);
+	usleep_range(10, 20);
+	reset_control_deassert(i2c->rst);
+	enable_irq(i2c->irq);
+
+	writel(clkdiv, (i2c->regs + MA35_CLKDIV));
+	ma35d1_i2c_write_ctl(i2c, MA35_CTL_I2CEN | MA35_CTL_INTEN);
+
+	if (i2c->target)
+		writel(slvaddr, i2c->regs + MA35_ADDR0);
+}
+
+static void ma35d1_i2c_stop(struct ma35d1_i2c *i2c, int ret)
+{
+	ma35d1_i2c_write_ctl(i2c, MA35_CTL_STO_SI);
+
+	if (ret)
+		i2c->err = ret;
+
+	ma35d1_i2c_controller_complete(i2c);
+}
+
+/*
+ * ma35d1_i2c_restore_idle - restore controller state to idle
+ * @i2c: Pointer to the ma35d1 i2c instance
+ *
+ * Restore the controller to an idle state after an unexpected event.
+ * Abort an active controller transfer, otherwise re-arm target mode
+ * if enabled.
+ */
+static void ma35d1_i2c_restore_idle(struct ma35d1_i2c *i2c)
+{
+	if (i2c->msg) {
+		ma35d1_i2c_stop(i2c, -EIO);
+	} else if (i2c->target) {
+		i2c->target_reject = false;
+		ma35d1_i2c_write_ctl(i2c, MA35_CTL_SI_AA);
+	} else {
+		ma35d1_i2c_write_ctl(i2c, MA35_CTL_SI);
+	}
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
+ * ma35d1_i2c_irq_target_trx - I2C Target state machine handler
+ * @i2c: ma35d1 i2c instance
+ * @i2c_status: hardware status code from MA35_STATUS0
+ */
+static irqreturn_t ma35d1_i2c_irq_target_trx(struct ma35d1_i2c *i2c,
+					     unsigned long i2c_status)
+{
+	unsigned char byte = 0;
+	int ret;
+
+	switch (i2c_status) {
+	case MA35_S_RECE_ARB_LOST:
+		/*
+		 * Arbitration lost during address transmission phase.
+		 * The hardware switches to Target Transmitter mode when
+		 * our own SLA+W is detected on the bus.
+		 */
+		i2c->err = -EAGAIN;
+		ma35d1_i2c_controller_complete(i2c);
+		ret = i2c_slave_event(i2c->target, I2C_SLAVE_WRITE_REQUESTED,
+				      &byte);
+		if (ret)
+			i2c->target_reject = true;
+		break;
+
+	case MA35_S_RECE_ADDR_ACK:
+		/* Own SLA+W has been receive; ACK has been return */
+		ret = i2c_slave_event(i2c->target, I2C_SLAVE_WRITE_REQUESTED,
+				      &byte);
+		if (ret)
+			i2c->target_reject = true;
+		break;
+
+	case MA35_S_TRAN_DATA_NACK:
+	case MA35_S_RECE_DATA_NACK:
+		/*
+		 * Data byte or last data in I2CDAT has been transmitted and NACK received,
+		 * or previously addressed with own SLA address and NACK returned.
+		 */
+		i2c->target_reject = false;
+		break;
+
+	case MA35_S_RECE_DATA_ACK:
+		/*
+		 * Previously address with own SLA address Data has been received;
+		 * ACK has been returned
+		 */
+		byte = readb(i2c->regs + MA35_DAT);
+		i2c_slave_event(i2c->target, I2C_SLAVE_WRITE_RECEIVED, &byte);
+		break;
+
+	case MA35_ADDR_TRAN_ARB_LOST:
+		/*
+		 * Arbitration lost during address transmission phase.
+		 * The hardware switches to Target Receiver mode when
+		 * our own SLA+R is detected on the bus.
+		 */
+		i2c->err = -EAGAIN;
+		ma35d1_i2c_controller_complete(i2c);
+		i2c_slave_event(i2c->target, I2C_SLAVE_READ_REQUESTED, &byte);
+		writel(byte, i2c->regs + MA35_DAT);
+		break;
+
+	case MA35_S_TRAN_ADDR_ACK:
+		/* Own SLA+R has been receive; ACK has been return */
+		i2c_slave_event(i2c->target, I2C_SLAVE_READ_REQUESTED, &byte);
+		writel(byte, i2c->regs + MA35_DAT);
+		break;
+
+	case MA35_S_TRAN_DATA_ACK:
+		i2c_slave_event(i2c->target, I2C_SLAVE_READ_PROCESSED, &byte);
+		writel(byte, i2c->regs + MA35_DAT);
+		break;
+
+	case MA35_S_REPEAT_START_STOP:
+	/*
+	 *  A STOP or repeated START has been received
+	 *  while still addressed as Target/Receiver
+	 */
+		i2c_slave_event(i2c->target, I2C_SLAVE_STOP, &byte);
+		i2c->target_reject = false;
+		break;
+
+	default:
+		dev_err(i2c->dev, "Status 0x%02lx is NOT processed\n",
+			i2c_status);
+		ma35d1_i2c_restore_idle(i2c);
+		return IRQ_NONE;
+	}
+	if (i2c->target_reject)
+		ma35d1_i2c_write_ctl(i2c, MA35_CTL_SI);
+	else
+		ma35d1_i2c_write_ctl(i2c, MA35_CTL_SI_AA);
+	return IRQ_HANDLED;
+}
+
+/*
+ * ma35d1_i2c_irq_controller_trx - I2C Controller state machine handler
+ * @i2c: ma35d1 i2c instance
+ * @i2c_status: hardware status code from MA35_STATUS0
+ */
+static irqreturn_t ma35d1_i2c_irq_controller_trx(struct ma35d1_i2c *i2c,
+						 unsigned long i2c_status)
+{
+	unsigned char byte;
+
+	/* Ensuring messages are absolutely valid in Controller mode. */
+	if (unlikely(!i2c->msg)) {
+		dev_err(i2c->dev, "Spurious controller interrupt (status: 0x%02lx)\n", i2c_status);
+		ma35d1_i2c_restore_idle(i2c);
+		return IRQ_HANDLED;
+	}
+
+	switch (i2c_status) {
+	case MA35_M_START:
+	case MA35_M_REPEAT_START:
+		ma35d1_i2c_set_addr(i2c);
+		ma35d1_i2c_write_ctl(i2c, MA35_CTL_SI);
+		break;
+
+	case MA35_M_TRAN_ADDR_ACK:
+	case MA35_M_TRAN_DATA_ACK:
+		/* SLA+W has been transmitted and ACK has been received */
+		if (i2c_status == MA35_M_TRAN_ADDR_ACK) {
+			if (is_last_msg(i2c) && i2c->msg->len == 0) {
+				ma35d1_i2c_stop(i2c, 0);
+				return IRQ_HANDLED;
+			}
+		}
+
+		if (!is_msgend(i2c)) {
+			byte = i2c->msg->buf[i2c->msg_ptr++];
+			writel(byte, i2c->regs + MA35_DAT);
+			ma35d1_i2c_write_ctl(i2c, MA35_CTL_SI);
+		} else if (!is_last_msg(i2c)) {
+			dev_dbg(i2c->dev, "WRITE: Next Message\n");
+
+			i2c->msg_ptr = 0;
+			i2c->msg_idx++;
+			i2c->msg++;
+
+			ma35d1_i2c_write_ctl(i2c, MA35_CTL_STA | MA35_CTL_SI);
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
+		/*
+		 * Controller Transmit Address NACK
+		 * 0x20: SLA+W has been transmitted and NACK has been received
+		 * 0x48: SLA+R has been transmitted and NACK has been received
+		 */
+		dev_dbg(i2c->dev, "\n i2c: ack was not received\n");
+		ma35d1_i2c_stop(i2c, -ENXIO);
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
+				ma35d1_i2c_write_ctl(i2c, MA35_CTL_STA_SI);
+			}
+		} else if (i2c->msg->len == 1) {
+			ma35d1_i2c_write_ctl(i2c, MA35_CTL_SI);
+		} else {
+			ma35d1_i2c_write_ctl(i2c, MA35_CTL_SI_AA);
+		}
+		break;
+
+	case MA35_M_RECE_DATA_ACK:
+	case MA35_M_RECE_DATA_NACK:
+		/* DATA has been received and ACK/NACK has been received */
+		byte = readb(i2c->regs + MA35_DAT);
+		i2c->msg->buf[i2c->msg_ptr++] = byte;
+
+		if (is_last_byte(i2c)) {
+			ma35d1_i2c_write_ctl(i2c, MA35_CTL_SI);
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
+				ma35d1_i2c_write_ctl(i2c, MA35_CTL_STA_SI);
+			}
+		} else {
+			ma35d1_i2c_write_ctl(i2c, MA35_CTL_SI_AA);
+		}
+		break;
+
+	case MA35_M_ARB_LOST:
+		/* Arbitration Lost */
+		i2c->err = -EAGAIN;
+		ma35d1_i2c_controller_complete(i2c);
+		ma35d1_i2c_write_ctl(i2c, MA35_CTL_SI);
+		break;
+
+	default:
+		dev_err(i2c->dev, "Status 0x%02lx is NOT processed\n",
+			i2c_status);
+		ma35d1_i2c_restore_idle(i2c);
+		return IRQ_NONE;
+	}
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t ma35d1_i2c_irq(int irqno, void *dev_id)
+{
+	struct ma35d1_i2c *i2c = dev_id;
+	unsigned long status;
+
+	status = readl(i2c->regs + MA35_STATUS0);
+
+	if (status == MA35_BUS_ERROR) {
+		dev_err(i2c->dev, "bus error\n");
+		ma35d1_i2c_restore_idle(i2c);
+		return IRQ_HANDLED;
+	}
+
+	if (ma35d1_is_controller_status(status))
+		return ma35d1_i2c_irq_controller_trx(i2c, status);
+	else
+		return ma35d1_i2c_irq_target_trx(i2c, status);
+}
+
+static int ma35d1_i2c_doxfer(struct ma35d1_i2c *i2c, struct i2c_msg *msgs,
+			     int num)
+{
+	unsigned long timeout;
+	unsigned int val;
+	int ret, err;
+
+	disable_irq(i2c->irq);
+	i2c->msg = msgs;
+	i2c->msg_num = num;
+	i2c->msg_ptr = 0;
+	i2c->msg_idx = 0;
+	i2c->err = 0;
+
+	ma35d1_i2c_write_ctl(i2c, MA35_CTL_STA);
+	enable_irq(i2c->irq);
+
+	timeout = wait_event_timeout(i2c->wait, i2c->msg_num == 0, HZ * 5);
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
+				 MA35_STOP_TIMEOUT_MS * 1000);
+	if (err) {
+		dev_err(i2c->dev, "bus idle timeout\n");
+		ret = -EBUSY;
+		goto reset;
+	} else if (i2c->err) {
+		dev_dbg(i2c->dev, "xfer error %d\n", i2c->err);
+		ret = i2c->err;
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
+	int ret;
+
+	ret = pm_runtime_resume_and_get(i2c->dev);
+	if (ret)
+		return ret;
+
+	ret = ma35d1_i2c_doxfer(i2c, msgs, num);
+
+	if (i2c->target)
+		ma35d1_i2c_write_ctl(i2c, MA35_CTL_AA);
+	pm_runtime_put_autosuspend(i2c->dev);
+
+	return ret;
+}
+
+static int ma35d1_reg_target(struct i2c_client *target)
+{
+	struct ma35d1_i2c *i2c = i2c_get_adapdata(target->adapter);
+	unsigned int slvaddr;
+	int ret;
+
+	if (i2c->target)
+		return -EBUSY;
+
+	if (target->flags & I2C_CLIENT_TEN)
+		return -EAFNOSUPPORT;
+
+	/* Keep device active for target mode listening. */
+	ret = pm_runtime_resume_and_get(i2c->dev);
+	if (ret) {
+		dev_err(i2c->dev, "failed to resume i2c controller\n");
+		return ret;
+	}
+
+	i2c->target = target;
+
+	slvaddr = target->addr << 1;
+	writel(slvaddr, i2c->regs + MA35_ADDR0);
+
+	/* I2C enter SLV mode */
+	ma35d1_i2c_write_ctl(i2c, MA35_CTL_AA);
+
+	return 0;
+}
+
+static int ma35d1_unreg_target(struct i2c_client *target)
+{
+	struct ma35d1_i2c *i2c = i2c_get_adapdata(target->adapter);
+	int ret;
+
+	if (!i2c->target)
+		return -EINVAL;
+
+	writel(0, i2c->regs + MA35_ADDR0);
+	/* Clear AA bit */
+	ma35d1_i2c_write_ctl(i2c, 0);
+
+	synchronize_irq(i2c->irq);
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
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
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
+static const struct i2c_adapter_quirks ma35d1_i2c_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN_READ,
+};
+
+static int ma35d1_i2c_suspend(struct device *dev)
+{
+	struct ma35d1_i2c *i2c = dev_get_drvdata(dev);
+	unsigned int val;
+	int ret;
+
+	/* Prepare for wake-up from I2C events if target mode is active */
+	if (i2c->target) {
+		ma35d1_i2c_write_ctl(i2c, MA35_CTL_AA);
+
+		/* Setup wake-up control */
+		writel(0x1, i2c->regs + MA35_WKCTL);
+
+		/* Clear pending wake-up flags */
+		val = readl(i2c->regs + MA35_WKSTS);
+		writel(val, i2c->regs + MA35_WKSTS);
+
+		ret = enable_irq_wake(i2c->irq);
+		if (ret) {
+			writel(0, i2c->regs + MA35_WKCTL);
+			return ret;
+		}
+		return 0;
+	}
+	return pm_runtime_force_suspend(dev);
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
+		return 0;
+	}
+	return pm_runtime_force_resume(dev);
+}
+
+static int ma35d1_i2c_runtime_suspend(struct device *dev)
+{
+	struct ma35d1_i2c *i2c = dev_get_drvdata(dev);
+
+	clk_disable(i2c->clk);
+
+	return 0;
+}
+
+static int ma35d1_i2c_runtime_resume(struct device *dev)
+{
+	struct ma35d1_i2c *i2c = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_enable(i2c->clk);
+	if (ret) {
+		dev_err(dev, "failed to enable clock in resume\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void ma35d1_i2c_pm_cleanup(void *data)
+{
+	struct device *dev = data;
+
+	pm_runtime_get_sync(dev);
+	pm_runtime_disable(dev);
+	pm_runtime_put_noidle(dev);
+}
+
+static int ma35d1_i2c_probe(struct platform_device *pdev)
+{
+	unsigned int busfreq = I2C_MAX_STANDARD_MODE_FREQ;
+	struct device *dev = &pdev->dev;
+	struct ma35d1_i2c *i2c;
+	struct resource *res;
+	int ret, clkdiv;
+	u32 val;
+
+	i2c = devm_kzalloc(dev, sizeof(*i2c), GFP_KERNEL);
+	if (!i2c)
+		return -ENOMEM;
+
+	init_waitqueue_head(&i2c->wait);
+	spin_lock_init(&i2c->lock);
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
+		return dev_err_probe(dev, PTR_ERR(i2c->regs),
+				     "can't get IO memory\n");
+
+	i2c->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(i2c->rst))
+		return dev_err_probe(dev, PTR_ERR(i2c->rst),
+				     "failed to get reset control\n");
+
+	ret = reset_control_deassert(i2c->rst);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to deassert reset line\n");
+
+	/* Setup info block for the I2C core */
+	strscpy(i2c->adap.name, "ma35d1-i2c", sizeof(i2c->adap.name));
+	i2c->adap.owner = THIS_MODULE;
+	i2c->adap.algo = &ma35d1_i2c_algorithm;
+	i2c->adap.quirks = &ma35d1_i2c_quirks;
+	i2c->adap.retries = 2;
+	i2c->adap.algo_data = i2c;
+	i2c->adap.dev.parent = &pdev->dev;
+	i2c->adap.dev.of_node = pdev->dev.of_node;
+	i2c_set_adapdata(&i2c->adap, i2c);
+
+	if (!device_property_read_u32(dev, "clock-frequency", &val)) {
+		if (val != 0 && val <= MEGA)
+			busfreq = val;
+	}
+	/* Calculate divider based on the current peripheral clock rate */
+	clkdiv = DIV_ROUND_CLOSEST(clk_get_rate(i2c->clk), busfreq * 4) - 1;
+	if (clkdiv < 0 || clkdiv > 0x3ff)
+		return dev_err_probe(dev, -EINVAL, "invalid clkdiv value: %d\n",
+				     clkdiv);
+
+	i2c->irq = platform_get_irq(pdev, 0);
+	if (i2c->irq < 0)
+		return dev_err_probe(dev, i2c->irq, "failed to get irq\n");
+
+	platform_set_drvdata(pdev, i2c);
+
+	pm_runtime_set_autosuspend_delay(dev, MA35_I2C_PM_TIMEOUT_MS);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	ret = devm_add_action_or_reset(dev, ma35d1_i2c_pm_cleanup, dev);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to add pm cleanup action\n");
+
+	writel(MA35_CTL_I2CEN | MA35_CTL_INTEN, i2c->regs + MA35_CTL0);
+	writel(FIELD_PREP(MA35_CLKDIV_MSK, clkdiv), i2c->regs + MA35_CLKDIV);
+
+	ret = devm_request_irq(dev, i2c->irq, ma35d1_i2c_irq, 0, dev_name(dev),
+			       i2c);
+	if (ret)
+		return dev_err_probe(dev, ret, "cannot claim IRQ %d\n",
+				     i2c->irq);
+
+	ret = devm_i2c_add_adapter(dev, &i2c->adap);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to add bus to i2c core\n");
+
+	dev_info(&i2c->adap.dev, "%pa MA35D1 I2C adapter registered\n",
+		 &res->start);
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

