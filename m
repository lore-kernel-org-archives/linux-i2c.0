Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F2B378D7C
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 11:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769771451; cv=none; b=NL9BQITp92rKJWKebltWwmyeWD+Sl1fE1gtev3lJVXl7jzPEYL4CtVcv0hw/oAggZ6gT0hZro+6sY00pwEpKs8wAKrHDd93m04o0WKe0OeWfBorlBLrVr56so2S71ij1CD7HAqZLOASrUGyPLzUV+4BkJLXWowzXaAsXN6merUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769771451; c=relaxed/simple;
	bh=000+YBcuqnKUv4T+6H0j6GbJbdg7y/YIwvOiUVAuiIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eu+e3QF350NIJkl8sLnbreUPV/ZXKJncQpNWpSUrm+nUS0ZuChL2Ls45aW8ZE9ziKQP7iwIfRDhw1QfQwVrJW5X1HODjHMsjAL5Tf29mSVq/vZi1jaBtVcEBLlEzf/UTRwDRIt3F4a7qXvYxNPQ59WKpO+NrBv/eITGcu+Avs3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPLn96aB; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPLn96aB"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b872f1c31f1so263934866b.0
        for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 03:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769771449; x=1770376249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWmsh3XdIKcxTYGWYNNKasGhX6YaVuG1V2PZUGcRH+U=;
        b=lPLn96aBRFDSKUMt/g0TTD7xjWAgbaSWZsAhIUabtVGOMmHK2rU8Xe3n5f4OuAefwH
         5GCuGEuQa75uLGZte+SLmcsCC44xIfJrIXED7k2YEn5rAxWVH6dTn3D5ptlKSo1CgUGD
         cIztjsOjqbD/uVMMPBUI995pSxl4tAcBDEAlPz5Rvhpm4iYL0iK38m2J1vZhsLZcS42m
         jCK4Ct/7UgTZvAgIWXZE1HZVad1fQeRbLWzIC3Gf3/YLX2ugfj8/Kh0ilNlEZuS9c9w7
         wNBQI93AZMx9WKE4bxIjKPe0yIncDxadI7FkX6J+8rGBnDa1z9ZHUK2izDlBpJ4cjE4F
         HxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769771449; x=1770376249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mWmsh3XdIKcxTYGWYNNKasGhX6YaVuG1V2PZUGcRH+U=;
        b=sdV1SJv3QMuQpWBz9KGY8MnnkvbrawTdGTLFYMK/bc46rNAGNkvduYEM+p+l+Lb0/H
         sSRTzglTFisPchwofJW9+e+EuiXz+tQBj9SGpm2Iaigao1Gr06RiXxVdfL5gvuzx04Zz
         pEHcM6baVcjNCs02HO2SYAYU/K+npFjI8pnM1Xh1WhF4eO52+iBHKR/P3QwXTRXuj+qi
         m0LdySguvLkr845YisZCdANvBEsxzAkYJWdrjLFChrv4TQs6RZOx+BWYi5869sf+sgM6
         IzsZTSS4tXqR6GjeKwjQ9MjYYwxyFZpNUwBA17nCLMidoj2l84mty7Xk/9A9nNw7LkOu
         ks9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWjf6Oa7kUJpvAHMAM+ZUtsnUvBRcXr7VjRBQrK4JvgDXoh3Jib2nsISf0MGJj1u1VL2xitTpB6N3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPOwacTmgjk+5CcANZBsL+o63eDpYbtByb7TU5rNEb5C2rbg/l
	QpILCGlNksD4PA7Vsq3WbolVvO1/Rf5MI4u8JVnfpRmCN0I0QYrMNmf7
X-Gm-Gg: AZuq6aLxgNhRlo0QA/D/8qE9aAh3aOEjvj21Gb7OevzFESq5GjeiHc93j+LNtUtvyCb
	qdr81li1OcsZ3irBRmiAowIqbLB+Rv7Kh/h0TUqEmnCIGlgoTL3L9ZhbLRzDo+ni7JyFKlPo5Ov
	eEWnFPjK3sZKDxPNORFzK7G6MA5JxXqEZV84BBMwwLa00Lh0lsjh3twH18Vq77mShg7g00yqCGF
	aSPSH3ou77136umdtyWglXjQaJG1b3nt1lmrn3n4DUoDCsyeT0egbM3C13vKzUnpfj87rn6xRYP
	F4QSjvPJVhG8hU971kckf//aDYLvHzuDZvxWcZM6jKRoqPV0ev51m8+yRracqXnXEZgCCCbL/QY
	sqdCrHhR9o8trYb0PK2Nng1W99eoebFtxEPtW+ZY2XNP506Hr8iwu/Me9WuAOfoifohfEcVo0V/
	apq9mbJoKafeFT62g6YmpAugcu7fZMow==
X-Received: by 2002:a17:907:948a:b0:b88:646b:ae31 with SMTP id a640c23a62f3a-b8dff6f79d8mr126642666b.47.1769771448498;
        Fri, 30 Jan 2026 03:10:48 -0800 (PST)
Received: from NB-6746.corp.yadro.com ([188.243.183.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbeffedd3sm396035666b.29.2026.01.30.03.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 03:10:48 -0800 (PST)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: andi.shyti@kernel.org,
	p.zabel@pengutronix.de,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	jsd@semihalf.com
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] i2c: designware-platdrv: simplify reset control
Date: Fri, 30 Jan 2026 14:10:36 +0300
Message-ID: <20260130111039.874548-2-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260130111039.874548-1-a.shimko.dev@gmail.com>
References: <20260130111039.874548-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation uses separate calls to acquire and deassert
reset control, requiring manual error handling for the deassertion
operation. This can be simplified using the dedicated devm function that
combines both operations.

Replace devm_reset_control_get_optional_exclusive() with
devm_reset_control_get_optional_exclusive_deasserted(), which handles both
reset acquisition and deassertion in a single call as well as
reset_control_put() which is called automatically on driver detach. This
eliminates the need for explicit deassertion and its associated error
checking while maintaining the same functional behavior through automatic
resource management.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 30 +++++++--------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 7be99656a67d..88e70970c72c 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -227,40 +227,32 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	dev->rst = devm_reset_control_get_optional_exclusive(device, NULL);
+	dev->rst = devm_reset_control_get_optional_exclusive_deasserted(device, NULL);
 	if (IS_ERR(dev->rst))
 		return dev_err_probe(device, PTR_ERR(dev->rst), "failed to acquire reset\n");
 
-	reset_control_deassert(dev->rst);
-
 	ret = i2c_dw_fw_parse_and_configure(dev);
 	if (ret)
-		goto exit_reset;
+		return ret;
 
 	ret = i2c_dw_probe_lock_support(dev);
-	if (ret) {
-		dev_err_probe(device, ret, "failed to probe lock support\n");
-		goto exit_reset;
-	}
+	if (ret)
+		return dev_err_probe(device, ret, "failed to probe lock support\n");
 
 	i2c_dw_configure(dev);
 
 	/* Optional interface clock */
 	dev->pclk = devm_clk_get_optional(device, "pclk");
-	if (IS_ERR(dev->pclk)) {
-		ret = dev_err_probe(device, PTR_ERR(dev->pclk), "failed to acquire pclk\n");
-		goto exit_reset;
-	}
+	if (IS_ERR(dev->pclk))
+		return dev_err_probe(device, PTR_ERR(dev->pclk), "failed to acquire pclk\n");
 
 	dev->clk = devm_clk_get_optional(device, NULL);
-	if (IS_ERR(dev->clk)) {
-		ret = dev_err_probe(device, PTR_ERR(dev->clk), "failed to acquire clock\n");
-		goto exit_reset;
-	}
+	if (IS_ERR(dev->clk))
+		return dev_err_probe(device, PTR_ERR(dev->clk), "failed to acquire clock\n");
 
 	ret = i2c_dw_prepare_clk(dev, true);
 	if (ret)
-		goto exit_reset;
+		return ret;
 
 	if (dev->clk) {
 		struct i2c_timings *t = &dev->timings;
@@ -308,8 +300,6 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 exit_probe:
 	dw_i2c_plat_pm_cleanup(dev);
 	i2c_dw_prepare_clk(dev, false);
-exit_reset:
-	reset_control_assert(dev->rst);
 	return ret;
 }
 
@@ -329,8 +319,6 @@ static void dw_i2c_plat_remove(struct platform_device *pdev)
 	dw_i2c_plat_pm_cleanup(dev);
 
 	i2c_dw_prepare_clk(dev, false);
-
-	reset_control_assert(dev->rst);
 }
 
 static const struct of_device_id dw_i2c_of_match[] = {
-- 
2.43.0

