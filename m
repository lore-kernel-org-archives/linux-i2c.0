Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792597204;
	b=5NCdyCDp4NPRyuNsI66Gk3DUIeEkleAoK6Pe9hXdJS7UKIK3nbTO7w9ljB49iRynuV7w
	 dF/axWbkqB4qd5dePU21g+HhMT+L6cHXhIjewrw+jCLMmaVgVl2koUA+m4Ww9GBXn0wkq
	 D11q47cRfyQP9EP/bSKqBa7LlfLPEvVphWe4XxQWE6Q/X5EukKrJQPe3B+7pXX3zcOdhq
	 aVfVC0gW5g+8iXq5IgMQGm7zI64GXL/Ifxc2bXJMi1gRTrmphVH6/RIFMmy5ihlN6Mbi+
	 HvRLMfxW+XC0/bYKmHx1CTEYvkUfWIeFiiO1laLphgYBnaM6EWyJ+Lrp0UXLGCjvlLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597204;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zaYwnYAxjbvafi5ZHaoMwUtj+Rh3uHmAjABbHohiMRE=;
	b=Zs+WFSCfhaDWRujyyblGTSGqCRrxeZE8fr7PGxbIkU++1vpPSbAtucnIVHkuOkdpaClz
	 TlxKpYKQQPBnwHr48PIBOJYfXUIcRoAnVT6QR4O40BUH3cZ0qx9YrtfJYZUhKb9BJEFpX
	 x8eJigvx2IbPHsFIUoWZlYH94hIkuVr2jMNuSeMuFSp1jE0eDQt+1fkbGyU1JrGlUgPfl
	 u140ly7zwnhX76CHO+NNmTZbJgf//Nl/t54WXv1sUYLgeKUFYiRkB3YT/QAlaFXw7wb9F
	 G585A5dTqZ5FAKfw57M2cQKrbF7S7ICRhSLvvhWLwwbw8EtRQimT1wqFGtFQMbQqPow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UeXBTAIf;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2F2606A320
	for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 15:40:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C2F2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UeXBTAIf
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1ec92f655so10246015e9.0
        for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 08:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792597203; x=1793202003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zaYwnYAxjbvafi5ZHaoMwUtj+Rh3uHmAjABbHohiMRE=;
        b=UeXBTAIfPiCMuR1LAD8ORgCkAfwJvgzFVzOv5DelyEpnNtRMT829g4ht0Y9ToGZ6Er
         al9V7Xp2Ea73W67Mfiw/DYe88EYVF5T8T0CutO0NQvlf9OID2yNUPOLXXv9l+3ZcfJjG
         DM4tmDkJKbFoRonUeyHiHUoUdCaLlu4Z2Mbq0iq6FfReF8mf0Y46M/PUAC0M1dSr8xEj
         SwWRg6p3GnBb+m/o0ri4ic1Q1UKZYBh0SgqeEWkBYIhrz+jUU+jhwjykw10vxlDcz4IF
         J+0Sh7N6IdKx4fcT3GIYTGYX7gT3L521otbmiQ5xE2hnge4tl6HRP0ZvFPhjCDv8plUb
         PS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792597203; x=1793202003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zaYwnYAxjbvafi5ZHaoMwUtj+Rh3uHmAjABbHohiMRE=;
        b=tKALwkzOKMNFevW4W22apmeoJVHmDj3ci0QgTBojsOmtf6vCSLHzzcWC1LyNLjC/7N
         NpcwK4k9OnVVNKkl25llCANv+0C8cp6LLK4tJiMIMmnFE4w3hkc2k9MRaDqFxm2CN/JY
         QuACc9gxjvrL5CtJIz5hBaniXM+58hWh0wktGl82HtJ0xqAOB2rtRfCwdF+P2BaZkE7w
         bec7xZSfdQooJ/NhjvUcvdNylIaeG+8jqBhO7IyOEXPAVHEYOSiJxrAYZZuKaHcWfDMt
         gcabPtnAVQc5YacuaHCdkndJSEIp0r83GxMBui2UhWIqLBlrIcMgipZzSRaSw2rIjzAe
         ozxg==
X-Forwarded-Encrypted: i=1; AKwUvBxritFyRnPDPXIEuMveGiNVj1QORyJo2VlEdk7B3pEFfKp8E8K6s5mcF7Rhe/fh17Fh00tt8FGz8+I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJI5WcM/m8QDCFvt+OrsXU6GUSxf1RXU4NXSkQegb2zH+hf+4Fa
	r6erQnmNprqS/n5JvtPPFc+PTEvsTD3BMKGpgR2VVxGfTv2rxgTT+Ykc
X-Gm-Gg: AYBFou3TIPTzqqYtqkdA/F7YloerrZs2eCVaAyoFl+WjXshHDO0ne3QjGVyMQWbABTF
	4ujJCSYYK+E92dJOoUujDplk5WpCXQ4uwo+B8GHoC79QMaCKVTpf4mzZHw2p+ButTpkz804rkg7
	rk58bEJuVxA/gNTAhE5qfUKcQc7tddK2oaQT41ENTgwZPQ/Xq8T6ISXKBAYZbdPmQ1NOYj+MwLz
	tcm6safCXvZU/v6LQanKAi9PpSLq4RTe7/MN+AqYWDhDjumeJjeQ5VqGsrl01bNT2uCdGdmp1mV
	bgzBOf4C5DobDgryASxiZhQB3aEEWds/8VM+gxWkNLpkEySSlj/dXs1O+QMTDzDuxCEjSFkdyQZ
	hl2MrzxAMotfj8naae/FIiLsnkil/Cl7XiCJbJUi1JOCw6i27AQiBePt87IQjqt1Ceb7NKlOf8S
	OYd5vFoFUI88MIxQC0NmmboC4AnQ7p4tUakwKE9/5Hm2fEETgzTXPH1LLwb4UIwNGNPyhnjwd9P
	A3t5YaCvihEu3PUFqSwKjHnPNT/lAvJdJUNWVjf91jAHBGq3q6b5+7ecmISKVtUOYK1+IerwZGd
	ODtruSS35ImA1K5LICcf2Eqez3HOwhCtUmxW9JF76yptuZqeB4lE08dHEhPm
X-Received: by 2002:a05:600c:3513:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4a1fdd2461cmr53680805e9.13.1792597202563;
        Wed, 21 Oct 2026 08:40:02 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it. [93.34.92.187])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd70027sm27793675e9.0.2026.10.21.08.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 08:40:01 -0700 (PDT)
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
Subject: [PATCH 2/2] i2c: mt7621: limit SCL_STRETCH only to Mediatek SoC
Date: Wed, 21 Oct 2026 17:39:52 +0200
Message-ID: <20261021153953.285222-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021153953.285222-1-ansuelsmth@gmail.com>
References: <20261021153953.285222-1-ansuelsmth@gmail.com>
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
 drivers/i2c/busses/i2c-mt7621.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt7621.c b/drivers/i2c/busses/i2c-mt7621.c
index 0a288c998419..19dde7c4069e 100644
--- a/drivers/i2c/busses/i2c-mt7621.c
+++ b/drivers/i2c/busses/i2c-mt7621.c
@@ -65,6 +65,7 @@ struct mtk_i2c {
 	u32 clk_div;
 	u32 flags;
 	struct clk *clk;
+	bool have_scl_stretch;
 };
 
 static int mtk_i2c_wait_idle(struct mtk_i2c *i2c)
@@ -83,6 +84,7 @@ static int mtk_i2c_wait_idle(struct mtk_i2c *i2c)
 
 static void mtk_i2c_reset(struct mtk_i2c *i2c)
 {
+	u32 reg;
 	int ret;
 
 	ret = device_reset(i2c->adap.dev.parent);
@@ -93,8 +95,11 @@ static void mtk_i2c_reset(struct mtk_i2c *i2c)
 	 * Don't set SM0CTL0_ODRAIN as its bit meaning is inverted. To
 	 * configure open-drain mode, this bit needs to be cleared.
 	 */
-	iowrite32(((i2c->clk_div << 16) & SM0CTL0_CLK_DIV_MASK) | SM0CTL0_EN |
-		  SM0CTL0_SCL_STRETCH, i2c->base + REG_SM0CTL0_REG);
+	reg = ((i2c->clk_div << 16) & SM0CTL0_CLK_DIV_MASK) | SM0CTL0_EN;
+	if (i2c->have_scl_stretch)
+		reg |= SM0CTL0_SCL_STRETCH;
+
+	iowrite32(reg, i2c->base + REG_SM0CTL0_REG);
 	iowrite32(0, i2c->base + REG_SM0CFG2_REG);
 }
 
@@ -249,6 +254,7 @@ static const struct i2c_algorithm mtk_i2c_algo = {
 
 static const struct of_device_id i2c_mtk_dt_ids[] = {
 	{ .compatible = "mediatek,mt7621-i2c" },
+	{ .compatible = "airoha,an7581-i2c" },
 	{ /* sentinel */ }
 };
 
@@ -296,6 +302,10 @@ static int mtk_i2c_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	/* Set SCL_STRETCH only for Mediatek SoC */
+	if (device_is_compatible(i2c->dev, "mediatek,mt7621-i2c"))
+		i2c->have_scl_stretch = true;
+
 	adap = &i2c->adap;
 	adap->owner = THIS_MODULE;
 	adap->algo = &mtk_i2c_algo;
-- 
2.55.0

