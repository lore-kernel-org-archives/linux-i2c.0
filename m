Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512133;
	b=siXPhxygdSPUx/wp7NParv2Dp6d6vR271yN4/VipVkMx1fszrkapAYLC8NyWkVoKDxjx
	 Gs8jKC0vTlBEHqX4uJ3jZSLkgSTbd6GeZ7QNAa+HMFtOEdkXHcyoffAqskUw0rmG9sTnF
	 zVIZtQYhYxpDEyX8ZsyzFHWPJg/0sqVHJLDQtL3dRt+yTbiDJMTxaVe8+4G7dedV4TFQw
	 JV2M5WkD0lWNHgpJU3PuMVws1OBy4gL7N0EW43hOeZeP8z7hHGB7+s/1ngcPHmjYMfmRn
	 zKA3FZZPb76MYhRMNr1CPe4WepAhzGRh73AobnJpifUzt8cNBIYrcz30AERmTCD3U1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jrYGP2NUS8MDFLO947LbBcMGV4wVMpRFW1toqHZsyiQ=;
	b=pD0ZQTs0gZr4v6IfFWTtW35Vg50FC04PvbdDMsPod96RVJDOPYDyns2vhR0Kwf9SXrCi
	 td7A5m/ENNEmNWUF6svgnlCH+wRo1Gle5ruElQTvswhUI1rH5qvi8cKZ+3BwkYrHRL+G/
	 44XSjVcxiXyPKqS2VQqfa+TurVDbj7oaFxbzAzZLyN55e2sr/9XgcP8yFSdJtyc2gcNIK
	 HQGj5K7h8gX3mJhtRRDbU0dGuqZTeV3MRxNCVevyEzDmM4BfEXr8BvQZWE0Eumbf5P8ec
	 fR9eut5myoUMmlbtTAx7zDw+OSzbfrEor9JYWqQJj6jVklBJM5tjmuWbZ73YZN5TwUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yHelgFAX;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D6E606A6A5
	for <linux-i2c@vger.kernel.org>; Tue, 24 Nov 2026 09:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0D6E606A6A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yHelgFAX
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36a315ed211so5341167eec.0
        for <linux-i2c@vger.kernel.org>; Tue, 24 Nov 2026 01:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795512131; x=1796116931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jrYGP2NUS8MDFLO947LbBcMGV4wVMpRFW1toqHZsyiQ=;
        b=yHelgFAXHZlKvExHvczgHRjsBLUOzun6wvv98SQTI27ld6w0gqkFpdDqLZPkzojczO
         Tlw/xOZqjwWcfDKs3kzRys1VVO4NdDw/PXwWSZH0JTk1QltoBrVwBrilicExolBya0Na
         4m27JH0nxVIkJsCpvEZj+BVwq5kk98fyfFmjdlUt18W+ao1sUebf/QiW/Ap/10RSghII
         XOfPl8vbmPQyLuAbklXzAwt5ucs96Pm9ipadzRAQsH6gE4u1wZB0aBPX263P/YqncJ+g
         gD3bqiW9JTfzTN62bBJEeO7q9vVV/iA5EUGIPqwHG2WS5xxRkytsiJOUO2H35LpwKC0t
         km0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795512131; x=1796116931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jrYGP2NUS8MDFLO947LbBcMGV4wVMpRFW1toqHZsyiQ=;
        b=Quffm201pH7BkCBHtHj3KOMmwyplVrkmiHZKw1FOoR/598OFk0cl/hsMYXf185bNia
         jPHugiKINRjPSiVJEyZR2tZYBODwCemf7slPBFlefirY1ljri8mM3zw1xzSePW4TPsxX
         +9kjHzdLMsjKaRZBTP/+arkstV0mjzPe8/bgbbb6xvsVYyW8q55RIn6EmDp5yCckCSjm
         GUdZaY43+LIJ2T/xS77cMWIEuUroLs5v7/NjmGVpSkIcohEHIWz3OXsvqWk679DwFW2J
         rDHXcTG5TLWbU91sKIM9jywz+U6djEEvJOCE+WGhl59fEFUovyDpBjL3tfKifZKGxcT9
         RCsw==
X-Forwarded-Encrypted: i=1; AL+hErGoN6t/LHeRBtEWAszMrHZTyFDvOtXhhrQSnF7k8OwdiV0Fciv80OMDpzjMZV/Pjv2UFHg8nsFH7sE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ud1EPhCzFi1p3iRx7fCjNdt5Jk14XafZ8fY8Gd0GKCRpPoRXE
	HHnGObxm8ZD6w5yP6IooXS3WywuxvW+n4A9Vx9JwiKuBqLwjCK7Hx7zy
X-Gm-Gg: AZFdTZftINK70YeEm0y6ZcpN6Yv12PJiErBlDq8b1Aa+mASUyq1sC6x+bFSQB5YAicA
	Ua8kLRqe3/3Lr7Osw3yBJkyG3CHtPO81dA6yCT+vRORfl1zADedgrZi8BcYhGq/+Ij9gXF8t95+
	TEQ9FBPr5lWeT4epZbe6jglG8IXSCcj5OdgIrcr2mehS8SRXWQkuoBrHD8O/5dAwL23Hwo1NyxU
	pv02lpYn8L7IYE0gAT2JaGsljigic1lGim1F6edgUP5YYTFSRdA9Gm5NzrHKAz8sLygyQyasK9h
	HCeGsbcZCtoEgjXcVndY41e3i9AERobbPupBNz+0VV6qDerBu3V3MfDo11P9/wHV6uvOeiw5Cfc
	+o8Ty8dbkiS8lZMM5UGNM/+tKQsLLiu0YR9NgGmnKCVAXlLDRv6jlPe813iQvzJ5Foholb8eNiy
	LucCRIfINLxXEZVagRIR+T0QC6ONs3o+MR8gtXlLWM98iF1+gIAdmLVrIMTnWjjCOJC8vlVLBM0
	Ku4m54ql2YIdrQpD12JJlm68OeYWOX1Ghj3kgmHO9HdijMnM0ybisVEnYtDXbMA3W6EB7/aIpk1
	vYpnzcjH1tPmSO/qrPrV/0gZ7rgcvOe53ofmxcwH6509uv8=
X-Received: by 2002:a05:7301:7187:b0:386:bd8:7abb with SMTP id 5a478bee46e88-3860bd889c6mr13672914eec.11.1795512130689;
        Tue, 24 Nov 2026 01:22:10 -0800 (PST)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c349csm45902545eec.22.2026.11.24.01.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 01:22:10 -0800 (PST)
From: Cong Nguyen <congnt264@gmail.com>
To: Vignesh R <vigneshr@ti.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>
Cc: Josua Mayer <josua@solid-run.com>,
	linux-omap@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: omap: do not deselect the mux-state twice in remove()
Date: Tue, 24 Nov 2026 16:22:02 +0700
Message-Id: <20261124092202.3766910-1-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

omap_i2c_probe() gets the mux-state with
devm_mux_state_get_optional_selected(). The helper selects the mux and
deselects it again when the device is released.

omap_i2c_remove() also calls mux_state_deselect(), so the mux is
deselected twice for one select. Drop the call from remove().

This issue was found by auditing the driver with an LLM coding assistant.

Fixes: 43c00f2bcff7 ("i2c: omap: switch to new generic helper for getting selected mux-state")
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
 drivers/i2c/busses/i2c-omap.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 4dd111f77ea0..d3c576ca7681 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1520,9 +1520,6 @@ static void omap_i2c_remove(struct platform_device *pdev)
 
 	i2c_del_adapter(&omap->adapter);
 
-	if (omap->mux_state)
-		mux_state_deselect(omap->mux_state);
-
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0)
 		dev_err(omap->dev, "Failed to resume hardware, skip disable\n");
-- 
2.25.1

