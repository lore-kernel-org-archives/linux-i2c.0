Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672D9224F3;
	Thu,  7 May 2026 08:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778141497; cv=none; b=ImbgaB+ngN00aCUWLKzKMz5OVjT2x9+2JROQjZKxk8QhF5s6LLWj3BVf6TUM1FmMmHlemGgIHHBhEgAkZyzCgiq00nEUKoqZisAf2eMMO0DzusZoeO2tzQUGyvGyfNQ5b2CRptARqD8JpVY0DhzFh7WnbkYw9iB/uJR3MuYM7yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778141497; c=relaxed/simple;
	bh=QqOG+YJLMq4Z0Ohnpeg7klTdc2gzVyUaA7a15v/HyKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EnLx/vMKabEGkNCYPVr6JHLeEQbMSAYHp7hCX5ig4WmKX4tbp2nYu2zwSD24fkXXurxzGhA7xmoodR1iN2DnHyvhPAiUbAq1BOqdT5DAPYE3uM/xvINeSi63+kzlSQOGwZnBXVMINsHxFztktmMQtUCEhy6FpP87VUsz8RWlZog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.101])
	by gateway (Coremail) with SMTP id _____8DxhukqSfxpzGkHAA--.23984S3;
	Thu, 07 May 2026 16:11:22 +0800 (CST)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.101])
	by front1 (Coremail) with SMTP id qMiowJBxSeAkSfxpvyd8AA--.39544S3;
	Thu, 07 May 2026 16:11:21 +0800 (CST)
From: Hongliang Wang <wanghongliang@loongson.cn>
To: Binbin Zhou <zhoubinbin@loongson.cn>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Hongliang Wang <wanghongliang@loongson.cn>
Cc: linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH v2] i2c: ls2x: Add clocks property parsing and adjust bus speed
Date: Thu,  7 May 2026 16:10:10 +0800
Message-Id: <20260507081010.12810-2-wanghongliang@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260507081010.12810-1-wanghongliang@loongson.cn>
References: <20260507081010.12810-1-wanghongliang@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxSeAkSfxpvyd8AA--.39544S3
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJFW8Ar4xJF1DCF1rKrWkZrc_yoWrWr13pF
	WDCFZ5Gr4jqF12grnIqw17ZFyYvws5JFZ7tr4xtw1xK3Z3Wr1DZ3Wftrn0kF1kGF97u3y8
	Xayqgr45uayDZrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8HKZJUUUUU==

From: wanghongliang <wanghongliang@loongson.cn>

The i2c-ls2x driver supports dts and acpi parameter passing.
In dts, uses clock framework, by parsing clocks property to
get i2c bus reference clock, and define factor by device data.
In acpi, by passing clocks property to describe i2c bus reference
clock and clock-div property to describe factor.
Based on i2c bus reference clock(clock_a), i2c bus speed(clock_s)
and factor, calculate the prcescale of i2c divider register.
The calculation formula is
prcescale = clock_a/(factor*clock_s)-1

Signed-off-by: wanghongliang <wanghongliang@loongson.cn>
---
 drivers/i2c/busses/i2c-ls2x.c | 42 ++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ls2x.c b/drivers/i2c/busses/i2c-ls2x.c
index b475dd27b7af..7db91e7a5d78 100644
--- a/drivers/i2c/busses/i2c-ls2x.c
+++ b/drivers/i2c/busses/i2c-ls2x.c
@@ -13,6 +13,7 @@
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/completion.h>
+#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/iopoll.h>
 #include <linux/i2c.h>
@@ -63,11 +64,16 @@
 /* The default bus frequency, which is an empirical value */
 #define LS2X_I2C_FREQ_STD	(33 * HZ_PER_KHZ)
 
+struct ls2x_i2c_chip_data {
+	unsigned int	factor;
+};
+
 struct ls2x_i2c_priv {
 	struct i2c_adapter	adapter;
 	void __iomem		*base;
 	struct i2c_timings	i2c_t;
 	struct completion	cmd_complete;
+	const struct ls2x_i2c_chip_data	*chip_data;
 };
 
 /*
@@ -96,6 +102,8 @@ static irqreturn_t ls2x_i2c_isr(int this_irq, void *dev_id)
 static void ls2x_i2c_adjust_bus_speed(struct ls2x_i2c_priv *priv)
 {
 	u16 val;
+	u32 pclk, factor;
+	struct clk *clk;
 	struct i2c_timings *t = &priv->i2c_t;
 	struct device *dev = priv->adapter.dev.parent;
 	u32 acpi_speed = i2c_acpi_find_bus_speed(dev);
@@ -107,12 +115,30 @@ static void ls2x_i2c_adjust_bus_speed(struct ls2x_i2c_priv *priv)
 	else
 		t->bus_freq_hz = LS2X_I2C_FREQ_STD;
 
+	if (dev_of_node(dev)) {
+		clk = devm_clk_get_optional_enabled(dev, NULL);
+		if (IS_ERR(clk) || !clk)
+			pclk = LS2X_I2C_PCLK_FREQ;
+		else
+			pclk = clk_get_rate(clk);
+
+		factor = priv->chip_data->factor;
+
+		val = (pclk * 10) / (factor * t->bus_freq_hz) - 1;
+	} else {
+		if (!device_property_read_u32(dev, "clocks", &pclk) &&
+		    !device_property_read_u32(dev, "clock-div", &factor) &&
+		    factor != 0)
+			val = (pclk * 10) / (factor * t->bus_freq_hz) - 1;
+		else
+			val = LS2X_I2C_PCLK_FREQ / (5 * t->bus_freq_hz) - 1;
+	}
+
 	/*
 	 * According to the chip manual, we can only access the registers as bytes,
 	 * otherwise the high bits will be truncated.
 	 * So set the I2C frequency with a sequential writeb() instead of writew().
 	 */
-	val = LS2X_I2C_PCLK_FREQ / (5 * t->bus_freq_hz) - 1;
 	writeb(FIELD_GET(GENMASK(7, 0), val), priv->base + I2C_LS2X_PRER_LO);
 	writeb(FIELD_GET(GENMASK(15, 8), val), priv->base + I2C_LS2X_PRER_HI);
 }
@@ -295,6 +321,8 @@ static int ls2x_i2c_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->chip_data = device_get_match_data(dev);
+
 	/* Map hardware registers */
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
@@ -348,9 +376,17 @@ static int ls2x_i2c_resume(struct device *dev)
 static DEFINE_RUNTIME_DEV_PM_OPS(ls2x_i2c_pm_ops,
 				 ls2x_i2c_suspend, ls2x_i2c_resume, NULL);
 
+static const struct ls2x_i2c_chip_data ls2x_i2c_2k_data = {
+	.factor = 4,
+};
+
+static const struct ls2x_i2c_chip_data ls2x_i2c_7a_data = {
+	.factor = 5,
+};
+
 static const struct of_device_id ls2x_i2c_id_table[] = {
-	{ .compatible = "loongson,ls2k-i2c" },
-	{ .compatible = "loongson,ls7a-i2c" },
+	{ .compatible = "loongson,ls2k-i2c", .data = &ls2x_i2c_2k_data, },
+	{ .compatible = "loongson,ls7a-i2c", .data = &ls2x_i2c_7a_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, ls2x_i2c_id_table);
-- 
2.47.2

