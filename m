Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793442411;
	b=sQZH0f1BciOMsJi/rWDWhQEwmnWznu1EPNjRLWkAmUbk2XMmWq7eoIV6XHEoNNp6+mBC
	 w4UhrH5IdEdkJwIJJkejBs6wdPIlvOYyGzKSahcJld0xGidd36XBw7R48WEE1Gvqk7jp3
	 hc/JX6EzLXADX1D6uYfIJPdFwM4mi7gBJT9cq7/6BX4HTqkwxV7tE7OuMz3iIiudRAsti
	 r4jzcCH/Gn3BTb7yjQyAkCS8Ex2rDWJVRxcjvnr2GSGXbMncYUDvjz8G2hV0LoYbzKeVh
	 7MFqCfgMYX8FitO1YvEsWXdanlvDiYtban1HGr1E7nq1iPYcm90cH7aPO5rzyApkUkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793442411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QI5qU1trTwZm0S8t5gCAWIJ9CPL9O0gAUfA8IjPCltU=;
	b=jhJzG2QhAstjCjg+SxlaKGNmdDyKyAcSbDuTbH020GzGm/rXwBXYtB5IDkbX0FCYhMCt
	 o1M+7aw+lnQM7thNoOdCjEn11JlprlWzaKMCFW9QW3RaZdV28McotFKmvIn3b43V/WxV3
	 p0LM3rxIXSraGVf/DfEF9Oz+9PkO1P2B1IB5jSaRlEvOZENawH6mLwny2NvxYf3ffWhky
	 WFvZWN8pC2rmGci+LiO96FpdZGk12fuS48xI3ex5B4UHWLpGLnOBARFrCGJXRvD2+yNk6
	 6UvHzL+U2U0DH+Ul4tHnig7UK/LfEKv+yVNiv0heNJiSatFUqI86VpIhemI9Mdl7HTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZFegw1xf;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B10606A330
	for <linux-i2c@vger.kernel.org>; Sat, 31 Oct 2026 10:26:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50B10606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZFegw1xf
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so9145235e9.1
        for <linux-i2c@vger.kernel.org>; Sat, 31 Oct 2026 03:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793442410; x=1794047210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QI5qU1trTwZm0S8t5gCAWIJ9CPL9O0gAUfA8IjPCltU=;
        b=ZFegw1xfAnTYk17r8T5nZe/VR9U/zw4z84x87wQkQ+N5WinMdMfT0ywnApQKiyGDA7
         kk7N4TAgVxEfmYQPKTHouV+tSdaW/C4mc5XoQtUU1uFYQgtXDao0WIGzg0o7Rjl5CCNU
         JNNIzclWERxspx9QsxTUKsAZO+iQgWJQfnz7SYIHBaBANlz0KYe7xMmjEQX0J2wMiIed
         aJkKzNWZHTJJdTtdBMrcLTqp1/dCMyxRjm1bCFcYkYxHx12gksgyTppx+CWL/hTH4x9x
         Ri+85EmO05puhR2zwIHG/CPzkBR4wcB1HhNAk+dzAD9PJDz3Pw+zq2Ul3tGrSi/JCxpH
         WJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793442410; x=1794047210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QI5qU1trTwZm0S8t5gCAWIJ9CPL9O0gAUfA8IjPCltU=;
        b=Oiv/7ygGIjP292U3nNqGuxT24Cz+6aeKAvyc89+0S5DRD7uzH1AprmsRTGhBAPHRXG
         xpRD+lwPsig4ItbnET1ecnGo5A+stbkJGmIdLdKUErF7gwhbCX5QXWgmH9vYo7bSB/3b
         RSJf+dI8+X97u4c6zjHvrUS3ICUGIrlxuPRbOmyJCiaahB7gZy9Cwn14vD7xjsJH9PJ7
         OkK8AX+lsS9gJe2kt/7jP0og/i1anV9TClKBWZlyZBCe+p9YMOuM1RGfMcjYEQB2l3Mb
         PzZ8TScnAGJ1apLJm+rqC2RFuJCK/t/G21piA0PKdgoZZgPlZIdICdEXJn6M++QtNdp3
         wzsw==
X-Forwarded-Encrypted: i=1; AKwUvByk+DPRZ9tr+fVzpFlz0T7J2du58VgT2+iu2Gt5G8IKYcQgtkVWrvLhCjyLvGQa0qk5NlaIoHsPDSk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMMYfGxm55a4ipnPFZyqB94KZe8+7axXc2Vi0nf5o2XWj2kMYA
	UnSKaKfsL8X2uyhycSe4BSjjNl921vcxqpnpS61mVJAC4DzZPKefA7sd
X-Gm-Gg: AYBFou25S5ewS4cMYTV5UPHiWC1JdPh25VxlAAZhtSDXqiMDwbyH9T8Z94RndlclEHQ
	E6HWOQ7FFPSecneqDS6V0ZcZh2zIywgSFOfHtMJ+5MHigEVqlgkPiYzzBAb70TyOipoc24APKX6
	2Ti71edNheLd5q3dFQRT1Q/WLmS4IgOY89IhahT5qmeEKtEoJ6dmzFSnBBPsPjMQ5FEbyPaqZoV
	aZgK4l1UNC2Nissfk2ivS5HIFt0DAlV0t29lMPqAnPFdvZTY1xwfhP44TLyWpODyQpP3JYJKAae
	+gYB2AtFaAIvtixxfjuwEN8sZgwF+AePZdBscRrY7KCV1/qVqE+CK4cP/+Qld5tjFYiDOcTaVMp
	eNlv8X1/Pnfq1kN2M6+rVUf5hPWoqSFQEqYaWJSRE8DJh+fL+x1htUVM2hlJeu7WaR3GJgkkUlJ
	GCgAdH7R0ww0V+u2yXZ0Hpx0mZ/pTYgDpyLHu1xCd3e9+VgtrCHybLYcV2jo7UHkJuDf0UVOh3m
	4dWXxl2FVYAtHF1QDNVtHhHOcZ+vILUYmOMkSM8bWPkDw2320TiW++AkUTCpbo6Av7p0VDZjOj+
	+t9kESHW/+8Z+RxzNBAmHGP+7NnFLH7yoAT6Z3OHKY4wNvnDVd0j+WmodZWMkXvSvwPthh1pq2c
	eHQNe56ZaaZI9BA==
X-Received: by 2002:a05:600c:5246:b0:4a1:d459:db4b with SMTP id 5b1f17b1804b1-4ac1889c7bdmr110005305e9.24.1793442409529;
        Sat, 31 Oct 2026 03:26:49 -0700 (PDT)
Received: from Ansuel-XPS24 ([2a0d:3344:54ec:1210:f1b7:9ece:c6e2:5df8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4abebe33e79sm90903535e9.2.2026.10.31.03.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 03:26:48 -0700 (PDT)
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
Subject: [PATCH v2 2/2] i2c: mt7621: limit SCL_STRETCH only to Mediatek SoC
Date: Sat, 31 Oct 2026 11:26:40 +0100
Message-ID: <20261031102641.12649-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261031102641.12649-1-ansuelsmth@gmail.com>
References: <20261031102641.12649-1-ansuelsmth@gmail.com>
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

