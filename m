Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3472048C8D7
	for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858412; cv=none; b=p3RLYXUMiwYCRNM64s3MjRseTDxCBpc5BkkamO6CZLE6ePKOHXbJQtOKdMZ68QE6xHQdRAN4x2qLpfHn+rINtJXfbbJ1TibaboIkngsFNKyK4qJEviG4U9MD9RazD8zLG6juUUKzLdrXaiuIyTtlDeOtF2SUuOLJ7wjE9dDDqYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858412; c=relaxed/simple;
	bh=aw//OWk7ekdLqz6+NXAqRiETHV/evtXwY9fM3TOle1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2enDQSpEijoWETCS7kQikM1TgOyUH1aF2+OIbhgEn9zFnqjpr51xJpowQNW6UXmMbyu5KCEa9e30IrHiUN5ZMbmIkI7RxeTcEWBwr+nE1VIwQ7X148sxr4V5zTL4IYLj+xDsT5eD6DQKyMgN4Y2Uo2ztHrpnKYmk9BPtcUf3Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G8mGfBh4; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G8mGfBh4"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a8e387baaaso364255e87.2
        for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 08:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778858407; x=1779463207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Y5rcd8ol/OODf2w+e7bAV3jzDI3zj+SkdCDhFbr/Ws=;
        b=G8mGfBh42HfbS3e+GzglYgRjH3oiGbEHsUeERP1PNRtGWfANbQTkEqHx4q/Hkx5zMR
         EXGEL7pCPUc74jGJVb8VWe0VLMVvX/TQn5NDopGTkeE7NA8bFEWUJLobKbANB9YyDEvw
         6MNq41dn8vI0YeTA1NMwCdKx97yoBFff0/vVbA2netgPywXe+fYJAX8+0+bmelNhmyCR
         8GC8kzS2Ku17WGrxSsUfRXsTGpZHb9vt6Mi6o+djUA+8y+Gh3p7jrOcCgPNTKWoM6aQi
         akBek8BJ0oeW3XOUEoP0TJrkHraWDP2tvZ0emYehqSsJ6jTwsbGaH9uUqeSv1vOec/GJ
         OAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778858407; x=1779463207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Y5rcd8ol/OODf2w+e7bAV3jzDI3zj+SkdCDhFbr/Ws=;
        b=sWHV7+F22eXaIirJ9++jU8TWzaqWu1dcVrH7NixctEf5crIx0DGUAHG8iIj12Zp0MX
         gnu0+xLFk7iA8Ve4J+kUJs5UygAtQzrAVMh/IcuMzJF9OpmTz8rGKVJcNUWlBF3UVcEk
         XwJHlPg+R42G77fDNBmARj9hZC+vVT+imd/cvzB2Z4D9W7JaJjAxcb5qv11Yk3t7Ntlc
         GoSwQg4DmaBxFxFrsChLyPlv3X+ATFx/boSuwpqXimg7buZpus7FfjXzs6igXUiy1pz4
         e6bjPQzj2nlbTUiDV7HU5gjzTEP/2UIQ/WkQVxpSKvAMt9IDowRphZ3ynHjhKRt88krw
         KC3w==
X-Forwarded-Encrypted: i=1; AFNElJ9yfFInCva5TE5RexxTgG+m2b6Pt3TaqVVYH0PPpGQfgGk79bVwAqY/QLL2avb7KHnO7sCTP4XzqoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVx4hTs2dsEJQW6sLY8no/sO9EiOvQHRnwXQNJT6GQU+09L1S7
	7rTyr8W8ALj3iJU+Ri2AQ48CktIATJwsoe73YMuX4gkiHpXoR1w0BjYBiHvNal7cNsg=
X-Gm-Gg: Acq92OHmHjXsF7KNbXz2Aou3VkWRLjF7IR87iFY6k9hoQmQRW17jqAqAXkNjGaLov1n
	quZZzWgABS2e15WDokk+M86POMeLGO4mXzI/faHUIJDQp7/1m83tijeXra7a9B9CLa5NkZ5ryqR
	Vn1JxtKp3d5MAxtQ2e2t+lW/X/Sagw/KofHk7CD+lOEzVN8z/Gi+yn1mayWcrz3g9xEJbB56B36
	OwsZrvB//wpz1sF8kqn0bjrRSL43WXrsRfJ6xOgbxRxA+yUwpNi0OPxhaT9gnxbsLHpBHBlj4Pi
	UGxpjHd8fZ1TORoK87NZq9E1scspe7p+m7kyQpfYOxUMbkVzZ0vNKTkvPJjcn4CBHlJpOpP98xt
	6WGyjlm7eC7RoANk9whQ5AV8OkaDSNmfhAryLL2tHd2nvqzXNLn/B/p869tN/aIBH9H2rwK53gx
	h3K/RWqMiq6/5I09nbmwvTjhI+5SV4cZRnrDAJK4YPQ3h3eo7YdDx5jcDMhNb+TevjCWCdfV738
	L1+
X-Received: by 2002:a05:6512:1249:b0:5a4:a4c:6595 with SMTP id 2adb3069b0e04-5aa0e74584fmr853988e87.4.1778858406883;
        Fri, 15 May 2026 08:20:06 -0700 (PDT)
Received: from thyme.. (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164bc20fsm1392418e87.43.2026.05.15.08.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:20:06 -0700 (PDT)
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Robert Foss <rfoss@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/4] i2c: qcom-cci: Do not check return value of cci_init()
Date: Fri, 15 May 2026 18:20:01 +0300
Message-ID: <20260515152003.1604187-3-vladimir.zapolskiy@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260515152003.1604187-1-vladimir.zapolskiy@linaro.org>
References: <20260515152003.1604187-1-vladimir.zapolskiy@linaro.org>
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

