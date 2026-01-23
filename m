Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6307D36F42E
	for <linux-i2c@vger.kernel.org>; Fri, 23 Jan 2026 10:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162762; cv=none; b=gkRJT2YAxhsGQbLBTiDFJNos4JdX8thpYIEAvJitb456gIoGmGCaJRK9IX9mcpVm6x34QbP5qlXxOom5iLpE6AQLmBTw+zFT9UYlL6znyK8NuscyEDUprD6susYWfswhdlGxYYCozd2VCms2nGWQRH8Fyqw/QK9MrukSrt/MgPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162762; c=relaxed/simple;
	bh=DP9gDT6UWjm/AKZ69bYn6QvCNY4qgqLvx4W6IFR2IiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lzv8uzgX4QUJB42C1JM0k008NchCzFAGa7s8QW4TtcSuCwYOFKQx934rVGEm7Kbgd9ce3y4ISYSal4/Ap0NKCT5boLfAn6DyQFK1K/3Uo6SHIi0V+Vul8V5LA4mUqbQ6K5OTi0Fee7tTZ18yD8ohIgXZ3B5Vet1V8MHTfA/X4W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWaAoxWV; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWaAoxWV"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b87124c6295so288199966b.3
        for <linux-i2c@vger.kernel.org>; Fri, 23 Jan 2026 02:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769162746; x=1769767546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CdYfdsWfa7LDquMIKKucDlhgkS6mtbPomfeEhXpctl4=;
        b=LWaAoxWVhNI10D0+1blbJPHhH6FcQ158MxKySN05y1WW23W11iyTOX6JoYocNKmtDh
         RImdBP3CF9ckzMsokDjUSktmK52G0zJgNQSugKMYG2jXBNDnEAbdpBs1YAgOQ42BTadV
         dY06YH8u/RHr/K0JAA8cU484CdbaCB4nrSBiOw/i7EeksHIAvYyscc7Lvzp6fbAqv+gG
         SiCDx+7f99nDAAUBozKx/qdNxjhJ8MHMj1J8gZc5iyamIjIzgdWoHltUD8BPD5ifA8+/
         40QQ+iS//GZbIjvz7bd+ospP8dKh4aF+pDgxZXoZ/4xGP/vnTo6zNaDSG194z1JPfRje
         pzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769162746; x=1769767546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdYfdsWfa7LDquMIKKucDlhgkS6mtbPomfeEhXpctl4=;
        b=sPhRDhSKhh24rFq173ueBWw1vi0SWiqTcCxioGbIIFWWokRxi2f/WSlmOGyYDJV8ud
         Pkshsvgz6Ib+ZZuLPFyqX+PM+BD4nMzC8OAVOWH/6EHnByITzcu1XPvWF6bM5V/1uhwi
         Huz6Iafg9jgMz1Z3NQrDscXQumc1R3XmNs23FcFqE+oTKB1zl9akR5tzyZaLOJBBo8HC
         3148ChA3nVGO4p6zY7+MsNc0i+zrlm257U0oYj5b/0K2augp7wiXZyfD7mk4jIeno6VR
         NUhKlS/jBH9LEX74jrb5htpy3E8gFmv6FG/tl/ROq7568KFp0KWNdsj5rs1y7r6gtdWc
         JMAg==
X-Forwarded-Encrypted: i=1; AJvYcCXYpN1BiJ1ueqddNzChzmua4DDWAknreynGEHNC3auQrMcYus/NHDAmJ+GHRX/Q9Kmlqf0fCjDgj/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+JGerMKIqq+x9lFm/8wZ67paUHN/h8serOo41JaRElCUD3lYi
	GrPQN9GQSg27buPR8WIU0VHCb5whcuejDu1EOLa70WG6sXXwN5cRucXqKDwZ4LwD
X-Gm-Gg: AZuq6aLMBMwsjkKG67JUEMm0TfJc18sD2HishrUsxp5V/M7ryGWtHuBQm0/28sJxRCu
	WM+AUIYThWbUI9A28fpxRdXtKDpW/V1uJUzjXUsS7XKHBh20NgyasaqMbTAnW1saKN5M5BpE60W
	qliYWEAaUPsfIpdpood9XZ8cAYyxRjqmTkmKXxeyY6/2bXhuoCJrArQos4zIbWxqXJknfDs7rav
	GFBMyZAbpw8IquIuYO9gOZEYaNnVQzJu3X24ZfeBEpfjCky0qo6QYo7o7tVyNXSohwk+C9OvKmm
	TIAYgqKo3wbJNrdMfFztA+jQGRbKZKJiq6znyegrYHqxRsumQHJRnuagpelKhvBf75RuDjwjCAM
	1ar2cAfHdTIrfsUu7dW1XYNXS/gCaBEEM8dcurf3AbF3OdHiaCA7ahEFuGo9PAEsfmurlpIk0Jo
	2kMXjNud4gIbI+
X-Received: by 2002:a17:907:3ea1:b0:b87:1b62:13ae with SMTP id a640c23a62f3a-b8867440f7emr66226966b.61.1769162745376;
        Fri, 23 Jan 2026 02:05:45 -0800 (PST)
Received: from NB-6746.. ([188.243.183.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b75d669sm83079366b.51.2026.01.23.02.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 02:05:45 -0800 (PST)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] i2c: designware-platdrv: refactor error handling and simplify cleanup
Date: Fri, 23 Jan 2026 13:05:36 +0300
Message-ID: <20260123100537.1429497-3-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Streamline the probe error handling by replacing goto statements with
direct returns and using dev_err_probe() for consistent error reporting.
This results in more linear and readable control flow.

Remove the explicit reset_control_assert() call from the driver's
remove function, as the reset controller is acquired with
devm_reset_control_get_optional_exclusive_deasserted() which manages
the reset state automatically through devm resource management.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 37 +++++++--------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index ab960458b5a8..74246fcd5138 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -233,32 +233,26 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 
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
@@ -298,17 +292,12 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	pm_runtime_enable(device);
 
 	ret = i2c_dw_probe(dev);
-	if (ret)
-		goto exit_probe;
+	if (ret) {
+		dw_i2c_plat_pm_cleanup(dev);
+		i2c_dw_prepare_clk(dev, false);
+	}
 
 	return ret;
-
-exit_probe:
-	dw_i2c_plat_pm_cleanup(dev);
-	i2c_dw_prepare_clk(dev, false);
-exit_reset:
-	reset_control_assert(dev->rst);
-	return ret;
 }
 
 static void dw_i2c_plat_remove(struct platform_device *pdev)
@@ -327,8 +316,6 @@ static void dw_i2c_plat_remove(struct platform_device *pdev)
 	dw_i2c_plat_pm_cleanup(dev);
 
 	i2c_dw_prepare_clk(dev, false);
-
-	reset_control_assert(dev->rst);
 }
 
 static const struct of_device_id dw_i2c_of_match[] = {
-- 
2.43.0

