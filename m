Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616D726CE39;
	Wed, 25 Mar 2026 01:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774401554; cv=none; b=b8TFyUUnpuBEvoCpxC4I+dwJ9oyInbKNX7P8HV8k0lWXwefmvgdWTqoVdoBstPuesZww/bVIWBeQE7xzWwAxA6AzazILgLOF4ZHMbkJwx68iim10+/9NFOjzIKbhJSonzopaQ3I+JqWaoosFS1n+HmbVEHT2bK+EHc3oSX4/uWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774401554; c=relaxed/simple;
	bh=Rg/Bc9YdfMuK7caX3Zt/dQAF6/dluLBBw3SnFSIs3lk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qf/awwUeGUvbzWzDhde4S7JTblPSwt4odTMNpwBLMLcasnrqWRitTme09qGAzc9EJrWYgwLVJGVJ0AziLUdR8ht+2sBZAO7woXbfkzUdAT7KDjJ4fgY6RnYbqT8BHuQ+RQnInEHIhaSHOtFlhxmAzuC8AEfu0+9DKXv5Qhcj3Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.101])
	by gateway (Coremail) with SMTP id _____8BxksANOMNpwWkeAA--.27798S3;
	Wed, 25 Mar 2026 09:19:09 +0800 (CST)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.101])
	by front1 (Coremail) with SMTP id qMiowJBxLMIIOMNpi6xcAA--.44576S4;
	Wed, 25 Mar 2026 09:19:08 +0800 (CST)
From: Hongliang Wang <wanghongliang@loongson.cn>
To: Binbin Zhou <zhoubinbin@loongson.cn>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hongliang Wang <wanghongliang@loongson.cn>
Cc: linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH v1 2/2] i2c: ls2x: Add clock-input and clock-div properties parsing
Date: Wed, 25 Mar 2026 09:18:52 +0800
Message-Id: <20260325011852.19079-3-wanghongliang@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260325011852.19079-1-wanghongliang@loongson.cn>
References: <20260325011852.19079-1-wanghongliang@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxLMIIOMNpi6xcAA--.44576S4
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw45Zr15Gryktw4UWryDJwc_yoW8Kr1xpF
	Z8Kan5Kr1qkF1S9r4vg347Xry5tws5JrZxGr17AwnrWanxXr1kXFy3tasYkFWkXF1xZa95
	Z3yqkr4DGF15AwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7MmhUUUUU

From: wanghongliang <wanghongliang@loongson.cn>

On 3A/7A/2K platform, the input clock of i2c controller and
the divisor of input clock maybe different, so define the
clock-input and clock-div properties in i2c controller node
description of dts or acpi. clock-input describes the input
clock of i2c controller and clock-div describes the clock
divisor of the input clock.

The formulas is
Prcescale = (clock-input * 10) / (clock-div * t->bus_freq_hz) - 1

The value of clock-input and clock-div on different platforms are
listed below:

1.7A1000/7A2000:
clock-input = 80MHZ
clock-div = 50

2.3A5000/3C5000/3A6000/3C6000:
clock-input = 100MHZ
clock-div = 40

3.2K0500/2K1000LA/2K2000:
clock-input = 100MHZ
clock-div = 40

4.2K3000:
clock-input = 100MHZ
clock-div = 55

Signed-off-by: wanghongliang <wanghongliang@loongson.cn>
---
 drivers/i2c/busses/i2c-ls2x.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-ls2x.c b/drivers/i2c/busses/i2c-ls2x.c
index b475dd27b7af..08c242e5fd75 100644
--- a/drivers/i2c/busses/i2c-ls2x.c
+++ b/drivers/i2c/busses/i2c-ls2x.c
@@ -96,6 +96,7 @@ static irqreturn_t ls2x_i2c_isr(int this_irq, void *dev_id)
 static void ls2x_i2c_adjust_bus_speed(struct ls2x_i2c_priv *priv)
 {
 	u16 val;
+	u32 pclk, div;
 	struct i2c_timings *t = &priv->i2c_t;
 	struct device *dev = priv->adapter.dev.parent;
 	u32 acpi_speed = i2c_acpi_find_bus_speed(dev);
@@ -107,12 +108,16 @@ static void ls2x_i2c_adjust_bus_speed(struct ls2x_i2c_priv *priv)
 	else
 		t->bus_freq_hz = LS2X_I2C_FREQ_STD;
 
+	if (!device_property_read_u32(dev, "clock-input", &pclk) &&
+	    !device_property_read_u32(dev, "clock-div", &div) && div != 0)
+		val = (pclk * 10) / (div * t->bus_freq_hz) - 1;
+	else
+		val = LS2X_I2C_PCLK_FREQ / (5 * t->bus_freq_hz) - 1;
 	/*
 	 * According to the chip manual, we can only access the registers as bytes,
 	 * otherwise the high bits will be truncated.
 	 * So set the I2C frequency with a sequential writeb() instead of writew().
 	 */
-	val = LS2X_I2C_PCLK_FREQ / (5 * t->bus_freq_hz) - 1;
 	writeb(FIELD_GET(GENMASK(7, 0), val), priv->base + I2C_LS2X_PRER_LO);
 	writeb(FIELD_GET(GENMASK(15, 8), val), priv->base + I2C_LS2X_PRER_HI);
 }
-- 
2.47.2

