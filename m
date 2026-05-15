Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E02839E19A
	for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778837156; cv=none; b=RZwYnlwzfdfKU4gWvgNmlVGxFM/KsmG2ltzDl9zbB8hV9+Gh93HU4knwAdx3QO/8sHYCjWWXJdi3p6dcPCAMnNEnavOQ0q22jd4rORV7FreM0X9i2H/LJfnVeLCa33z+Pkkow7KqTUtU73ri5/SoZksu2kJ3g6kO2gwKfEMhJXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778837156; c=relaxed/simple;
	bh=OQSmcdMGLcht6LgFbXJblFwpoEU39TYz6Vwkm8EsCTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HpSUgHf70pf4yv2hG877/fgWN5x+45Y4SABsWpdJOGQMQtDez7qIVH5B56bWoqNWXz0lOJJZkK3AEYaW8tQDNYFK/LqO6FC3Lfdfmebg6ks+w1Z+AJfWAkpE5FbBV0ez5vDBnFdZ0hPsBWBkYtKdSGrZ/ODZj8tpxjnOPRC6hzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3g8DV11; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3g8DV11"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-83ec36a13e9so3292059b3a.0
        for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 02:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778837155; x=1779441955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h187CLLtKoMiP+2/X+09HRYFjKBZCzb1UldAVYewGlw=;
        b=A3g8DV11mhghB8920NSvUlb7Arae/UyKtz2erAKrMXNnxeaNMHLW5uG902M72edm9e
         6i4MOjDTiWNm0EfpocogTbPJOBXUO38rTY3nn5xY69ProOMhvINItuTIPp4URseKupV3
         xFRAayOX7oACC0wkFA7YlRNQjKUwfITorVwHbHfRhKWwrEpClchMeE1cfG0xx2MwVy04
         y5XffG+a7yM84PIqqBaky3deh6x+eabNFbrNilOOQk80stkTy7IyoBEAg0Ldv+81g0IB
         YkRrv5WmsXnW/03+dwL+bLGj/ekYXkv3WSnrufPP4pjz2QdYziDIQfHEoUsNLEW/Om0L
         CiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778837155; x=1779441955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h187CLLtKoMiP+2/X+09HRYFjKBZCzb1UldAVYewGlw=;
        b=fxbcFxs8koj0CQcHy462zAB91DzeY8INURZm5be5KDpGXphVOWOHcRSJKpKxp15/4P
         ivg6oNp7hRPfvZHcdYRwfRgx/WetRvVpwUOAoLqQzxceqtfZe9+3r9RXMuBWW9WOtZ3T
         ghf6kRnZlAd6mR5r69U6Gj9JzJ2Z8rak53Jh1YBi1QLpjzNWSBaJXLif0IHtKJB/SXWd
         UuBjnJXMOg27nSZJPXL9Sf3X2DhzRvgzVaPx5nR3dK+QPNkMSdkZchJd2ZWScHiTDwKt
         M0XzUIHX++mSYtmjoUhBEnJegsMTwaf1pKfxbaoFmw6Bb8dUloScxmVJF35E0GPcA+zK
         MHCA==
X-Forwarded-Encrypted: i=1; AFNElJ+bu0JKnNjV8f7DN+h4roCWhwbNoaNGGYebsg9qiELxjyJi462cJ3hyBORpEMU4OjFW+C4U6tXglNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzabTlr3Pn8UJOyb4lj1dVHN2/bhkhQoDAz0ASkkE+tSLQjA+ac
	29XDpNbBvvSrJxHH+2Mb1eBIvN3hTr2xHplke3f97MpZ0XKKdnTXlJUP
X-Gm-Gg: Acq92OGYaxY24PFHlsd9Rq/Pehi0nr+OevmUrTrgEOF+oErQxNXlSFj5x0S2aBEtKtL
	q+Jx/JlZz4Zow7rw2LdbX7cVvxl+eHBeS0ElniCczkNUEbKigXBQvOZfiz8hhnyzBGuaMaDzC5Q
	E5BGQThnfUWzXBFPREZwFL1HUApTQ3utMSNkiVEVUQYwQ4cVhB8OJwI03Q+NneQMWiE1Ex2HfKG
	cZx3mpbobSZk1i7ui2CFaEymPD7R/uVX7PbVJTvn3NKvMpHCVwwPL2OTpdjt1wBJcFiLWe7yEKc
	ru9ldSneT6R+BmPguiCsci3bF4F1bYRVEeia6C4rtJ6+ImS4Y4LJb2ybLOLdLa7ZBay0byo0u6D
	IVPHjb9AXBqjs4Qp87zOlsayK/fOLy2S5tPkhSKDRji5gBMmlg2tzlp6/4YpbWgV6dPbwNwphdB
	YymSMgWbaJ2To4Mk2iTxXsv4eUTsrm+Vzp/qkVZfUPTdo7zBlfGPZjd41jguIV1wzmxUXyuRv1O
	nAQwd/5WJs=
X-Received: by 2002:a05:6a00:2394:b0:83e:c76c:d720 with SMTP id d2e1a72fcca58-83f33c60de3mr3457647b3a.30.1778837154576;
        Fri, 15 May 2026 02:25:54 -0700 (PDT)
Received: from chaitanya-virtualbox.. ([103.249.241.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f2b9bec8fsm3829097b3a.33.2026.05.15.02.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 02:25:54 -0700 (PDT)
From: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
To: brgl@kernel.org,
	andi.shyti@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chaitanya Sabnis <chaitanya.msabnis@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v3] i2c: davinci: fix division by zero on missing clock-frequency
Date: Fri, 15 May 2026 14:55:20 +0530
Message-ID: <20260515092520.9006-1-chaitanya.msabnis@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the 'clock-frequency' property is missing from the device tree,
the driver falls back to DAVINCI_I2C_DEFAULT_BUS_FREQ. However, this
macro was defined in kHz (100), whereas the device tree property is
expected in Hz.

The probe function divided the fallback value by 1000, causing
integer truncation that resulted in dev->bus_freq = 0. This triggered
a deterministic division-by-zero kernel panic when calculating clock
dividers later in the probe sequence.

Fix this by redefining DAVINCI_I2C_DEFAULT_BUS_FREQ in Hz (100000)
to match the expected device tree property unit, allowing the existing
division logic to work correctly for both cases.

Fixes: b04ce6385979 ("i2c: davinci: kill platform data")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260514044726.57297C2BCB7@smtp.kernel.org/
Signed-off-by: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
---
 drivers/i2c/busses/i2c-davinci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index a773ba082321..a264a480dc3c 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -117,7 +117,7 @@
 /* timeout for pm runtime autosuspend */
 #define DAVINCI_I2C_PM_TIMEOUT	1000	/* ms */
 
-#define DAVINCI_I2C_DEFAULT_BUS_FREQ	100
+#define DAVINCI_I2C_DEFAULT_BUS_FREQ	100000
 
 struct davinci_i2c_dev {
 	struct device           *dev;
@@ -761,9 +761,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	r = device_property_read_u32(&pdev->dev, "clock-frequency", &prop);
 	if (r)
 		prop = DAVINCI_I2C_DEFAULT_BUS_FREQ;
-
 	dev->bus_freq = prop / 1000;
-
 	dev->has_pfunc = device_property_present(&pdev->dev, "ti,has-pfunc");
 
 	dev->clk = devm_clk_get(&pdev->dev, NULL);
-- 
2.43.0

