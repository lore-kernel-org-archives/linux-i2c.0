Received: from ms2.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB4717B50A;
	Thu,  6 Aug 2026 03:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785988601; cv=none; b=VGbyZMDp77Vd4CZ1xdgB4M46KE/r054iLFOdTkxVzg+ufHMiM4+x8CTxUMm6NTnr+/lZ0GGEGGP+0+IuNtShKeK/t4JajvVCxxa/oZ3jZOTv8svQiDzYrpwOslsBa6LcSz2eq8qaHzd8M+MNfFk3wleXU5OtS8Kfnn2IxRAHgdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785988601; c=relaxed/simple;
	bh=4yUZd1W4axEzQ67uqKJVrUHjbBIaxkxYDgvr+h8O5gk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AAEAY1qp92QvXJEiBSBcaSDWeNqzVNGHJqy0DfwguGaooqApMB3VNyZI59ysz7y48DR14G8I699Q6xmAOWMSHfdE5PtNQ6VX6D3qdW7YrEZv3XzpmSpjrEog7atCUyxCfw8TtrcShC0knZL/IL3W0Dp1axfkrf93f8zG35jo7zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=rS5Oifbk; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="rS5Oifbk"
X-UUID: d0b58548914a11f1b694ffd7d3467620-20260806
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=VY3g+5V8GiHLlm1Y5H8aavhrZDYXXwHsXHZppNyAI4E=;
	b=rS5Oifbkf6xomR9mJlwmpVSMaexhZoytuDIg025kjGCXgsdcb15ztQ7wOuuAVwSKo0bk9hkf/3xYCYyViiEVpGvH1KwGkyJKH9hie2te6QdOX9XmS1q7LHOI/BmsfNonEJCECIAR2wdWm7iBXm7+eCCV3RBDbAuDuPVCNqMAlyM=;
X-UUID: d0b58548914a11f1b694ffd7d3467620-20260806
Received: from spmgt1 [(172.20.13.10)] by ms2.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 11361097; Thu, 06 Aug 2026 11:56:34 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.13.160])
	by spmgt1 (Postfix) with ESMTP id 167191A22CC;
	Thu,  6 Aug 2026 11:56:34 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id 73354C600CF; Thu,  6 Aug 2026 11:56:32 +0800 (CST)
From: nina_kuo@novatek.com.tw
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
Subject: [PATCH v6 2/3] i2c: nt72676: Add Novatek NT72676 I2C controller driver
Date: Thu,  6 Aug 2026 11:56:31 +0800
Message-Id: <20260806035632.777782-3-nina_kuo@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20260806035632.777782-1-nina_kuo@novatek.com.tw>
References: <20260806035632.777782-1-nina_kuo@novatek.com.tw>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Huang <Ben_Huang@novatek.com.tw>

This driver performs the fundamental read/write functions as an I2C
controller and supports Standard-mode and Fast-mode.
Default operation is Standard-mode.

Signed-off-by: Ben Huang <Ben_Huang@novatek.com.tw>
Signed-off-by: Nina Kuo <Nina_Kuo@novatek.com.tw>
---
 drivers/i2c/busses/Kconfig       |  10 +
 drivers/i2c/busses/Makefile      |   1 +
 drivers/i2c/busses/i2c-nt72676.c | 728 +++++++++++++++++++++++++++++++
 3 files changed, 739 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-nt72676.c

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index d35456994280..a94b8746d883 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -962,6 +962,16 @@ config I2C_NPCM
 	  controllers.
 	  Driver can also support slave mode (select I2C_SLAVE).
 
+config I2C_NT72676
+	tristate "Novatek NT72676 I2C controller"
+	depends on OF || COMPILE_TEST
+	help
+	  Say Y here if you want to enable I2C bus controller on
+	  Novatek NT72676 SoC.
+	  This driver performs fundamental read/write functions
+	  as an I2C bus controller and supports Standard-mode and
+	  Fast-mode. Default operation is Standard-mode.
+
 config I2C_OCORES
 	tristate "OpenCores I2C Controller"
 	help
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 3755c54b3d82..e5440de0fe14 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -90,6 +90,7 @@ obj-$(CONFIG_I2C_MV64XXX)	+= i2c-mv64xxx.o
 obj-$(CONFIG_I2C_MXS)		+= i2c-mxs.o
 obj-$(CONFIG_I2C_NOMADIK)	+= i2c-nomadik.o
 obj-$(CONFIG_I2C_NPCM)		+= i2c-npcm7xx.o
+obj-$(CONFIG_I2C_NT72676)	+= i2c-nt72676.o
 obj-$(CONFIG_I2C_OCORES)	+= i2c-ocores.o
 obj-$(CONFIG_I2C_OMAP)		+= i2c-omap.o
 obj-$(CONFIG_I2C_OWL)		+= i2c-owl.o
diff --git a/drivers/i2c/busses/i2c-nt72676.c b/drivers/i2c/busses/i2c-nt72676.c
new file mode 100644
index 000000000000..b67509767680
--- /dev/null
+++ b/drivers/i2c/busses/i2c-nt72676.c
@@ -0,0 +1,728 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Novatek Microelectronics Corp.
+ * Author: Ben Huang <ben_huang@novatek.com.tw>
+ */
+
+#include <linux/completion.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define I2C_REG_CTRL			0x00
+#define I2C_REG_CLK			0x04
+#define I2C_REG_ACK			0x08
+#define I2C_REG_SIZE			0x0C
+#define I2C_REG_FIFO1			0x10
+#define I2C_REG_SUBADDR			0x20
+#define I2C_REG_PINGPONG		0x24
+#define I2C_REG_INTR			0x28
+#define I2C_REG_FIFO2			0x2C
+#define I2C_REG_DUTY			0x3C
+#define I2C_CLR_FIFO1			BIT(7)
+#define I2C_CLR_FIFO2			BIT(23)
+#define I2C_BUF_LITTLE_ENDIAN		BIT(13)
+#define I2C_BUSY			BIT(1)
+#define I2C_ENABLE			BIT(2)
+#define I2C_REPEAT_ENABLE		BIT(7)
+#define I2C_READ_OPERATION		BIT(8)
+#define I2C_NACK			BIT(24)
+#define I2C_CLOCK_DUTY_ENABLE		BIT(21)
+#define I2C_CLOCK_STRETCH_ENABLE	BIT(27)
+#define I2C_MASTER_CLK_STRETCH_ENABLE	BIT(28)
+#define I2C_TRIGGER			BIT(0)
+#define I2C_IRQ_FLAG			GENMASK(15, 8)
+#define I2C_IRQ_ARBI_LOSS		BIT(15)
+#define I2C_IRQ_SUS			BIT(14)
+#define I2C_IRQ_ALERT			BIT(13)
+#define I2C_IRQ_CLK_STR_TIMEOUT		BIT(12)
+#define I2C_IRQ_NACK			BIT(11)
+#define I2C_IRQ_RX_FULL			BIT(10)
+#define I2C_IRQ_TX_EMPTY		BIT(9)
+#define I2C_IRQ_FINISH			BIT(8)
+#define I2C_IRQ_CLEAR_ALL		GENMASK(20, 16)
+#define I2C_IRQ_ENABLE_SETTING		GENMASK(4, 0)
+#define I2C_IRQ_DISABLE_SETTING		0x00000000
+#define I2C_SUBADDR_ENABLE		BIT(6)
+#define I2C_16BITSUBADDR_ENABLE		BIT(16)
+#define I2C_24BITSUBADDR_ENABLE		BIT(17)
+#define I2C_32BITSUBADDR_ENABLE		BIT(18)
+#define I2C_ACK_CTRL_COUNTER		0x000001E0
+#define I2C_TX_EMPTY_FIFO1		BIT(6)
+#define I2C_TX_EMPTY_FIFO2		BIT(22)
+#define I2C_RX_FULL_FIFO1		BIT(5)
+#define I2C_RX_FULL_FIFO2		BIT(21)
+
+#define STBC_REG_PSWD			0x0204
+#define STBC_REG_KEYPASS		0x0208
+#define STBC_REG_I2C_SWITCH		0x0220
+#define STBC_PSWD_DATA1			0x72682
+#define STBC_PSWD_DATA2			0x28627
+#define STBC_KEYPASS_ENABLE		BIT(0)
+#define STBC_AGPIO_SWITCH_TO_CPU	BIT(14)
+
+#define FIFO_CHUNK_SIZE			16
+#define FIFO_WORD_BYTES			4
+#define MAX_MSG_SIZE			4096
+
+enum {
+	SUBADDR_DISABLE,
+	SUBADDR_8BITS,
+	SUBADDR_16BITS,
+	SUBADDR_24BITS,
+	SUBADDR_32BITS
+};
+
+enum {
+	FIFO_1 = 0,
+	FIFO_2,
+	FIFO_ALL
+};
+
+struct nvt_i2c_compatible_data {
+	bool stbc_i2c;
+	unsigned int source_clock; /* Unit: Hz */
+	unsigned long reg_offset;
+};
+
+struct nvt_i2c_bus {
+	void __iomem *base;
+	struct i2c_adapter adapter;
+	struct device *dev;
+	struct completion msg_complete;
+	struct i2c_msg *msg;
+	unsigned int bus_clk_rate;
+	const struct nvt_i2c_compatible_data *comp_data;
+	struct regmap *stbc_regmap;
+	int irq;
+	/* lock for msg and reg protection */
+	spinlock_t lock;
+	/* used for xfer, protected by lock */
+	struct i2c_msg *current_msg;
+	int remaining;
+	int write_ptr;
+	int read_ptr;
+	int fifo_idx;
+	int error_code;
+};
+
+static void nt72676_i2c_writel(u32 val, struct nvt_i2c_bus *i2c, unsigned int reg)
+{
+	writel(val, i2c->base + i2c->comp_data->reg_offset + reg);
+}
+
+static u32 nt72676_i2c_readl(struct nvt_i2c_bus *i2c, unsigned int reg)
+{
+	return readl(i2c->base + i2c->comp_data->reg_offset + reg);
+}
+
+static int nvt_i2c_stbc_auth(struct nvt_i2c_bus *i2c)
+{
+	unsigned int val;
+	int ret;
+
+	if (!i2c->comp_data->stbc_i2c)
+		return 0;
+
+	ret = regmap_write(i2c->stbc_regmap, STBC_REG_PSWD, STBC_PSWD_DATA1);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(i2c->stbc_regmap, STBC_REG_PSWD, STBC_PSWD_DATA2);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(i2c->stbc_regmap, STBC_REG_KEYPASS, STBC_KEYPASS_ENABLE);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(i2c->stbc_regmap, STBC_REG_I2C_SWITCH, &val);
+	if (ret)
+		return ret;
+
+	val |= STBC_AGPIO_SWITCH_TO_CPU;
+	return regmap_write(i2c->stbc_regmap, STBC_REG_I2C_SWITCH, val);
+}
+
+static void nvt_i2c_reset(struct nvt_i2c_bus *i2c)
+{
+	nt72676_i2c_writel(nt72676_i2c_readl(i2c, I2C_REG_CTRL) & ~I2C_ENABLE,
+			   i2c, I2C_REG_CTRL);
+	nt72676_i2c_writel(nt72676_i2c_readl(i2c, I2C_REG_CTRL) | I2C_ENABLE,
+			   i2c, I2C_REG_CTRL);
+	nt72676_i2c_writel(I2C_IRQ_ENABLE_SETTING | I2C_IRQ_CLEAR_ALL,
+			   i2c, I2C_REG_INTR);
+}
+
+static void nvt_i2c_set_clk(struct nvt_i2c_bus *i2c)
+{
+	unsigned int source_speed = i2c->comp_data->source_clock;
+	unsigned int clk_div = 0;
+	unsigned int duty = 0;
+
+	clk_div = source_speed / i2c->bus_clk_rate;
+	nt72676_i2c_writel(clk_div << 1, i2c, I2C_REG_CLK);
+
+	duty = (clk_div * 9 + 10) / 20;
+	nt72676_i2c_writel(duty << 16, i2c, I2C_REG_DUTY);
+
+	nt72676_i2c_writel(I2C_ACK_CTRL_COUNTER, i2c, I2C_REG_ACK);
+}
+
+static bool nvt_i2c_set_subaddr(struct nvt_i2c_bus *i2c,
+				const struct i2c_msg *msg,
+				int num)
+{
+	unsigned int reg_ctrl, subaddr = 0;
+	int i = 0;
+
+	reg_ctrl = nt72676_i2c_readl(i2c, I2C_REG_CTRL);
+	reg_ctrl &= ~(I2C_16BITSUBADDR_ENABLE |
+		      I2C_24BITSUBADDR_ENABLE |
+		      I2C_32BITSUBADDR_ENABLE);
+
+	if (msg && num == 2 && msg[0].len && msg[0].buf) {
+		if (msg[0].len <= SUBADDR_32BITS && !(msg[0].flags & I2C_M_RD) &&
+		    msg[0].addr == msg[1].addr) {
+			reg_ctrl |= I2C_SUBADDR_ENABLE;
+
+			switch (msg[0].len) {
+			case SUBADDR_8BITS:
+				break;
+			case SUBADDR_16BITS:
+				reg_ctrl |= I2C_16BITSUBADDR_ENABLE;
+				break;
+			case SUBADDR_24BITS:
+				reg_ctrl |= I2C_24BITSUBADDR_ENABLE;
+				break;
+			case SUBADDR_32BITS:
+				reg_ctrl |= I2C_32BITSUBADDR_ENABLE;
+				break;
+			default:
+				return false;
+			}
+
+			for (i = 0; i < msg[0].len; i++)
+				subaddr |= msg[0].buf[i] << (8 * (msg[0].len - 1 - i));
+			nt72676_i2c_writel(subaddr, i2c, I2C_REG_SUBADDR);
+		} else {
+			dev_err(i2c->dev,
+				"[%s]: invalid msg, addr1 = 0x%x, addr2 = 0x%x, len = %u, flags = 0x%x\n",
+				i2c->adapter.name, msg[0].addr, msg[1].addr,
+				msg[0].len, msg[0].flags);
+			return false;
+		}
+	} else {
+		reg_ctrl &= ~I2C_SUBADDR_ENABLE;
+	}
+
+	nt72676_i2c_writel(reg_ctrl, i2c, I2C_REG_CTRL);
+	return true;
+}
+
+static int nvt_i2c_init(struct nvt_i2c_bus *i2c)
+{
+	if (i2c->comp_data->stbc_i2c) {
+		int ret = nvt_i2c_stbc_auth(i2c);
+
+		if (ret) {
+			dev_err(i2c->dev, "[%s] STBC authentication failed, ret = %d\n",
+				i2c->adapter.name, ret);
+			return ret;
+		}
+	}
+	nvt_i2c_set_clk(i2c);
+	nt72676_i2c_writel(I2C_BUF_LITTLE_ENDIAN, i2c, I2C_REG_PINGPONG);
+	nt72676_i2c_writel(I2C_IRQ_ENABLE_SETTING | I2C_IRQ_CLEAR_ALL,
+			   i2c, I2C_REG_INTR);
+
+	return 0;
+}
+
+static int nvt_i2c_suspend(struct device *dev)
+{
+	struct nvt_i2c_bus *i2c = dev_get_drvdata(dev);
+
+	if (i2c) {
+		unsigned long flags;
+
+		i2c_mark_adapter_suspended(&i2c->adapter);
+		spin_lock_irqsave(&i2c->lock, flags);
+		i2c->current_msg = NULL;
+		nt72676_i2c_writel(I2C_IRQ_DISABLE_SETTING, i2c, I2C_REG_INTR);
+		spin_unlock_irqrestore(&i2c->lock, flags);
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
+		int ret = nvt_i2c_init(i2c);
+
+		if (ret)
+			return ret;
+		i2c_mark_adapter_resumed(&i2c->adapter);
+	}
+
+	return 0;
+}
+
+static void nvt_i2c_clear_fifo(struct nvt_i2c_bus *i2c, unsigned int which)
+{
+	unsigned int regval = nt72676_i2c_readl(i2c, I2C_REG_PINGPONG);
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
+	nt72676_i2c_writel(regval, i2c, I2C_REG_PINGPONG);
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
+		copy_bytes = min(FIFO_WORD_BYTES, length);
+		for (j = 0; j < copy_bytes; j++)
+			value |= ((unsigned int)buf[buf_offset + j]) << (j * 8);
+
+		nt72676_i2c_writel(value, i2c, fifo_reg + reg_idx * 4);
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
+		value = nt72676_i2c_readl(i2c, fifo_reg + reg_idx * 4);
+		copy_bytes = min(FIFO_WORD_BYTES, length);
+		for (j = 0; j < copy_bytes; j++)
+			buf[buf_offset + j] = (unsigned char)(value >> (j * 8));
+
+		buf_offset += copy_bytes;
+		length -= copy_bytes;
+		reg_idx++;
+	}
+}
+
+static void nvt_i2c_handle(struct nvt_i2c_bus *i2c, struct i2c_msg *msg, bool is_read)
+{
+	unsigned int bytes, fiforeg;
+
+	if (!i2c || !msg || !msg->buf || !msg->len || msg->len > MAX_MSG_SIZE) {
+		dev_err(i2c->dev, "I2C invalid msg: i2c=%p, msg=%p, buf=%p, len=%d\n",
+			i2c, msg, msg ? msg->buf : NULL, msg ? msg->len : 0);
+		if (i2c) {
+			dev_err(i2c->dev, "[%s]: i2c_handle\n", i2c->adapter.name);
+			i2c->error_code = -EINVAL;
+		}
+
+		return;
+	}
+
+	bytes = min(FIFO_CHUNK_SIZE, i2c->remaining);
+	fiforeg = i2c->fifo_idx == FIFO_1 ? I2C_REG_FIFO1 : I2C_REG_FIFO2;
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
+	unsigned int status, clr = 0;
+	struct i2c_msg *msg;
+	int do_complete = 0;
+
+	spin_lock(&i2c->lock);
+	status = nt72676_i2c_readl(i2c, I2C_REG_INTR);
+	/* IRQ from other I2C, ignored */
+	if (!(status & I2C_IRQ_FLAG)) {
+		spin_unlock(&i2c->lock);
+		return IRQ_NONE;
+	}
+
+	msg = i2c->current_msg;
+	if (!msg) {
+		status &= ~I2C_IRQ_FLAG;
+		status |= I2C_IRQ_CLEAR_ALL;
+		nt72676_i2c_writel(status, i2c, I2C_REG_INTR);
+		spin_unlock(&i2c->lock);
+		return IRQ_HANDLED;
+	}
+
+	if (status & I2C_IRQ_CLK_STR_TIMEOUT) {
+		i2c->error_code = -ETIMEDOUT;
+		clr |= I2C_IRQ_CLK_STR_TIMEOUT << 8;
+	} else if (status & I2C_IRQ_NACK) {
+		i2c->error_code = -ENXIO;
+		clr |= I2C_IRQ_NACK << 8;
+	} else if (status & I2C_IRQ_RX_FULL) {
+		if (i2c->remaining > 0)
+			nvt_i2c_handle(i2c, msg, true);
+		clr |= I2C_IRQ_RX_FULL << 8;
+	} else if (status & I2C_IRQ_TX_EMPTY) {
+		if (i2c->remaining > 0)
+			nvt_i2c_handle(i2c, msg, false);
+		clr |= I2C_IRQ_TX_EMPTY << 8;
+	} else if (status & I2C_IRQ_FINISH) {
+		if (i2c->remaining > 0 && (msg->flags & I2C_M_RD))
+			nvt_i2c_handle(i2c, msg, true);
+		clr |= I2C_IRQ_FINISH << 8;
+		do_complete = 1;
+	}
+	if (i2c->error_code)
+		do_complete = 1;
+
+	nt72676_i2c_writel(status | clr, i2c, I2C_REG_INTR);
+	spin_unlock(&i2c->lock);
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
+	nt72676_i2c_writel(0, i2c, I2C_REG_CTRL);
+	for (i = 0; i < 4; i++) {
+		nt72676_i2c_writel(0, i2c, I2C_REG_FIFO1 + i * 4);
+		nt72676_i2c_writel(0, i2c, I2C_REG_FIFO2 + i * 4);
+	}
+	nvt_i2c_clear_fifo(i2c, FIFO_ALL);
+	reinit_completion(&i2c->msg_complete);
+}
+
+static int nvt_i2c_check_msg(const struct i2c_msg *msg)
+{
+	if (!msg || !msg->buf || !msg->len || msg->len > MAX_MSG_SIZE)
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
+	i2c->fifo_idx    = FIFO_1;
+}
+
+static int nvt_i2c_write(struct nvt_i2c_bus *i2c, struct i2c_msg *msg)
+{
+	int ret, offset = 0, write_bytes, fifo_num;
+	const unsigned char *buf = msg->buf;
+	unsigned int ctrl_mask;
+	unsigned long flags;
+
+	ret = nvt_i2c_check_msg(msg);
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&i2c->lock, flags);
+	nvt_i2c_prepare_xfer(i2c, msg);
+
+	nt72676_i2c_writel((msg->len * 8) << 8, i2c, I2C_REG_SIZE);
+
+	/*  Write FIFO data first */
+	for (fifo_num = FIFO_1; fifo_num < FIFO_ALL && offset < msg->len; fifo_num++) {
+		write_bytes = min(FIFO_CHUNK_SIZE, msg->len - offset);
+		nvt_i2c_write_fifo(i2c, fifo_num == FIFO_1 ? I2C_REG_FIFO1 : I2C_REG_FIFO2,
+				   buf, offset, write_bytes);
+		offset += write_bytes;
+	}
+	i2c->write_ptr = offset;
+	i2c->remaining = msg->len - offset;
+	i2c->fifo_idx = FIFO_1;
+
+	ctrl_mask = nt72676_i2c_readl(i2c, I2C_REG_CTRL);
+	ctrl_mask |= (((msg->addr << 1) << 8) | I2C_ENABLE |
+			I2C_CLOCK_DUTY_ENABLE | I2C_CLOCK_STRETCH_ENABLE |
+			I2C_MASTER_CLK_STRETCH_ENABLE | I2C_TRIGGER);
+	nt72676_i2c_writel(ctrl_mask, i2c, I2C_REG_CTRL);
+	spin_unlock_irqrestore(&i2c->lock, flags);
+
+	ret = wait_for_completion_timeout(&i2c->msg_complete, i2c->adapter.timeout);
+	spin_lock_irqsave(&i2c->lock, flags);
+	if (!ret) {
+		i2c->error_code = -ETIMEDOUT;
+		nvt_i2c_reset(i2c);
+	}
+	ret = i2c->error_code;
+	i2c->current_msg = NULL;
+	spin_unlock_irqrestore(&i2c->lock, flags);
+
+	if (ret)
+		dev_err(i2c->dev, "[%s]: write failed (err:%d); SA[0x%X]\n",
+			i2c->adapter.name, i2c->error_code, msg->addr);
+
+	return ret;
+}
+
+static int nvt_i2c_read(struct nvt_i2c_bus *i2c, struct i2c_msg *msg)
+{
+	unsigned int ctrl_mask;
+	unsigned long flags;
+	int ret;
+
+	ret = nvt_i2c_check_msg(msg);
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&i2c->lock, flags);
+	nvt_i2c_prepare_xfer(i2c, msg);
+
+	nt72676_i2c_writel((msg->len * 8) << 8, i2c, I2C_REG_SIZE);
+
+	ctrl_mask = nt72676_i2c_readl(i2c, I2C_REG_CTRL);
+	ctrl_mask |= (((msg->addr << 1) << 8) | I2C_ENABLE |
+			I2C_REPEAT_ENABLE | I2C_READ_OPERATION |
+			I2C_CLOCK_DUTY_ENABLE | I2C_CLOCK_STRETCH_ENABLE |
+			I2C_MASTER_CLK_STRETCH_ENABLE | I2C_TRIGGER);
+	nt72676_i2c_writel(ctrl_mask, i2c, I2C_REG_CTRL);
+	spin_unlock_irqrestore(&i2c->lock, flags);
+
+	ret = wait_for_completion_timeout(&i2c->msg_complete, i2c->adapter.timeout);
+	spin_lock_irqsave(&i2c->lock, flags);
+	if (!ret) {
+		i2c->error_code = -ETIMEDOUT;
+		nvt_i2c_reset(i2c);
+	}
+	ret = i2c->error_code;
+	i2c->current_msg = NULL;
+	spin_unlock_irqrestore(&i2c->lock, flags);
+
+	if (ret)
+		dev_err(i2c->dev, "[%s]: read failed (err:%d); SA[0x%X]\n",
+			i2c->adapter.name, i2c->error_code, msg->addr);
+
+	return ret;
+}
+
+static int nvt_i2c_xfer(struct i2c_adapter *adap,
+			struct i2c_msg msgs[],
+			int num)
+{
+	struct nvt_i2c_bus *i2c = i2c_get_adapdata(adap);
+	struct i2c_msg *msg = NULL;
+	int ret = 0, i = 0;
+
+	nvt_i2c_ctrl_init(i2c);
+
+	if (num == 2) {
+		if (!nvt_i2c_set_subaddr(i2c, msgs, num))
+			return -EOPNOTSUPP;
+
+		msg = &msgs[1];
+		if (msg->flags & I2C_M_RD)
+			ret = nvt_i2c_read(i2c, msg);
+		else
+			ret = nvt_i2c_write(i2c, msg);
+	} else {
+		if (!nvt_i2c_set_subaddr(i2c, NULL, 0))
+			return -EOPNOTSUPP;
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
+static const struct i2c_algorithm nvt_i2c_algo = {
+	.master_xfer = nvt_i2c_xfer,
+	.functionality = nvt_i2c_func,
+};
+
+static int nvt_i2c_parse_dts(struct nvt_i2c_bus *i2c)
+{
+	struct device *dev = i2c->dev;
+	struct device_node *np = dev->of_node;
+	int ret;
+
+	i2c->comp_data = of_device_get_match_data(dev);
+
+	/* read DTS(novatek,stbc-syscon) for STBC I2C */
+	if (i2c->comp_data->stbc_i2c) {
+		i2c->stbc_regmap = syscon_regmap_lookup_by_phandle(i2c->dev->of_node,
+								   "novatek,stbc-syscon");
+		if (IS_ERR(i2c->stbc_regmap))
+			return dev_err_probe(i2c->dev, PTR_ERR(i2c->stbc_regmap),
+					     "Failed to get STBC syscon\n");
+	}
+
+	/* read DTS(clock-frequency) */
+	ret = of_property_read_u32(np, "clock-frequency", &i2c->bus_clk_rate);
+	if (ret || !i2c->bus_clk_rate) {
+		dev_info(i2c->dev, "Not set dtb clock-frequency, set default 100kHz\n");
+		i2c->bus_clk_rate = I2C_MAX_STANDARD_MODE_FREQ;
+	}
+
+	return 0;
+}
+
+static const struct nvt_i2c_compatible_data nt72676_i2c_data = {
+	.stbc_i2c = false,
+	.source_clock = 96000000,
+	.reg_offset = 0xC0,
+};
+
+static const struct nvt_i2c_compatible_data nt72676_stbc_i2c_data = {
+	.stbc_i2c = true,
+	.source_clock = 12000000,
+	.reg_offset = 0,
+};
+
+static const struct of_device_id nvt_i2c_of_match[] = {
+	{ .compatible = "novatek,nt72676-i2c", .data = &nt72676_i2c_data },
+	{ .compatible = "novatek,nt72676-stbc-i2c", .data = &nt72676_stbc_i2c_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, nvt_i2c_of_match);
+
+static int nvt_i2c_probe(struct platform_device *pdev)
+{
+	struct nvt_i2c_bus *i2c;
+	int ret;
+
+	i2c = devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
+	if (!i2c)
+		return -ENOMEM;
+
+	i2c->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(i2c->base))
+		return PTR_ERR(i2c->base);
+
+	spin_lock_init(&i2c->lock);
+	init_completion(&i2c->msg_complete);
+	i2c->dev = &pdev->dev;
+
+	ret = nvt_i2c_parse_dts(i2c);
+	if (ret)
+		return ret;
+
+	i2c->irq = platform_get_irq(pdev, 0);
+	if (i2c->irq < 0)
+		return i2c->irq;
+	ret = devm_request_irq(&pdev->dev, i2c->irq, nvt_i2c_isr,
+			       IRQF_SHARED | IRQF_TRIGGER_HIGH, dev_name(&pdev->dev), i2c);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "[%s] devm_request_irq fail\n",
+				     dev_name(&pdev->dev));
+
+	ret = nvt_i2c_init(i2c);
+	if (ret)
+		return ret;
+
+	/* Setup I2C adapter */
+	i2c->adapter.owner = THIS_MODULE;
+	i2c->adapter.algo = &nvt_i2c_algo;
+	i2c->adapter.dev.of_node = pdev->dev.of_node;
+	i2c->adapter.dev.parent = &pdev->dev;
+	i2c->adapter.timeout = 3 * HZ;
+	strscpy(i2c->adapter.name, dev_name(&pdev->dev), sizeof(i2c->adapter.name));
+	i2c_set_adapdata(&i2c->adapter, i2c);
+
+	ret = i2c_add_adapter(&i2c->adapter);
+	if (ret) {
+		nt72676_i2c_writel(I2C_IRQ_DISABLE_SETTING, i2c, I2C_REG_INTR);
+		return dev_err_probe(&pdev->dev, ret, "Failed to add adapter\n");
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
+	unsigned long flags;
+
+	i2c_del_adapter(&i2c->adapter);
+	spin_lock_irqsave(&i2c->lock, flags);
+	nt72676_i2c_writel(I2C_IRQ_DISABLE_SETTING, i2c, I2C_REG_INTR);
+	nt72676_i2c_writel(nt72676_i2c_readl(i2c, I2C_REG_CTRL) & ~I2C_ENABLE,
+			   i2c, I2C_REG_CTRL);
+	spin_unlock_irqrestore(&i2c->lock, flags);
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
+		.name = "nt72676_i2c",
+		.pm = &nvt_i2c_pm_ops,
+		.of_match_table = of_match_ptr(nvt_i2c_of_match),
+	},
+};
+module_platform_driver(nvt_i2c_driver);
+
+MODULE_DESCRIPTION("Novatek NT72676 SoC I2C Bus Driver");
+MODULE_AUTHOR("Ben Huang <ben_huang@novatek.com.tw>");
+MODULE_LICENSE("GPL");
-- 
2.40.1

