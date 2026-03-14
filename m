Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495CA30FC39
	for <linux-i2c@vger.kernel.org>; Sat, 14 Mar 2026 17:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773507831; cv=none; b=My1jxRiQBCvNIrqGMqkul1xNsGvE1ulErmdXx+JQ+0qM//TNDjhPgUqSsNhvJmu6wUqMS0PyCFCgjuuUgX6uQU/jmKEwQ5STEiauVblAEZWSMQYdeVgImtw3bEWU7s+PD4heCc0SXbejy2K3lxjHrAuLzvEM43kNEAsP2xrF9DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773507831; c=relaxed/simple;
	bh=BECZ2kWUv9/sN/1vY2tcda5a7XzLvGpcZP8UN42zdk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UKNkt+nCha8pcqpgVcywHcFMET7psSeYQiaoGizfr5yiLC0KXCdhbbnttKUFzWrEJ1WkJYUD64Ht99JL5KhHchQrvJXGwmzNAI3+4j8gHKKUWuxl6ePIJR5+knktvYCr37gDZ/v2flodKWeiud2VL0NR3CZ316F8M3hPczoqxCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfnd3g7Y; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfnd3g7Y"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852f8ac7e9so37361085e9.1
        for <linux-i2c@vger.kernel.org>; Sat, 14 Mar 2026 10:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773507828; x=1774112628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KVES9EBO2t19jyDyTJ/K+Tu3EVOBdgA74w8xUim9e9E=;
        b=jfnd3g7Y+QiaVtJOna+E/eiNUpOkEVyEphKKNlKn+T76b2oU+OMk2hUMOPsZN4P7V2
         aXufnB0E3blnAnBi/VfEp53m1a5eg2PtCOMckDOmg4U7Wc+eoGKXsSq+Z9NeTwpb022T
         1YeKfZzfaQ9Q6PYjeA75ptDpiCQA1dzwHIGAZADT4GwaYESwwhpN1EyRaSdSfYkMwIFA
         S9HA2w54UN7nf14vjJdiy7FKL+JVjge5ifMXNErjvadxQoMl6nydXuU+QLjsaJiE5vdH
         YMo5P1xmOxbgb7Jpe9Di/Zsc0t5+QtP/7MWAWtyRh5kVNTqZUg7ZFwt/lAjH7wqIJ2bQ
         XDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773507828; x=1774112628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVES9EBO2t19jyDyTJ/K+Tu3EVOBdgA74w8xUim9e9E=;
        b=j4WiG98j0Y48KUzn36XR04/pvnI6RbCUgZ2DMXIk5XAq8DgV/0kd+7AzU7mBtcgMa5
         yLI0H+ZDO4ANvN+u7PZaPVCxGxnb1FByVsKpe9OgKUBI3y7KuUpmptVTn/gJFKx6T0/h
         kWDO+cngsJlw1Y1WjUAtyIfeMnqJKAbvwhqlCKzVqEXRlOiSHDkl20EXPIKfZxguaoEK
         vsEVXwrOpW7V/vdwTcOSFAfxG8/xB+jzlDcBfZ6yPGa3CZps1/ygTrcxcb9QU5/qfZKT
         iQc74MQbKyKENF7vNEHw+ySYCpFPeDqkIJxbq6wSm1Lm39ZG1ONfuPwOrecFAjvV7h5b
         dziw==
X-Forwarded-Encrypted: i=1; AJvYcCWBEPqQO0aA8WKNzS0ITPPZ6YTXE9RzqsFNSWfbOx8pHPN7S1utcwryu4QPiCPe9UckNeGYBu7XHig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA0RY3sOYJ8r87lwNmQEXwiMA01HH3h0qj5KxJVzc9lRwPi5wM
	qH8e2nCFREfFPdbE883tW7l90dEvV4SCRAxuHX+3FT8PbiqgcvyUhmaR
X-Gm-Gg: ATEYQzwJxJ6UfZdUVZwcHSTXC6gzyje2FZwbCor1y/evDhFr5mlAMVm+z6UxUV5hGF/
	W7Dk7/mZf+O86pU89yb8XWnbpq3OkZxV4EYYa0N2qA5prkOuFqv3i+7jE1JXtyKvumyCYffguyz
	ewr//cCGTvPvnOvF9Ngd5BrtmiItowAfPDv3/mnqvvIoT6sUtZ7Acj51VnKPisnFIoduuNR8X2o
	mCDvxgjoO+Xd09WR9q1TGO3/qHLpTvInduZpwWl+RO8fMbcxUvMKQ474L0+j2OP+V8Klt4w+RQ4
	fQ29A/nU8nyXGLT8LKvLAmPLfgQxVQl7O9HofSfvfSLrpS6LwvgHv6HoPWhLIemIpGSO1Fsoya2
	ePgYc/QcKRtUfXbNhG+Xy8qQ8ja42OLhlVAeXdo1C07wi2w3Q/DM0rSTm1sJ3BeIKSIpBQp9WYE
	e7bNHRgIV6drw/K0uBYgXc/A==
X-Received: by 2002:a05:600c:3550:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-4855670c971mr130625545e9.29.1773507828313;
        Sat, 14 Mar 2026 10:03:48 -0700 (PDT)
Received: from localhost ([87.254.0.141])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b47145dsm288880245e9.0.2026.03.14.10.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:03:47 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Rishi Gupta <gupt21@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] HID: mcp2221: Fix spelling mistake "Enfore" -> "Enforce"
Date: Sat, 14 Mar 2026 17:02:25 +0000
Message-ID: <20260314170225.1260440-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a module description. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/hid/hid-mcp2221.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index ea9f7ddd93a2..be80970ab48e 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -26,7 +26,7 @@ static bool gpio_mode_enforce;
 
 module_param(gpio_mode_enforce, bool, 0644);
 MODULE_PARM_DESC(gpio_mode_enforce,
-	 "Enfore GPIO mode for GP0 thru GP3 (default: false, will be used for IIO)");
+	 "Enforce GPIO mode for GP0 thru GP3 (default: false, will be used for IIO)");
 
 /* Commands codes in a raw output report */
 enum {
-- 
2.53.0

