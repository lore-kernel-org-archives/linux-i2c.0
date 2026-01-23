Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001AE349B1D
	for <linux-i2c@vger.kernel.org>; Fri, 23 Jan 2026 10:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162759; cv=none; b=dz8xXjs8F/FwwPnH7ug+6OXf5tHGIhW46j7Eda+zQjnmL91u8mQwNb3uSJd4hYHAnXW/Ifa0cODhVfP09ZrD1QxOeybCiSxwcrOFG1lzKOGn48HOlDe835y/j9yW7eQKm/+D5RgDprEzPQh6n7I3oHHH33BGOEzVDS0lZ8QvBJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162759; c=relaxed/simple;
	bh=T4Qv34+iHO/1XsGGaVk1mRM89//Ft/tKeIBOdkp7ddA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cQbSSscoWUZ1DKVc9a1Tf5TY6BQKL+ZNfznWJb4nH1fuVpiQLZg49wRTAvVrQcXN6NBsRg3OHKJ3o2ylTA0qMUAdfFKuA3Cxe65Xci4HYZkA1ue2bWfDRATPQi5TLpqi3aj/TcTF9biAgUlBfaJTfOJ/DZ8PpaJ2aiio9/e9BAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nwadoczf; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nwadoczf"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b88593aa4dcso124896366b.3
        for <linux-i2c@vger.kernel.org>; Fri, 23 Jan 2026 02:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769162743; x=1769767543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yZydcSKZgcNLloFPkvpl/esGuibEnxopykSaYg2WoVk=;
        b=NwadoczfKLbX0RQqfUoAJDN8kRG0najL3onpIpbr1Feqmm6x2RBj+DRuqhzAe6ZcBv
         +ZCUcDTZ6Njbs+SoDrvKwkUnyua5/gxcVV1616Z9j+ditPeL6tvD4j5hTwSlVrgQxJ/s
         TzC1ggWWxv8bqseM4DBrbrqLMOt2KdSy+n3cZFDKK+RUb2ugnOEKAEn6v9tFkUqND8JF
         5Cdck1gsNF868Kw0ry0YJ3dGVPcDkKWkfoQ2ojvK0L7xuZNA74aknJv5ubuuLYm8wERb
         TcPbQNKs1xlkm6WHl4OrWx1xFlUIXTNyQNCyJU+KjVtb4cG7L7rwgV0oRqkzTAyGrTHs
         snaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769162744; x=1769767544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZydcSKZgcNLloFPkvpl/esGuibEnxopykSaYg2WoVk=;
        b=QezVx7qfzoRm1S3CaRFWEdRVuQA6JFFxnCAVd6wOEOc6ryEMVjYz9/qm/Vge+ZCfUG
         1Kz850yv+h1gEyVPIq4DmFDvbDULKGKLQrCHgRTaobFd4hl1cdNBzxapFj9ddUNnJzZh
         kd0dP8ofD3lkPqd9mfe55dnlqjgBAx6icPWBZ8W+JxmM5dJS2TEwSQl+wdEHHWTQ31jX
         ERZkbw75j1oJg/FThcyy2RxKy3hrylyIOGXUMEt+pJY6/ZL1FmPCosz5bU3Iwa2W0Kbc
         UaQzdnTfBMVt2hZxM/+eTZe8lA/QfjQjCGtNx4KY5IbdGPl3jgEMkHS65FQMst09oPrz
         FVCg==
X-Forwarded-Encrypted: i=1; AJvYcCW7fMNGMN14azwD/o89vCzeWO3YjYcQZeH8rkbOMKuVUzGzFihoPZ1dsKQLyLJYv+uWJESoKgA/2zY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxffomUMGa45PCRaeD15PfdTz2YURn+xGmISMxh3DQ/WVGwPtUM
	otSJvRk1A7CidB/5U3iZozVPbR3IUdPtNUXRQp0SbZz4ZgbLJle8fNeFRYgQ3qLN
X-Gm-Gg: AZuq6aJ7FY5u0TDgSy68oz/nnXbzSL5thsfW0jCT0e6tmOrdBjbAP6b07VVsM86Wl0y
	Wd7kpcoTgiadXzK4rLQKxQjae3XO3oQl/OV+uWuH1drBUe5ctUmTKEyhhXw2UIL5GOyybQwBCEg
	+QmMlBC+gP0ySazNP9IXc1T7DtEIYZUu5MLK8IJWT4cuGy34J6+SDaU+R0o2h9oZUcX2wylPMKN
	m0NVlgcSZ96IrpDI4Swb16GM51hvaU1aCNLzDzwlhA+Mvk2pAPV6ikTqEFjbvFkvLf4JP03haL+
	VTHtxO8gERdZphLU+PN+BD9gsN1qNMMM+h8kZjHAvXszJTJs2663x7FC3/vLwGCplW9sRVe/yry
	1Tk4Y9nl469ExB2p9rRnvIe8GaOs4zIp8mn0daq6ODA8CBywcqqtVEBjNN3pLUZ613KyQo6Z3xz
	oCr6emwX31n8gtb2OlUtKD/UM=
X-Received: by 2002:a17:906:fe06:b0:b84:22cc:3c8 with SMTP id a640c23a62f3a-b885abf34b6mr148764166b.4.1769162743373;
        Fri, 23 Jan 2026 02:05:43 -0800 (PST)
Received: from NB-6746.. ([188.243.183.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b75d669sm83079366b.51.2026.01.23.02.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 02:05:43 -0800 (PST)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] i2c: designware-platdrv: simplify reset control
Date: Fri, 23 Jan 2026 13:05:35 +0300
Message-ID: <20260123100537.1429497-2-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
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
 drivers/i2c/busses/i2c-designware-platdrv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 7be99656a67d..ab960458b5a8 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -227,12 +227,10 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
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
 		goto exit_reset;
-- 
2.43.0

