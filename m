Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1E336CDEB
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 22:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229996; cv=none; b=PixmgW9tn9KNCcQG2yg/HG95dYnYwQkFoT9FfT8waCiVn+BrES3cZCxKOcB90XZgE7ZZYEGVMYJldT9YNxEvwOzyjO1XPCmA4nYgBjUfp61Tc8PXy/AYS/QsrIcKhSBpIbAGpHXcHmQ7IlpTYngmM1a8hXwyTaxkSkA31ODqcQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229996; c=relaxed/simple;
	bh=Y3rrfwYds9sZ3rVEgOuLjjzbMEvYwH+wEZ2bp61Lv68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUDQHRu4WUcaf6wmcPA9OGTqB/3epT3Kjk0nCE4BbI7dOzNmW4ALcBzseine19H/SITWFbbogM8kO3N0tDIlMIpxFJSZxrAgqk0HI27R0qSJEkiBW1nHF4hJgq+k676i1HdLu2ZaMwB/7QakAkB3zyR1a0zLlLhq1KtsdywBbYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sk6q6DGS; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sk6q6DGS"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-44985f4ab0fso2158970f8f.0
        for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 15:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779229993; x=1779834793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNsfYCBsduV7LW18AOFLY4oJx3XVZ8OM9ODGDYLi8HY=;
        b=sk6q6DGSNtpk4AgvApPHQSursQqkck3rtc36iDpDmFr3/pBT/45psyFuduEGGMn+NC
         0I8XZOiHSdQb4dpURpzPCJxYtAAv2aATfcB/GtthXVpgtW3Ij6414x1TFoU38kiJZe5d
         kZlnRHgRtzPDoCgjiWwT4x16/tNKQv/5jm+JGlmHpsDhgUGdR4TtqCahHLo+kj1VTD6+
         Q93Q2oe5Q/ldj3ca7635AQ6MX2sQDkKnhMN2wpY33QaGQUGYTsffL+bTfczGMrvmhlY4
         OQGDg/DegGD4SOTFxUY/bi0q8J7lTJ4qpH3mQW59RkdidnFs/PS0lIATU6nD9hyQDH2a
         B0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779229993; x=1779834793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xNsfYCBsduV7LW18AOFLY4oJx3XVZ8OM9ODGDYLi8HY=;
        b=HtWVsqB0XwDvgAsgafeZSsNlTyMX3i5P35EXZRk9SbVrKcWj88oFiQH9dIF0/srZO+
         egI6uWyuzASLUTGajC/dnRwrFTiSKQLuU4j7JkqPenwDNUdWVNdBpXiB5KVEA7vJwWti
         SyDdIfOAwmiM3v6Zc+x2NB/KQeswjzUkHLkzVwN5Y8bLnFpuZDv6wOL8ULfHUe3ffCHo
         8827ObxPkJUzGikwvyoRv4zt9Un8oDjkcOoVhmbV2E8pDkrz6RoRUyhnQqUyfDkeE+4H
         LFoueoG8j6AjvfUDeJ8brMpIbJtATmikCH7MuVV6o8zag97pXl7DQn5RZ4wKeyDcIhdp
         7FQw==
X-Forwarded-Encrypted: i=1; AFNElJ8PslWmAgyulmSjRUJqUPJpIq2ebLlujVsK9CtfNGteOW7YeDMpuEUIdGpQkf5PgpF8z5whxeY7TB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvmGBdKL4CyVnxicgPYAQyyv0APOG8wOwKAp6ht0fFAecEAxU7
	g5XWoodiqs2nD1RgQrvER9E2sGm6Rgdn5W7bMSIaWoAfCHVJJfwnEuBy
X-Gm-Gg: Acq92OF1ZNV8IZVXdNqnRfkv22v0dJxoDu7WQ5Ie0OEtpUi3LyPQhlwLdVcGuSZPS+w
	RPCZc6BdMYnIK1zBLe4ceHJ/pA84ZyQ5JlU2yfYewN027VbeFNI9hmhyqV6l5CdEcKyitTGV0kd
	7GHyQBhqs9+HCBeeH0GgV5R56afEnZeLCsXfLjCTzikSqcZAYdYDfmG8szYfJFtUkbZ9FBNG+3+
	4UQoi/FwLy17cyI2m1kQdGdPOIHPA73HpBwp+uxtpnwRNd5blxvuZKzsdWKYcQ2tVPkfX+1xGFy
	Ssk5dzA63QkfuWugb+lZf4rqlEy2P+VHv15rDxHGobFfSlJ5iIEHzZsRaZpVmD68Yc5bY/8TNs+
	n/O1Ol8NCw7KinoUsBveAGnDJ9UT7EDRCzY2o3TZ4vCsBTWF76mhPDYRkw2xvPYe0bAHZ6w0oif
	+lFmcxkPpuiY0Ix7u5d4QO7RVSKEhogbqskA4FySQoFRcaSJQhGeExtFQ+Nch0R5oJZ+UJGx+5B
	5sJemymlg==
X-Received: by 2002:a05:600c:b95:b0:48a:8b02:ae91 with SMTP id 5b1f17b1804b1-48fe60ea2dfmr321638395e9.11.1779229993156;
        Tue, 19 May 2026 15:33:13 -0700 (PDT)
Received: from Ansuel-XPS24 (host-82-55-252-101.retail.telecomitalia.it. [82.55.252.101])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48fe4c88495sm346659955e9.4.2026.05.19.15.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 15:33:12 -0700 (PDT)
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
Subject: [PATCH v3 4/5] i2c: mt7621: limit SCL_STRETCH only to Mediatek SoC
Date: Wed, 20 May 2026 00:32:46 +0200
Message-ID: <20260519223253.1093-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519223253.1093-1-ansuelsmth@gmail.com>
References: <20260519223253.1093-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The same I2C driver is also used for Airoha SoC with the only difference
that the i2c_reset should not enable SCL_STRETCH for Airoha SoC.

Introduce a new compatible for Airoha and limit the SCL_STRETCH only to
mediatek SoC.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/i2c/busses/i2c-mt7621.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt7621.c b/drivers/i2c/busses/i2c-mt7621.c
index d8fa29e7e0fa..3cde43c57a2b 100644
--- a/drivers/i2c/busses/i2c-mt7621.c
+++ b/drivers/i2c/busses/i2c-mt7621.c
@@ -88,6 +88,7 @@ static int mtk_i2c_wait_idle(struct mtk_i2c *i2c, bool atomic)
 
 static void mtk_i2c_reset(struct mtk_i2c *i2c)
 {
+	u32 reg;
 	int ret;
 
 	ret = device_reset(i2c->adap.dev.parent);
@@ -98,8 +99,12 @@ static void mtk_i2c_reset(struct mtk_i2c *i2c)
 	 * Don't set SM0CTL0_ODRAIN as its bit meaning is inverted. To
 	 * configure open-drain mode, this bit needs to be cleared.
 	 */
-	iowrite32(((i2c->clk_div << 16) & SM0CTL0_CLK_DIV_MASK) | SM0CTL0_EN |
-		  SM0CTL0_SCL_STRETCH, i2c->base + REG_SM0CTL0_REG);
+	reg = ((i2c->clk_div << 16) & SM0CTL0_CLK_DIV_MASK) | SM0CTL0_EN;
+	/* Set SCL_STRETCH only for Mediatek SoC */
+	if (device_is_compatible(i2c->dev, "mediatek,mt7621-i2c"))
+		reg |= SM0CTL0_SCL_STRETCH;
+
+	iowrite32(reg, i2c->base + REG_SM0CTL0_REG);
 	iowrite32(0, i2c->base + REG_SM0CFG2_REG);
 	/* Clear any pending interrupt */
 	iowrite32(1, i2c->base + REG_PINTEN_REG);
@@ -271,6 +276,7 @@ static const struct i2c_algorithm mtk_i2c_algo = {
 
 static const struct of_device_id i2c_mtk_dt_ids[] = {
 	{ .compatible = "mediatek,mt7621-i2c" },
+	{ .compatible = "airoha,an7581-i2c" },
 	{ /* sentinel */ }
 };
 
-- 
2.53.0

