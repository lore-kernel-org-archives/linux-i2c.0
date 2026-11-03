Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793739958;
	b=pVEuehxRhmM9OtoYMNI+jmczAIJwzVvB8eDdyoDECkKo0EMXMOe5F5T+L8jp5fsJ0/Pr
	 V1l7WywH8vY9dN9AYLRo/YMf1HkopItkvMDcgvmtt8GBaKujp9aSK7Prh6Pxs0tp0GWLB
	 be7Eyyu6GlStOueSJJaXyONbdwtpaTKTAgNi412OhpABkZZBdwAFw2Al6gTJ+PipMFEdO
	 X4QWZtYxbOy35yn9uny6Yzh1WNNHnoXmfmCOnXKlWbdVQB0PXXZRjysUiCE9G+Cpj4Jhc
	 MjRpAWDTAE1zxJz28HLQNi5Qp93UBiRpel4iV/xM4j03zLfdGeKFarF/RdFR4lIWB1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QI5qU1trTwZm0S8t5gCAWIJ9CPL9O0gAUfA8IjPCltU=;
	b=t6IeowecRPx9zv6R7auEalAFyNGkkcg9gKXv9FKbKVcIOzUOByUUMVIXf09/D/qUAld1
	 P8kddHJu8m61LOra4esggNEaiU6G0tC+TcNylOr1KEsdZskdKgT82ZHh+Pv2Kf+pwSDmy
	 zlFBmEjYU/hQW4ldf6cCjYDFimvrdRD9vA65a5okk+YRorDXFoZdsSkvgZs/R2iRZGzCz
	 Xhf3OF2T9CYMZe4lMSwmk8j+I8ilNwzCsGT/0GkzwJYpsEQBRxKSJV9XbDPGubl3iGM1f
	 5qeiy0NZo7NecvY/bBLdb1WpPPCMzugbA8qmMYiMQH++QtSGjOI6IZ2xpmGM9EPK/Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OJuvyz3j;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156D2606A333
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 21:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 156D2606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OJuvyz3j
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48c45111bebso16395f8f.0
        for <linux-i2c@vger.kernel.org>; Tue, 03 Nov 2026 13:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793739956; x=1794344756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QI5qU1trTwZm0S8t5gCAWIJ9CPL9O0gAUfA8IjPCltU=;
        b=OJuvyz3j70MjV8XQJoIom1Q/RGba1SDSh9oDkAGWqCHZJvRt79oJJ2dNRgEpZ15hHx
         uSvh/CAjG0Rho1dTJn/GLNrpOw70dXusp2CcEOp40TMWvGOE0hbP8qaqjwuG7sVQAFYt
         9gFWE3VP2/KiQf1DEc1Z+KAp7G1Rs12rKa8/ztgrJ6/z6TOq/m7aWcbpEGjkdhMjKALG
         5vA90huOJO7qrWN20z3retMDkuDJZLYMlneIy5fQU8OG23qDiKOF4Wfk1rVNXf1q3Hcu
         J3EeQqX5nMKG6S98M0pEm3ZgkzGWX6VT/FYs6hTwa0EEAhQ9JD+98CBTfCDj0DArg9aO
         bcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793739956; x=1794344756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QI5qU1trTwZm0S8t5gCAWIJ9CPL9O0gAUfA8IjPCltU=;
        b=hDuQsfcTbm8VVJrCdQ5DeLaDN+M5Yf5vDjZpotY59J2ZwUytnMxp61SPW7FfRKgRFg
         tr8nMwhknlEUW7CWPrcUIP0QT4OUc9OjWAYa2a134hiA6MaOR7rS14NrojeRMr0BLj+w
         c4PlLCqdl+IGA9hNMLfbmlalx5Uj9zkfLR7Q1Kr6ugXhVwOeCiaSQK4d0rxWNSIch02Y
         rqjwd8+BIdc5ikRiK9Kg64aFIX9zWTbA5yRzrBFnLy3p8zLxjBniME0AyKQqRypL6PGC
         Oaj64FT2XeVdB3hpCLPRbD4QyGM5S6d/uVbrXnhIVPLLIvej7/2dHnHvpoZpMp38CpuS
         Fxvg==
X-Forwarded-Encrypted: i=1; AKwUvBz9CqnyTNFogd7+HtNLPlrX6jdQX09/Zw55kppQbXBN6HX9oW0jFoeEHQmiMhIUI52NIILNit1IDBA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+pqI55WnLwvC3z9AWor9mYKewdzsPebXJ6+/uZIP5xJK9CUOJO
	yepLYvlEJvjrFylr9ULz69KzS8/B9jtwGFioRItYpMJvTITv4oOWR9HZ
X-Gm-Gg: AYBFou3zmjQs89WikgqcrHD8ZW+rUJN8gBWlib7HiIqGoYI0hkw7rBBsR4dsmsdeTsD
	Fcqj7H0lhcHLH7ijGa6IK40eloUoZ98qi7tLe5BI8lfFD7ovNrN8skFXd3AEhkkymbcVy01g7rp
	kRGmqWuBsSP/xusiUtU95EJbH38NqzLq2AZ3XWS3IwKyjHgOFE9x/rL4yw0wPHO0leFAbawCruw
	OCbvl6QFI6tzjjCCMUstAnCB9KeTlQs8p7QbIEv4GHKpGlWz20Z8XRQ623oGNlGysiJ3sp89rc4
	v4/F9+Zoe9Rg+loG3AUPPew0+u5o/0SDzufLBiTwOdhRpVzPq2PxQcR5bSEedSytjvkpGfx6hJz
	vCtGR+X19HSc/3eGV5XUV6Xg7RRAMvyXkp82okB4SWbbMuS4ZqBBJgMjNkvkgb1vHlKfZfX9u89
	x9+VRu789YeuJiQzx2+IRIcD0/gvnVtmah1cBE0Z6LBz8R8vHLiFRb7yla4XnFIUdCATQYQ3oF8
	HkGzrsxNy851wEV+UqIioqVpzSKRNNl+8Ozo9a7SoWwfUlwklSru/yAC7chsCIuh/DBqG0GNnFp
	HsPJG2OfUgbvGmBHD2bl9mZRqoSIIDigokmGsgOiyK+OPzsB5DXSVZBuJmMgvJ+B8DElR6Aav+u
	VVlFI8g7mGmTwCbAMroxG/UkutDhiCIQJmA==
X-Received: by 2002:a05:600c:8b2c:b0:4a7:a5db:a93e with SMTP id 5b1f17b1804b1-4ac150b3dbfmr345625415e9.4.1793739956406;
        Tue, 03 Nov 2026 13:05:56 -0800 (PST)
Received: from Ansuel-XPS24.localdomain (93-34-90-148.ip49.fastwebnet.it. [93.34.90.148])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48fed553441sm41850f8f.43.2026.11.03.13.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:05:55 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Stefan Roese <sr@denx.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v3 2/2] i2c: mt7621: limit SCL_STRETCH only to Mediatek SoC
Date: Tue,  3 Nov 2026 22:05:41 +0100
Message-ID: <20261103210542.15965-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103210542.15965-1-ansuelsmth@gmail.com>
References: <20261103210542.15965-1-ansuelsmth@gmail.com>
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

The same I2C driver is also used for Airoha SoC with the only difference
that the i2c_reset should not enable SCL_STRETCH for Airoha SoC.

Introduce a new compatible for Airoha and limit the SCL_STRETCH only to
Mediatek SoC.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Use match data for storage

 drivers/i2c/busses/i2c-mt7621.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt7621.c b/drivers/i2c/busses/i2c-mt7621.c
index 0a288c998419..fa1f32d4f046 100644
--- a/drivers/i2c/busses/i2c-mt7621.c
+++ b/drivers/i2c/busses/i2c-mt7621.c
@@ -57,9 +57,14 @@
 /* timeout waiting for I2C devices to respond */
 #define TIMEOUT_MS		1000
 
+struct mtk_i2c_data {
+	bool have_scl_stretch;
+};
+
 struct mtk_i2c {
 	void __iomem *base;
 	struct device *dev;
+	const struct mtk_i2c_data *data;
 	struct i2c_adapter adap;
 	u32 bus_freq;
 	u32 clk_div;
@@ -83,6 +88,7 @@ static int mtk_i2c_wait_idle(struct mtk_i2c *i2c)
 
 static void mtk_i2c_reset(struct mtk_i2c *i2c)
 {
+	u32 reg;
 	int ret;
 
 	ret = device_reset(i2c->adap.dev.parent);
@@ -93,8 +99,11 @@ static void mtk_i2c_reset(struct mtk_i2c *i2c)
 	 * Don't set SM0CTL0_ODRAIN as its bit meaning is inverted. To
 	 * configure open-drain mode, this bit needs to be cleared.
 	 */
-	iowrite32(((i2c->clk_div << 16) & SM0CTL0_CLK_DIV_MASK) | SM0CTL0_EN |
-		  SM0CTL0_SCL_STRETCH, i2c->base + REG_SM0CTL0_REG);
+	reg = ((i2c->clk_div << 16) & SM0CTL0_CLK_DIV_MASK) | SM0CTL0_EN;
+	if (i2c->data->have_scl_stretch)
+		reg |= SM0CTL0_SCL_STRETCH;
+
+	iowrite32(reg, i2c->base + REG_SM0CTL0_REG);
 	iowrite32(0, i2c->base + REG_SM0CFG2_REG);
 }
 
@@ -247,8 +256,17 @@ static const struct i2c_algorithm mtk_i2c_algo = {
 	.functionality = mtk_i2c_func,
 };
 
+static const struct mtk_i2c_data i2c_mt7621_data = {
+	.have_scl_stretch = true,
+};
+
+static const struct mtk_i2c_data i2c_an7581_data = {
+	.have_scl_stretch = false,
+};
+
 static const struct of_device_id i2c_mtk_dt_ids[] = {
-	{ .compatible = "mediatek,mt7621-i2c" },
+	{ .compatible = "mediatek,mt7621-i2c", .data = &i2c_mt7621_data },
+	{ .compatible = "airoha,an7581-i2c", .data = &i2c_an7581_data },
 	{ /* sentinel */ }
 };
 
@@ -286,6 +304,7 @@ static int mtk_i2c_probe(struct platform_device *pdev)
 	}
 
 	i2c->dev = &pdev->dev;
+	i2c->data = device_get_match_data(&pdev->dev);
 
 	if (of_property_read_u32(pdev->dev.of_node, "clock-frequency",
 				 &i2c->bus_freq))
-- 
2.55.0

