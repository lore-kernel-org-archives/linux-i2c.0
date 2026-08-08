Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B1132F770
	for <linux-i2c@vger.kernel.org>; Sat,  8 Aug 2026 15:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786202874; cv=none; b=hFYHn4FIjJ1Ux7NdyDiTtJuw33syFZqVXekvl5WXgjc+20baYTCRP5DGEyk2JczI7Mh9qvhvTEnnXO7K/ylhaFGNn0wOfoP2q33/vcwnn/T8JJnYnC23utjyC/VhFPVgCtq+tnqwo5JBmgHgEuH2ynF58lMMWZ7YCc16jQuD7JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786202874; c=relaxed/simple;
	bh=kpeaAxS9LFu/8STzYbBglogfC3SD8I76cMF2ZM5B+38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QyyX8lYPwqkzNBD6T3Wjv0misRSFFJhEC3gVNahLzox1bKT/5fyBzLECNbJSlAjkVVkK+ZW2zHGQltvCQC7Owy1/g5xlDW3P5e6jZkAEuDQQarLCj8yUfzBuOY0JXfuvCq5JZNJaHeG0XUUPb60FpJemYZzVolyYxnSMsB4uVRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KysmkUTq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KysmkUTq"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cc891373e0so5576185ad.2
        for <linux-i2c@vger.kernel.org>; Sat, 08 Aug 2026 08:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786202873; x=1786807673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fosxO2aakWlymDAhSXtvCLChemt0o7MdN2FsRA0clTA=;
        b=KysmkUTqvEMmUDI6rr3JrQHnS3DNGxej+YMklGux+vGCgE6ao+ia+N0OzoSf/UD+0n
         zz47KhxwcJbEkljkVssNm3hFW1Q2T0Y14eg7d624Uo5xntn7uJjyz6ZmIyJZmSrWK+pw
         zMJGsvSj4mXzgBagfdwcJ2Ut+ptz4AGNV6nF92bfzRqX7FqjCET9ZCwnvMMygOAPnxPo
         jljRQY63iPqBckV5/Zs+9GOlAZJIUoCsmVO8+Vpy43Tx3BwM2c/0evaUXDduLCJWVZpD
         0KYhi7OtKYkXP9sbQubJc6vwwWpxq67yzgLO7T5BJOQmdD99z8AEFShkmcDs47ff6tDK
         WbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786202873; x=1786807673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fosxO2aakWlymDAhSXtvCLChemt0o7MdN2FsRA0clTA=;
        b=AHLPo/BfhPjShl47tX5LMFDBa0/0uZil4CYeqDB/N4wat9DGqaqI4qAcQeKMnaBXFE
         MA8XbPfzPua7DoaGdTSK3VyX6/kK/Z92OhNvx/KOCWZtM3VtTHEwUYRxK+kwCm0zbINQ
         +AnULcT+fAKDoH3PS7DNfCuVH2KKBjvzCcZ9rCOMuxjGjsiKhJhaoJjdWaNMjE4UpRKr
         xwVBSGe5Y6+QoqkoUjS7t09ySHHlAr8M9LOCR9f3vfj4HDd4M2tlr8LfffI7pDn3DaRV
         6Vo1pgO+E/OPRVFQt4JL3ZhibXoQW5+kf/YlBuHReldCgtLSPNmvUG0WLguwTpwaSxtd
         1OOg==
X-Forwarded-Encrypted: i=1; AHgh+RqJoAzjkYm974qJ9y44NWn1KZG4yyiQ6N0+dIgoJI0i9DRSnG9ntbeCqXMrL7ZRCugjQ0lRV1Q+Vs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNWb79uU9x0CdglzC1G4ADCzv83ZdoTGFWKHBZkr8kX8P1pA5o
	44K6dFEz35+tjrsWrzeZX7T/fyw9SqsLupOECik3s1Mml/0uExMfZshR
X-Gm-Gg: AR+sD11ZgHt0lxujJZdf9jtsxywPRUoUbR5P5WkwF2rNXwlI05B4TYPJ7+rgc7Sk51X
	iYuQKXLvumtEy8dr8Ezt6wuR0laGq5/I3fz7o5ID5MF7OKBK9p7IJZa2RqQN3xpAm15CYIFYka8
	cngu5byVC7vpUB4BC/XLmv+xrLWjdihiKaZb2JcoSZL892E8EUtKwUNW0v3evpgXaSTFccUS8FZ
	oGhoIqdnUgRgfuX/O5MaxHkylQFpM1SDKOQ0czvAmMMBUgt1P/N5PehME4qKHOLZqtyvO5/HxD2
	CFbUvlh5esy9iCiWDNfMtDqFEQuMtbHJSoNcLTYq1u55bHsWsrk4YrZGi6WW35msBWU3k9N6dJB
	PLDJDaQbpPUR8x3zboJJ55qlYmSFHQ6OvzeXaapinq3/juE//cka4JC51PSxt5HRppBZGP6pxQ5
	SVQmA2lNx2e6T665ZS36aRgzfOprSbxMo1hZZk9mRNQBUY02dfZL91a4tU5aMkDs4n5YS6VA==
X-Received: by 2002:a17:902:e951:b0:2ca:bf68:2a54 with SMTP id d9443c01a7336-2d0ca96246bmr402478875ad.22.1786202872580;
        Sat, 08 Aug 2026 08:27:52 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14d57f8b7sm19558175ad.30.2026.08.08.08.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 08:27:52 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Ludovic Desroches <ludovic.desroches@atmel.com>,
	Wenyou Yang <wenyou.yang@atmel.com>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: at91: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 23:26:54 +0800
Message-ID: <20260808152654.2943371-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

at91_twi_probe() calls pm_runtime_use_autosuspend(), but neither the
probe error path nor at91_twi_remove() calls the matching
pm_runtime_dont_use_autosuspend() during teardown.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() calls to the probe
error and driver remove paths.

This issue was found by manual code inspection.

Fixes: d64a818859af ("i2c: at91: add support for runtime PM")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/i2c/busses/i2c-at91-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-at91-core.c b/drivers/i2c/busses/i2c-at91-core.c
index b64adef778d4..65b389d07d2f 100644
--- a/drivers/i2c/busses/i2c-at91-core.c
+++ b/drivers/i2c/busses/i2c-at91-core.c
@@ -253,6 +253,7 @@ static int at91_twi_probe(struct platform_device *pdev)
 
 	rc = i2c_add_numbered_adapter(&dev->adapter);
 	if (rc) {
+		pm_runtime_dont_use_autosuspend(dev->dev);
 		pm_runtime_disable(dev->dev);
 		pm_runtime_set_suspended(dev->dev);
 
@@ -270,6 +271,7 @@ static void at91_twi_remove(struct platform_device *pdev)
 
 	i2c_del_adapter(&dev->adapter);
 
+	pm_runtime_dont_use_autosuspend(dev->dev);
 	pm_runtime_disable(dev->dev);
 	pm_runtime_set_suspended(dev->dev);
 }
-- 
2.43.0

