Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9692385D81
	for <linux-i2c@vger.kernel.org>; Fri, 22 May 2026 20:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779482133; cv=none; b=kAJs3HaFbVcqAXZRPV9/6nFvIiZziLjE8vQfaoUK3RuvIKeduk6R+RBTb5sAO1BU9YDRcOCKl39idNbm7Yr9Tm64P8Ra1IM48GFE6asoKQ0NAzyFMTv+xaa8UsHODZpnJMHk0b3+CaFPAFqVjuvL7PfvCXde8Tsad+KPUhjgdcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779482133; c=relaxed/simple;
	bh=iAjQZT5aUoAWVJVFTqyNXVazgRDPkpuN3yaqpW1aML0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C09z2LxPY9+V0AQW7fV3fEKgZ6HJSrlGQY1jt2s458IPZ3fq9cqU8a5hj07sofDoPM3NnyLIdVVZa+vXqv7DWIbbVH18kwkDXqYmpDRPz89ZaHKmVWwZi+o7dxP3EaXUsTQmMnn0cfdWOZn5oXdPhPlpj34JMNaDeiQKgX+YTR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=dNhQsHjw; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="dNhQsHjw"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so4005534f8f.2
        for <linux-i2c@vger.kernel.org>; Fri, 22 May 2026 13:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779482130; x=1780086930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiIrfEjXizuDvUFyygdqA7+8wvQNjBlFchL1YFzPjzw=;
        b=dNhQsHjwAZqo4wg8dV1KPi0/sNXyvpDV/WvG8W4+jG3CLq6Z0J7yAVp1cfHsAYoJn5
         jJN99YSDKV7NoxfhfnVhaEI8QGGQARoaZOpoIWSxJa7Xfi+cK+gVipJ8834zYMtx+4pB
         iZXKmAxw3InSmtkPdIMja9r/OAU6/EGmw8bSP0QK/eRrq11DBx11ziCCf5T38c8KKW4X
         T2Nnczf9jtnSEFOxLe90+oiGB0oHg79EqIW0xaBVwO3nwzYbUYYJcvMy9DCdQCYQrWF8
         rCPBy/8H2mS2rtEuO3jdpTkVkArHemgqKCqlGCRGfnEPmzq6U7XUobxVssbpW8mp2ZI5
         68xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779482130; x=1780086930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hiIrfEjXizuDvUFyygdqA7+8wvQNjBlFchL1YFzPjzw=;
        b=pJxezXaDXT7/7h98feti9YAm8+sqyjb7GH+9LqrpIdRCJTjfKfo6I2zYuEY0AmhHjY
         0LcEYfMatAUSREus7VCciMdvUM6C4qUOONS7H+5G/Wek5A9XJEvNhxwl5WFyjvgZWqsx
         amOW4K/joecEkAw2NoY/q3YIt0GS8P7eDLz1nwQy3CLAWaAp8WTBEZQ0imL+1b3D3dmU
         OXzkDq29dBV+hJjAU658+bf/jNTUd/bZp3RSUCgg6vpISf2A7W0q2+F3uknCzujukmiH
         6h7Yv8FuExNGbY6+cNW8qrzA5Y3183FT7QVRDrKZxi62SXJftAVs5d41qOMqLrk77xIJ
         cOtg==
X-Forwarded-Encrypted: i=1; AFNElJ/0P9hC0rCixJwtObHxUN9EixzsHM90oU2B8+5jjnRFDH9NRqyaoEqSP90oyQ3pOiXp03dPcecaTfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Rz+qP6nI/pa9wS9B+kk7IasiNTLpQlnbJMR8/yehNmbcnaMv
	hAWceRhBANkf6wxPIWTAV1F2NnoUXHH7MAP+yLl2lp0dzmbLnlJ3BTZqDsVBupOzhBfVKSb/kMD
	s4xRiJmw=
X-Gm-Gg: Acq92OGKAy8mKNRpY4sutUhR33f0BwfICb1zYXfMr7sF1sOSW4h6uLbruX/VVHgSRjT
	EAA1YC0AX3eixK9BYP5ENGHLGCe/iLEzEc4t9PiOIZReSAgDGb4C7JK6z+X3A/obIh6HJFJYGu8
	7ECmh2vCLXB5XHWxiqpkBQ1ev0+3SZDG0KBKlY7pUugmnge9cagL1ReoFDEuAgZhHApN8zO8bxk
	8iFiTXIeKfVvJ0FZeGIWGXIzkyz4WXUHdlM82nitVBq57jpVMK/5lkccASq+ogTA1sPlv21Sksr
	dy+fOClzvY1HOonHrA8qpHobiVNX56JLVwiYKJLhJMNe1e66jyFP+gIZyV/9Nzi8SHNkvAvb1v0
	wvr6t7e52pXa0SV378B/8ED3DyG86gKr1jgxAR/KUZVUd47t2/nP/FiZ7aWOyUZj7iXA2gssH/X
	lxd6tn8/BEI+R7VxE7QfmHtm37sR+T3My8tp/BRGY=
X-Received: by 2002:a05:6000:26c3:b0:45d:b14b:23fb with SMTP id ffacd0b85a97d-45eb369c7abmr8298560f8f.11.1779482130180;
        Fri, 22 May 2026 13:35:30 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45eb6c9f548sm7357082f8f.2.2026.05.22.13.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 13:35:29 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] i2c: designware-pcidrv: Consistently define pci_device_ids using named initializers
Date: Fri, 22 May 2026 22:35:13 +0200
Message-ID:  <68667c4ab85716b190d8b705813b610e21a386f6.1779481436.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5239; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=iAjQZT5aUoAWVJVFTqyNXVazgRDPkpuN3yaqpW1aML0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqEL4E3vg7OBUUJN+Z3hqJ+PYfvCEbd07WmzNrQ RCI5nQ33y+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCahC+BAAKCRCPgPtYfRL+ TmngB/9KvsHUQJwx3BVGjf2QW/fJyFWRPnkJFxsHb2AXhfbc52YJkVmXA4iJbMGMe1VGqD4E2cK dnjg4HjA+qD2CUaN9RN2T6c1netwBVP87TygN7oDSMhGPTLNRk1mXu9RXE8d9gNmSMj31ygpHWR Pxayen4yl6mwcoiLOGOSkRBJJZwmvEgipY9JLR+s30QreKBmCCAQO7fy4HOce6ojqIBvUovIXpF U8oiN4td7GMogyeNSXpPRe1rmfFEvUy+x3OWubCubs7Hr+j4w7f128FUIBzNWI42r/IVq0Tw9I3 hE0SJRYzWMIu5XSn+PqiFmIWVpJiztqpmIf9lO5mIzpungkN
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The .driver_data member of the struct pci_device_id array were
initialized by list expressions. This isn't easily readable if you're
not into PCI. Using named initializers is more explicit and thus easier
to parse.

This change doesn't introduce changes to the compiled pci_device_id
array. Tested on x86 and arm64.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c | 78 +++++++++++-----------
 1 file changed, 39 insertions(+), 39 deletions(-)

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
 
-- 
2.47.3

