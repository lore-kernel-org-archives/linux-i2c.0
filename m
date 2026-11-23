Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795409497;
	b=3DsLn8Az48VVWuraBeHLpobPw86zg70bH2um3ud0EpvgqFbtXMwk+xGHS2Zs4g4UfJYR
	 xkrL+Fgr1cOZp/3jV9jtRBgFPPv/jtuTcXh+mEo7aV9kN5Ds52hkY5iN/Gf1ov/E9dzKy
	 VtJLvgUnjLvD2EIQepLpWAfQu/oyU5NaUEyzYJ0QYa2qsDsAtoCDv3EbmIc8KgUvk7zKm
	 EVlz6DOj/ggB9EjyBt/3Yrg60qW1JytcmvzYniPTV69Q5nYLFziQvQmIluqS6bwSXyZkj
	 PkW2bNt0Pm2IyJpRFXKEwywfBa9dSkpQDME4saIkh9jM28F70JbXiauRfjTG3lkN4jg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795409497;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3FwG7mX5zlZBqN+BGxKHGoAGEMqnQOwJV3TjX51GPvs=;
	b=CmDnoFVd0C6GCXSb4KOPlRCMct/Oj0w3FghyHXN52uIuocq40iIx3haFnikKMWqSoddx
	 uXoQHyclb7b7dm4RkFU5EauRXVSzsf0V1Gd2AAH+bq7YS9YHH62DnjbIROnLqWCDLOk0C
	 vXOtaq/1/DEL1rE+SL9DXjdb4u04bj3KwymprmbkgjDc7hpCEuWGj3wWl3XjGxu2+NtQ9
	 N+Xcv9n/yprGs070RRJbLwP5RCXZzpvBBBFTriwvhJle/ZgKTi5H9P2/lw+cJyGuJTBZu
	 lSZ8HZR4Tysj8ezM4QXsetHDLz4sjPYLlxbYlzWaFR+Q+pEdcf/NsdFpd50HUhSLKuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eJuYPR7m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79411606A332;
	Mon, 23 Nov 2026 04:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eJuYPR7m
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795409496;
	b=TlhgOicVuWfXkC2BxziQ9ehL+w2Ce8YtxDnvYEQ4Gwu3GKzZVzeTOF4vY0NDlP3hmKpj
	 DyL0fiqTixHAR+6mqnVVxexVsVExlWSsqKjvjS4CH4IiU0FHvGNNF+qhrKCEzIrVBzMb8
	 1225otILl9v7ZuY/qPwWdoMZ3mcvc9mdE1vRgcjA2LzMdUYiNTIgkFANepcmHy23yWy8w
	 wRe8awFXWh22RQXFyoDkNMdiJZ19+fl9k+vuUjgFDlBYcKIo8JuE7METOlPEsh+8827e7
	 tkcg6wjiTKtTJjBYNlqtreqnTYKZ+4ePZTn13u38LeSo631IfeY3BXFc3DfyhSs5sXg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795409496;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3FwG7mX5zlZBqN+BGxKHGoAGEMqnQOwJV3TjX51GPvs=;
	b=puQh1YPEOKLFEMmVU4TRGV80CbJjzg0MRidVYzFJKUmHz7P6E3S58fQFKRg5RZGMFPPi
	 deMFZdO4DEj6AIPs4dD5sI2eoT2Bv56ClbMtLCS6V9FthuSQiy1hQmb9YHF9QsdmlQ8uw
	 oJQzbY6Pg3NCAkZ9V6A6nVhhB1CdUXFfNT99ty265Ao7HCa5sv0VFxJ9wJtDwkejG8gRH
	 8Y9suYssQ4VhHZ48jZh1nIwn0GakfFPMdsgBSV/GnAXAXXunfbu6ehnTaFekb9Oot9CC9
	 k1yAfRUhwEvanwJg01skEN1oDPBhiDnH77PNM37UicVsWbQIJaMsnY7bosjs0x2FM1Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 069511F000D0;
	Mon, 23 Nov 2026 04:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795409496;
	bh=3FwG7mX5zlZBqN+BGxKHGoAGEMqnQOwJV3TjX51GPvs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=eJuYPR7mhGc4yuKbR+9ToRV9k5dCfhvMG+Y6TeTdF2UgqV/+zQEm1haupTeuJVbT0
	 qGcysU7/RdIGFekvJScgpdmSxnGvde95zi3YKNgmxxOpxwe5hWcmF1TOdLvfPEB0b2
	 PoRIZpIUR2wKDx3cznT65g8br7oD69Z7X6kVUBaWPfpBXED5dB6vW6DjN0HXnqZrBP
	 txEglvbSdj2oEBqzs3meY3oDISoscIIEbUJro3RmBIn2lZOpqtaY8Ahbhl21JF/jhh
	 gtirENRWvvpqMjU6IOGWZxrY+Bi9a+AWR69Zbj0uYLpStbXH5vCY64Dli7VwM8k3Kb
	 xfUnMJfO7akTg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8942E4C352;
	Mon, 23 Nov 2026 04:51:25 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 07:51:09 +0300
Subject: [PATCH v6 2/2] i2c: Add Cortina Systems CS75xx I2C controller
 driver
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-cs75xx-i2c-v6-2-2504375e4342@gmail.com>
References: <20261123-cs75xx-i2c-v6-0-2504375e4342@gmail.com>
In-Reply-To: <20261123-cs75xx-i2c-v6-0-2504375e4342@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Fil Dunsky <filipp.dunsky@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795409484; l=12869;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=sdKb23F6aWeqpJLbpvhACtdkiZ/sWmFtTwhFjE/scGw=;
 b=TnRPoQGcBZAlEhOLNOkHDqhvLbEjZceIcKjMTnpshnCCgqYNJbq9TtcgZ39WfI11DvoeIXsNo
 ubH7ZDCpvIIDT54/kD6kyCD+TaAwgzJHGB9latsQWiWD35KVpEqk+sZ
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com
Content-Transfer-Encoding: 7bit

From: Fil Dunsky <filipp.dunsky@gmail.com>

The I2C ("Bi-Wire") controller of the Cortina Systems CS75xx SoCs
transfers one byte per command, with a command register much like the
OpenCores one (start, stop, read, write, acknowledge), and raises an
interrupt when a command has completed.

Messages are sent with a repeated start between them and a stop after
the last one. Every message needs at least one data byte, so SMBus quick
commands are not supported. Arbitration loss is reported as -EAGAIN and
retried by the core.

The driver depends on OF and HAS_IOMEM and uses generic platform and
I2C APIs, so it can be enabled without the CS75xx platform series.

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 drivers/i2c/busses/Kconfig      |  11 ++
 drivers/i2c/busses/Makefile     |   1 +
 drivers/i2c/busses/i2c-cs75xx.c | 393 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 405 insertions(+)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 275aaa7f3..1bebffc7d 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -550,6 +550,17 @@ config I2C_CPM
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-cpm.
 
+config I2C_CS75XX
+	tristate "Cortina Systems CS75xx I2C controller"
+	depends on OF
+	depends on HAS_IOMEM
+	help
+	  Say yes here to support the I2C ("Bi-Wire") controller of the
+	  Cortina Systems CS75xx SoCs.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called i2c-cs75xx.
+
 config I2C_DAVINCI
 	tristate "DaVinci I2C driver"
 	depends on ARCH_DAVINCI || ARCH_KEYSTONE || COMPILE_TEST
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index e5440de0f..f19df25eb 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_I2C_CADENCE)	+= i2c-cadence.o
 obj-$(CONFIG_I2C_CBUS_GPIO)	+= i2c-cbus-gpio.o
 obj-$(CONFIG_I2C_CGBC)		+= i2c-cgbc.o
 obj-$(CONFIG_I2C_CPM)		+= i2c-cpm.o
+obj-$(CONFIG_I2C_CS75XX)	+= i2c-cs75xx.o
 obj-$(CONFIG_I2C_DAVINCI)	+= i2c-davinci.o
 obj-$(CONFIG_I2C_DESIGNWARE_CORE)			+= i2c-designware-core.o
 i2c-designware-core-y					:= i2c-designware-common.o
diff --git a/drivers/i2c/busses/i2c-cs75xx.c b/drivers/i2c/busses/i2c-cs75xx.c
new file mode 100644
index 000000000..09a77c7be
--- /dev/null
+++ b/drivers/i2c/busses/i2c-cs75xx.c
@@ -0,0 +1,393 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Cortina Systems CS75xx I2C ("Bi-Wire") controller
+ *
+ * The controller works one byte at a time: software writes the byte to
+ * transmit and a command (start, stop, read, write, acknowledge) and gets
+ * an interrupt when the command has completed.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/spinlock.h>
+
+#define CS75XX_I2C_CFG		0x00
+#define CS75XX_I2C_CTRL		0x04
+#define CS75XX_I2C_TXR		0x08
+#define CS75XX_I2C_RXR		0x0c
+#define CS75XX_I2C_ACK		0x10
+#define CS75XX_I2C_IE		0x14
+#define CS75XX_I2C_INT		0x18
+
+#define CS75XX_I2C_CFG_EN	BIT(0)
+#define CS75XX_I2C_CFG_PRER	GENMASK(31, 16)
+
+#define CS75XX_I2C_CTRL_NACK	BIT(3)
+#define CS75XX_I2C_CTRL_WRITE	BIT(4)
+#define CS75XX_I2C_CTRL_READ	BIT(5)
+#define CS75XX_I2C_CTRL_STOP	BIT(6)
+#define CS75XX_I2C_CTRL_START	BIT(7)
+
+#define CS75XX_I2C_ACK_AL	BIT(0)
+#define CS75XX_I2C_ACK_BUSY	BIT(1)
+#define CS75XX_I2C_ACK_NACK	BIT(2)
+
+#define CS75XX_I2C_INT_DONE	BIT(0)
+
+enum cs75xx_i2c_state {
+	CS75XX_I2C_IDLE,
+	CS75XX_I2C_ADDR,
+	CS75XX_I2C_WRITE,
+	CS75XX_I2C_READ,
+	CS75XX_I2C_STOP,
+};
+
+struct cs75xx_i2c {
+	struct i2c_adapter adap;
+	struct device *dev;
+	void __iomem *base;
+	int irq;
+	u32 prer;
+
+	spinlock_t lock;	/* protects the transfer state */
+	struct completion done;
+	enum cs75xx_i2c_state state;
+	struct i2c_msg *msg;
+	unsigned int pos;
+	bool last;
+	int err;
+};
+
+static void cs75xx_i2c_hw_init(struct cs75xx_i2c *i2c)
+{
+	if (readl(i2c->base + CS75XX_I2C_CFG) & CS75XX_I2C_CFG_EN) {
+		writel(0, i2c->base + CS75XX_I2C_CFG);
+		fsleep(5000);
+	}
+
+	writel(FIELD_PREP(CS75XX_I2C_CFG_PRER, i2c->prer) | CS75XX_I2C_CFG_EN,
+	       i2c->base + CS75XX_I2C_CFG);
+	fsleep(5000);
+}
+
+/*
+ * Reset the controller and enable its interrupt again, with the handler
+ * kept away from the registers meanwhile
+ */
+static void cs75xx_i2c_reset(struct cs75xx_i2c *i2c)
+{
+	disable_irq(i2c->irq);
+	cs75xx_i2c_hw_init(i2c);
+	writel(CS75XX_I2C_INT_DONE, i2c->base + CS75XX_I2C_INT);
+	writel(CS75XX_I2C_INT_DONE, i2c->base + CS75XX_I2C_IE);
+	enable_irq(i2c->irq);
+}
+
+static void cs75xx_i2c_finish(struct cs75xx_i2c *i2c, int err)
+{
+	i2c->err = err;
+	i2c->state = CS75XX_I2C_IDLE;
+	complete(&i2c->done);
+}
+
+/*
+ * End the transfer with a stop condition and complete it only once the
+ * stop is done, so that its interrupt cannot be taken for the next one
+ */
+static void cs75xx_i2c_abort(struct cs75xx_i2c *i2c, int err)
+{
+	i2c->err = err;
+	i2c->state = CS75XX_I2C_STOP;
+	writel(CS75XX_I2C_CTRL_STOP, i2c->base + CS75XX_I2C_CTRL);
+}
+
+/* Start the transfer of the next data byte of the message */
+static void cs75xx_i2c_next_byte(struct cs75xx_i2c *i2c)
+{
+	struct i2c_msg *msg = i2c->msg;
+	bool last_byte = i2c->pos == msg->len - 1;
+	u32 cmd;
+
+	if (msg->flags & I2C_M_RD) {
+		i2c->state = CS75XX_I2C_READ;
+		cmd = CS75XX_I2C_CTRL_READ;
+		/* Do not acknowledge the last byte of a read */
+		if (last_byte)
+			cmd |= CS75XX_I2C_CTRL_NACK;
+	} else {
+		i2c->state = CS75XX_I2C_WRITE;
+		writel(msg->buf[i2c->pos++], i2c->base + CS75XX_I2C_TXR);
+		cmd = CS75XX_I2C_CTRL_WRITE;
+	}
+
+	if (last_byte && i2c->last)
+		cmd |= CS75XX_I2C_CTRL_STOP;
+
+	writel(cmd, i2c->base + CS75XX_I2C_CTRL);
+}
+
+static void cs75xx_i2c_process(struct cs75xx_i2c *i2c, u32 ack)
+{
+	struct i2c_msg *msg = i2c->msg;
+
+	/* Late interrupt of a transfer that timed out */
+	if (i2c->state == CS75XX_I2C_IDLE)
+		return;
+
+	if (i2c->state == CS75XX_I2C_STOP) {
+		cs75xx_i2c_finish(i2c, i2c->err);
+		return;
+	}
+
+	if (ack & CS75XX_I2C_ACK_AL) {
+		cs75xx_i2c_abort(i2c, -EAGAIN);
+		return;
+	}
+
+	switch (i2c->state) {
+	case CS75XX_I2C_ADDR:
+		if (ack & CS75XX_I2C_ACK_NACK) {
+			cs75xx_i2c_abort(i2c, -ENXIO);
+			return;
+		}
+		cs75xx_i2c_next_byte(i2c);
+		break;
+
+	case CS75XX_I2C_WRITE:
+		if (ack & CS75XX_I2C_ACK_NACK) {
+			/* The last byte of the last message carried the stop */
+			if (i2c->pos == msg->len && i2c->last)
+				cs75xx_i2c_finish(i2c, -EIO);
+			else
+				cs75xx_i2c_abort(i2c, -EIO);
+			return;
+		}
+		if (i2c->pos == msg->len) {
+			cs75xx_i2c_finish(i2c, 0);
+			return;
+		}
+		cs75xx_i2c_next_byte(i2c);
+		break;
+
+	case CS75XX_I2C_READ:
+		msg->buf[i2c->pos++] = readl(i2c->base + CS75XX_I2C_RXR);
+		if (i2c->pos == msg->len) {
+			cs75xx_i2c_finish(i2c, 0);
+			return;
+		}
+		cs75xx_i2c_next_byte(i2c);
+		break;
+
+	default:
+		break;
+	}
+}
+
+static irqreturn_t cs75xx_i2c_isr(int irq, void *dev_id)
+{
+	struct cs75xx_i2c *i2c = dev_id;
+	u32 ctrl, ack;
+
+	guard(spinlock)(&i2c->lock);
+
+	if (!(readl(i2c->base + CS75XX_I2C_INT) & CS75XX_I2C_INT_DONE))
+		return IRQ_NONE;
+
+	writel(CS75XX_I2C_INT_DONE, i2c->base + CS75XX_I2C_INT);
+
+	/* Acknowledge DONE with a CTRL read/writeback, as in the vendor driver. */
+	ctrl = readl(i2c->base + CS75XX_I2C_CTRL);
+	writel(ctrl, i2c->base + CS75XX_I2C_CTRL);
+
+	ack = readl(i2c->base + CS75XX_I2C_ACK);
+	cs75xx_i2c_process(i2c, ack);
+
+	return IRQ_HANDLED;
+}
+
+static int cs75xx_i2c_xfer_msg(struct cs75xx_i2c *i2c, struct i2c_msg *msg,
+			       bool last)
+{
+	unsigned long time_left;
+
+	spin_lock_irq(&i2c->lock);
+	reinit_completion(&i2c->done);
+	i2c->msg = msg;
+	i2c->pos = 0;
+	i2c->last = last;
+	i2c->err = 0;
+	i2c->state = CS75XX_I2C_ADDR;
+	writel(i2c_8bit_addr_from_msg(msg), i2c->base + CS75XX_I2C_TXR);
+	writel(CS75XX_I2C_CTRL_START | CS75XX_I2C_CTRL_WRITE,
+	       i2c->base + CS75XX_I2C_CTRL);
+	spin_unlock_irq(&i2c->lock);
+
+	time_left = wait_for_completion_timeout(&i2c->done, i2c->adap.timeout);
+	if (!time_left) {
+		spin_lock_irq(&i2c->lock);
+		i2c->state = CS75XX_I2C_IDLE;
+		spin_unlock_irq(&i2c->lock);
+		dev_err(i2c->dev, "transfer timed out, resetting the controller\n");
+		cs75xx_i2c_reset(i2c);
+		return -ETIMEDOUT;
+	}
+
+	return i2c->err;
+}
+
+static int cs75xx_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
+			   int num)
+{
+	struct cs75xx_i2c *i2c = i2c_get_adapdata(adap);
+	u32 val;
+	int i, ret;
+
+	/* Another master may hold the bus for a whole transfer */
+	if (readl_poll_timeout(i2c->base + CS75XX_I2C_ACK, val,
+			       !(val & CS75XX_I2C_ACK_BUSY), 100,
+			       jiffies_to_usecs(adap->timeout))) {
+		cs75xx_i2c_reset(i2c);
+		if (readl(i2c->base + CS75XX_I2C_ACK) & CS75XX_I2C_ACK_BUSY)
+			return -EBUSY;
+	}
+
+	for (i = 0; i < num; i++) {
+		ret = cs75xx_i2c_xfer_msg(i2c, &msgs[i], i == num - 1);
+		if (ret)
+			return ret;
+	}
+
+	return num;
+}
+
+static u32 cs75xx_i2c_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
+}
+
+static const struct i2c_algorithm cs75xx_i2c_algo = {
+	.xfer = cs75xx_i2c_xfer,
+	.functionality = cs75xx_i2c_func,
+};
+
+/* A message always carries at least one data byte after the address */
+static const struct i2c_adapter_quirks cs75xx_i2c_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN,
+};
+
+static void cs75xx_i2c_disable(void *data)
+{
+	struct cs75xx_i2c *i2c = data;
+
+	writel(0, i2c->base + CS75XX_I2C_IE);
+	writel(0, i2c->base + CS75XX_I2C_CFG);
+}
+
+static int cs75xx_i2c_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cs75xx_i2c *i2c;
+	unsigned long ref_rate;
+	struct clk *clk;
+	u32 bus_rate;
+	u64 div;
+	int ret;
+
+	i2c = devm_kzalloc(dev, sizeof(*i2c), GFP_KERNEL);
+	if (!i2c)
+		return -ENOMEM;
+
+	i2c->dev = dev;
+	spin_lock_init(&i2c->lock);
+	init_completion(&i2c->done);
+
+	i2c->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(i2c->base))
+		return PTR_ERR(i2c->base);
+
+	i2c->irq = platform_get_irq(pdev, 0);
+	if (i2c->irq < 0)
+		return i2c->irq;
+
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to get clock\n");
+
+	ref_rate = clk_get_rate(clk);
+	if (device_property_read_u32(dev, "clock-frequency", &bus_rate))
+		bus_rate = I2C_MAX_STANDARD_MODE_FREQ;
+	if (!bus_rate || bus_rate > I2C_MAX_FAST_MODE_FREQ)
+		return dev_err_probe(dev, -EINVAL,
+				     "unsupported bus frequency %u Hz\n",
+				     bus_rate);
+
+	div = DIV_ROUND_UP_ULL(ref_rate, 5ULL * bus_rate);
+	if (!div || div - 1 > FIELD_MAX(CS75XX_I2C_CFG_PRER))
+		return dev_err_probe(dev, -EINVAL,
+				     "cannot derive %u Hz from %lu Hz\n",
+				     bus_rate, ref_rate);
+	i2c->prer = div - 1;
+
+	cs75xx_i2c_hw_init(i2c);
+
+	writel(0, i2c->base + CS75XX_I2C_IE);
+	writel(CS75XX_I2C_INT_DONE, i2c->base + CS75XX_I2C_INT);
+
+	ret = devm_add_action_or_reset(dev, cs75xx_i2c_disable, i2c);
+	if (ret)
+		return ret;
+
+	ret = devm_request_irq(dev, i2c->irq, cs75xx_i2c_isr, 0, dev_name(dev),
+			       i2c);
+	if (ret)
+		return ret;
+
+	writel(CS75XX_I2C_INT_DONE, i2c->base + CS75XX_I2C_IE);
+
+	i2c->adap.owner = THIS_MODULE;
+	i2c->adap.algo = &cs75xx_i2c_algo;
+	i2c->adap.quirks = &cs75xx_i2c_quirks;
+	i2c->adap.retries = 3;
+	i2c->adap.dev.parent = dev;
+	device_set_node(&i2c->adap.dev, dev_fwnode(dev));
+	strscpy(i2c->adap.name, dev_name(dev), sizeof(i2c->adap.name));
+	i2c_set_adapdata(&i2c->adap, i2c);
+
+	ret = devm_i2c_add_adapter(dev, &i2c->adap);
+	if (ret)
+		return ret;
+
+	dev_dbg(dev, "bus %u Hz, reference %lu Hz\n", bus_rate,
+		ref_rate);
+
+	return 0;
+}
+
+static const struct of_device_id cs75xx_i2c_of_match[] = {
+	{ .compatible = "cortina,cs7542-i2c" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, cs75xx_i2c_of_match);
+
+static struct platform_driver cs75xx_i2c_driver = {
+	.probe = cs75xx_i2c_probe,
+	.driver = {
+		.name = "cs75xx-i2c",
+		.of_match_table = cs75xx_i2c_of_match,
+	},
+};
+module_platform_driver(cs75xx_i2c_driver);
+
+MODULE_DESCRIPTION("Cortina Systems CS75xx I2C controller driver");
+MODULE_LICENSE("GPL");

-- 
2.53.0


