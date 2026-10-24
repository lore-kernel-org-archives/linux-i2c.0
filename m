Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792877125;
	b=a9EjC4ZIlCnNVW3diMsSY5LjYxF9Jp+Vu/up3Wb1wet3PZuZWdu83RM4bD5Ej5te/alc
	 d/rhAPSRO7kY0vrw0sOS0Z0O5a+i6iYkuPVBx9TAujCDbiCOVM3zXrjdfrGUfvergah2L
	 2hJOKrivSsDuWiIke/tqVGsfiOfX7PvZ8mQyjFGr8H24HWtA1m94a1Xc1BJtAuoC2se3k
	 /4l9+sRYecA4t2ud5ea66XgyjeGyTg6Ljzo5bn5t8wGHhZOCgjuX9Uu0Y9t4wPhXAftec
	 pkik4feAvFuMnWad23mCiFFOo95X2pk56uMPt2dpwkxdHvZkYWAUs8tfuefzhfwvXdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792877125;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FT/A/DgEc/1PdtmIuuiz9qA/j5kLnlOWpR51oppuUm0=;
	b=CYCLzbyBFxmAIh7GSo+Ba6LTWHUdFfHF/E73PD3EZBhMOPRKWHF2/KPuLnGGcQqizrT9
	 kmKRqYj4sh0bUE69M4+YbH1jmWG0KepXfB5Z2KDKR1QiuL6/g/RBTI8RV5CKc0FN0Q4OV
	 QRMAPdGogNRltzT39JzoUo9tyAcge3waOGceW9YUIjrtric2pDLoS3O049D4LcchT23ys
	 LCUTKr8rszhTAWPL72Zu+mEQQ+KWgl2s6hLthgXrHEPFrmpZZuWjFsfzCtTzDPYqxHwhJ
	 VRebliwogG0Tl5OJtaj7cveV1cSIwIEInW7QB1c8kIXlUmzPiTfTPeaQ3bgW4mj/uBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=FFY9UXC4;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC42606A325
	for <linux-i2c@vger.kernel.org>; Sat, 24 Oct 2026 21:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECC42606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=FFY9UXC4
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so5626085e9.2
        for <linux-i2c@vger.kernel.org>; Sat, 24 Oct 2026 14:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792877123; x=1793481923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FT/A/DgEc/1PdtmIuuiz9qA/j5kLnlOWpR51oppuUm0=;
        b=FFY9UXC4nEgSwxaS/SuV8AKXzuWttgHbi8x3huR9cAIRIERXXxOiOL1H4056S67fKy
         YHJyipd0Zk8OCh4mygo/AW5Zq4wNUSa0/srwX9oh9WnuMfdpOQpCL7idhjBfQhy4pBGH
         by4wi+S8CG9zXPl8BkJXA9ZOB/bjoDoc9t7EjDySRlmH5FGqzzFnXZsiAdQFzD0biWxA
         gxQL2k2L/AkwbBVc/RT3vdzBLteAzUV0wwaiEGrgXACrd/9+QHw4o94TgVrJS/8Y+8b3
         CxFw7GgFGWvkbup+GIdekR39+ntWGKaXKmbhZHI0e2jCQGhigvdv/mQsQQRqkzhVACoD
         Zcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792877123; x=1793481923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FT/A/DgEc/1PdtmIuuiz9qA/j5kLnlOWpR51oppuUm0=;
        b=ecvBZ2wGSuvQ5AzOioG8W8PjhPQ8wSnEtqudK7FZPJZ9R0aY/LXD+YnEFn3duM2EpM
         etOS9xa5dXp3rG7NJarsO9+NpwTVEh6BvEIGg8LsWAIyP7p3LS/3itGVnQ+z8rV6yuyd
         ePNyu9HwGtHc3bTscaHcg5tW8fResQZ1IvUGJsvlamaLQ9NcfLZACgy9Slz1IzIiotHL
         hTpmSv1n8wJFD7+YG8BIqoIlCfTDS1uPL8sUiND4HXUXUgpZpzbodOm30iQnLVAjwdpf
         UhHvTeKauuv5OG1qyfzRbRyyY6sbZ0ATC7hBeUzU1SUOFUi5h2udcHzU8v92+QYoGQTw
         gPnA==
X-Forwarded-Encrypted: i=1; AKwUvBwyX1MxZXY5mDhLAiKSXm13lsTw4c+rOB2La4hlYtxYsUx4Lg4g/sbjMj2BnURO+HXUNTX/BOVR+6Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYIrThtoNhTFPQGegaeFuZl6gfPZO2gGnUvuDgw/j5GZR3Qj440N
	D9S4ouQ6mELNMQdM2H+rRurYLuFTbCaImYzg7jAxVRIgbc8ISVJZjsQr6tZ8L77U6Wc=
X-Gm-Gg: AYBFou2GKp7ZCpvbUmFV1x2O0lSBwLI7oiJUgC9OokS7/8U4tcMCCElSvbl55QKZ+rU
	CowbnsgXeh4vUmzsGo0Lookeh1Mr7LqtIGySIj+lOfRSL95UNNht8Y2Ld+PjtcSMEChD+hT+LSj
	vlVhvIh4NYeSb7XznzepbLejIwa8TeIBM9gYXtHS9CR3Ruc62Dzj2HkA0XSpkmzOyt1j+TSGfTE
	qM9iZAv+EEHr+JE4wR2UqAvTYc/LHDSKASz9kB56hGH39eVQxVnzn4HvooLMBi2mwpmMG0HJZEW
	fmQbV+cRtErtC0rDiJ2p/w8ioV6iLrJqF1cj24qvCp4rNv+qlyzQ3+4ROWnhXD6iVfULmLwrcS9
	W6CPmLmawyvr5/uAoFJtjSJBfJvL5YC5DEHMe+HXhNSmF4vDeBXLBrN4fZ99OB89SPMDOZiVGmA
	Py+dB+dZa2O/Su24RQDSrMVidEPbOhWwABtyh6NGj++zJkUaQ7qYsBJlJUmhJstvwK+LojNkd3F
	cszlohT0odvW3OC6O2GmoF1hHc/9FuH6WEGT3magWe/Lu7wfO4K8o9StS1p5ORk/TLsUMIijv/g
	kHroGLRsOErwzYTJK2Ur6Oikr3IGJ9G63F1O62pen4khX2fM9l3dsaU3gXzGNLL3a/wiVshaT6U
	eSFdlSGf8Cj1lsmrrS5M=
X-Received: by 2002:a05:600c:870c:b0:4a5:4589:24e2 with SMTP id 5b1f17b1804b1-4a545892686mr2153365e9.7.1792877123471;
        Sat, 24 Oct 2026 14:25:23 -0700 (PDT)
Received: from localhost.localdomain (2a01cb060184ad00bcfbae5efa3e0f0b.ipv6.abo.wanadoo.fr. [2a01:cb06:184:ad00:bcfb:ae5e:fa3e:f0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a2ed5a2sm79597135e9.15.2026.10.24.14.25.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Oct 2026 14:25:23 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Paul Cercueil <paul@crapouillou.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH v2 2/2] dt-bindings: i2c: ingenic,i2c: Add the X1600
Date: Sat, 24 Oct 2026 23:25:20 +0200
Message-ID: <20261024212520.91401-3-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261024212520.91401-1-olivier@mgcrea.io>
References: <20261024212520.91401-1-olivier@mgcrea.io>
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

The X1600's I2C controller has the X1000's registers, so it falls back
to ingenic,x1000-i2c.

Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
---
 Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml b/Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml
index b61fdc9548d8..9004f9799fd0 100644
--- a/Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml
@@ -24,6 +24,9 @@ properties:
       - items:
           - const: ingenic,jz4780-i2c
           - const: ingenic,jz4770-i2c
+      - items:
+          - const: ingenic,x1600-i2c
+          - const: ingenic,x1000-i2c
 
   reg:
     maxItems: 1
-- 
2.39.5

