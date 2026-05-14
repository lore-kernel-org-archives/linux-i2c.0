Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8FF38237C
	for <linux-i2c@vger.kernel.org>; Thu, 14 May 2026 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778755080; cv=none; b=ojJBkgap8+Myhqf5cH3h1moxrJqkPj/f97LgKD8ksEXQI1p9s+XE1R8tU4wqKKcZDUdkwiQ5fJT937819Yegf2Hhd/e5IwEkhxkah0HiU+/pet+Mc/9j4OFKzhKjZuLToDTBBqK7RNyr60q5WjliHunbq7D49m+8e6XMARWMrf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778755080; c=relaxed/simple;
	bh=4mJmvtE5Y9rt0p2kmIR0I1IFeafTBCzZc6ipf8jcL24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oFOobTLy3qIIT2rttGAyUHTK817vxxpATblS5HO+95EBzcF123TlMId8rXagQo5PCo5LMFHZg7SIPN+5h2jkw3K5HoUqr5DuvhQ659c00wYKQ97DhEYg1pDz5osLDhc7R4CX2GSAlekHEC3opzKUY7j8Riuss0Y8GSUVMfPxX+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGRZOJes; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGRZOJes"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-368977e33b1so2640672a91.1
        for <linux-i2c@vger.kernel.org>; Thu, 14 May 2026 03:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778755079; x=1779359879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=docZu46gG++Kf1XBSX2+6MGhAZFNy07C3ni4sJC8Jrc=;
        b=nGRZOJestqdVCB7IAJk8zuAkbOrpMginTUVSCn8G6ONCICq9uXGf86X7gvlGOVk4Lp
         3+TMEGhAcxAe6Wi026wJhe4cyBlDQAXJooiWKB5jQ6xUJz8hdOO/kDoSyFO5PJ+2vOFg
         QIPwDcjgUNSdnPmQ0h4K+cA1+xD2acB9nT8qqIPsjaI7DKU/OUNfEpdPcoDelYEwzCsp
         +nZApUH5a/XO/7Cs8W47y/PYedMnGFCcLNcspBxt0CJ0NPA6GpH4hmnBurRYmKdDMK+x
         cxB5pkAMgYxyCXXEUZSN/AORFHxje6ZQ6hy9BgmkZpQwjgNAHTLKDoLG9VcUHH1EkpFj
         6pXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778755079; x=1779359879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=docZu46gG++Kf1XBSX2+6MGhAZFNy07C3ni4sJC8Jrc=;
        b=Z9CIWBNz/TxGDlIcElcU6/OrjUvExLbL24Z+lDOsahRUIld6S0Xili60vOUftusps5
         9SOLuCJmTS+7hEJUhBDLKDFvjhmGCtDs/LNy4SRwCK6MtWZku3gXlOx8/lTh99PWorfJ
         5+QMZq4NHpgTUBY84tTD92IsjOcWLf4ujP7bUNAqWOzHJBy0IUCim22yfMn7jXwtp0Zh
         V8LV5vu3fT7PT1S9Vn8n5BLCjvlwMO9tc7WS70EhJaX5qTWs2Oi/uia+9RsOrJXoOdks
         RSOAqOmRiRRQTgrx8omICPZyDCcXpe6pJytpK8KEuvc+uG7NmpbI7sICPT4yjrEJ3boH
         Jk2Q==
X-Forwarded-Encrypted: i=1; AFNElJ+uhCWySFtf8AVKoSx6s0MKAs8qE4FTz6/aCdp+fiZAj/Bg++6D6Dn8FNoD4n9PPVL3vqBGy81PLi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTDKJEANY/9lTON5gBIjrlDF1vci09Jt/4ystAdHL9jOXeQI5j
	JOjfWsStP7OmXWdpQPV9HPDZZ3FGtPy+FCS7UJGfArFy4n1dnU3NRs7G
X-Gm-Gg: Acq92OEWxTIAZRHYCz/98eNqebQ8YIgpk0XEdGU2gfpGVZchS1qM9A2hUXxe1msog7D
	vQmISzKJQRn8a3Q1qgLe1kDEJ0lm6ov+km9DS5oqsuvOMyhajm0C25H7TuQKZUNi6u3Hu7lh6r4
	jr/WwLKasHJhur3eIRGROGf/Np8femTg0pOXWX6fuhAzRhrYG6WZqJlZunRjis7PM4CxE0cje03
	SlOkexR8tb50PJf3RWc0hz0kPbjSmautj66HajnVwV95zABuC3PBTH2QMEhs6Tirohp2Rjy4iCj
	+ghplcQJGb8BqUe2m0ZbOkvI8v58z777gLBmPmcJhAbdK250trS7wHQ1+lr7iouQBUsqJR6uvbC
	ajEr90EQ+UPOEAiUWnVDpXijQEhNVaaQIgYcYMBZdbSrHjGlgkZ5ZwR6rwjcHoL0MLT5Dchktpw
	Xcwq0l0QPvYgfStQbFejXmajGBdbqBHLzQkSteR6OwhIGvZBnPuHwL+J364Yu6ntB3ltE77hWZ
X-Received: by 2002:a17:90b:3c85:b0:368:12f3:fa4a with SMTP id 98e67ed59e1d1-368f3d4400dmr7945009a91.23.1778755078444;
        Thu, 14 May 2026 03:37:58 -0700 (PDT)
Received: from chaitanya-virtualbox.. ([103.249.241.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3692f4a038esm3164644a91.15.2026.05.14.03.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 03:37:58 -0700 (PDT)
From: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
To: brgl@kernel.org,
	andi.shyti@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chaitanya Sabnis <chaitanya.msabnis@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] i2c: davinci: fix division by zero on missing clock-frequency
Date: Thu, 14 May 2026 16:07:40 +0530
Message-ID: <20260514103740.5416-1-chaitanya.msabnis@gmail.com>
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
macro is defined in kHz (100), whereas the device tree property is
expected in Hz.

The probe function blindly divided the fallback value by 1000, causing
integer truncation that resulted in dev->bus_freq = 0. This triggered
a deterministic division-by-zero kernel panic when calculating clock
dividers later in the probe sequence.

Fix this by isolating the division so it only applies to the Hz value
read from the device tree, cleanly assigning the kHz default otherwise.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260514044726.57297C2BCB7@smtp.kernel.org/
Signed-off-by: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
---
 drivers/i2c/busses/i2c-davinci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index a773ba082321..bd0754abdcb7 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -760,9 +760,9 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 
 	r = device_property_read_u32(&pdev->dev, "clock-frequency", &prop);
 	if (r)
-		prop = DAVINCI_I2C_DEFAULT_BUS_FREQ;
-
-	dev->bus_freq = prop / 1000;
+		dev->bus_freq = DAVINCI_I2C_DEFAULT_BUS_FREQ;
+	else
+		dev->bus_freq = prop / 1000;
 
 	dev->has_pfunc = device_property_present(&pdev->dev, "ti,has-pfunc");
 
-- 
2.43.0

