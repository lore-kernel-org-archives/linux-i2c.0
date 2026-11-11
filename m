Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.4.11.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794389996;
	b=NkcIgHYPwOPfyT4r4a0eHYmktkVXL3iU87ScX2X/OYjj5PEIz67us2cKlHfqt8YafCXY
	 hsvR0GsuN5CS0bCtxzvaKMqRQ1UD5GQ4J9Bbz0X+b2KZY+OR9IsHZBQ0HJOt/XOGJTk+2
	 dFb272lii9pfBaXsfc9atBxBjzmuB3Doe6InEIrdY4yj5pnOC78iW/BGMFxFSBIbl8vmF
	 ggWQBVr9kbedFKK+wYxDzCA4xEyB6xqLWm5hqMQtxwBB/bt3AljxGqq8E1wySkVZtmIW4
	 gBZKyKyfg5cWg85QiXmpA7OJseaMBZ61hhjFA+z6NGHyHcGzWsENHOhoMmMdPFybxAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389996;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sOmg8pF/82dquPMd4rQf73eaB6QpmmTcPKl4uD99Q8U=;
	b=V8pNztEMeoLYfzNv7N7Mjvu6Z1kg2miiJaKnJyYz6IP6TAWs5DIliSHmxuqiebarytzZ
	 stQhqSMv12tvT1Wncnhv/LHo/6xh/pp66JXsiX8FUVugC49aHrW2UWS5r1GzmsYo04JpQ
	 ySxNwkuX3J67cEBhevx8QgR9CxY2Anv9Ros91CVuZLWbefRQ0tQA6mpQM1Cj4xSTOKf45
	 KlqyJDbC367d8oHrfPIx9JWKcZzh4RK7NQYs1xekWbt2L9dJaLP+JcI+k2j/LVKuWe6DD
	 GLZwvpwj9EfWLwdjNlrmo51+gcrgFFICa8Dt6DNr692bJeqH6OxJZREDt/RIgkIMjFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=phrozen.org;
	spf=pass smtp.mailfrom=phrozen.org;
	arc=none smtp.remote-ip=46.4.11.11
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E944160A2610;
	Wed, 11 Nov 2026 09:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E944160A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phrozen.org
Received: from [2a04:4540:1401:33fc:b262:f9a8:847e:6650] (helo=bertha10..)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <john@phrozen.org>)
	id 1xR4nz-001U9u-28;
	Wed, 11 Nov 2026 10:39:47 +0100
From: John Crispin <john@phrozen.org>
To: Stefan Roese <sr@denx.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	devicetree@vger.kernel.org,
	lei.dong@airoha.com,
	Linqi.zhang@airoha.com,
	linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Rajeev.kumar@airoha.com,
	upstream@airoha.com,
	Weifeng.xu@airoha.com,
	zhengping.zhang@airoha.com
Subject: [PATCH 2/2] i2c: mt7621: add support for Airoha AN7589
Date: Wed, 11 Nov 2026 10:39:41 +0100
Message-Id: <20261111093941.691801-3-john@phrozen.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111093941.691801-1-john@phrozen.org>
References: <20261111093941.691801-1-john@phrozen.org>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Airoha AN7589 carries this controller with a second control
register at 0x68. It holds a 16 bit clock divider selected by
SM0CTL2_SCL_DIV_SEL, wider than the 11 bit field in SM0CTL0, and SDA
wait control. The AN7589 also runs without SCL stretching.

Describe the variants as match data: whether to set SCL_STRETCH, and
whether to program the extended divider. With the extended divider the
bus frequency is clamped to the range from standard mode to fast mode
plus instead of the fixed divider bounds of the MT7621.

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/i2c/busses/i2c-mt7621.c | 58 ++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt7621.c b/drivers/i2c/busses/i2c-mt7621.c
index 9ea5e3f9a763..37524bae1f8b 100644
--- a/drivers/i2c/busses/i2c-mt7621.c
+++ b/drivers/i2c/busses/i2c-mt7621.c
@@ -10,6 +10,7 @@
  * (C) 2014 Sittisak <sittisaks@hotmail.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
@@ -18,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/reset.h>
 
 #define REG_SM0CFG2_REG		0x28
@@ -28,6 +30,7 @@
 #define REG_PINTEN_REG		0x5c
 #define REG_PINTST_REG		0x60
 #define REG_PINTCL_REG		0x64
+#define REG_SM0CTL2_REG		0x68
 
 /* REG_SM0CFG2_REG */
 #define SM0CFG2_IS_AUTOMODE	BIT(0)
@@ -54,13 +57,25 @@
 #define SM0CTL1_MODE_MASK	(0x7 << 4)
 #define SM0CTL1_TRI		BIT(0)
 
+/* REG_SM0CTL2_REG */
+#define SM0CTL2_DATA_WAIT_SDA	BIT(18)
+#define SM0CTL2_INIT_WAIT_SDA	BIT(17)
+#define SM0CTL2_SCL_DIV_SEL	BIT(16)
+#define SM0CTL2_CLK_DIV_EXT	GENMASK(15, 0)
+
 /* timeout waiting for I2C devices to respond */
 #define TIMEOUT_MS		1000
 
+struct mtk_i2c_soc_data {
+	bool scl_stretch;
+	bool ext_clk_div;
+};
+
 struct mtk_i2c {
 	void __iomem *base;
 	struct device *dev;
 	struct i2c_adapter adap;
+	const struct mtk_i2c_soc_data *soc;
 	u32 bus_freq;
 	u32 clk_div;
 	u32 flags;
@@ -83,6 +98,7 @@ static int mtk_i2c_wait_idle(struct mtk_i2c *i2c)
 
 static void mtk_i2c_reset(struct mtk_i2c *i2c)
 {
+	u32 ctl0;
 	int ret;
 
 	ret = device_reset(i2c->adap.dev.parent);
@@ -93,8 +109,16 @@ static void mtk_i2c_reset(struct mtk_i2c *i2c)
 	 * Don't set SM0CTL0_ODRAIN as its bit meaning is inverted. To
 	 * configure open-drain mode, this bit needs to be cleared.
 	 */
-	iowrite32(((i2c->clk_div << 16) & SM0CTL0_CLK_DIV_MASK) | SM0CTL0_EN |
-		  SM0CTL0_SCL_STRETCH, i2c->base + REG_SM0CTL0_REG);
+	ctl0 = ((i2c->clk_div << 16) & SM0CTL0_CLK_DIV_MASK) | SM0CTL0_EN;
+	if (i2c->soc->scl_stretch)
+		ctl0 |= SM0CTL0_SCL_STRETCH;
+	iowrite32(ctl0, i2c->base + REG_SM0CTL0_REG);
+
+	if (i2c->soc->ext_clk_div)
+		iowrite32(SM0CTL2_SCL_DIV_SEL | SM0CTL2_DATA_WAIT_SDA |
+			  FIELD_PREP(SM0CTL2_CLK_DIV_EXT, i2c->clk_div),
+			  i2c->base + REG_SM0CTL2_REG);
+
 	iowrite32(0, i2c->base + REG_SM0CFG2_REG);
 }
 
@@ -250,8 +274,17 @@ static const struct i2c_algorithm mtk_i2c_algo = {
 	.functionality = mtk_i2c_func,
 };
 
+static const struct mtk_i2c_soc_data mt7621_i2c_soc_data = {
+	.scl_stretch = true,
+};
+
+static const struct mtk_i2c_soc_data an7589_i2c_soc_data = {
+	.ext_clk_div = true,
+};
+
 static const struct of_device_id i2c_mtk_dt_ids[] = {
-	{ .compatible = "mediatek,mt7621-i2c" },
+	{ .compatible = "mediatek,mt7621-i2c", .data = &mt7621_i2c_soc_data },
+	{ .compatible = "airoha,an7589-i2c", .data = &an7589_i2c_soc_data },
 	{ /* sentinel */ }
 };
 
@@ -259,11 +292,16 @@ MODULE_DEVICE_TABLE(of, i2c_mtk_dt_ids);
 
 static void mtk_i2c_init(struct mtk_i2c *i2c)
 {
-	i2c->clk_div = clk_get_rate(i2c->clk) / i2c->bus_freq - 1;
-	if (i2c->clk_div < 99)
-		i2c->clk_div = 99;
-	if (i2c->clk_div > SM0CTL0_CLK_DIV_MAX)
-		i2c->clk_div = SM0CTL0_CLK_DIV_MAX;
+	unsigned long rate = clk_get_rate(i2c->clk);
+	unsigned long div_min = 99;
+	unsigned long div_max = SM0CTL0_CLK_DIV_MAX;
+
+	if (i2c->soc->ext_clk_div) {
+		div_min = rate / I2C_MAX_FAST_MODE_PLUS_FREQ - 1;
+		div_max = rate / I2C_MAX_STANDARD_MODE_FREQ - 1;
+	}
+
+	i2c->clk_div = clamp(rate / i2c->bus_freq - 1, div_min, div_max);
 
 	mtk_i2c_reset(i2c);
 }
@@ -278,6 +316,10 @@ static int mtk_i2c_probe(struct platform_device *pdev)
 	if (!i2c)
 		return -ENOMEM;
 
+	i2c->soc = device_get_match_data(&pdev->dev);
+	if (!i2c->soc)
+		return -EINVAL;
+
 	i2c->base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(i2c->base))
 		return PTR_ERR(i2c->base);
-- 
2.34.1

