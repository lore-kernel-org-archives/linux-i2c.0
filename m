Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8013F8882
	for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 23:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778888494; cv=none; b=niGEJ6CLa7hGmUqgoUihS8Jg+1VbjfUAbry4mN5UlLX+/Lvx+9dxuEREznrGL/sfkshYhlJiu5vMYdXevIYAvRqxlEmcHG4zl/mAIbLwUkDwzXNpnCMv0bnvxLSISrvQJLD+7kX+kHdwxwK/9zXbrcVF8EDyLPYPZoefka06jZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778888494; c=relaxed/simple;
	bh=rW5n7OqbSCAqxVhlwKXH9xQUGgQISNsL2fWviW3pC1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKr+qIovKAgs+Y1d74L1aKzXLeOl96xNnbhquLWvlyY9rDdl7PjMGhFnm4LSd7wutzrZhMe42MbQVYjpjyy6FP11VReoqcc/evFa4S24QUUH4qbW86tE0YEb1CFpyaFVMZTDQN2PuZtwRrAgbahEbE/CuntrPKJ9fHv+vhiAQzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vbcc/ABJ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vbcc/ABJ"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a3ffd11fa2so39311e87.0
        for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 16:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778888491; x=1779493291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKAOTSOlzS3MEHwcMlGimMeAY+aTNXac4GDWI+Xw68c=;
        b=vbcc/ABJmUb0mQ9J4gbqCau2XP8jJ+N11i+s6OA1qYdtipxq+1R8YmTjKiI31HVkG4
         +KtoXaVUYA2NzDdo6EaRF6xwi3kujihU2rIP2ILOw805fbNdlH+w7oP5goVpidcsFVdM
         w4lW7NVf1PS55cpvNUU1+0ZnAyR5nLoPQNY+qH6RsZWJ4HD6RpzJrnVmNb82w+n6XAFm
         fvakLmr0Oxrzlxh5JriBwc715Y5EvCIDbas0OdN11tsPEjhn80CApBxRkaRjqTUfRz9n
         4PDnBPlBMsT+g9Dee4wSQ77KXK1SXu+U+OZKSPJw1HaFCo5fD6/wMuP0S9s+kmq0VKFi
         R1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778888491; x=1779493291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oKAOTSOlzS3MEHwcMlGimMeAY+aTNXac4GDWI+Xw68c=;
        b=m+YXz7BQgnXY09/EYaEbUTFMjJWbpfUZk+HQF4yi2I3cHkw+80J+Wpi4SbNmqiOXxH
         oxz+tWXjjP9GDvGoZ/JiO6dIhsk5hOHMYjXCF6DFn1T0KAwHXpSNPXFpuqf5w2RdwwGq
         YzP2CGRBywIJGmjVX2SrBFlZR6w1jfARt0t8eu4G/THhsDXg4JvYAV0OcofS+GtpVALs
         XdUXX/w5xy1MVts8zkFc6Iz9JCB3yZxshhx46hqLs4nYPV+zbn/Sj6Yh/0y20PZcSp/9
         SUjd5Qe/xoNBFOfmSq2vgaYAwuTGgHvKI9/ihq9GdHkt7aM022xRt80cyeGihrRTuEDT
         EWMg==
X-Forwarded-Encrypted: i=1; AFNElJ8Fa5LqF3Oc8NDmOGWPQkKeoaNzxciw3w2LC1lkA/AP63INC/mIjnSRH4nrcL7cccaq7ybhVLn9tjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXYGwftFD/Q9uUscnNnQdP/Ui8U1xBqYETDdnWCddw3xFvN62K
	dLG9Ix7gmD3Il8F9BGK+ybvk7beaQp8JkIEp38T6P0xKNvPeSWG1/jjyS4UwZaO1w0I=
X-Gm-Gg: Acq92OFi2sCCxnyOQxK1aFGKnK+4ZbWG0B2dCYJ2bvO7/FbOYlV56eYrCYAGFGVCgOj
	M/jBdvl8LYb8VC75hWk2y4WaI7HIYS3Flz0ARuZ0GbBiV/P71EbGFhrtUI2GCObVGmchLlCygBt
	RT5bl4HRvJA4B6FQp3i1dOr4gACwjNEc//jXRJYN2l6jNWX9cebJgtk7BDWOYR1CH0+lHqyZqee
	+tQVda8zDhyRrsdwuzJseuGJVKZXSImCHsIZxi7nbtZioPm0tcSnYHusaLun0hkeDAIaco3KAET
	ZOM4zBoNTKoS971N8dbWl64Ifts1pvjbZfFvId41kvEFeWgZKePf1gJMsK88AIVeeSUbRoNfC1p
	Ljpej+xlrPL7BdWmBmKgSmaDwKBCKQR8+DjXHdYkK6XEzUJO/4rDCmMouHwsGVPi4zmmiMm64sT
	vr1awqNOhgApGTSSeJYbO7S4iL1gUkqoCLnQkmE21a7zlEk7lqD/HGNNIJdrGJP45/dA==
X-Received: by 2002:a05:6512:3409:b0:5a4:1099:b16a with SMTP id 2adb3069b0e04-5aa0e5d8440mr743152e87.0.1778888490651;
        Fri, 15 May 2026 16:41:30 -0700 (PDT)
Received: from thyme.. (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f10c710sm1631384e87.7.2026.05.15.16.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 16:41:30 -0700 (PDT)
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Robert Foss <rfoss@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 3/4] i2c: qcom-cci: Move cci_init() under cci_reset() function
Date: Sat, 16 May 2026 02:41:20 +0300
Message-ID: <20260515234121.1607425-4-vladimir.zapolskiy@linaro.org>
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

On probe or runtime errors cci_reset() is called and it should be coupled
with cci_init(), instead of doing this on caller's side, embed cci_init()
directly into the cci_reset() function.

This is a non-functional change, cci_reset() and cci_init() function
bodies are reordered.

Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 41 +++++++++++++++----------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index be41a53e30c6..2d73903f14d3 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -225,24 +225,6 @@ static int cci_halt(struct cci *cci, u8 master_num)
 	return 0;
 }
 
-static int cci_reset(struct cci *cci)
-{
-	/*
-	 * we reset the whole controller, here and for implicity use
-	 * master[0].xxx for waiting on it.
-	 */
-	reinit_completion(&cci->master[0].irq_complete);
-	writel(CCI_RESET_CMD_MASK, cci->base + CCI_RESET_CMD);
-
-	if (!wait_for_completion_timeout(&cci->master[0].irq_complete,
-					 CCI_TIMEOUT)) {
-		dev_err(cci->dev, "CCI reset timeout\n");
-		return -ETIMEDOUT;
-	}
-
-	return 0;
-}
-
 static void cci_init(struct cci *cci)
 {
 	u32 val = CCI_IRQ_MASK_0_I2C_M0_RD_DONE |
@@ -286,6 +268,26 @@ static void cci_init(struct cci *cci)
 	}
 }
 
+static int cci_reset(struct cci *cci)
+{
+	/*
+	 * we reset the whole controller, here and for implicity use
+	 * master[0].xxx for waiting on it.
+	 */
+	reinit_completion(&cci->master[0].irq_complete);
+	writel(CCI_RESET_CMD_MASK, cci->base + CCI_RESET_CMD);
+
+	if (!wait_for_completion_timeout(&cci->master[0].irq_complete,
+					 CCI_TIMEOUT)) {
+		dev_err(cci->dev, "CCI reset timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	cci_init(cci);
+
+	return 0;
+}
+
 static int cci_run_queue(struct cci *cci, u8 master, u8 queue)
 {
 	u32 val;
@@ -302,7 +304,6 @@ static int cci_run_queue(struct cci *cci, u8 master, u8 queue)
 		dev_err(cci->dev, "master %d queue %d timeout\n",
 			master, queue);
 		cci_reset(cci);
-		cci_init(cci);
 		return -ETIMEDOUT;
 	}
 
@@ -609,8 +610,6 @@ static int cci_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto error;
 
-	cci_init(cci);
-
 	pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_active(dev);
-- 
2.49.0

