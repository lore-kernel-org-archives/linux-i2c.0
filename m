Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792653286;
	b=EdtKGTH9zhnIozAEUmTRB2maciK/yqrZ6Dk5mziTsvc/SEJmdwVGK7GwpI4G2TXl9+U6
	 b0nVVQ/gsSBtOOs2sehFmSdSCNJf1ghSeG2ZeWRTFTVNN1toYGqcR9QctDY6gX8PHmKMR
	 BnDI3IbIaEPyD7TaWDYtyIMBlakTdlvSlctCJZm7VZLKZBLPT9albiMMjIiMkTXVAFsG6
	 VklZnJeYBu6k1xZhPHYQiGB1YaKBy1bENjsHRTIeGOI5erZqiFiuYMgWNCzqztaYz/NVE
	 LMmNc0ckGhpt8Dgs99D6fkRYto88txZyDHXGG1oSoqVVfLu1nEP6I6/bv+jYQObThHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792653286;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rbQd37yNdLoEoUUb1uI07DktRFDbgbFgP3dMH/u8vgc=;
	b=Ob+594CSmJR+uwoxPQuzGZL0Ku47PihInUkb+XMgi+vPiPUPsddbxqt3upF9pUGmgXT+
	 ynf2j3COk+525MEFWo5TnjAUXxUAzhttZCz8x/Xq+fniEsnZhb30O+9WXza19ei/eyyFn
	 FRHtthC88kfy6mztknt5xeU0dhCwv0Bq0sKDEmsYeHQkzUqEC3gnWz4s2/0y/h8QkV+o3
	 dX21TTRYAsaFkvY35tQhZ9PfePVGwC4I9G3L2AGLcc3NVtmM+7AyC6CAV+G96P9eUFqu5
	 Ou5rcP7y4JhtFXiHDPCoLxawATosN+n9V4ligY3eNEtic61MmZDPOX7BBjYoeUShn2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BFZUQwc0;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185AD606A327
	for <linux-i2c@vger.kernel.org>; Thu, 22 Oct 2026 07:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 185AD606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BFZUQwc0
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3282db206d3so3634387eec.0
        for <linux-i2c@vger.kernel.org>; Thu, 22 Oct 2026 00:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792653285; x=1793258085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rbQd37yNdLoEoUUb1uI07DktRFDbgbFgP3dMH/u8vgc=;
        b=BFZUQwc0glnGG0PC89J6I5yzkEC2MR9OBVnxAlTWSNJ8PjQOGdEdTojkyZ000fkN7e
         /dLlw/5WtvHT5jU1Yxb+WnqLDWSfzrof6bbJL5BZmrl46WtCGkJg1OKvHcF6eU990bAV
         QkHS0G/s1TMlcc/SSQtVmAUmBSr7R0IzoGXCX5PvLjuokmEWSK3+cL7NJtu2hTzoBPQw
         GG0wDpoO3cgyMe2DJJPE3vuBX0vjYr5isphipLLx2VirrFABjVhrX9oCuv1HUbrkPgMw
         PJJ41YcltJaXXf0As8L62f7a0Q+dPDQjyiJoOoXy2zqV4PouQ59trMIUpagKBt8KDJSM
         FKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792653285; x=1793258085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rbQd37yNdLoEoUUb1uI07DktRFDbgbFgP3dMH/u8vgc=;
        b=t5GNq2iMjObceOOPjJT2DMFweRvc/By3m1WmPiK2MtsgZQvWdHQF3HzHRR5lObfuus
         XeMtlj7MC2tv/KMdokK/xExRu7lQLA74ZrfswkuS79xH1oyhlhm1USwzLTx9mchBTRZK
         9rXKBsiTUMx8hx+varLXjeCCRnO8lcjY3cnqQEbhNO2pnne7nXoY7+wlwq2NH737iYAF
         m3g6fgJUnCuz7GBs84X5fsAg97ZpEpwvN5q4QedgXTX9dV5sQXiCBnRn+zEMWvOt+yeM
         snt7yezfbD9pSgdRm+2jB/d/TVM5DsRgjXb9V7xAI/YUgh1IVOTE/nHs5E8+vo5Y/ouL
         vcnA==
X-Forwarded-Encrypted: i=1; AKwUvByz/zR3XJ9/M5/2kNhFE+HXBg5Cw2utU64xtqkIlbDTCCeKopi5AfUt8USvA93qZzvXIXsPbkDdxKk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLLyn461VTO5syx9vhBY9z8XnfaODiZqP5qcDI+YMCLMtLS8AzS
	4M3Ukcsjx18DSkmpElloszC2iyGoAdhjrKpoA4T3Apm6gyVJQ0OSyL5m
X-Gm-Gg: AYBFou3FH6p8Sm6SUMiC5OyuOtIQktNJ3G8rCtzHBZjrBGK8/zCSlG+raxHjOSVCJ7N
	y5wA9Htl4Foi+qpr3kE11YlyRoxv9e+aSLO8lf0n2WcXpW4Plel8YNT1M8LS3QU6B/9Nr/ImFJr
	XexEWcI/JwG0ajxj55cenEeszpadB0Hftb1W0vO5SAvMEQ60I0Nw2tcpY7g02J60eyoTAv2MF1t
	aXeZ5v+68TV/wekfvrjUuU6PpFVI1yI4VYtvWT09957SB60YHGNaC6aolLnrRFn3TPoLUD8t66b
	unmPEyCdccq3HuM7wYsi6CQnkFcWnizmSsGfioUnsyKZBkiwG+AW+Arv5LJrygyXErfwD0tOnnr
	JFm88XkFznPPZX5MJrWUKAgJfTKCEB8kEPJZKJ/Faoh6P4g8UqOM2XkyML+YZSie07Gp5aiP5jF
	JY+qL90sF61kDInwD01exVdZchAk8Pv07AU89XblvtxyxHdD3bD2vUGzI3w+6CkT6dMRqIklLG/
	pm1/voFE6novfrNAZ8CqSo9HW2LCggQpVRha8WdFJ0IZgbIe40oxfkh/JBX+acNsQ7qPYRQ40Q=
X-Received: by 2002:a05:7022:c43:b0:194:3a84:e67a with SMTP id a92af1059eb24-1943a84eaabmr325046c88.41.1792653285121;
        Thu, 22 Oct 2026 00:14:45 -0700 (PDT)
Received: from fedora-x1e ([210.89.35.119])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903bd6b7ccsm11112321c88.13.2026.10.22.00.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 00:14:44 -0700 (PDT)
From: Saikiran <bjsaikiran@gmail.com>
To: loic.poulain@oss.qualcomm.com
Cc: rfoss@kernel.org,
	andi.shyti@kernel.org,
	sakari.ailus@linux.intel.com,
	hansg@kernel.org,
	bod@kernel.org,
	mchehab@kernel.org,
	vladimir.zapolskiy@linaro.org,
	jishnu.prakash@oss.qualcomm.com,
	birk.skyum@pm.me,
	linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Subject: [PATCH v1 2/2] media: ov02c10: Fix sensor power sequencing
Date: Thu, 22 Oct 2026 12:44:18 +0530
Message-ID: <20261022071418.26895-3-bjsaikiran@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022071418.26895-1-bjsaikiran@gmail.com>
References: <20261022071418.26895-1-bjsaikiran@gmail.com>
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

The OV02C10 driver enables MCLK before the sensor supplies and disables it
after the supplies. This can back-power the sensor through MCLK while its
supplies are off and contributes to camera brownouts on the Lenovo Yoga
Slim 7x.

Follow the power sequence used by the firmware on this platform: enable the
supplies before MCLK and disable MCLK before the supplies. Hold reset for
at least 1 ms before disabling MCLK on power-off, and wait at least 10 ms
after releasing reset on power-on to allow the sensor to start up.

Update the power-on error path to disable the supplies if enabling MCLK
fails.

Tested-on: Lenovo Yoga Slim 7x (Snapdragon X Elite)
Signed-off-by: Saikiran <bjsaikiran@gmail.com>
---
 drivers/media/i2c/ov02c10.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/media/i2c/ov02c10.c b/drivers/media/i2c/ov02c10.c
index 221cb93126ec..42aa43ea0a22 100644
--- a/drivers/media/i2c/ov02c10.c
+++ b/drivers/media/i2c/ov02c10.c
@@ -661,12 +661,13 @@ static int ov02c10_power_off(struct device *dev)
 	struct ov02c10 *ov02c10 = to_ov02c10(sd);
 
 	gpiod_set_value_cansleep(ov02c10->reset, 1);
+	usleep_range(1000, 1100);
+
+	clk_disable_unprepare(ov02c10->img_clk);
 
 	regulator_bulk_disable(ARRAY_SIZE(ov02c10_supply_names),
 			       ov02c10->supplies);
 
-	clk_disable_unprepare(ov02c10->img_clk);
-
 	return 0;
 }
 
@@ -682,23 +683,24 @@ static int ov02c10_power_on(struct device *dev)
 		usleep_range(5000, 6000);
 	}
 
-	ret = clk_prepare_enable(ov02c10->img_clk);
+	ret = regulator_bulk_enable(ARRAY_SIZE(ov02c10_supply_names),
+				    ov02c10->supplies);
 	if (ret < 0) {
-		dev_err(dev, "failed to enable imaging clock: %d", ret);
+		dev_err(dev, "failed to enable regulators: %d", ret);
 		return ret;
 	}
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(ov02c10_supply_names),
-				    ov02c10->supplies);
+	ret = clk_prepare_enable(ov02c10->img_clk);
 	if (ret < 0) {
-		dev_err(dev, "failed to enable regulators: %d", ret);
-		clk_disable_unprepare(ov02c10->img_clk);
+		dev_err(dev, "failed to enable imaging clock: %d", ret);
+		regulator_bulk_disable(ARRAY_SIZE(ov02c10_supply_names),
+				       ov02c10->supplies);
 		return ret;
 	}
 
 	if (ov02c10->reset) {
 		gpiod_set_value_cansleep(ov02c10->reset, 0);
-		usleep_range(5000, 5500);
+		usleep_range(10000, 11000);
 	}
 
 	return 0;
-- 
2.56.0

