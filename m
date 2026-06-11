Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5B33C5848
	for <linux-i2c@vger.kernel.org>; Thu, 11 Jun 2026 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781174943; cv=none; b=CS/bdtgajyrDXt2RZPf7X+cgAbs3fZPREpgtSNZbd56dXKEb7JTxUvH2AYahRXl+fcgUYDlB/JY1IxgZUrOKLUOJowl6oslctujR8W2/zZcOjcJIcNi8AEeJ1zDE1vSKRkr6bwDR2SenbqQSXWBxZKdHz31CCixG7VhxtbHhxXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781174943; c=relaxed/simple;
	bh=B+yE8akfi+ZSIBEFL7WAjU9Czxb3CY1wU70AYHiiCO0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=RzBwwJjONpPBjAquHznbYkQcD32cRXFz5PdRmKg1Aq0y0si+hpu0L3KEdFp4kmZf//LEk+063b8hcbcf9tFDfXtYT+5YvJdxoh/LhJaEALyW1cWaSxs5l54qNduOMwm8xifzxu0afZs4QH3M41k0ZYBzrTFnurbZOdQWm0BtFXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAKXD9f+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAKXD9f+"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490ac10e337so63468055e9.3
        for <linux-i2c@vger.kernel.org>; Thu, 11 Jun 2026 03:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781174940; x=1781779740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T7qWssdHiLBFsSt8dH4a2h+fzHkfZe1zSV2zWUbUyiA=;
        b=PAKXD9f+nMlKcj2b6U6SiS/Iw3TQY5+de4zbdE/tyAQU537T6l+MTlXMcsNKV3AJXm
         XYcMRVaUA/DrkFrIR1QIkyiJj7Euh1mUKZhYnpgGZ3SbSXTeuzdxRMz/g1sRoLQSGUgy
         GZv6huFiiDnP1mhQ45Wzlq4mLNtG+DTtbm+o8qSaltwPmj5iuRRyAT9ej5l1hitVoesU
         lrkO78mncx897ssdrPXG/Lzf3ySMpragxe7OzUzOztR7lvQDbul0/kAU4+H0SG5fQ4SE
         CWOOrFTyORdC4udrWMSg21kQ07IGSs0nu3zxDMvVrIQ+lDL+cbWMWMaD+IdtZM5uZnt9
         ERcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781174940; x=1781779740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7qWssdHiLBFsSt8dH4a2h+fzHkfZe1zSV2zWUbUyiA=;
        b=AvJM7OFUtWXRrNkCVKcOmr5TwrfVkp4VQGYDIIxpZgK2sjkHjUfUSVulwsCWU0vPiu
         RNDFiA7rJY+cFTJ1QpMqo/WJ1cBtIo+UPH4x3LqVX2aQU3LzeZKcTgwHS+fMK8aOR8WT
         crc5TNMi6mDnxj/pEdkk95x7ExZ8iHfWNFfucsdMTOOFEI/Ru3WjS6Ht5LNegCcEIfJx
         zFcv/jQDHMufdO8Y3wAgm/elXRlHQjsKbxZ+C5VpcOdYjQokXWYcEYIseNKbbdvAKlz+
         k9dvZI08M1LcogpglvykE+HQRa4y+iIyqXJrBQAXAfqk7uAw/9KShgm3mUOCK0ww/LUX
         IjKg==
X-Forwarded-Encrypted: i=1; AFNElJ+oDxqDpg3/w7fpaQ75vD5BEcJVigOoefLfpfivgS/a0LIZjlftmGCts3WMdbdyYV7YfYDqte0eFC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyppDaQ1Dc5/6ylVPEqFlQGELUgRp9Jd1thiwiPr1sAqS+3xawL
	0reCC6VwZmXsF15StKYUoWmhN6f3enF4rcrq1umlroP0hjTZaTo6rtXr
X-Gm-Gg: Acq92OGI+h2cMI/reuvCEgiKGkQ6v8eTdzWsbZ/xs2btR/5Qk9hxuQje2C+MlB5Wwsx
	ruZbyvCmw7rgo7Ijg93VHMq79kYEl4NdTUmJD4/D1JnvNNiNnaNBnrZvuYEF2dfNrBWBqzIEut4
	EaLQofFt5XWBLGug1IyMmDylV++bhAbwhQeOHnK4sZQ25mNhrWU4MOVJfN+Nyq2QRmxBzofSq1K
	lHeNbsXq1E8dDhSTF9G9C6x4Tesxffe9EGB2KExnjKtIf8+zkr0tyn/J0DPTSPCx6O07I1I65+n
	WpDsxGkrqDtJbMftcUr21uPvK8u/I5wh5z+8l4FSdEz66oAoyM/vbZx1m3v1XbCGcvWUCPmCMqC
	A6JOVK+ZdqKVA/A1q6KvrV4dNkdc6fiYEjJ4CCVF/vjCMfkgTeIw+63tNgnJqZqHM7MDLzYPTAw
	E/35a8hacPss8ut/17c4Ifb/k101RKArNnuNhpQcIWCvjVrG7kSuAAaZ8J2t4Lt87ZEwasem68F
	TxSDIv5RtyfCg==
X-Received: by 2002:a05:600c:c054:b0:490:4b89:5362 with SMTP id 5b1f17b1804b1-490e56146admr18108955e9.24.1781174939589;
        Thu, 11 Jun 2026 03:48:59 -0700 (PDT)
Received: from localhost.localdomain ([90.173.102.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2c7ead0sm62775155e9.3.2026.06.11.03.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 03:48:59 -0700 (PDT)
From: =?UTF-8?q?Guillermo=20Rodr=C3=ADguez?= <guille.rodriguez@gmail.com>
To: Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"M'boumba Cedric Madianga" <cedric.madianga@gmail.com>,
	Wolfram Sang <wsa@kernel.org>
Cc: =?UTF-8?q?Guillermo=20Rodr=C3=ADguez?= <guille.rodriguez@gmail.com>,
	Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
	linux-i2c@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: stm32f7: truncate clock period instead of rounding it
Date: Thu, 11 Jun 2026 12:48:56 +0200
Message-Id: <20260611104857.242153-1-guille.rodriguez@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

stm32f7_i2c_compute_timing() derives the I2C clock source period
(i2cclk) with DIV_ROUND_CLOSEST, which may round it up. When the
period is overestimated, all timings computed from it (SCLDEL,
SDADEL, SCLL, SCLH) come out shorter on the wire than calculated,
and the resulting bus rate can exceed the requested speed, violating
the I2C specification minimums for tLOW and tHIGH.

For example, with a 104.45 MHz clock source (e.g. PCLK1, the
reset-default I2C clock source on STM32MP1), i2cclk is rounded from
9.574 ns up to 10 ns. Requesting a 400 kHz fast mode bus with
72/27 ns rise/fall times and no analog/digital filters then produces
an actual bus rate of 415.6 kHz with tLOW = 1254 ns, violating both
the 400 kHz maximum rate and the 1300 ns tLOW minimum of the
specification.

Truncate the period instead, so that it can only be underestimated.
The error then falls on the safe side: the programmed timings come
out slightly longer than computed and the bus runs marginally below
the target rate (375.3 kHz in the example above) while meeting the
specification.

i2cbus is left rounded-to-closest: it is only used as the target of
the clk_error comparison and is never multiplied into the programmed
timings, so nearest rounding remains accurate there.

Fixes: aeb068c57214 ("i2c: i2c-stm32f7: add driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guillermo Rodríguez <guille.rodriguez@gmail.com>
---
 drivers/i2c/busses/i2c-stm32f7.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 53d9df70ebe4..6439620d6bed 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -464,8 +464,13 @@ static int stm32f7_i2c_compute_timing(struct stm32f7_i2c_dev *i2c_dev,
 {
 	struct stm32f7_i2c_spec *specs;
 	u32 p_prev = STM32F7_PRESC_MAX;
-	u32 i2cclk = DIV_ROUND_CLOSEST(NSEC_PER_SEC,
-				       setup->clock_src);
+	/*
+	 * Truncate instead of rounding to closest: if the clock period is
+	 * overestimated, the computed SCL timings will come out shorter on
+	 * the wire, which can push the bus above the target rate and below
+	 * the spec's tLOW/tHIGH minimums.
+	 */
+	u32 i2cclk = NSEC_PER_SEC / setup->clock_src;
 	u32 i2cbus = DIV_ROUND_CLOSEST(NSEC_PER_SEC,
 				       setup->speed_freq);
 	u32 clk_error_prev = i2cbus;
-- 
2.25.1

