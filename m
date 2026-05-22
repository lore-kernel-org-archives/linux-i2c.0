Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D73B2FE057
	for <linux-i2c@vger.kernel.org>; Fri, 22 May 2026 20:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779482135; cv=none; b=M+2HC+pH7rn1AZFZnR9zIjdQh6T1yLQ571QLVuxLmoqsg3qn+UP6IrJQZ3uNsNmR1ut0XvxJOwMIzRXHpWxBIVFlj8vZakRI8lKo9U+3VI6JLnwbmv9K+7BGPXJa/i48IAYT310hO7Uo4Uf8mF/COLFyCJ4KDO990IZdWjTTyRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779482135; c=relaxed/simple;
	bh=Q9ZIxPqq+avWubd/LonKxN16U7vM7tUrFVIGXJ359Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKFma+JxLiBuTZ4dmaDxrKM80AJt/CUp4/UDvHgheK5n+fVW2DqWKC6jcDgmpYyr0RFwqcvwnQMEgiD/ICgBPx7evlexSz9WQ6hWEnpDEsYbuxKpfyXAKfSAVVAjHsvVdgfFsa2nMVOJ2/0Tgu4tk/5G0MPTt65KAu8nPZh1LsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=VeVEfuIV; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="VeVEfuIV"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d77f6092eso4582797f8f.2
        for <linux-i2c@vger.kernel.org>; Fri, 22 May 2026 13:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779482132; x=1780086932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2y3T/h7K/6PEJ0HofLl2zEWQ0yuqByR/h59bZrxMAs=;
        b=VeVEfuIVCGgPIZv61Z5lFYzJ+dE1BlBllFNPg7P2TVy4wxcJU6/QOkKTCGWYQSnVq1
         LI4jh/WYO0fZQZdhL8ExdzeR/oB3WYvOBg5YyIakqrsH2fluDaOsUdoIlrrwOt/FuIs4
         ULfSIuju5qG787LmoEI+QxB133cqIvCbI/mPNXQjQ6qgFo3J0YogSpUab5rb/jkIm36+
         BRMDATM5L7DkLqXsxjLHrxhi5kk9upy3WwcGKxxL888vVuYA9qggr0l38YfJ0ASMjNd/
         TWxyrTofYDACBbZSen8+RYZw/lWqbkbdsypxgnKO5aWTe0bAYWBykHBlEaM7p31mkeHN
         YvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779482132; x=1780086932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f2y3T/h7K/6PEJ0HofLl2zEWQ0yuqByR/h59bZrxMAs=;
        b=Yez57bjNWA6VortN8gyxJGkL6uGBglB5fRmpV36XhcbVBWn0OFadFMCKB3gaofFZcF
         +xhGc4lisOpAhYJPTppyACurlOsPBJxFnZmp8n0htnS/CD5l4gVymSr2H53cIj5F1FsY
         3lzqfsRYHv+y8TVi9hefDn2al5Cj+WzZo6LiFs1FZ7sfb4dmdxCwPFytsOf08IoIDVbt
         nq42EKIwn6cDSoWVh913Tb2YUgW7SBdCaMvlgjVSSDdFg9+OSI1f2XeVitj10dmus6e0
         vEbPBYAuI0pJ1iK+/rIjtXQYVtMhdKNlSkJRZD8QjpAGmy+3QynFdY7aDuZ2bE1SYwCi
         fKgQ==
X-Gm-Message-State: AOJu0YxCNRkHIqWD010xGHNOcGgW8189bvds88kXzDpiqu4GFiSw8XvR
	N0N0o5/j51XrzOxLheB8ZBqG+fevAqYDZhGNEikcqO14gX5kfP7bt/5IGvZRntgs7Eg=
X-Gm-Gg: Acq92OHRorWUz3YMnvpS+K7ZGN1Th0hm+ADxJDhOXMPX9JrdEfskKoovVKMMRk0m0jv
	4yrbTkvbH7fFLsrqJyqGjSsutel1uEtpQfZoncGxL/axpQxNdTafvI7pXGghb55VRZEjr1Mr9A4
	1yVATykGmLg8cMY88KQlDHKB2/w97bp+TjPt5J4V5XGdnvzpaf9UaELTWl5190MdmqV18OVbGc8
	EUvD+uwnYysEhiNv6GfHXRdJHhu1kSq/UtWwh0kvPFYK4/fLkzxrXgEU0kwuu4IhWqgjlNCJQLd
	uXAAMdk3iTua06EdlouJmPOPtHRwK81+Ws9issP5Vf7DrVbM4UzGvnoIM/OY/z+hOCl6MU/LZtZ
	+3CIhfIOuMgRbL0pLwOMqg261C588e6L3QbethKoj8uzAttIA31c6385/dL7eEqoVzJSr64/eTU
	vKYYAjX1IS2a7mCA8QOpfn5NhoCShk
X-Received: by 2002:a05:6000:1848:b0:43d:733f:aee6 with SMTP id ffacd0b85a97d-45eb3687dedmr8362080f8f.10.1779482132065;
        Fri, 22 May 2026 13:35:32 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45eb6cd151asm5990419f8f.13.2026.05.22.13.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 13:35:31 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] i2c: eg20t: Consistently define pci_device_ids using named initializers
Date: Fri, 22 May 2026 22:35:14 +0200
Message-ID:  <41316792102ff2860ec019373293cb07d545a0b0.1779481436.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779481436.git.u.kleine-koenig@baylibre.com>
References: <cover.1779481436.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1449; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Q9ZIxPqq+avWubd/LonKxN16U7vM7tUrFVIGXJ359Kw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqEL4GxS/C+lP+v+RJzVjXostgzeQlSIU7laJcF lyuZpQXjOCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCahC+BgAKCRCPgPtYfRL+ TtbjCACehs6et6YO9YlnIwjf+9u/LKci1facCtQV80XlbdTylbWgFTZYexbqV61wLP/fFgQ6Zl9 AqMEqSu7SlEXzyoRtdxQgJehR+HfRC2ug1ZskWe8Jy3X0GurprWK07b80RzyYm+pZgUJrlgZ+nG Zr1Jre0jTA3sngHQIIelEaYYFMTUButjklBfKqOcqZyrVlSlImObehIy8P3a1M3eE/8aJvnGg8D yl9dRWwbvaV806QNljGt7i8SqFxEPipXsfDEk00oeem90Z1dUlQvAKp1rVBATnd8TXnp+WVkfux rXRlb++Qee0XT1xq0sh9fcUYM/OFrGVWsrrpyQ3rxgtP8P2v
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The .driver_data member of the struct pci_device_id array were
initialized by list expressions. This isn't easily readable if you're
not into PCI. Using named initializers is more explicit and thus easier
to parse.

This change doesn't introduce changes to the compiled pci_device_id
arrays. Tested on x86 and arm64.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/i2c/busses/i2c-eg20t.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index f83238868802..8c67ab4f2aad 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -169,11 +169,11 @@ static DEFINE_MUTEX(pch_mutex);
 #define PCI_DEVICE_ID_ML7831_I2C	0x8817
 
 static const struct pci_device_id pch_pcidev_id[] = {
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_PCH_I2C),   1, },
-	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_I2C), 2, },
-	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_I2C), 1, },
-	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_I2C), 1, },
-	{0,}
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_PCH_I2C),   .driver_data = 1 },
+	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_I2C), .driver_data = 2 },
+	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_I2C), .driver_data = 1 },
+	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_I2C), .driver_data = 1 },
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, pch_pcidev_id);
 
-- 
2.47.3

