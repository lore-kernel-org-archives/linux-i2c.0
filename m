Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4C93FBEB1
	for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 08:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834388; cv=none; b=PMfK6vZcuT+CEUXQeb1jBnB812I1melDIX2OcQBV7F/jxX3TC/KCZ55nO34KpaBMpHtedodi9iOzljuxi2QgV7R9vwepo/ivs6+LPvL6Zaa4/xthxh42ABxT1qnwijsDXwPt05QcuXGsU3pLOKG7LWHMBAQaUfMsR1jFJntui40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834388; c=relaxed/simple;
	bh=JHNLP5jwyn1hfRzQMU8zfNrmWdhcL7oBMVe8I6w9oIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FhTHaMC7ibKkSfFJbRf79enKQbuyyJvLvhe+2IlXuZIrCf3UHowVdx6ib/9PqkRiRidrK+jH+/GislKXJlcXc1QPquSK7sGqhyQ54AS7fwWTOcewMde14JstOoHdDEHeUlvLbiUOOHb2E1KwjAikJ3kqiZ+4Lfgd+wr0ZqfFIvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6sla9Ii; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6sla9Ii"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2adff872068so47883535ad.1
        for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 01:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778834385; x=1779439185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mUQeo4WtwZOyiPosjJ+e5V/s5KXRfRIpXXnzgHHEpY0=;
        b=X6sla9IiRHr5IsikkPwhEEczMYhNW1+QmbSxJm+35CMnoXxicz1YRDO22JJPdOfuvC
         QE0Y4vipXx/DbEKaOKrWtNGv2ZvEbDpRmbzwsM0lT5uwZzPsPkQG2R1tJpdK1h3/ko9l
         pscfK5M2+ptACNESmyGpzNaiPPG0zmdKPmMYCyT3fSl8/6fRK+wsyHK4bFfvrAkNCzNT
         mld749ZwZvgOkXIGLjD97g136iVmr1l5e+lzVvlV9zkUOU4E5h1+mtpun0jSHCs+MF+l
         Z3E2N/sd0zoo9saK2YZ3krd49ZbpebocU0JMwQ6zxQnh6QFPFUjBsO40jOQGdRXQdcBz
         A9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778834385; x=1779439185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUQeo4WtwZOyiPosjJ+e5V/s5KXRfRIpXXnzgHHEpY0=;
        b=E+X1qcYeW+qptQETJizdSuJV2hnrLus/UIaITB5cBZ8BsX6Qoxh+BMg7dA3l3RP7oZ
         oSJktObKo7Al9FHR4+8Rz+28fW5l9wZrh/5S7dywusbYkbw226gZ0Qr6IQ1jdZAv8wNd
         17JxXXQz1jivnqY2f9kOhgkx5UgJE/Mv3QMfEgWFbGfbOBWTUAd7vzbZU3LNRkXBrtLd
         ji6fNVHbVrrRTkK75EyH+nuG99SMkWuN1yWEmoZMara1f3daqJ0QIxURaEmTvV1SbvNm
         5SwbKz8Pdi8/dZIAQZ0WSVosCiCKhL4597PzBGMM3H472LtUmL19xB5TFjReqZhXSR87
         Q2LQ==
X-Forwarded-Encrypted: i=1; AFNElJ/vt9yDP3upKGZH0AsBOEQXuQrMPIoqaDcn2cJJI3YoB7+9bclDRUlIHwAiRdmfRW8L/jbQ6affPbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzImVHTF2nXk6w1s8IQZ2InMnNTL9xfZq2y+EHIdF+QH7tru06y
	I9EUo2JHZLSDJ0DGOP/JgVSQ8LvFwHlq0hFgHJyo4QwGJxUw09OHMq5p
X-Gm-Gg: Acq92OGt0/0JPO6NBfh7enNimUSoCmcutwWG3u3YMYdw6hG5Xg6+vpwjBYYIuWlL3q3
	6FJ4wFyVVs+SfpjWR5+91us2DpWRYU5VkKGl16f77Lgjy7jRZd3pvoDuPcwzSxj9WjM12EmEVIW
	KgFuc/1m8KzciN0Ro5uoY8T1B/KONl2dkjkpWqedz9/pIwgyaFcrkVC88WcK3/34mDdvCujIFfC
	gmFxpzbfizw2xpivAdl3UWz5S41uj6iBaF6LEioTjlu3TNViw9oAyeJ0o1pQc6qi581I3a0OtD0
	RF5oM2DvZpeTZy/Vz2tKLjr8ULSTgJdDgPcxCl8rjUIwbEqOVng0Al0SwCG9TWKnz/jDxALJVKG
	CAjfHk51xNAyQjJhreZIIFStiWbZVI0BR112nRAy/xjhtPmKPbFbefjCPNWfxNiRiu3bvMRTHNb
	7I3NMQUWkX3hR+mg/p0K+KTwhShagfJ9FnseSHY8mxNNe4ClmxgL6uA2hmX0m3qJgYoyPtJpKxo
	At2na2/NTk=
X-Received: by 2002:a17:903:3d4f:b0:2ae:450c:951e with SMTP id d9443c01a7336-2bd7e9040a2mr24024255ad.17.1778834385278;
        Fri, 15 May 2026 01:39:45 -0700 (PDT)
Received: from chaitanya-virtualbox.. ([103.249.241.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c05fcb3sm53551645ad.26.2026.05.15.01.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:39:44 -0700 (PDT)
From: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
To: brgl@kernel.org,
	andi.shyti@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chaitanya Sabnis <chaitanya.msabnis@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2] i2c: davinci: fix division by zero on missing clock-frequency
Date: Fri, 15 May 2026 14:09:26 +0530
Message-ID: <20260515083927.5033-1-chaitanya.msabnis@gmail.com>
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

