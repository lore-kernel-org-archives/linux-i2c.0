Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9183F6C5F
	for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 23:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778888493; cv=none; b=m6LiI139t5aggnin8CAhdSmTb39J6418AuuGnwKCoFWQGo8ItuFgpgcYO4Kvr+FMp8jAl2atxudp5DMiRy5TPg5zjZEsSfuo2N69KHKc8rTv5UbJux1e37p3xm85sOjG0FjApvwj5ShPEDTzSDKrtlPm4VP4oxT4kDNY0SFjtJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778888493; c=relaxed/simple;
	bh=aw//OWk7ekdLqz6+NXAqRiETHV/evtXwY9fM3TOle1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PB9GNh/Qyn6iDDqGt09k4haFtP2XJCZfwiQ47/rvPtLxbZbpUw+4F2NTDxJl/b17xUua/J3NKOJM436XXC6sx/kg+VdgV/MFDv2vvAZ5+JucNsL0Tt86EYaCHkRmoXiYralHKBOhMnT8WUfJOyMSBproonGkW/lpqIF/Anj6CcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VdIm4L7o; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VdIm4L7o"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a8772a67bcso41429e87.3
        for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 16:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778888490; x=1779493290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Y5rcd8ol/OODf2w+e7bAV3jzDI3zj+SkdCDhFbr/Ws=;
        b=VdIm4L7oVzeVWzk/zmjH2JYH6nOx07Xz3Yy14wh7WeBCij5ZHvMgGlhKLbFIkaKZUG
         josOW4Z+tDeJqk/eh4BCl0m084V4Wb3cffgq6tOCGeeCXhqHl5rx8WsqKtW/ZzEVjdpF
         gP53+j3fhJGpW/wNMrODZoscku+4+HUtuBt7QBzF9XKau3b37taU7SNXJlNa6hpjJeOP
         6mpDHlLNdaN1EwHfT3pfXfa8ntyOfFCF+Tkyrp+exn4XoORP/KTI6KWUVOlPRoHqrZtU
         wt7cm4Gsgiu9MSO5KKKFGTDcYxfqzGfVJqb2PI7i2K629pxq5WnQXgTARhOYApJc+qXd
         bzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778888490; x=1779493290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Y5rcd8ol/OODf2w+e7bAV3jzDI3zj+SkdCDhFbr/Ws=;
        b=ci6IfTwbOji1hAG8KraEA+AO5utMvEv7TNqdFMpfxghQRfnDKBbKk072RWL8J2J1Vy
         Ti7fY6GQgRrMxZsS7+dpXLDfxq1NY3I+HoJk3Q/o6vD/dN1HyKpchW/30jZQAkzN7DiR
         /cLY7xqBr/Ay9tz1bHCGW5mHFksr/x17G5KhW87Z9YuBtyJLbVIUvwlDaQAQRJK4oErQ
         d96luISI+9nSoMzA7V8g/0dz7hA6gAV/qyH68UVLv2/+Si7yd3LBA6cqG71MdXQ8pzg4
         6ziRhglj40xVAm7zjyU8fIAh8/CvxqvbXGj5wdGSElqfUN6vKYwFawEbMQlSudFZqX/I
         qyjw==
X-Forwarded-Encrypted: i=1; AFNElJ/4IV/1lcyOD0efSqvrcsRJk5E+xUgTiW5ueTDIui+PApAbXe5nnL4ohEWsLrC5cmIuuj64da4oVnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKV0dkAhYWwXCX8Ad969SM/0VgaGnyhKg6Iqyo3W1iVyg/feKR
	8V9a+USakYZQFK+BuOw7Yj9P7BjnLYNK7M2YPpNVDiAkxD8DttTPMqDgAYgtjKYFvxU=
X-Gm-Gg: Acq92OG5uDCY1IW8HSLIvSwvtjqyixx90RCqVqHdG/Mk3k1VY2JtrNxdLNbAFd7An0z
	qAVWyfVcxscG+d/h9Kf+dE72/e3xqY6sKlq3WPul5eh/MuJItup0hlRjcyfyqu/cDKF0iG9sY5T
	pqpQ2ELpfRtq5M6A/JmYGjqR2dQxwOEC9TQIf9HJxsgHEhbuBJPEKOc2r77HnAMIhnzUGfP1Zin
	5M1+3iWLr4MR+ZKyy7n3R9SWxbjRR0COpjFGoUTB0I2mOnHRADgqttFoRQsyaDytT7dDrhKooIm
	NHe+yDLG/9v9xF9D966pIfaFiQVEwHjuJa4KNayaPcgvQTFlR41GTcsCEq0Ukfoo1XBJG+OqOBo
	l3+QsGwM80FlJrhhDsFRiXB/FGaYZOzHJj0K3CY6zZTuEWQ2gcnSfBZzMPL8VP7vzg5WCR893eG
	XvM1aBC4iMWQ5Cutg8FVzY0CIBFcV6+kguJD3Tgz5PUTu7pzRXJZ+oa0ta/6ibgWfbTFrnbXyjN
	pex
X-Received: by 2002:a05:6512:1085:b0:5a7:4048:af21 with SMTP id 2adb3069b0e04-5aa0e7470b9mr831580e87.7.1778888489796;
        Fri, 15 May 2026 16:41:29 -0700 (PDT)
Received: from thyme.. (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f10c710sm1631384e87.7.2026.05.15.16.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 16:41:29 -0700 (PDT)
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Robert Foss <rfoss@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 2/4] i2c: qcom-cci: Do not check return value of cci_init()
Date: Sat, 16 May 2026 02:41:19 +0300
Message-ID: <20260515234121.1607425-3-vladimir.zapolskiy@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260515234121.1607425-1-vladimir.zapolskiy@linaro.org>
References: <20260515234121.1607425-1-vladimir.zapolskiy@linaro.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cci_init() function is not supposed to fail, and it never returns
a non-zero, so it'd make sense to convert its signature to void.

Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 01e440b6585d..be41a53e30c6 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -243,7 +243,7 @@ static int cci_reset(struct cci *cci)
 	return 0;
 }
 
-static int cci_init(struct cci *cci)
+static void cci_init(struct cci *cci)
 {
 	u32 val = CCI_IRQ_MASK_0_I2C_M0_RD_DONE |
 			CCI_IRQ_MASK_0_I2C_M0_Q0_REPORT |
@@ -284,8 +284,6 @@ static int cci_init(struct cci *cci)
 		val = hw->scl_stretch_en << 8 | hw->trdhld << 4 | hw->tsp;
 		writel(val, cci->base + CCI_I2C_Mm_MISC_CTL(i));
 	}
-
-	return 0;
 }
 
 static int cci_run_queue(struct cci *cci, u8 master, u8 queue)
@@ -611,9 +609,7 @@ static int cci_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto error;
 
-	ret = cci_init(cci);
-	if (ret < 0)
-		goto error;
+	cci_init(cci);
 
 	pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
 	pm_runtime_use_autosuspend(dev);
-- 
2.49.0

