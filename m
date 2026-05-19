Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62507367F51
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 22:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779230003; cv=none; b=WwmiGNXEBcymP5zttc1tYk9B3WNT8l4VHzFRPJp4cEzv166ylUVtT2WpJWRpu+R1Ix1lzTHbrupg71DMqy3hGIiY1sXBC1FQdxZs401cMMHol7Vwa52VRq2fLtSViA5DESCEdsI75AptW0ynFv7ehEzQ/ghQt41VMZdLyw15CZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779230003; c=relaxed/simple;
	bh=9W5ieynLgtxAnXzgdfu5gC5t7ObxwneC4rU1N6qv4oA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EFjwryKFvfPS/FrpksKJ2SeF6YiNayN+/Nj6EinEDC8JQ92T132eIGQRQ4m4lT3ELi3XWzWmgQifVsWmuVg5w37aEEmRw0aDA8zVWx5bgmbHVV+02lxRCZDtAiy+KVnz/DDsMa24K1R9tn15AVk08f0fDrZWQ0HMVmwNiVKSq8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkCvNUi9; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkCvNUi9"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-459bf19e87bso2471561f8f.1
        for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 15:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779229994; x=1779834794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNDI0lLPNRldsjOACKAWSwRc2mbScMYD4jMMM2OXl2o=;
        b=MkCvNUi9sVlkMGV5Elhs3gW/BFazu8pMo7/QMR7abqIIHR2bovmvz7U2/rdPPcRWPv
         acuB27+u7ahwT4UTw+rzxbEXG25+1J7YDXOZq+NWLbAGbR/KtF9DkhtBlCmOPSyDCKhi
         aByvUID/sKYGCkQssfHk11Rjw9XBlbEFf71wlBFC7jumXuqHAqZKoLZM+X5Hgir+AeX2
         kaPifmYu9g4wM+p/ZEVXZWSPGw68/o73wKvKyUAkcIwcRl6uwqVk4ZzbA2U2/Jk82cgN
         zRJx/m5YVARvR2mgz4b1bkFPHDKFA+TNaTx6aVSKLDzJh1VvWJLyiSfL+mzvkNWZK/mQ
         DOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779229994; x=1779834794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZNDI0lLPNRldsjOACKAWSwRc2mbScMYD4jMMM2OXl2o=;
        b=jDqR0yHRiIV+zD/fWY6kS+WY4tGXzzXwhi+jMDtMQGXicz4PVRODDXLWOw8c4h0COz
         V5cTYNkhim4KHsqme5zcceJ4fFkMWtg2Q2Zgrzz0DJBhk83nD/ApsYlX6iOuQMzWrSM2
         AvtNM7zwNbfG2kFd9/W2Iwbj6mXUZTTlTvXPfHb7etMoMygdgf0xnNqGyotYKhErS7yH
         nv7clbtcD2HfCjErnLcL2C4+T4HM20W/ZYVhtqknTYNQ3Bz3N3iTNM26PWbwyD7U9Gxc
         q+VhWqgi9II6vagHOw23PdImCAb5FyAy+bj3J24ZQfHDZlMLStf1o+Ojfw1hDTFrU9f3
         NMZA==
X-Forwarded-Encrypted: i=1; AFNElJ+i+I/YI3RwszKujNJnmo2Z1fLRJgOh17g7KqsjfqZMw6+26Nl715PKqtaBwmLHyZrtQiu+z4MNkTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHWTQz8RXO8cyI9jeKRGK8YMw9t8RU0Ip9H5/B3Xs2gS3Ge53u
	rI4FDRvsqgYvA4XHpKy0K6w/a49SuWkKKWkraihHMlWWx7GmR/tmvRKT
X-Gm-Gg: Acq92OFTcRpWiGCw+WAdg8ZxDBApCYDIOTOPoCUMgJVzcCjYftIm7Ec3IlJHjWGfqoO
	0tuhdXex6V/DzUrg7XV3KdVQ/ASaSPeB9sXbAoPWdI9Eu6wsyDA2ZFPHgRx5X/CfjYRbAdMg8IX
	4ikoK8TY7EqBBTOD5iKpyl5082JL4z8yVb2mMZc7nAok36jNpjY3S/UsvJ/Ytx/ymx8wvQ3V/gr
	fyBolGOhkz9xQe9siii4ywgTaqZmsDnV5lVvRvMGT6B2fR7JmZohvaBhoFGPNikdx+P+hXC24RU
	4XxqV8sSGkbwSu9fjUWd/CXpXpeSO9rrfjwPKM2/fRt2mg2b8/pyEwOAsFhrL5F9UU9aE9FVe00
	tuXe6VrnQ8+7a+p7bEMNxalslbR/u9QL9LqT5WO9ijFdTBrBt+CVWMX7Z5sV+KZf+BaaRuFkpFk
	n1jfvbr4wx+mrMXrFxFR2c1cFeFJU8Pu0q4XR5sqrhtrY7fLcu0CdBcOUv6xzUHoOPGfbBKBLfn
	CKBpEYjeg==
X-Received: by 2002:a05:600c:310f:b0:48f:d346:e646 with SMTP id 5b1f17b1804b1-48fe60d5693mr310445495e9.10.1779229994584;
        Tue, 19 May 2026 15:33:14 -0700 (PDT)
Received: from Ansuel-XPS24 (host-82-55-252-101.retail.telecomitalia.it. [82.55.252.101])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48fe4c88495sm346659955e9.4.2026.05.19.15.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 15:33:14 -0700 (PDT)
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
Subject: [PATCH v3 5/5] i2c: mt7621: make device reset optional
Date: Wed, 20 May 2026 00:32:47 +0200
Message-ID: <20260519223253.1093-6-ansuelsmth@gmail.com>
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

Airoha SoC that makes use of the same Mediatek I2C driver/logic doesn't
have reset line for I2C so use optional device_reset variant.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/i2c/busses/i2c-mt7621.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mt7621.c b/drivers/i2c/busses/i2c-mt7621.c
index 3cde43c57a2b..fb9d9701bb10 100644
--- a/drivers/i2c/busses/i2c-mt7621.c
+++ b/drivers/i2c/busses/i2c-mt7621.c
@@ -91,7 +91,7 @@ static void mtk_i2c_reset(struct mtk_i2c *i2c)
 	u32 reg;
 	int ret;
 
-	ret = device_reset(i2c->adap.dev.parent);
+	ret = device_reset_optional(i2c->adap.dev.parent);
 	if (ret)
 		dev_err(i2c->dev, "I2C reset failed!\n");
 
-- 
2.53.0

