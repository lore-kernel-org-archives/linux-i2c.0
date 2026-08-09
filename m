Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E977391513
	for <linux-i2c@vger.kernel.org>; Sun,  9 Aug 2026 07:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786260794; cv=none; b=mCTMWiUD4d2XK1/93WpESrk8hrMPsgJ5C2Q+tgQiihuQWScT4UHhis0Qb5eLY2x9HZrECpHm/h1eT2J93dhj1nATw55lpNaJOStqf6LjTmt2OIa6tj6/lF95TBQ4JLnP1ZhItzG2PliwS5wpUDDcWHnRowEQQaTROF9rGRfCzuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786260794; c=relaxed/simple;
	bh=KjB2Lr+gNrW4tPidywgCIXL5Whe6bg7M2THcOPT44YY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AiPvfT+U3D5+leBKFQQI0vN1RW1Ks94ObEoFt6jiAAAjWcMzPwXFvkjRQ2eXbQMa6wEUzeh2rWZmR7lswGgHgufX6sIGVpyL2CDJrlCa18ssreQ2dQ9MTlaXdTlqWUFBfKfjrKpxWAk1A5w4D3AehtS+W1sIaLrI0M5EVCkYRDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKwGycuY; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKwGycuY"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ce98cb8165so7471385ad.1
        for <linux-i2c@vger.kernel.org>; Sun, 09 Aug 2026 00:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786260793; x=1786865593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ENfS7OBp/4A8ZLshWeb8VKrRLZVv7nV81r8Jw7UB3zw=;
        b=SKwGycuYH2x5dibFopnT7XL5r9+OqAmBy/jwRWdl5pHaFYoOYEoEku6NVXQF15dUvp
         kmYafpC+zlgOgy1lTlpwoz1EArXmdZSgXSFTs/TYXfExeq5p/9UGN+PH1iYiOJopsZ95
         +BbP/cH+XdYiwO2XIOVajPSvMAjnJUjqd+Uls57kLW5WA/N/nD2FfC/UxaGsVZ5DA8Xg
         cyJEJw+ekr0vuiC9HtdUdGK8YcTyaEq1n5Qwq+GEg1sSoCHccUJr4zPJy9P2Ve9SwRJ1
         uOJt74YI92EfViyGCZ7eOFg4uX/x8FNaePCYvI3DLiLE9ZKDj48RRnRFiccgj8l8pvTJ
         jNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786260793; x=1786865593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ENfS7OBp/4A8ZLshWeb8VKrRLZVv7nV81r8Jw7UB3zw=;
        b=G10NiRu1Wo7Ywu2Rz4GuotaPk6BtS/KJbISZ53KVsLbCIA36hNRNFB7twYpWMeo2kR
         TMM55S11bMDYXS2rKfvJmuMh38EAMKla+h9eOCeTJUkQlgWj53upJzWRx9yYk7sKW6Bs
         eiVPkdqwdKt+sTms2CcvUqCODbCsSN9kkgMQI0mvKcLHKU0c8XYf5Rk1p7ul/BdcD2hq
         sKPm9j1pkn1zjyrpenc3C3AtPtZI/fp5QdFLoBT0IuBoUkwwJqMljRIdpOaSi4ervCok
         460+fWi7ODW6TEJofUl9mFhMdJ/xxS1IWdrlaDTMs1iwlxUoSmlLQTbqGFM4akO0NdmA
         KnQA==
X-Forwarded-Encrypted: i=1; AHgh+RrwOwezrnnf4mwFY/w2Tge4KHeWhccLWb/MqfcNa00V3bwTth1hkF/dsI2tKBhkoUQD8Dvud8pC7yI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0D47Ez9p77SEvj4ivufnXFZ6hdMYGRT9Dgq9O7Sys5u9x8PGg
	4vkApybEQVpqzxcwfxlE7mdErBNkcEeJgpv1aB5aMmtBpTZwAlzs8qm0
X-Gm-Gg: AR+sD12BWPF/S+y6FXVP+eJ9zUqGPjKR7Gd1V9CDu7teZxQtgZ9ThcjQLsfBnOCmVtk
	xIuqqdzrqXEN8RCIm0hyzo6hFGDUix7fY4IhBmvpThXYuH0L0QARmf/wHWheUwYvZs6rIUuFKVp
	jsQdZYdXEPFG6SgD3SyrI+VZwiX3utAt5iIuVFTkkOaZ1ZXHnLJ/S4TNt4k78/C1N1KErD+jyl+
	MBpG/MgfjloPulWmeQq5KVC1otMPdCnhf1k6lr7VWWWwwIsNnIjV6ut8uJsrdU/AxwOPYG8xVA4
	zHZfZ9paZn3AAnWVP441G9IhDsVZcmvH2c4dZeq+R9A+gEitHtoVWG0ssXmWrmYknDCTkm/MK6P
	5vWbRqbgf1LCnxRu9CX71DwKygXFo9/tBT7snlPAfPBdNXfZVKyJgtA+lT1gBePQhcKJ6vXwXle
	9KomqeHhcwdRvhEJAsX76rUoiRMnwm8upaiunu65dpK4COFkWc6Ju5qw==
X-Received: by 2002:a17:903:2383:b0:2c0:d94f:50c7 with SMTP id d9443c01a7336-2d2b2de58dcmr124370505ad.7.1786260792633;
        Sun, 09 Aug 2026 00:33:12 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085f5e33fsm10540532a91.14.2026.08.09.00.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 00:33:12 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Ben Dooks <ben-linux@fluff.org>,
	Dirk Brandewie <dirk.brandewie@gmail.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: designware-pci: fix autosuspend cleanup during teardown
Date: Sun,  9 Aug 2026 15:30:55 +0800
Message-ID: <20260809073055.2980971-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i2c_dw_pci_probe() calls pm_runtime_use_autosuspend(), but
i2c_dw_pci_remove() does not call the matching
pm_runtime_dont_use_autosuspend() during teardown.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() call to the driver
remove path.

This issue was found by manual code inspection.

Fixes: 18dbdda89f5c ("i2c-designware: Add runtime power management support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 468287922363..f1f4955f9a3f 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -300,6 +300,7 @@ static void i2c_dw_pci_remove(struct pci_dev *pdev)
 
 	i2c_dw_disable(dev);
 
+	pm_runtime_dont_use_autosuspend(device);
 	pm_runtime_forbid(device);
 	pm_runtime_get_noresume(device);
 
-- 
2.43.0

