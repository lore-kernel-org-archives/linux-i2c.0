Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793417565;
	b=gmMTGjbm6VP4CIP7HRL4UJFQmClWKnwwRBT9HRkXttdxELvDLR+LL/UHh6Yt9laqup4M
	 dqAM1Dy037VsglZ0quTHpZ4VWonE/XXJX8ykNL16WwMpLAbb89U6MYNAItnNRKUelfX/O
	 pP1kRf/AWyccgtKocbNzbW95HhSiWG51uMDgYfO5dYr9VYRgOxXt9mLXwgQFD9ZoVRXQI
	 6ngbCrC+AD8c3DTi21awkZzEgFf8MTSwgcg81ch5Dwe77ETjzcMgseLF2qsEvIdk2gj3D
	 uiqUHEYL+OA/E/Ss52CO53oUAoePrzTz/JPNFOWMEIyxZ6QA58twg4gnHoGIL/7ZXQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793417565;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=FGHv4YKoijyM41+FMl7kNSX2OQQ8v6dgSsciG/L0QxM=;
	b=A+tO2pztyBTSLfcVMI0EzgHUw53vzxqZwAaH29yyoqxQ5r6Qqi91JWkTZ76nuHB2YTGO
	 InxV3Bt15t5xNrh9T3DJNjTa8lugYVxM/48SueS0NKRYT0RsYhseSOjmhyEvZfoX9+nUf
	 DDOBg2+fRjMaN14VuljZuo2RzTqwEhpueru3zxRx1dfzc+vKMXPMvTadL19FI9Xwndq2G
	 oxJN8DF3jF81bhYQgybi6e9J8W7bss8yyNOvLPVaWd4F1fnXNURrsBHI/c/ziIvmwmVEX
	 Aj3Mkpa0q+41XUgLe+dvjoyg1jPjopdhJVZjmLLYXndooJYwEFWwZN7Wq+JkkghZqfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="yH/lhlPY";
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526E9606A31F
	for <linux-i2c@vger.kernel.org>; Sat, 31 Oct 2026 03:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 526E9606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yH/lhlPY
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-15dd124bbe7so534624c88.1
        for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 20:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793417564; x=1794022364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FGHv4YKoijyM41+FMl7kNSX2OQQ8v6dgSsciG/L0QxM=;
        b=yH/lhlPYC4BYxzURy572YkQGTX7lR7bNq6OUeSqAKnolFcmblaGnmtLozxVfc1vFQ+
         Nu9HYjjRxpuwFZH1wb9+hUY+LwRdzyOeiZyL6+HvpxQozudWO3+KM9TTl+I7Fw2R3lnV
         ySjIpUeK4mFpP8hIEPv8iPo+8iOsjkUbXUD7CWmTyipzHSxNruIyWAm75M2HKEdceVAd
         3E+YSSfteFntTc77qGGFqW2LdoJQpengipoTqRUmMxQqbYf522Fu0OejTkAOpAP6P+N7
         M9rdpOMEagk82zkiWj579bA7uxcVIIFSLfoPn3fTvO4mTWSmHJVQRDoGZmo7ppm9MaXn
         ZUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793417564; x=1794022364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FGHv4YKoijyM41+FMl7kNSX2OQQ8v6dgSsciG/L0QxM=;
        b=f7iSSq6j9t7UZ/jpvvEw6RS/Uc6ocLQrUzwbiOeRqilstDA8cD7Bct9KiqMmurt825
         vjvdVvTD0nVwEyMbFelgtohUX4VpyIQTtxdtdi6liQ33b8+6KXWB5kmd9N/x80pAdrQ8
         peDWDVuZ9LFcY1nS4k2sEkyId5CR1AY7YEGRffX19k6IqnBvgWOeiTj7T2PUxXvKUDTl
         PY9xoUvhzTrCXMePTx7gbPCgaGqP0lfd6BiRozAJz1gIBTnVkafLCL7i4kAaV3yu6JVO
         FrLage3lZMhe/fk8wewGI+Pauaiv0V42xYxmt9SQmN7QDPniKm0GiuWdgGhav5el4JGn
         M5SA==
X-Gm-Message-State: AFq9FYLSAd573HS1WWWnmXzEMzQUE7dmu2mbcBi7vCNnUHpKOOQeXRd5
	A8Lt9OtNpEmhpokDuqJRYpozsPYm23LHSa6yWSBCcfyXHH7j3+MReJT+
X-Gm-Gg: AYBFou1Dqc/87RmW8SAaTRj2swMfDzKzt7WPyiJmfuHEEUc4laCcMfyEYU77H5/1w1y
	m1k/+Zx4RmI0Ms8WljKyu/ajt6X3hTnqHwoSW93MphgSzcMr47qeh8qc9Bo8vH8WOmx1ayfKopr
	YjBkambaTUiYTAsLl4CmoHp2cW8DlfBN7elsQZwWgk+/v2ZBce2m6cH079wReagz7rsToQqyucf
	Nda/i8B7zxt7EVd7ZRRze377IcZ/XNPfznSPJklxOt1kMIADUY5ZUa03pPP3+nlY6XSHnkDsKAD
	dYQi9AU9WeIo6AzvNtKCX3lp/D3+mVg4YTe+dGQNjIIpKRsX2QV9i49EcJA2kYBKqpyun5ItI2O
	kGiMj1BzZjBw4EaL2dlW4ROufXPY+onneMg3gZy2Bb3eS+kDcGhGiKEb8pSim01VBWLfmARCd8n
	Mv148SYSlW+8RjPzy0lV9toL2l3P6M01cC0A/T4bpvno+Vh8Bqq0RuG4YsvW2R/4ykD6Vk5HPI3
	8UWzXXARz9jQR10M7AECo3k8IeaCdgeIYyx3cxV+I5xttNBWcsj21T2UZONPx9NuWCZGmQl5KpA
	qSMgUIqGq9/EWAA4IE+bGNYwx+NwLYW3bB7VmYn+Mb2df4Clcahp+ew4lQ37pv9TjEDo2tfvDjM
	weVSSmnEppoBbDe8X5J3cBt0KPs5XPWDPcDdmuRmpIUE3A1iriilQJ51nQ6G9/cYmKCQYuPKSpC
	2Dgo+J9cmIUSkheTk6eI+/do52a5SYm9z3Evc=
X-Received: by 2002:a05:7022:170c:b0:145:287:ce91 with SMTP id a92af1059eb24-1ac59dd30ebmr6048776c88.14.1793417564179;
        Fri, 30 Oct 2026 20:32:44 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac19f4a04esm11229136c88.15.2026.10.30.20.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 20:32:43 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Peter Korsgaard <peter@korsgaard.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: ocores: delete adapter before disabling controller
Date: Sat, 31 Oct 2026 11:32:40 +0800
Message-ID: <20261031033240.2491016-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
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

i2c_del_adapter() unregisters child devices, and their removal
callbacks may perform I2C. Delete the adapter before disabling the
controller so those transactions still work.

Found by Sashiko AI review.

Link: https://sashiko.dev/#/patchset/20260813153155.3953577-1-ruoyuw560@gmail.com
---
 drivers/i2c/busses/i2c-ocores.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 2d18c1035837..ff024cf5f92d 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -720,14 +720,15 @@ static int ocores_i2c_probe(struct platform_device *pdev)
 static void ocores_i2c_remove(struct platform_device *pdev)
 {
 	struct ocores_i2c *i2c = platform_get_drvdata(pdev);
-	u8 ctrl = oc_getreg(i2c, OCI2C_CONTROL);
+	u8 ctrl;
+
+	/* remove adapter & data */
+	i2c_del_adapter(&i2c->adap);
 
 	/* disable i2c logic */
+	ctrl = oc_getreg(i2c, OCI2C_CONTROL);
 	ctrl &= ~(OCI2C_CTRL_EN | OCI2C_CTRL_IEN);
 	oc_setreg(i2c, OCI2C_CONTROL, ctrl);
-
-	/* remove adapter & data */
-	i2c_del_adapter(&i2c->adap);
 }
 
 static int ocores_i2c_suspend(struct device *dev)

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
prerequisite-patch-id: 44b1c2680cb029871e123eb11eab7764a807ef24
prerequisite-patch-id: f4dfbbaaec2d208ac255451cf032c22f0e7fed2d
-- 
2.56.0

