Received: from ms1.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454C03BD629;
	Wed, 15 Jul 2026 07:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784100943; cv=none; b=j8kOovC98LaEgEl1dJsFf20/0OPRFutq8wU1nvov3IKdmRR4r2DWRFmm3iGAxbSfCPwr6P9T6rfsiS6xXtoX/t9DwtIwG2nzZsOJQUtE2TCbt1Fx07VKItzrRR6gjstchpAUUPzuPcl+6kV591JpCiBOKGy11N4W8zZ+tKL+9SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784100943; c=relaxed/simple;
	bh=XrpBrSzqAHhFkOMUBb4Vj2L+nXv9hn91/D0OJ96ZpUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tYI4JJ99AuKWFOiyvv+QynMbwwaKC5zBzvYcsW5pLZAEXj7pz3dbLHJCYC4QKTJl9z5a/EHBlHqxZ63LhNuCV6ciydZOGbt8hSgSNaGpOIHO8RLfJmoNv/Wv7CppBplSj4tZXOJrq+jbiDj820nKQNIVAJA/YNWlvFhCw1nZ3rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=HzZoYDBx; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="HzZoYDBx"
X-UUID: c4cd1a3e801f11f181a149c3f3c08161-20260715
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=vOt87bP1hOgaxUDS1yo1O42zmiUC4MNSRQiNlqNrKKw=;
	b=HzZoYDBxdiYJThS1pl7gMxcVjPfJy06q6kyyf+7L6N6ft/DXCxbJlBstygRu/PWhhmIgNmjShfUvlJ4Y0UqHdQIIFJc2aqMJHI/SrP+G6DLrebQCEEU9i5d1/tUkbwA3PFuGwvDnRzSGfqQtAkb8SJi92h89WeIkGIV+Imrm+08=;
X-UUID: c4cd1a3e801f11f181a149c3f3c08161-20260715
Received: from spmgt1 [(172.20.13.10)] by ms1.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 1002625376; Wed, 15 Jul 2026 15:35:35 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.13.160])
	by spmgt1 (Postfix) with ESMTP id E76981A1E1C;
	Wed, 15 Jul 2026 15:35:35 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id E9C95C600CC; Wed, 15 Jul 2026 15:35:34 +0800 (CST)
From: Nina_Kuo@novatek.com.tw
To: andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ben_huang@novatek.com.tw,
	toby_chui@novatek.com.tw,
	shihpei_hsu@novatek.com.tw
Subject: [PATCH v3 3/3] i2c: Add i2c-nt726xx.c I2C driver for Novatek NT726xx SoCs
Date: Wed, 15 Jul 2026 15:35:34 +0800
Message-Id: <20260715073534.147663-1-Nina_Kuo@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20260715073521.147610-1-Nina_Kuo@novatek.com.tw>
References: <20260715073521.147610-1-Nina_Kuo@novatek.com.tw>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Huang <Ben_Huang@novatek.com.tw>

This patch introduce the support of I2C bus controller driver of
Novatek NT726xx SoCs.

This driver performs the fundamental read/write functions as
an I2C controller and supports Standard-mode and Fast-mode.
Default operation is Stardard-mode.

Signed-off-by: Ben Huang <Ben_Huang@novatek.com.tw>
Signed-off-by: Nina Kuo <Nina_Kuo@novatek.com.tw>
---
 drivers/i2c/busses/Kconfig       |  10 +
 drivers/i2c/busses/Makefile      |   1 +
 drivers/i2c/busses/i2c-nt726xx.c | 698 +++++++++++++++++++++++++++++++
 3 files changed, 709 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-nt726xx.c

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index d35456994280..52ee2c82e9d5 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -962,6 +962,16 @@ config I2C_NPCM
 	  controllers.
 	  Driver can also support slave mode (select I2C_SLAVE).
 
+config I2C_NT726XX
+	tristate "Novatek NT726xx Driver"
+	default n
+	help
+	  Say Y here if you want to enable I2C bus controller on
+	  Novatek NT726xx SoCs.
+	  This driver performs fundamental read/write functions
+	  as an I2C bus controller and supports Standard-mode and
+	  Fast-mode. Default operation is Standard-mode.
+
 config I2C_OCORES
 	tristate "OpenCores I2C Controller"
 	help
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 3755c54b3d82..e82646919916 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -90,6 +90,7 @@ obj-$(CONFIG_I2C_MV64XXX)	+= i2c-mv64xxx.o
 obj-$(CONFIG_I2C_MXS)		+= i2c-mxs.o
 obj-$(CONFIG_I2C_NOMADIK)	+= i2c-nomadik.o
 obj-$(CONFIG_I2C_NPCM)		+= i2c-npcm7xx.o
+obj-$(CONFIG_I2C_NT726XX)	+= i2c-nt726xx.o
 obj-$(CONFIG_I2C_OCORES)	+= i2c-ocores.o
 obj-$(CONFIG_I2C_OMAP)		+= i2c-omap.o
 obj-$(CONFIG_I2C_OWL)		+= i2c-owl.o
diff --git a/drivers/i2c/busses/i2c-nt726xx.c b/drivers/i2c/busses/i2c-nt726xx.c
new file mode 100644
index 000000000000..ac3fd7ccc68c
--- /dev/null
+++ b/drivers/i2c/busses/i2c-nt726xx.c
@@ -0,0 +1,698 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Novatek Microelectronics Corp.
+ * Author: Ben Huang <ben_huang@novatek.com.tw>
+ */
+
+#include <linux/completion.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/irqdomain.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/version.h>
+
+#define I2C_INFO_LOG(fmt, ...)		\
+	pr_info("[I/SOC_I2C] " fmt, ##__VA_ARGS__)
+
+#define I2C_ERR_LOG(fmt, ...)		\
+	pr_err("[E/SOC_I2C] " fmt, ##__VA_ARGS__)
+
+#define I2C_NAME                              "NT726xx I2C adapter"
+#define I2C_REG_CTRL                          0xC0
+#define I2C_REG_CLK                           0xC4
+#define I2C_REG_ACK                           0xC8
+#define I2C_REG_SIZE                          0xCC
+#define I2C_REG_FIFO1                         0xD0
+#define I2C_REG_SUBADDR                       0xE0
+#define I2C_REG_PINGPONG                      0xE4
+#define I2C_REG_INTR                          0xE8
+#define I2C_REG_FIFO2                         0xEC
+#define I2C_REG_DUTY                          0xFC
+#define I2C_CLR_FIFO1                         0x80
+#define I2C_CLR_FIFO2                         0x800000
+#define I2C_BUF_LITTLE_ENDIAN                 0x00002000
+#define I2C_BUSY                              0x00000002
+#define I2C_ENABLE                            0x00000004
+#define I2C_REPEAT_ENABLE                     0x00000080
+#define I2C_READ_OPERATION                    0x00000100
+#define I2C_NACK                              0x01000000
+#define I2C_CLOCK_DUTY_ENABLE                 0x00200000
+#define I2C_CLOCK_STRETCH_ENABLE              0x08000000
+#define I2C_MASTER_CLK_STRETCH_ENABLE         0x10000000
+#define I2C_TRIGGER                           0x00000001
+#define I2C_IRQ_FLAG                          0x0000FF00
+#define I2C_IRQ_ARBI_LOSS                     0x00008000
+#define I2C_IRQ_SUS                           0x00004000
+#define I2C_IRQ_ALERT                         0x00002000
+#define I2C_IRQ_CLK_STR_TIMEOUT               0x00001000
+#define I2C_IRQ_NACK                          0x00000800
+#define I2C_IRQ_RX_FULL                       0x00000400
+#define I2C_IRQ_TX_EMPTY                      0x00000200
+#define I2C_IRQ_FINISH                        0x00000100
+#define I2C_IRQ_TX_SETTING                    0x001F001B
+#define I2C_IRQ_RX_SETTING                    0x001F001D
+#define I2C_IRQ_ENABLE_SETTING                0x001F001F
+#define I2C_IRQ_DISABLE_SETTING               0x00000000
+#define I2C_SUBADDR_ENABLE                    0x00000040
+#define I2C_16BITSUBADDR_ENABLE               0x00010000
+#define I2C_24BITSUBADDR_ENABLE               0x00020000
+#define I2C_32BITSUBADDR_ENABLE               0x00040000
+#define I2C_ACK_CTRL_COUNTER                  0x1E0
+#define I2C_TX_EMPTY_FIFO1                    0x40
+#define I2C_TX_EMPTY_FIFO2                    0x400000
+#define I2C_RX_FULL_FIFO1                     0x20
+#define I2C_RX_FULL_FIFO2                     0x200000
+#define FIFO_1                                0
+#define FIFO_2                                1
+#define FIFO_ALL                              2
+#define FIFO_CHUNK_SIZE                       16
+#define FIFO_WORD_BYTES                       4
+#define STBC_MASTER                           0xFC040000
+#define STBC_PSWD                             0xFC040204
+#define STBC_PSWD_DATA1                       0x72682
+#define STBC_PSWD_DATA2                       0x78627
+#define STBC_KEYPASS                          0xFC040208
+#define STBC_I2C_SWITCH                       0xFC040220
+
+enum {
+	SUBADDR_DISABLE,
+	SUBADDR_8BITS,
+	SUBADDR_16BITS,
+	SUBADDR_24BITS,
+	SUBADDR_32BITS,
+	SUBADDR_40BITS,
+	SUBADDR_48BITS,
+	SUBADDR_56BITS,
+	SUBADDR_64BITS
+};
+
+struct nvt_i2c_compatible_data {
+	unsigned int sys_clock; // Unit: Hz
+	unsigned int stbc_clock; // Unit: Hz
+};
+
+struct nvt_i2c_bus {
+	void __iomem *base;
+	struct i2c_adapter adapter;
+	struct device *dev;
+	struct completion msg_complete;
+	struct i2c_msg *msg;
+	unsigned int bus_clk_rate;
+	bool stbc_i2c;
+	const struct nvt_i2c_compatible_data *comp_data;
+	int irq;
+	/* used for xfer */
+	struct i2c_msg *current_msg;
+	int remaining;
+	int write_ptr;
+	int read_ptr;
+	int fifo_idx;
+	int error_code;
+};
+
+static void nvt_i2c_use_case_feature(struct nvt_i2c_bus *i2c)
+{
+	void __iomem *reg_tmp;
+
+	if (i2c->stbc_i2c) {
+		reg_tmp = ioremap(STBC_PSWD, 4);
+		if (reg_tmp) {
+			writel(readl(reg_tmp) | STBC_PSWD_DATA1, reg_tmp);
+			writel(readl(reg_tmp) | STBC_PSWD_DATA2, reg_tmp);
+			iounmap(reg_tmp);
+		} else {
+			I2C_ERR_LOG("stbc pswd ioremap failed\n");
+		}
+
+		reg_tmp = ioremap(STBC_KEYPASS, 4);
+		if (reg_tmp) {
+			writel(readl(reg_tmp) | 0x1, reg_tmp);
+			iounmap(reg_tmp);
+		} else {
+			I2C_ERR_LOG("stbc keypass ioremap failed\n");
+		}
+	}
+}
+
+static void nvt_i2c_reset(struct nvt_i2c_bus *i2c)
+{
+	writel(readl(i2c->base + I2C_REG_CTRL) & ~I2C_ENABLE,
+	       i2c->base + I2C_REG_CTRL);
+	writel(readl(i2c->base + I2C_REG_CTRL) | I2C_ENABLE,
+	       i2c->base + I2C_REG_CTRL);
+}
+
+static void nvt_i2c_set_clk(struct nvt_i2c_bus *i2c)
+{
+	unsigned int duty = 0;
+	unsigned int clk_div = 0;
+	unsigned int source_speed = i2c->stbc_i2c ?
+		i2c->comp_data->stbc_clock : i2c->comp_data->sys_clock;
+
+	clk_div = source_speed / i2c->bus_clk_rate;
+	writel(clk_div << 1, i2c->base + I2C_REG_CLK);
+
+	duty = (clk_div * 9 + 10) / 20;
+	writel(duty << 16, i2c->base + I2C_REG_DUTY);
+
+	writel(I2C_ACK_CTRL_COUNTER, i2c->base + I2C_REG_ACK);
+}
+
+static void nvt_i2c_set_subaddr(struct nvt_i2c_bus *i2c, struct i2c_msg *msg)
+{
+	unsigned int reg_ctrl;
+	unsigned int subaddr = 0;
+	int i = 0;
+
+	reg_ctrl = readl(i2c->base + I2C_REG_CTRL);
+	reg_ctrl &= ~(I2C_16BITSUBADDR_ENABLE |
+		      I2C_24BITSUBADDR_ENABLE |
+		      I2C_32BITSUBADDR_ENABLE);
+
+	if (msg && msg->len > 0 && msg->len <= 4 && msg->buf) {
+		reg_ctrl |= I2C_SUBADDR_ENABLE;
+
+		switch (msg->len) {
+		case SUBADDR_8BITS:
+			break;
+		case SUBADDR_16BITS:
+			reg_ctrl |= I2C_16BITSUBADDR_ENABLE;
+			break;
+		case SUBADDR_24BITS:
+			reg_ctrl |= I2C_24BITSUBADDR_ENABLE;
+			break;
+		case SUBADDR_32BITS:
+			reg_ctrl |= I2C_32BITSUBADDR_ENABLE;
+			break;
+		default:
+			return;
+		}
+
+		for (i = 0; i < msg->len; i++)
+			subaddr |= msg->buf[i] << (8 * (msg->len - 1 - i));
+		writel(subaddr, i2c->base + I2C_REG_SUBADDR);
+	} else {
+		reg_ctrl &= ~I2C_SUBADDR_ENABLE;
+	}
+
+	writel(reg_ctrl, i2c->base + I2C_REG_CTRL);
+}
+
+static void nvt_i2c_init(struct nvt_i2c_bus *i2c)
+{
+	nvt_i2c_use_case_feature(i2c);
+	nvt_i2c_set_clk(i2c);
+	writel(I2C_BUF_LITTLE_ENDIAN, i2c->base + I2C_REG_PINGPONG);
+	writel(I2C_IRQ_ENABLE_SETTING, i2c->base + I2C_REG_INTR);
+}
+
+static int nvt_i2c_suspend(struct device *dev)
+{
+	struct nvt_i2c_bus *i2c = dev_get_drvdata(dev);
+
+	if (i2c) {
+		i2c_mark_adapter_suspended(&i2c->adapter);
+		i2c->current_msg = NULL;
+		writel(I2C_IRQ_DISABLE_SETTING, i2c->base + I2C_REG_INTR);
+	}
+
+	return 0;
+}
+
+static int nvt_i2c_resume(struct device *dev)
+{
+	struct nvt_i2c_bus *i2c = dev_get_drvdata(dev);
+
+	if (i2c) {
+		nvt_i2c_init(i2c);
+		i2c_mark_adapter_resumed(&i2c->adapter);
+	}
+
+	return 0;
+}
+
+static void nvt_i2c_clear_fifo(struct nvt_i2c_bus *i2c, unsigned int which)
+{
+	unsigned int regval = readl(i2c->base + I2C_REG_PINGPONG);
+
+	switch (which) {
+	case FIFO_1:
+		regval |= I2C_CLR_FIFO1;
+		break;
+	case FIFO_2:
+		regval |= I2C_CLR_FIFO2;
+		break;
+	case FIFO_ALL:
+		regval |= I2C_CLR_FIFO1 | I2C_CLR_FIFO2;
+		break;
+	default:
+		break;
+	}
+	writel(regval, i2c->base + I2C_REG_PINGPONG);
+}
+
+static void nvt_i2c_write_fifo(struct nvt_i2c_bus *i2c,
+			       unsigned int fifo_reg,
+			       const unsigned char *buf,
+			       unsigned int buf_offset,
+			       unsigned int length)
+{
+	unsigned int reg_idx = 0, copy_bytes = 0, j = 0, value = 0;
+
+	while (length > 0) {
+		value = 0;
+		copy_bytes = length >= FIFO_WORD_BYTES ? FIFO_WORD_BYTES : length;
+		for (j = 0; j < copy_bytes; j++)
+			value |= ((unsigned int)buf[buf_offset + j]) << (j * 8);
+
+		writel(value, i2c->base + fifo_reg + reg_idx * 4);
+		buf_offset += copy_bytes;
+		length -= copy_bytes;
+		reg_idx++;
+	}
+}
+
+static void nvt_i2c_read_fifo(struct nvt_i2c_bus *i2c,
+			      unsigned int fifo_reg,
+			      unsigned char *buf,
+			      unsigned int buf_offset,
+			      unsigned int length)
+{
+	unsigned int reg_idx = 0, copy_bytes = 0, j = 0, value = 0;
+
+	while (length > 0) {
+		value = readl(i2c->base + fifo_reg + reg_idx * 4);
+		copy_bytes = length >= FIFO_WORD_BYTES ? FIFO_WORD_BYTES : length;
+		for (j = 0; j < copy_bytes; j++)
+			buf[buf_offset + j] = (unsigned char)(value >> (j * 8));
+
+		buf_offset += copy_bytes;
+		length -= copy_bytes;
+		reg_idx++;
+	}
+}
+
+static void nvt_i2c_handle(struct nvt_i2c_bus *i2c, struct i2c_msg *msg, int is_read)
+{
+	unsigned int bytes, fiforeg;
+
+	if (!i2c || !msg || !msg->buf || msg->len == 0 || msg->len > 4096) {
+		I2C_ERR_LOG("I2C invalid msg: i2c=%p, msg=%p, buf=%p, len=%d\n",
+			    i2c, msg, msg ? msg->buf : NULL, msg ? msg->len : 0);
+		if (i2c) {
+			I2C_ERR_LOG("[%s.%d]: i2c_handle\n", dev_name(i2c->dev), i2c->adapter.nr);
+			i2c->error_code = -EINVAL;
+		}
+
+		return;
+	}
+
+	bytes = i2c->remaining > FIFO_CHUNK_SIZE ? FIFO_CHUNK_SIZE : i2c->remaining;
+	fiforeg = i2c->fifo_idx == 0 ? I2C_REG_FIFO1 : I2C_REG_FIFO2;
+
+	if (is_read) {
+		nvt_i2c_read_fifo(i2c, fiforeg, msg->buf, i2c->read_ptr, bytes);
+		i2c->read_ptr += bytes;
+	} else {
+		nvt_i2c_write_fifo(i2c, fiforeg, msg->buf, i2c->write_ptr, bytes);
+		i2c->write_ptr += bytes;
+	}
+	nvt_i2c_clear_fifo(i2c, i2c->fifo_idx);
+	i2c->remaining -= bytes;
+	i2c->fifo_idx ^= 1;
+}
+
+static irqreturn_t nvt_i2c_isr(int irq, void *dev_id)
+{
+	struct nvt_i2c_bus *i2c = dev_id;
+	struct i2c_msg *msg = i2c->current_msg;
+	unsigned int status = readl(i2c->base + I2C_REG_INTR);
+	unsigned int clr = 0;
+	int do_complete = 0;
+
+	if (!(status & I2C_IRQ_FLAG) || !i2c->current_msg)
+		return IRQ_NONE;
+
+	if (status & I2C_IRQ_NACK) {
+		i2c->error_code = -ENXIO;
+		clr |= I2C_IRQ_NACK << 8;
+	} else if (status & I2C_IRQ_RX_FULL) {
+		if (i2c->remaining > 0)
+			nvt_i2c_handle(i2c, msg, 1);
+		clr |= I2C_IRQ_RX_FULL << 8;
+	} else if (status & I2C_IRQ_TX_EMPTY) {
+		if (i2c->remaining > 0)
+			nvt_i2c_handle(i2c, msg, 0);
+		clr |= I2C_IRQ_TX_EMPTY << 8;
+	} else if (status & I2C_IRQ_FINISH) {
+		if (i2c->remaining > 0 && (msg->flags & I2C_M_RD))
+			nvt_i2c_handle(i2c, msg, 1);
+		clr |= I2C_IRQ_FINISH << 8;
+		do_complete = 1;
+	}
+	if (i2c->error_code)
+		do_complete = 1;
+
+	writel(status | clr, i2c->base + I2C_REG_INTR);
+	if (do_complete)
+		complete(&i2c->msg_complete);
+
+	return IRQ_HANDLED;
+}
+
+static void nvt_i2c_ctrl_init(struct nvt_i2c_bus *i2c)
+{
+	int i = 0;
+
+	writel(0, i2c->base + I2C_REG_CTRL);
+	for (i = 0; i < 4; i++) {
+		writel(0, i2c->base + I2C_REG_FIFO1 + i * 4);
+		writel(0, i2c->base + I2C_REG_FIFO2 + i * 4);
+	}
+	nvt_i2c_clear_fifo(i2c, FIFO_ALL);
+	reinit_completion(&i2c->msg_complete);
+}
+
+static int nvt_i2c_check_msg(const struct i2c_msg *msg)
+{
+	if (!msg || !msg->buf || msg->len == 0 || msg->len > 4096)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void nvt_i2c_prepare_xfer(struct nvt_i2c_bus *i2c, struct i2c_msg *msg)
+{
+	i2c->remaining   = msg->len;
+	i2c->current_msg = msg;
+	i2c->write_ptr   = 0;
+	i2c->read_ptr    = 0;
+	i2c->error_code  = 0;
+	i2c->fifo_idx    = 0;
+}
+
+static int nvt_i2c_write(struct nvt_i2c_bus *i2c, struct i2c_msg *msg)
+{
+	const unsigned char *buf = msg->buf;
+	int ret, offset = 0, write_bytes, fifo_num;
+	unsigned int ctrl_mask;
+
+	ret = nvt_i2c_check_msg(msg);
+	if (ret)
+		return ret;
+
+	nvt_i2c_prepare_xfer(i2c, msg);
+
+	writel((msg->len * 8) << 8, i2c->base + I2C_REG_SIZE);
+
+	/*  Write FIFO data first */
+	for (fifo_num = 0; fifo_num < FIFO_ALL && offset < msg->len; fifo_num++) {
+		write_bytes = msg->len - offset > FIFO_CHUNK_SIZE ?
+				FIFO_CHUNK_SIZE : msg->len - offset;
+		nvt_i2c_write_fifo(i2c, fifo_num == 0 ? I2C_REG_FIFO1 : I2C_REG_FIFO2,
+				   buf, offset, write_bytes);
+		offset += write_bytes;
+	}
+	i2c->write_ptr = offset;
+	i2c->remaining = msg->len - offset;
+	i2c->fifo_idx = 0;
+
+	ctrl_mask = readl(i2c->base + I2C_REG_CTRL);
+	ctrl_mask |= (((msg->addr << 1) << 8) | I2C_ENABLE |
+			I2C_CLOCK_DUTY_ENABLE | I2C_CLOCK_STRETCH_ENABLE |
+			I2C_MASTER_CLK_STRETCH_ENABLE | I2C_TRIGGER);
+	writel(ctrl_mask, i2c->base + I2C_REG_CTRL);
+
+	ret = wait_for_completion_timeout(&i2c->msg_complete, i2c->adapter.timeout);
+	if (ret == 0) {
+		i2c->error_code = -ETIMEDOUT;
+		nvt_i2c_reset(i2c);
+	}
+	if (i2c->error_code)
+		I2C_ERR_LOG("[%s.%d]: write failed (err:%d);"
+			    " SA[0x%X]\n",
+			    dev_name(i2c->dev), i2c->adapter.nr, i2c->error_code,
+			    msg->addr);
+
+	i2c->current_msg = NULL;
+
+	return i2c->error_code;
+}
+
+static int nvt_i2c_read(struct nvt_i2c_bus *i2c, struct i2c_msg *msg)
+{
+	unsigned int ctrl_mask;
+	int ret;
+
+	ret = nvt_i2c_check_msg(msg);
+	if (ret)
+		return ret;
+
+	nvt_i2c_prepare_xfer(i2c, msg);
+
+	writel((msg->len * 8) << 8, i2c->base + I2C_REG_SIZE);
+
+	ctrl_mask = readl(i2c->base + I2C_REG_CTRL);
+	ctrl_mask |= (((msg->addr << 1) << 8) | I2C_ENABLE |
+			I2C_REPEAT_ENABLE | I2C_READ_OPERATION |
+			I2C_CLOCK_DUTY_ENABLE | I2C_CLOCK_STRETCH_ENABLE |
+			I2C_MASTER_CLK_STRETCH_ENABLE | I2C_TRIGGER);
+	writel(ctrl_mask, i2c->base + I2C_REG_CTRL);
+
+	ret = wait_for_completion_timeout(&i2c->msg_complete, i2c->adapter.timeout);
+	if (ret == 0) {
+		i2c->error_code = -ETIMEDOUT;
+		nvt_i2c_reset(i2c);
+	}
+	if (i2c->error_code)
+		I2C_ERR_LOG("[%s.%d]: read failed (err:%d);"
+			    " SA[0x%X]\n",
+			    dev_name(i2c->dev), i2c->adapter.nr, i2c->error_code,
+			    msg->addr);
+
+	i2c->current_msg = NULL;
+
+	return i2c->error_code;
+}
+
+static int nvt_i2c_xfer(struct i2c_adapter *adap,
+			struct i2c_msg msgs[],
+			int num)
+{
+	struct nvt_i2c_bus *i2c = i2c_get_adapdata(adap);
+	int ret = 0, i = 0;
+	struct i2c_msg *msg = NULL;
+
+	nvt_i2c_ctrl_init(i2c);
+
+	if (num == 2) {
+		nvt_i2c_set_subaddr(i2c, &msgs[0]);
+		msg = &msgs[1];
+
+		if (msg->flags & I2C_M_RD)
+			ret = nvt_i2c_read(i2c, msg);
+		else
+			ret = nvt_i2c_write(i2c, msg);
+	} else {
+		nvt_i2c_set_subaddr(i2c, NULL);
+
+		for (i = 0; i < num; i++) {
+			msg = &msgs[i];
+			if (msg->flags & I2C_M_RD)
+				ret = nvt_i2c_read(i2c, msg);
+			else
+				ret = nvt_i2c_write(i2c, msg);
+			if (ret < 0)
+				break;
+		}
+	}
+
+	if (ret < 0)
+		return ret;
+	return num;
+}
+
+static u32 nvt_i2c_func(struct i2c_adapter *adap)
+{
+	return (I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL) & ~I2C_FUNC_SMBUS_QUICK;
+}
+
+static int nvt_i2c_get_hwmods(const char *hwmods_name)
+{
+	long val;
+
+	if (!hwmods_name || strncmp(hwmods_name, "i2c", 3) != 0)
+		return -EINVAL;
+
+	if (kstrtol(hwmods_name + 3, 10, &val) == 0 && val >= 0)
+		return (int)val;
+
+	return -ENODEV;
+}
+
+static struct i2c_algorithm nvt_i2c_algo = {
+	.master_xfer = nvt_i2c_xfer,
+	.functionality = nvt_i2c_func,
+};
+
+static int nvt_i2c_parse_dts(struct nvt_i2c_bus *i2c)
+{
+	int ret;
+	struct device *dev = i2c->dev;
+	struct device_node *np = dev->of_node;
+	const char *hwmods_val = NULL;
+
+	/* read DTS(novatek,hwmods) and set bus number */
+	ret = of_property_read_string(np, "novatek,hwmods", &hwmods_val);
+	if (ret == 0) {
+		i2c->adapter.nr = nvt_i2c_get_hwmods(hwmods_val);
+		if (i2c->adapter.nr >= 0) {
+			I2C_INFO_LOG("Get novatek,hwmods:i2c%d\n", i2c->adapter.nr);
+		} else {
+			I2C_ERR_LOG("Invalid novatek,hwmods value = %d\n", i2c->adapter.nr);
+			return -EINVAL;
+		}
+	} else {
+		I2C_ERR_LOG("Can't get novatek,hwmods\n");
+		return ret;
+	}
+
+	i2c->comp_data = of_device_get_match_data(dev);
+
+	/* read DTS(novatek,stbc-controllable) */
+	i2c->stbc_i2c = of_property_read_bool(np, "novatek,stbc-controllable");
+
+	/* read DTS(clock-frequency) */
+	ret = of_property_read_u32(np, "clock-frequency", &i2c->bus_clk_rate);
+	if (ret || !i2c->bus_clk_rate) {
+		I2C_INFO_LOG("Not set dtb clock-frequency, set default 100kHz\n");
+		i2c->bus_clk_rate = 100000;
+	}
+
+	return 0;
+}
+
+static const struct nvt_i2c_compatible_data nt726xx_data = {
+	.sys_clock = 96000000,
+	.stbc_clock = 12000000,
+};
+
+static const struct of_device_id nvt_i2c_of_match[] = {
+	{ .compatible = "novatek,nt72600-i2c", .data = &nt726xx_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, nvt_i2c_of_match);
+
+static int nvt_i2c_probe(struct platform_device *pdev)
+{
+	struct nvt_i2c_bus *i2c;
+	struct resource *res;
+	int ret, irq;
+
+	i2c = devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
+	if (!i2c)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	i2c->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(i2c->base)) {
+		I2C_ERR_LOG("failed to map controller\n");
+		return PTR_ERR(i2c->base);
+	}
+
+	init_completion(&i2c->msg_complete);
+	i2c->dev = &pdev->dev;
+
+	ret = nvt_i2c_parse_dts(i2c);
+	if (ret)
+		return ret;
+
+	nvt_i2c_init(i2c);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		I2C_ERR_LOG("No IRQ resource\n");
+		return irq;
+	}
+
+	ret = devm_request_irq(&pdev->dev, irq, nvt_i2c_isr,
+			       IRQF_SHARED | IRQF_TRIGGER_HIGH, I2C_NAME, i2c);
+	if (ret) {
+		I2C_ERR_LOG("devm_request_irq fail\n");
+		return ret;
+	}
+
+	/* Setup I2C adapter */
+	i2c->adapter.owner = THIS_MODULE;
+	i2c->adapter.class = I2C_CLASS_HWMON;
+	i2c->adapter.algo = &nvt_i2c_algo;
+	i2c->adapter.dev.of_node = of_node_get(pdev->dev.of_node);
+	i2c->adapter.dev.parent = &pdev->dev;
+	i2c->adapter.timeout = 3 * HZ;
+	strscpy(i2c->adapter.name, I2C_NAME, sizeof(i2c->adapter.name));
+	i2c_set_adapdata(&i2c->adapter, i2c);
+
+	ret = i2c_add_numbered_adapter(&i2c->adapter);
+	if (ret) {
+		I2C_ERR_LOG("[%s] failed to add adapter\n", dev_name(&pdev->dev));
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, i2c);
+
+	return 0;
+}
+
+static void nvt_i2c_remove(struct platform_device *pdev)
+{
+	struct nvt_i2c_bus *i2c = platform_get_drvdata(pdev);
+
+	writel(I2C_IRQ_DISABLE_SETTING, i2c->base + I2C_REG_INTR);
+	writel(readl(i2c->base + I2C_REG_CTRL) & ~I2C_ENABLE,
+	       i2c->base + I2C_REG_CTRL);
+	of_node_put(i2c->adapter.dev.of_node);
+	i2c_del_adapter(&i2c->adapter);
+}
+
+static const struct dev_pm_ops nvt_i2c_pm_ops = {
+	.resume_early = nvt_i2c_resume,
+	.suspend_late = nvt_i2c_suspend,
+};
+
+static struct platform_driver nvt_i2c_driver = {
+	.probe = nvt_i2c_probe,
+	.remove = nvt_i2c_remove,
+	.driver = {
+		.name = "nvt_nt726xx_i2c",
+		.owner = THIS_MODULE,
+		.pm = &nvt_i2c_pm_ops,
+		.of_match_table = of_match_ptr(nvt_i2c_of_match),
+	},
+};
+
+static int __init nvt_i2c_platform_init(void)
+{
+	return platform_driver_register(&nvt_i2c_driver);
+}
+postcore_initcall(nvt_i2c_platform_init);
+
+static void __exit nvt_i2c_platform_exit(void)
+{
+	platform_driver_unregister(&nvt_i2c_driver);
+}
+module_exit(nvt_i2c_platform_exit);
+
+MODULE_DESCRIPTION("Novatek NT726xx SoC I2C Bus Driver");
+MODULE_AUTHOR("Ben Huang <ben_huang@novatek.com.tw>");
+MODULE_LICENSE("GPL");
-- 
2.40.1

