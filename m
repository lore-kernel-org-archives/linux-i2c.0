Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188DD402442
	for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786526872; cv=none; b=B9DBexMFGhud3GqKdPRmqf1O4NVpsuScm9k2QbcPGZgXBfJMqXJRvb3yrRi4j9XGFFH9lqUzG9slI6VWBiTB7YcHNLv2nCtKmINtbaNbAC1OPGZ8oquIzwIFL0XDAvEC+ovs6DaTQr5hZ5G28F9bV3MyhkLZKBZB/lYg9RPF2qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786526872; c=relaxed/simple;
	bh=+Q0nVSzTRmqvmkg+g0HdWQYxEGok9QT2sLIAdcqKVkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bdb2BN2LSw3bp0wpHB9X6dpAHX2xGp4Cb6TCxcG0/ag7wngUneLhQXkgG1vQUzin7QEIHWMiJFLZTs/4qcMkUwp66VRzgAr4kigM+7yHZcx0g9iF5tcWXBYdjWrzYDCA/z5AlY+VkXojcH9ziFeEal7v4pkUuXOiz+JpMmoaVIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTMYeyGX; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTMYeyGX"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso915144b3a.1
        for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 02:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786526869; x=1787131669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1TfD87JSttf0FoHcv7x41fHEYgAqJLQiQ0nL4xBOEkE=;
        b=NTMYeyGX4J1C8MUCjODyC0XjSDhw81szdFDQP6yssDZDG16XM4W+lMGObP7/jUDz0u
         sojHABqWaBWrNF5mXvq/b/pFr8ruLQzIB9cF2cYlLwL3d6x2vgkjeHD5EsWPKXFuTHwo
         9goxt0PKyCRrTwn7UUTPwIzfZoza4CFfUqO+2xtDobJH6uen/joG1I9RtH1B1YUOfxlT
         gSBR0DwUq+8ah3f8Q1jZ2qJ6V+u55OBYLpx8iL4s6o3qUvYO67i3Df/wL5WaUpdYcr+0
         Ds/flKSh7K17mNTlvChrKbXoF7LDhNI3my+lPPjLbmKqYQvsuIKmgxFTYDMhu9TY/Chm
         MXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786526869; x=1787131669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1TfD87JSttf0FoHcv7x41fHEYgAqJLQiQ0nL4xBOEkE=;
        b=XR2E2E9GANWU5NR83VmRFQTfSb5ZMPdVSRLQCD/Y+Nd/xWT/0HhrNAMQdRCOt2roRE
         xGfjYH6uFm0swFFyVSAcBg5Ufua8zsc72VUD0qyZVzuzFQe5btEmhZjiHLls0ka6j/Yi
         vZ3fEWY8EZQOTZC8nhRy6YVmIQz3qUDrOeD5okiENfK1+DvDzVLIFDK+6Xem6jscZ0xq
         0B+EN1vriyeTvdXSWpZSE2kteBHekub0VlcMAD3oNZ3JKgmJUMCoVaDxwU0whRzhv9eU
         fMqjgxxiBWVE/HZ2xileel9tVP/eNaEz9iNj1PMt8js740doqsGT7Q7L3m7rer+F95r2
         x5yA==
X-Forwarded-Encrypted: i=1; AHgh+RoqenPyfhnRJ9g06ArcGwpaD6OlPSKvp1GoBDCEDCVa0D+7QHDaMwLD66fHzUg6c0rLowg8ewP+5TU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU9IiMMVFAem1W7dCA0IYZ37vYbf9O0UYjbP+9I2PVRV7xmr7O
	X1s+go7kZG7FvBzV06maQG+NI0eOuobK3HqwMA9pA6wgkllFiYyNN8lB
X-Gm-Gg: AR+sD13q5PM1eBMZxtRiFsoENQvHFgyVMJE09kJKXgntlJzUCCEKOPvE/FMeOoeWgHh
	6yhyOSv71w/4xrU+isPTcmWDPt3I3zEQqbsUB55Nta3qcu3Z6B8RePjqgW7CFW/Yvg5+eu6mo5k
	VDCHUoTlTs+CB19Urusm6TBqC379vX1XvTvMXIigozVRtLGFIUuiUFQ9apV+Zi2gYfe9iimo/E8
	XL17ASUp8zXEuIzCM7cOy4he0EBvEWviJ0Zwj10hsaKMVUaBdjQrSzJ2Z28pDWhfeUoRfQKw211
	L6eXINWS1Gq81P4L7VruRvE2N2tn2FAdZttxA+8t9BdDv7+7jAmQ/UQRkn5dPaUWRf+/jwd9xa8
	tngi7OxNMpTlwCCxOfvcbXyIvIzAS2Kqku1xZ9Vs4eANR/kmcuoniRc5/GDZTsHcfYmatdpU4WJ
	2Ibn9H6DNMlNbRMsAo8Ew7Y+CVuonGcUqLbR0XJdFqiKo=
X-Received: by 2002:a05:6a00:8d1:b0:842:5da3:9b89 with SMTP id d2e1a72fcca58-84fb55aaf96mr3658976b3a.38.1786526869174;
        Wed, 12 Aug 2026 02:27:49 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fb1ee6646sm727306b3a.38.2026.08.12.02.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 02:27:48 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Ajay Gupta <ajayg@nvidia.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: nvidia-gpu: fix autosuspend cleanup
Date: Wed, 12 Aug 2026 17:23:22 +0800
Message-ID: <20260812092322.3423217-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gpu_i2c_probe() calls pm_runtime_use_autosuspend(), but the remove
path does not call the matching pm_runtime_dont_use_autosuspend().

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without undoing the autosuspend setting during
teardown, this reference is not dropped and usage_count remains
unbalanced.

Call pm_runtime_dont_use_autosuspend() during driver removal to
properly undo the autosuspend setting.

This issue was found by manual code inspection.

Fixes: d4a4f927e4dd ("i2c: nvidia-gpu: add runtime pm support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/i2c/busses/i2c-nvidia-gpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-nvidia-gpu.c b/drivers/i2c/busses/i2c-nvidia-gpu.c
index 14c059b03945..9dbe1fe22412 100644
--- a/drivers/i2c/busses/i2c-nvidia-gpu.c
+++ b/drivers/i2c/busses/i2c-nvidia-gpu.c
@@ -334,6 +334,7 @@ static void gpu_i2c_remove(struct pci_dev *pdev)
 	struct gpu_i2c_dev *i2cd = pci_get_drvdata(pdev);
 
 	pm_runtime_get_noresume(i2cd->dev);
+	pm_runtime_dont_use_autosuspend(i2cd->dev);
 	i2c_del_adapter(&i2cd->adapter);
 	pci_free_irq_vectors(pdev);
 }
-- 
2.43.0

