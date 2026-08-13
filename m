Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7CC445AE3
	for <linux-i2c@vger.kernel.org>; Thu, 13 Aug 2026 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611161; cv=none; b=OOeolLve1CaIjCund6HVv0Ys9qgYeQIvMv52/xTqCEOmqDGqXixrAeIP/n5v9OhuLJovxzhR7nPanj8+OITdmw8O1NSNt9ezu3NQ/0GG2S2FvYFWDC0UYiymCxSMG/rz55wvzSVXNcH0eKLET2TZZ9rK2fZ/yU2WJKckNkxJeP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611161; c=relaxed/simple;
	bh=KjvjKvkgL644W4yGzFffrW4wGqvGgxi3zwpZYuA1u/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHJvrp41qluNfbLLbVFc7uHR01ZPezxC9+zN6x8ZTFcvo/sUxlu4JOzOXo/5F114AJqTs3mQzVZbTsYkFol4jcn6pJqrsj8duDd9JYqc7yY6V10KEtnX+NmQuL75Pmhi5Y2FSpnfBD3UqeZEAkh27henl2/xLbHtrIBI4/21QdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6f/bHOx; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6f/bHOx"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cbedda4c154so1192575a12.1
        for <linux-i2c@vger.kernel.org>; Thu, 13 Aug 2026 01:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786611159; x=1787215959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+jR/AjpIRwYXk9oHrDaUFtlf2egH/aUGrOWWf2J37lM=;
        b=B6f/bHOxnOAUh63MteX4T72gKEFI3Rs05Ubn/MUgnhlTFrwI2iwbbqlieMOBqm//CW
         Go9q+XUCIaPnM7bPrFl7DqXr8zraFxZtLT30O9/SaEAo4qu89FSA4IGgzQqoVD6XanHC
         6suHYUyt2g+6QefE5gkBeBtz1sMnbT5oHpwNGOMp6OOsmsw+z9Xte7iWY3oWVWgrTYfw
         DteMVylGLhciq9vBaH4F18WQlkrwLrq5ujRaI/Fkuao3mBx/KS+f9kUlHOC5O6GdM8Qe
         lRgIl8+EN617qugQXl3cwy3HP/JMAB2QXqxN2jxewuNlwHcOpML13IRe/J6p4qxD56/u
         BMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786611159; x=1787215959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+jR/AjpIRwYXk9oHrDaUFtlf2egH/aUGrOWWf2J37lM=;
        b=BxWP1JKXpuBfHfkMUDbX+kAwmcjZJ3fB9O3+5s9Psn6dJ1bbKFS4+Qh1XfasH7Ktwq
         BGjwbFj5rls76h7KmECjUJmBkLLfZ4YV0AMvN8L1OW3bN1AWxy6CobISQiY/8Jpq4iWb
         e7RbOMExtiAG16+5kwgb/p9sOwu88+MC9Rt3eMi5zmDmN4QLahV8gbwaBMgqJKdq/oYG
         WWr4JTtCBQZ+lLWwehULWB0tCGE8b6ByFBzfKRBJXtSX28fPadedUs5yOxnZ/wH9PmSm
         DhNS043gBfUelh5Yvk5tj5d+oAX5QhSQyt6/dTIthxQvfQTIwJo3QBzWUJkPeFd8MP+r
         mRTQ==
X-Forwarded-Encrypted: i=1; AHgh+RrVbsWMWk9ST/LypoC9d+ROnYCcUMIJ3Tsj0wiu0k/cUAj50Zw8yAklvX/j/4Qq8cG7JSDBlJHl0gU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzVkTa6YOK6OYb9ej8fDgVUT6qowjkKv1mmIFZ0BwPw3oFmOZT
	X+ybjIlRJbGd+Gvn52d3k5Tu4dn5K1gUIxGDrs5bLN0V4x9hpST5NRJ5
X-Gm-Gg: AR+sD13bNT4uGwdSlN8Il9/jz2sjrKyfvE/QrjBJ35iNwamhGW9D0wlSsocHYGf4rQ7
	nWvqcDh7xX+l2I4qU8dPcmT7Dzo47DpIUQ1lFVmGXYRkxBZhjL5Pe3mQrlqUaCTff0WNyG6rkU1
	73eZQowoz9u18Pn9ontG5dhcIrRT10PmXSSFhIGffkMxVtCjN9hGNObMF//GUXmL0UUpweWOkOL
	ZZVOMqSxGyW2XoreydvzuWq6lQuvk6q3/ewrhaKk3PyaPZ/Y+0DIe4TEa9CUp0gOw5XpOBgxquF
	IPiUq4MLiW63zngXYORNkAm3V/xsQ4a9Rf4pDo/vqjAHsuyw3uvTD8icEouv3VCvXzlMXYhjN0Z
	DerPauvgKQFTpD0/ncuOidJltlGV6xHAjqIYf/CvytbQWXsW2OwR/J7Qn6kiscvwp84ictRLQ65
	+PG6FqS2KNsHiee75TW0b2GWxxWRSHWGttciC29jxb+9tZic+XJQ45Z4g/L0ye34OiBiZLMWG/E
	byTzeU9p7VSDqQUVsw/cTzK4vHM4RMFqxLSanj5heUk5l1HmvfjQ/s8G25mvfT0vfNvCKKPO2Km
	E8iMA1/x9uBbD7w=
X-Received: by 2002:a05:6a20:6f02:b0:3cc:36a0:3ff6 with SMTP id adf61e73a8af0-3cc553971a7mr6274859637.19.1786611159290;
        Thu, 13 Aug 2026 01:52:39 -0700 (PDT)
Received: from phuc-desktop.. ([14.160.25.72])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ec0223e31sm5465372eec.25.2026.08.13.01.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 01:52:38 -0700 (PDT)
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
Subject: [PATCH 2/3] i2c: brcmstb: Handle errors from optional IRQ lookup
Date: Thu, 13 Aug 2026 15:52:12 +0700
Message-ID: <20260813085213.44001-3-phucduc.bui@gmail.com>
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
 drivers/i2c/busses/i2c-brcmstb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-brcmstb.c
index 5fa30e8926c5..91525a36e575 100644
--- a/drivers/i2c/busses/i2c-brcmstb.c
+++ b/drivers/i2c/busses/i2c-brcmstb.c
@@ -648,6 +648,8 @@ static int brcmstb_i2c_probe(struct platform_device *pdev)
 
 	/* Get the interrupt number */
 	dev->irq = platform_get_irq_optional(pdev, 0);
+	if (dev->irq < 0 && dev->irq != -ENXIO)
+		return dev->irq;
 
 	/* disable the bsc interrupt line */
 	brcmstb_i2c_enable_disable_irq(dev, INT_DISABLE);
-- 
2.43.0

