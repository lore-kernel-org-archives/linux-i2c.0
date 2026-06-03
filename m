Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9811D5174
	for <linux-i2c@vger.kernel.org>; Wed,  3 Jun 2026 00:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780448226; cv=none; b=B5OKWbSxymho+W8LgwH0fXKTQ6FXV478oo7oWPyn7woiHS5khlyatC9soOcs9XOqFruoKtvmnMRdfg7zmjY4ptSFiPjQoCScHsJN7v4x/h8Xzh8MXOox3CmupZrmnS6m1HMcFwGzz6T/+y9DYexYr/okTazw3AfKvriTVLKPGjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780448226; c=relaxed/simple;
	bh=+e9JGzxHkKgEWY9gimGZdmxvSDE+fmUpCYE90HZ0Xe0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K6YzE73aqUSuKljJDf5eVrx0CZ5RLgMe4+0yVAUk970WDSwnaE2+ozj9qDiQKSMb9A2m/voCa4dr/uheabOF1r1yUOE+xWES2oEUTwRKl2dO0qA2nex8y7tnPSLpdJM0T8G8rR01i5rkUPDYepDNC6En4NhntMgNKGBQc1Z0fRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWDQ226o; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWDQ226o"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5176096116fso22180491cf.0
        for <linux-i2c@vger.kernel.org>; Tue, 02 Jun 2026 17:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780448224; x=1781053024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Jhe81GLnFMt2SFFisrAqvCgJB0UsWbau4qiCW8JuqQ=;
        b=PWDQ226oBUHgLoIl7cBtl9BKHtmhvA3VqgzHEasA1MhZnIFCW5bpjTpL5GApe46ADM
         v8scOhvJ0DK57YdyThzfQU8sCxKXH8+8lNeShi5joJxadH9fOhxwCP35v2NS8vn+Mv2j
         GR+Rc2Zti9oCcAeeXynnHD4de0Im2S5VH02CW2L+7AlhHzwsc028Ad6FboCdzmvvTml0
         9wK9gPkkTWBt957SY/QEw2J7CyBOU/nIanTGZEXtkjRcVCBq5sTDp0NWh90ySGOep9SE
         WSmcZjkT+hCabMgMltJwp0XV35L42CMZ7rVGEpyS78ttqLvZYZ+9uhOtAU4YIu3Zo4TC
         qcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780448224; x=1781053024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Jhe81GLnFMt2SFFisrAqvCgJB0UsWbau4qiCW8JuqQ=;
        b=fxzbKyF54YfX8KaFmJcI1W7BnZ0/QmmnCvjRSMooxN+h4l9E3k4gNJXum+WaIR12b/
         2vmVcFZuX5bZA6lLuevMQ6l7lAKP1saGZSikApM2RWNRDiFbOgC0GuOO2vJM/LgdqA5b
         PZkjG4/cIH7g7ruUBchzloYWaQ7fsLSTpglg2X3XC6BA5sBy84kEHMi0/UfCSUcpmc24
         XqBGWd5cU+hnM2D5in2ydecFkoFlzr2xxK1ytuSNU5j6g2bYd1ILudUVzb6BmZD/b5yB
         L7Cx/0Jql0IM8lkhP8vz9MX0HKk2SDMBs5zKZQ7geGcbf6NRIO0nweUOe13s43Wx7joC
         hcjg==
X-Gm-Message-State: AOJu0YyKNzc3x/3qIEwx8dPLkMe8l33ZJ++gyUDWHPsQ7PtPcZDwX6so
	HNWsjiVyVVcvfn1UIwPeZePMJptM+xb1t7RqbOFN5SDtRtS5MTMi4pSJdowmEAh+
X-Gm-Gg: Acq92OF9LI+SnBDprYIqCWrrl+nS4UG8pj/6Pte1zqT5o2kqiIZejuwzNMhJ2DjccSX
	Rb/0s/5NKzP1EOuA7qKAWl1Ra6Q53F/f1DdSPUh2gCrsmI4JZiofVxmWTRKkLzQUCYy59FLrrWf
	+SDT3P0ErV4NERjYvBVNELiHiXSaa2vlQaYCLuB+lA+5Hny+Ka8ITkWJzW1UiwjX7WOJ3hnPlTP
	G4lsyQwBsPZTPLUz7Y8lgXMfwjoSxD+ojNKemOL25wvgMs0LSqDco5hUqoXvt3YEeoRFzizx5Np
	TuU0TPe92np2ktrWFCkDsMux2eb89Wgk9weAjG+ytuEBb/E7sGCeVR11LNZfJk7zKoGIuTPGFCT
	GZ5N+QRjR26X02eUBsEuSkA4gimZ6M9eTP6DBPrr5VKGXA65ByMFUCBDfSC2aL7RYTO4jMBD4cq
	nN/wmkX8Uy4mVetlTL5pgw+ymS49IaGKlpHvJDX1tbsqxI6bMb4aKwLKk1tEIhxCq63AhIXoxNl
	MDLoV++Ugm9IT0W0DGRHpvAyfVtralIhadX7zBRwdcnjQ==
X-Received: by 2002:a05:622a:4114:b0:517:642c:8196 with SMTP id d75a77b69052e-517785921eemr24993891cf.12.1780448224112;
        Tue, 02 Jun 2026 17:57:04 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c297a8sm12121051cf.8.2026.06.02.17.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 17:57:03 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Joel Stanley <joel@jms.id.au>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	openbmc@lists.ozlabs.org (moderated list:ARM/ASPEED I2C DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/ASPEED MACHINE SUPPORT),
	linux-aspeed@lists.ozlabs.org (moderated list:ARM/ASPEED MACHINE SUPPORT),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] i2c: aspeed: Simplify resource mapping and IRQ retrieval
Date: Tue,  2 Jun 2026 17:56:45 -0700
Message-ID: <20260603005645.227239-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify resource mapping by using devm_platform_ioremap_resource()
instead of the longer devm_platform_get_and_ioremap_resource() helper
as the last argument is NULL.

Additionally, use platform_get_irq() to retrieve the interrupt
instead of irq_of_parse_and_map() and propagate its error code on
failure.

Assisted-by: Antigravity:Gemini-3.5-Flash
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index a26b74c71206..f3c28c7c547d 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -1006,7 +1006,7 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
 	if (!bus)
 		return -ENOMEM;
 
-	bus->base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
+	bus->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(bus->base))
 		return PTR_ERR(bus->base);
 
@@ -1064,7 +1064,10 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
 	ret = devm_request_irq(&pdev->dev, irq, aspeed_i2c_bus_irq,
 			       0, dev_name(&pdev->dev), bus);
 	if (ret < 0)
-- 
2.54.0

