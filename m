Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80505492196
	for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858413; cv=none; b=MslIpyWuYbgIbYJXUc+N+fDNokcLoR3TnqoYNqWIAQnmzTHxS+kqQYV69Kv/bgFmtrfmO5yyFmJmJTsreNnuS4jPTSitZ4Qxx5QiUbw94hxvj/d0/NPvutao7taiidtPvoYRN6L5xPg18pEPBS74a4rQKYPodAUDH0dWFTBasns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858413; c=relaxed/simple;
	bh=rW5n7OqbSCAqxVhlwKXH9xQUGgQISNsL2fWviW3pC1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h417E7rSYXWNyRIDVONMa4vMKs3dt5iyTusS2YEKOZi4swF23qdkAgq/Rrpk0mnLsmeQs4GzEv3IlhCl3v37gQi6Nxzs16pGENC7aAV5stBknJ3DxcNZv0SxAFuuFJtV+w5qInU1qvAJr+jHPBuOs3R0xlYywkMU9oSXSe4d7n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cE/p4Uxh; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cE/p4Uxh"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a8b18f6567so461683e87.2
        for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 08:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778858408; x=1779463208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKAOTSOlzS3MEHwcMlGimMeAY+aTNXac4GDWI+Xw68c=;
        b=cE/p4UxhFZbRDvdzgriOqqlKmxZmcfVDDLIRopCdehFdQySuv0mVnVkbngigwqm70B
         H1dwJRqKp4/TngP0Ma0aYm8A4R0vnP3nOTndTOKhnpbbAd78sZTNLef6E+bo79/Am9Tr
         xFUNxg99E6WxjITm4kXE6XI6tWksO6LuRXgG+B0UtQRHT2tJUtteG+nw9ZdpP/VnzTxJ
         jfMm8wvY7nC8hSsAhsEKZGgVNy7kra01PgaGBYfAEgBV/bKyewmFF7OEbFjtZXxl5kRj
         v8ZFThsBB4csQ9Va6Oc4B9OoYlzXLEcRxqw6wcsPiSbHlNcqSN1XwITFgE/85RU/Jgy/
         XHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778858408; x=1779463208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oKAOTSOlzS3MEHwcMlGimMeAY+aTNXac4GDWI+Xw68c=;
        b=MHB99rhFWYWdXcBnyKMKm2FcIbiu3q3Vdh3FUzMseERZqGGQxYBkONkOHrYSa/awhT
         +ZTDv3TZ0xDoezcqDvXFrLlwp1mzYUop5PFFvppZcF8ElZJG6oTu64jXoO+ZP7+BgTsu
         wqE81sug4kCfWFpcnA8IJRQacVJYoCR0TqnCqkL+iM//cojvQyC/N9IiypGJbBVM4/YN
         VxLfiIxDv9V9u0pH7gY+lVu4s0Iz256rgsSHDL5zWWXjv980XCpYbu6Om8amgv+jX3IM
         4KaS7KSIS2RaBTv1IHLU2nLTCeji2BzBEb/T8EW3lyvj9xfNfp+tGkXzUBW+c7rIsJeV
         h5Ag==
X-Forwarded-Encrypted: i=1; AFNElJ/u9GvTJBro0zfaBAUTWGcmsd40HkyPC6sbIsR5sxYBMtiyy8uGFdlnj1pcC18BHAhtPrlGGFqPzN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyQFS1Mx5EzfUaEhuOSS2kbQ6onn/A2M4/funDWPOUywB4rrEv
	gAIsd5mdTEgDN26fdp2GhiV+x++VekD64V6IkaCEfh4I+xcmulE4FJhX2PYbQt8wVeU=
X-Gm-Gg: Acq92OEV/BVFh39T3T/T4w/prgcxrEAHB9JlSqMbXVjUZxSEYKdpLznqBT9aHAlO5GL
	SFvEqsL+MRvHFECdDgUI3vUmw6+MNdmgUXFf/kSKqHSN5M0Fn9nu08ia+jy9hHMldsgkXdLBN8h
	4VvLrhQz4nCekXut1ekxOitNLFyj+yV08B26b2X33NIDCtj2KKX/eWU2jiLd947qKcnRx4EFFpJ
	/zOraMF0Y2Q15cw7VsVzCmAO4rOExz7j0opatfBUOUBn+Ztxqr5wIZ20wOR8q0bRCExS1warqKl
	SIgqkd3xREBjcrVOq0waROfgSLLesvsbw5vCiuLrfXkUyztW4rc09uv9CNLx5ILhxcGSwJx9vWI
	ttmOJQrUrpxk+4vGfwWY99M5enlLzu/a8bDBBCjHnZc5XOgBUN2Htq9iFZoVwTOPpB+XgxNxx5u
	FF4E40U6RtcADYnYx8iuqC/NPYboiA4V92FN9Wu+dpd/5xWt2pqTshz0Spi6L8GACApA==
X-Received: by 2002:a05:6512:1254:b0:5a8:7c42:bebe with SMTP id 2adb3069b0e04-5aa0e97f14emr666583e87.4.1778858407611;
        Fri, 15 May 2026 08:20:07 -0700 (PDT)
Received: from thyme.. (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164bc20fsm1392418e87.43.2026.05.15.08.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:20:07 -0700 (PDT)
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Robert Foss <rfoss@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 3/4] i2c: qcom-cci: Move cci_init() under cci_reset() function
Date: Fri, 15 May 2026 18:20:02 +0300
Message-ID: <20260515152003.1604187-4-vladimir.zapolskiy@linaro.org>
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

