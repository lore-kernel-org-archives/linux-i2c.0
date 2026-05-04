Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0647A3E023C
	for <linux-i2c@vger.kernel.org>; Mon,  4 May 2026 14:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904822; cv=none; b=ACSQ9h5U5IQ8OU/vkxZN22yw+MMxjGPYmjS9k4hSImGyA+VWYtwUNZZKeCHh1rNwB9Xn5SjcR13hh9ZRiOpzx8A/ha3s7uiTlUSMxkSjDXFHXdlvFfn7PXWjV4Oj+Rrbw0lwot/gKWSgJp7xgdMXD67jW5MA0E+Cxy+F/upePFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904822; c=relaxed/simple;
	bh=7DBV+brMqKkeMyg1c7e4s4uQZkFydD8Oz83RwNoguwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mL8n09qxjv+nVDcff46OprOInCVTQe45pcYgwCfzA0e00vbxTmu4zN4e+bTmPS1Qq1bQo863+qv4mjAdX2NsfKdXJV93b6YQkw6q8OO+4YlNDKuA0bdXYOhZ+l7yrkK9hA2iuc0KWrAbVe5Uad+GcPinR8ZDRe9oCm5zjAWSkIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=Fa0wC8fh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Fa0wC8fh"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso50531455e9.3
        for <linux-i2c@vger.kernel.org>; Mon, 04 May 2026 07:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777904818; x=1778509618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hCo82CHkAXOC89AUSItSs3xEdVl/ldyDWnB7Br1LviY=;
        b=Fa0wC8fh5XUp7fEvYc9tp/t8jbpKROZVFdevp7NnJ1/RkEgrFGS8WgaICrb6/Tnwy4
         vxt1oc2P4VWAH+G0wtR/Y67m8Xd82ZxKqAbGCgkhzclV6bF0WHJvO3aCFBuqUX4wtv3U
         o5L00+mhZT2ksPrjpk8tWm7URo5DDvjnl5pEa8GcAw3ZRpbT3TgzwfTE8FmHNbkuUTu3
         AQFeuGV69MUoVSW64x1D2vfAmS+MHFRHczIhEGTsVs6EMrZHjC3v1BlCdby+4ykmg9lh
         NhG+nqwEwD/MLZ5kQiEqCIvP9cVpAoJJzpf5I2forXkm10EKitNgYgm+LsRAjf94u0SI
         r+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777904818; x=1778509618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCo82CHkAXOC89AUSItSs3xEdVl/ldyDWnB7Br1LviY=;
        b=r6nak1UpueYV96N1M85mTVbUciHTlszA/+bxnrruXB9D+/NHhvan4XsuTfre2tWnn3
         9Ma94umOJpzRn7bXMrJXqB3ctUTl8p36is0go5TBFjsXXa8v+3nMtF3jrAzeQxytJDNY
         YYLwwPlnsTW78OM8oQ1COkj4gsb8cGHaIYg8Ss1Pzvt6rnOVvRNQJALFDbPZCJTmDend
         x7Wh4fVh/UA7isDPLQGPDSIFUSFo2u1mKyHGFhwN/QEr2DgwOzYpnjod+83lVG/FfgxE
         36tmZyWAFzwuv3um4cLjU77q5gq3io26pq+Ym1Nqn7B6D9FnAlHM3umFE+7cVlqKzPlV
         yPvw==
X-Forwarded-Encrypted: i=1; AFNElJ8RBcFvhRsJlYe3WSb2AyDdveD6XQeWsODMifeNYbj/8R0aqzwBPyn0HHCRRkWr0eizwuIhJ7HwxVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjxZtiECMfgoVuRS/jISk73OhKFBxnxsr93XFsHZrouy9JhmPI
	1zAPgwPeLzCvaWMyfIP8U7krbpmf4vyJDtCtrv52npmkrSgMbZe2s7P6p2Vd+a5bFSI=
X-Gm-Gg: AeBDietW22jN93xP29c4Fh8ELXMdEXOP9vUexDIr9+8Ih4GbV+sYENjMYlV4MdNB2Y2
	C+oUeg9MKzjEckx+pSgIa4Hn3b7GqIZoGiuNpcIXH9FOGVNwfuGnf6Q1Ax6mY7nck+kpwUxG4yi
	8jun1XTHfvFeEKLKyMFO3acNMQ07ABfruFZcgMAY5+rGrr4Op0qZsM/O38tZhifmGGrX1MrwFI5
	eHVTlZyEi2ShFbPkti9siDsxQNEueAvYVrCtrC7cxrA4OfeR5bxJIfwDGzkq9JrzLJqcxrkF1Vo
	zJAy9iguErOnxbTX3BNKnbWqOnxFJBIZwIdw49ylMsW3Ud5kHvqwcjq+UrxMhFu74pvaqb+EIdG
	MYlApBCzZ6k+DVz7oxIgSt3p4Y6KIUFom22peZs1wliKRgjns94ouwiDe6Sxu14j3SPu8DC0kc4
	pGHFLZwKPRcW/OLnCHcBI1PUuli9vonl/ImHi2XmtTbL6Iy7kf+ceHP54y7Hqy85aYBbObrGc+X
	uz57YsnbrVzZrVwCL0X714W6Q==
X-Received: by 2002:a05:600c:1385:b0:48a:5970:2005 with SMTP id 5b1f17b1804b1-48a9853c8camr170563115e9.2.1777904818318;
        Mon, 04 May 2026 07:26:58 -0700 (PDT)
Received: from localhost (p200300f65f114e08197264a4bf9e813f.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:1972:64a4:bf9e:813f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48a8feef7d5sm82083105e9.27.2026.05.04.07.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:26:57 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] i2c: Consistently define pci_device_ids using named initializers
Date: Mon,  4 May 2026 16:26:39 +0200
Message-ID: <20260504142639.2119645-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7109; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=7TT1sRnJfW/ikxn6WTYJotq672L1S5wcmrSZS97KA/4=; b=owGbwMvMwMXY3/A7olbonx/jabUkhswfa+Y/7mlIjGvu3Za60uTXr7jdBn8yv9y+uaX09rc2p 5O/uHbGdDIaszAwcjHIiimy2DeuybSqkovsXPvvMswgViaQKQxcnAJwEW/2f6pKHG37E5mEFqb9 yFtm55aQemLa7ZmpTeHJAUnh8Wn1EUJfT1kvWsOqZ+TKv2vP5P1fVAzbi17fOPrSl332i1cneoM PNTbvaHwiHfv7S+3xE0kZiZEausvYJxd9s1dd7LbBw7ncxXf9M49Xb97oiAS13mi7+OlJCdMrVd 9ERU2VnTsF40PzS4z8N7xxmXd1r6o9VxN/ZFeOy5EtL8x/6TNenWz9XybO4QWbQ++xxzueilsrn GRfqhVg35yku3+mUCMP6+u9rWekjD5vl1slszKlVW6PkJRS7o0G/sD8p3FTbaIMtGZ21cu//bJ7 3iahdekBE5uWWrnrPVTSqT/3c5a7QAdTTtfmvIZrPKcA	
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6	
Content-Transfer-Encoding: 8bit


The .driver_data member of the various struct pci_device_id arrays were
initialized by list expressions. This isn't easily readable if you're
not into PCI. Using named initializers is more explicit and thus easier
to parse. Also skip explicit assignments of 0 (which the compiler then
takes care of).

This change doesn't introduce changes to the compiled pci_device_id
arrays. Tested on x86 and arm64.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

The secret plan is to make struct pci_device_id::driver_data an
anonymous union (similar to
https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre.com/)
and that requires named initializers. But IMHO it's also a nice cleanup
on its own.

The anonymous union will allow changes like the following:

-	{ PCI_VDEVICE(INTEL, 0x4b84), .driver_data = (kernel_ulong_t)&dw_spi_pci_ehl_desc },
+	{ PCI_VDEVICE(INTEL, 0x4b84), .driver_data_ptr = &dw_spi_pci_ehl_desc },

(together with the respective change in the code when the value is
used).  This gets rid of a bunch of casts and thus slightly improving
type safety. (Though this doesn't affect i2c as there no driver data is
a pointer.)

Best regards
Uwe

 drivers/i2c/busses/i2c-designware-pcidrv.c | 78 +++++++++++-----------
 drivers/i2c/busses/i2c-eg20t.c             | 10 +--
 2 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index f21f9877c040..aa358eb6656d 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -308,51 +308,51 @@ static void i2c_dw_pci_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id i2c_designware_pci_ids[] = {
 	/* Medfield */
-	{ PCI_VDEVICE(INTEL, 0x0817), medfield },
-	{ PCI_VDEVICE(INTEL, 0x0818), medfield },
-	{ PCI_VDEVICE(INTEL, 0x0819), medfield },
-	{ PCI_VDEVICE(INTEL, 0x082C), medfield },
-	{ PCI_VDEVICE(INTEL, 0x082D), medfield },
-	{ PCI_VDEVICE(INTEL, 0x082E), medfield },
+	{ PCI_VDEVICE(INTEL, 0x0817), .driver_data = medfield },
+	{ PCI_VDEVICE(INTEL, 0x0818), .driver_data = medfield },
+	{ PCI_VDEVICE(INTEL, 0x0819), .driver_data = medfield },
+	{ PCI_VDEVICE(INTEL, 0x082C), .driver_data = medfield },
+	{ PCI_VDEVICE(INTEL, 0x082D), .driver_data = medfield },
+	{ PCI_VDEVICE(INTEL, 0x082E), .driver_data = medfield },
 	/* Merrifield */
-	{ PCI_VDEVICE(INTEL, 0x1195), merrifield },
-	{ PCI_VDEVICE(INTEL, 0x1196), merrifield },
+	{ PCI_VDEVICE(INTEL, 0x1195), .driver_data = merrifield },
+	{ PCI_VDEVICE(INTEL, 0x1196), .driver_data = merrifield },
 	/* Baytrail */
-	{ PCI_VDEVICE(INTEL, 0x0F41), baytrail },
-	{ PCI_VDEVICE(INTEL, 0x0F42), baytrail },
-	{ PCI_VDEVICE(INTEL, 0x0F43), baytrail },
-	{ PCI_VDEVICE(INTEL, 0x0F44), baytrail },
-	{ PCI_VDEVICE(INTEL, 0x0F45), baytrail },
-	{ PCI_VDEVICE(INTEL, 0x0F46), baytrail },
-	{ PCI_VDEVICE(INTEL, 0x0F47), baytrail },
+	{ PCI_VDEVICE(INTEL, 0x0F41), .driver_data = baytrail },
+	{ PCI_VDEVICE(INTEL, 0x0F42), .driver_data = baytrail },
+	{ PCI_VDEVICE(INTEL, 0x0F43), .driver_data = baytrail },
+	{ PCI_VDEVICE(INTEL, 0x0F44), .driver_data = baytrail },
+	{ PCI_VDEVICE(INTEL, 0x0F45), .driver_data = baytrail },
+	{ PCI_VDEVICE(INTEL, 0x0F46), .driver_data = baytrail },
+	{ PCI_VDEVICE(INTEL, 0x0F47), .driver_data = baytrail },
 	/* Haswell */
-	{ PCI_VDEVICE(INTEL, 0x9c61), haswell },
-	{ PCI_VDEVICE(INTEL, 0x9c62), haswell },
+	{ PCI_VDEVICE(INTEL, 0x9c61), .driver_data = haswell },
+	{ PCI_VDEVICE(INTEL, 0x9c62), .driver_data = haswell },
 	/* Braswell / Cherrytrail */
-	{ PCI_VDEVICE(INTEL, 0x22C1), cherrytrail },
-	{ PCI_VDEVICE(INTEL, 0x22C2), cherrytrail },
-	{ PCI_VDEVICE(INTEL, 0x22C3), cherrytrail },
-	{ PCI_VDEVICE(INTEL, 0x22C4), cherrytrail },
-	{ PCI_VDEVICE(INTEL, 0x22C5), cherrytrail },
-	{ PCI_VDEVICE(INTEL, 0x22C6), cherrytrail },
-	{ PCI_VDEVICE(INTEL, 0x22C7), cherrytrail },
+	{ PCI_VDEVICE(INTEL, 0x22C1), .driver_data = cherrytrail },
+	{ PCI_VDEVICE(INTEL, 0x22C2), .driver_data = cherrytrail },
+	{ PCI_VDEVICE(INTEL, 0x22C3), .driver_data = cherrytrail },
+	{ PCI_VDEVICE(INTEL, 0x22C4), .driver_data = cherrytrail },
+	{ PCI_VDEVICE(INTEL, 0x22C5), .driver_data = cherrytrail },
+	{ PCI_VDEVICE(INTEL, 0x22C6), .driver_data = cherrytrail },
+	{ PCI_VDEVICE(INTEL, 0x22C7), .driver_data = cherrytrail },
 	/* Elkhart Lake (PSE I2C) */
-	{ PCI_VDEVICE(INTEL, 0x4bb9), elkhartlake },
-	{ PCI_VDEVICE(INTEL, 0x4bba), elkhartlake },
-	{ PCI_VDEVICE(INTEL, 0x4bbb), elkhartlake },
-	{ PCI_VDEVICE(INTEL, 0x4bbc), elkhartlake },
-	{ PCI_VDEVICE(INTEL, 0x4bbd), elkhartlake },
-	{ PCI_VDEVICE(INTEL, 0x4bbe), elkhartlake },
-	{ PCI_VDEVICE(INTEL, 0x4bbf), elkhartlake },
-	{ PCI_VDEVICE(INTEL, 0x4bc0), elkhartlake },
+	{ PCI_VDEVICE(INTEL, 0x4bb9), .driver_data = elkhartlake },
+	{ PCI_VDEVICE(INTEL, 0x4bba), .driver_data = elkhartlake },
+	{ PCI_VDEVICE(INTEL, 0x4bbb), .driver_data = elkhartlake },
+	{ PCI_VDEVICE(INTEL, 0x4bbc), .driver_data = elkhartlake },
+	{ PCI_VDEVICE(INTEL, 0x4bbd), .driver_data = elkhartlake },
+	{ PCI_VDEVICE(INTEL, 0x4bbe), .driver_data = elkhartlake },
+	{ PCI_VDEVICE(INTEL, 0x4bbf), .driver_data = elkhartlake },
+	{ PCI_VDEVICE(INTEL, 0x4bc0), .driver_data = elkhartlake },
 	/* AMD NAVI */
-	{ PCI_VDEVICE(ATI,  0x7314), navi_amd },
-	{ PCI_VDEVICE(ATI,  0x73a4), navi_amd },
-	{ PCI_VDEVICE(ATI,  0x73e4), navi_amd },
-	{ PCI_VDEVICE(ATI,  0x73c4), navi_amd },
-	{ PCI_VDEVICE(ATI,  0x7444), navi_amd },
-	{ PCI_VDEVICE(ATI,  0x7464), navi_amd },
-	{}
+	{ PCI_VDEVICE(ATI,  0x7314), .driver_data = navi_amd },
+	{ PCI_VDEVICE(ATI,  0x73a4), .driver_data = navi_amd },
+	{ PCI_VDEVICE(ATI,  0x73e4), .driver_data = navi_amd },
+	{ PCI_VDEVICE(ATI,  0x73c4), .driver_data = navi_amd },
+	{ PCI_VDEVICE(ATI,  0x7444), .driver_data = navi_amd },
+	{ PCI_VDEVICE(ATI,  0x7464), .driver_data = navi_amd },
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, i2c_designware_pci_ids);
 
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
 

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

