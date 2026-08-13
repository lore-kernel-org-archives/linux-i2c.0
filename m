Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A0F4457A9
	for <linux-i2c@vger.kernel.org>; Thu, 13 Aug 2026 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611156; cv=none; b=BREScgXrvZRfV1uT6GKv6u5B0XxZhpNnYLgXWaaNOyZyQjeA9jc5657Lk6Bi31Ei3lyUe4FVgDoCsV5ACQMvok8DV5rAq+5s2wOOiuUD/r51hEILvCoM7XF2Xq4nsCW2a7gqz+3TJq9hwf/dp/WUi9qAZCI9rjq+If2MpRD7J+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611156; c=relaxed/simple;
	bh=ZgxTFZcf40IOcm2DafLWlJOaKw16R2DhB9yXYf3EDzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5KIdLhwznD9piFen4ZsYB1TY7bUc16vf00SoazPdQr29qF2sEESacTnWiTc5e0TJ4aRuEiG8QbsALyk7SxHpwKuXiD5M1hpsKT/wJIUkPPe4cKtEhU6bjLNgDL/5WiNDsA5WPzTBGw8l5d/bweD5B8oX5PXsGQZeJeJQRC1c3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Heg9/Yr7; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Heg9/Yr7"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso25094475ad.2
        for <linux-i2c@vger.kernel.org>; Thu, 13 Aug 2026 01:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786611154; x=1787215954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RHtK6ZnzwEf/ipBzEmZ+Ey8tpxuxKg88KuJsAtOmL1k=;
        b=Heg9/Yr7lNfcC3slgwAswoOQHyYhqPaRUF6HZdkp3jDT0kNlS61rAnxOXzWCc1U74G
         a2LFJu3vksxhk37ibMPNCTn8yhVl0+8Gxk4hNzf9i+j+TDiq8TK/LajhGxCz0hfY4kww
         NgzfCzKoHkrmws7upx3pAOZCMt5CcRfwHLNNPhIIFzVd7WPnzrhzZgz4vmDIYL8OfcUy
         Ql6aTeO3hpa3rwOdjz8Zj6F8jidoMyuzPDPq1hMTuzhvT/ttgLamDbwVMGNk7DOeHUpn
         iAgIsZHblVeBDDEMMMeI5pksoka2OGrZa3KUL576dxjkuQn6NBVnUwfG65IDoRFXYjEn
         lRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786611154; x=1787215954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RHtK6ZnzwEf/ipBzEmZ+Ey8tpxuxKg88KuJsAtOmL1k=;
        b=BiVPyM284EU1UdkgZvGkyhma+mOPKCi5YVKk3TfJ0KbIXFIcetSZeQDcJ5/D/a4v1j
         dsWRGBx/Oj6E0k3Qz1ec+FvjzWcJ7FD9P0vWtZWS1q1RRSpd1botx1MzXvlZQikVDTHw
         5TQlEMygt9jyyft2UTcfQORvmbpIIEaD0mQrNQ/EFF6NH+D6vxNVrzKMG2fZituSRRFP
         9TbxyoDf/KN/OZaGUVz2ytPUAL+pEw/hJBOdoi8paXUoWdoW4LAXYHiy1OCx0fx2VU1F
         KqoxN7fxQZcIesUCZjKWdisRM7W9sFjVTvvAjkRFzWLNa1zihRHcXanzXxAX0gvLYhrg
         DH5g==
X-Forwarded-Encrypted: i=1; AHgh+Roa8tzhXyhA7pEWUS4oTeqHPUVaTdOS7RxqqL8k/c0XqErYPjrqJz7xaRjPSPVpJ/szZwBLx9WiX4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt547563FaWcPS1WObS5I0w30fCoBUX33fnw3RRLCIcjSY7YnM
	/Vl0y1kmO8ATpnk/uaZ206BztYpmGaN1R4/8hhi9Zy9m8680Inxpp9fb
X-Gm-Gg: AR+sD10Wi92nWOHYSm37hL3IqJlEOXyUUBBir3gfSuzigpM37BbK0zvW69sM8+PaFcI
	ErfXpp/wkk/KuJOjtieAavN9OGWh1h2WCAHPwxyq/oQJdtd93BCPqGwCAj2KqNIYI7lOOKBkf78
	vRQ5Sa4xRosV60f428ws/WYGJgPu7D+v7GiXzi82B2+Y0H99H79qGwxWIDJG3IZpZ4wo3h5S2Gj
	HCPl2D8KSuTCdUjMWuvtjGbI2X46MGowdHkg2btkr7UdtE1uo9F/lZ6NSx88j6JVeR032mVIzlB
	TmMHZKRZbxj5Rx+rAgQENJdS0a0mcW/OIBaNeO8ph6AijjTPAXJNv9vIEfynGlivlBcV2J6JPnZ
	luxAGvlmc2s0vCo9ZoffW+t9ZfDhsvFyZBmpmlCfW2fNyQscwvgewc0bNgc67RQVw7so9PjPaYs
	l7pQeitlJhyDp6jZ+CWtZO80Q2pWSoNByJxApYGvFh6uJ0UliSEZMeNfdMVPYrPNnMVJHw6jNnX
	Jlt/MrmVFYE2tQh98RqfNPu1JARO4tbQMTzM9rM03xoliZicLPJpntnewJJPrZGnsvTiaYq8xTB
	LFO8
X-Received: by 2002:a17:90b:568d:b0:380:f85c:94b4 with SMTP id 98e67ed59e1d1-3931e02fb3amr5399769a91.7.1786611153889;
        Thu, 13 Aug 2026 01:52:33 -0700 (PDT)
Received: from phuc-desktop.. ([14.160.25.72])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ec0223e31sm5465372eec.25.2026.08.13.01.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 01:52:33 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Kamal Dasu <kamal.dasu@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-i2c@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@kernel.org>,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 1/3] i2c: pca-platform: Handle errors from optional IRQ lookup
Date: Thu, 13 Aug 2026 15:52:11 +0700
Message-ID: <20260813085213.44001-2-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813085213.44001-1-phucduc.bui@gmail.com>
References: <20260813085213.44001-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

platform_get_irq_optional() returns a positive IRQ number on success or
a negative error code on failure. For an optional IRQ, -ENXIO indicates
that no optional IRQ is available. Other errors, such as -EPROBE_DEFER
and -EINVAL, should be propagated so that the caller can handle them
appropriately.

Propagate negative errors other than -ENXIO.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/i2c/busses/i2c-pca-platform.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index c0f35ebbe37d..63c8ca1f1870 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -139,8 +139,11 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq_optional(pdev, 0);
 	/* If irq is 0, we do polling. */
-	if (irq < 0)
+	if (irq < 0) {
+		if (irq != -ENXIO)
+			return irq;
 		irq = 0;
+	}
 
 	i2c = devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
 	if (!i2c)
-- 
2.43.0

