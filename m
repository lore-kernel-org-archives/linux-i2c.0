Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173863CF05F
	for <linux-i2c@vger.kernel.org>; Sun,  3 May 2026 18:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777831221; cv=none; b=M7imBIxb5Bno/82l2uEBnprW4qVViXDWZvNCaJnT0nX5S7Xi6ltQhoJxaAML021WdbU5yAr3yS3kLZCSUrOXbNaQgU6XWNU5Y9K8oQ2d/vL6g7k28JyZTROwLlRQcA9vlr2HIEx/ivIlCSnbBc3dx6jMi+d+l7o/6SFpeMVHEmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777831221; c=relaxed/simple;
	bh=+cHiJOGyps4tP874tIrcNGCbxetNmnQg9UStX/QIs/I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mnl6YdIN3OTZwN+frgQrfXaMg7A68oEUJ4gDGGSIO2JXrL6KRN4EX5imMJqpfZmOIt6y77ppHa+l6AW2UmTw7YemHqQGhryrxuJegn/BXwFah2TVTpNTRA6/Bgs19+wR1PNcD4JCxbPREMWfBD1GtKl6Gcnn2jBSulHm8ekILf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWbey4rC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWbey4rC"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4836fc075d2so3099525e9.0
        for <linux-i2c@vger.kernel.org>; Sun, 03 May 2026 11:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777831215; x=1778436015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hd7o6sxV5jy46yv8SLZalxFTVSZ+c2N5QIlGo7fccME=;
        b=OWbey4rCwNVa8lzF2ratHKsaCk/kEqThA7SpAWI2b8nVg+qF94IhHQU+JzeA/bMgxJ
         sDoHN+wnfddP8RaMvumgcJQVoYY13HwPDvVK4tKuYsfRLB9d3219khqtoarfmDzS46dn
         3Gw4KePQm5a7mhUmXkE+Mj41lH4Lxk1rGJ7dwb9KsjDoxvaymtE4oV72kax9g99mSI6B
         dQDu5Ib+54MaRo0oTyNxIwtwS/9dYUC8geA+R3brIyCaxNuZ9HB29cknakai+NRZjOdT
         QzJS1SLnK46Ul7Qz+v+U12VZ4Z1BAJFQn7825qaokjs+8DMqMXNLs2O0xDKjmqJa+AMv
         7nXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777831215; x=1778436015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hd7o6sxV5jy46yv8SLZalxFTVSZ+c2N5QIlGo7fccME=;
        b=g9vxps1K2maLVN/JtP0M0vqpNnm9C26MyBPB+FeM9cdpxjXQ4CHCxQOJf5b1nq6mQ2
         BFfffH9p3TtNn77NBkpg84JT6urKjitdDf9jv2F+1hMdnPYxwHlwT3+Gsld4Fpn20Eet
         TWyKjIDhCyvJ/zdGT+0FMraxfMlxf/XpWmDsqpr/ywuqYug6ZfuPPGAskf6PcNawDaGP
         tatozzgODTObM0Z5MqnF95C/YQkbTC6nb0wZyWWNVgclR351ZhXTcGgNGGmjHoTRNyPW
         o8U8aWKaPseh1q9TfgkELXmO7UdfYRTPk6teivF/KD0dXpWl44kso7mjBm7s7WO1NEIp
         +ZVA==
X-Forwarded-Encrypted: i=1; AFNElJ+xc3gZFYt8YwXdGEujeXSkFUO9J3Lowk6KFP1RWdtFClUTS286bJvA/iRK/e9Wu9nS+sF9/lR+M2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ8CPRTM1WLVlTgbzRp8EGMTpuZ90kVEk3ku37l0kvGzfcCrox
	QptXnBInDwJgOpwNY9Krbe/tFo32qnDCiRuIWxykGeek/nl5WYHEx7sGfzlFHDFBDwyc0Q==
X-Gm-Gg: AeBDietdo8t3K6pzPH5P0Q822CmZzdmzrgcCTHyavLnc9c/Ed43n51XadLcsdj5w+Wx
	76agROOEqLRl++JRobRxmRlX06iHgh5VOWB9OJOctF5vN+byRnoJNC27yf8pw05hmLfdj92IG11
	TKyIVOKQuyk6cAgQMGkh+o1fWK1dsguGFU19xWrl7E0XOutVyXmh5+QpSRek98LUqcFge05PAUv
	tW2fFEP3/fUjscCtv6GgvVAnS36bygJdTIpn4LXopVtxT94CDIxUw5c1Vj/KrDNYewE6UEq5T6h
	eX23J+igSvAvG/1sp0Oeoe35eCG1CfeNhO+6PRiEEwXUS9SjN07KrVF40V/knrlGr7h07S6U2KZ
	HQFidRJDYQ743rJQ8H9P2AYOrczrCSoOFQSU/Xu/C8PcWgYDujFc84MNKxaE7suS0Bs5H/El9Wm
	bwnsBy3gAm++iWoDyDRd1g8BI4I5lfxh4+lgRNZhRajzYiFtwSab7K9tKhGr1NeWYcpg==
X-Received: by 2002:a05:600c:46c6:b0:48a:5302:8ed9 with SMTP id 5b1f17b1804b1-48a980fb90fmr53190105e9.0.1777831215421;
        Sun, 03 May 2026 11:00:15 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb75fe8sm214960305e9.8.2026.05.03.11.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 11:00:15 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: andi.shyti@kernel.org
Cc: florian.fainelli@broadcom.com,
	rjui@broadcom.com,
	sbranden@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>
Subject: [PATCH] i2c: bcm-kona: fix spelling mistake in timeout-check comment
Date: Sun,  3 May 2026 21:59:25 +0500
Message-Id: <20260503165925.1738-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a spelling mistake in the timeout-check comment.

No functional change.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/i2c/busses/i2c-bcm-kona.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-bcm-kona.c b/drivers/i2c/busses/i2c-bcm-kona.c
index 9d8838bbd..d4f287b31 100644
--- a/drivers/i2c/busses/i2c-bcm-kona.c
+++ b/drivers/i2c/busses/i2c-bcm-kona.c
@@ -427,7 +427,7 @@ static int bcm_kona_i2c_write_fifo_single(struct bcm_kona_i2c_dev *dev,
 		return -EREMOTEIO;
 	}
 
-	/* Check if a timeout occured */
+	/* Check if a timeout occurred */
 	if (!time_left) {
 		dev_err(dev->device, "completion timed out\n");
 		return -EREMOTEIO;
-- 
2.33.0.windows.2

