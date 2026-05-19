Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6666405855
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183499; cv=none; b=dMWuok+Px4tiWRqL6xm4cnZEOVDY+zVTcfy5zQQun/pphbTSVLAkshvJ5ncafOqFuhZBQn1rx7FtgApwZCuSMM7LFauPuTPHsHK3cxvBQgjnNEu3jRQOx3b2lVbvfLEr6Fh//D26viObNEeQw5RusFLQQhBGHrcm16n1WhNWAaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183499; c=relaxed/simple;
	bh=qRRQXp0U6iWJ6fRxiYMVSIZ4g1MrQM/QNV99ICd0FUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kLXbjT+yQFYV+em233nePIGqrX+tR+wDHe367f87M+bUzR7KUrkgEuicZYTYJ8MiwISBMX/oKCjNDpanp0fURr5puP8Wc0nspXxdhStEP3wxQUjcswSUJPke8zhtKlxXfu5BHNj1cLF/n27te5qlCZ7SvgDG2FGT9J0MXThbLGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=D4r0zBgM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="D4r0zBgM"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b0046078so29886795e9.1
        for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 02:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779183494; x=1779788294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5w9ev5uT8jYgS/YrJtWGQ7Pmlpe8iBTub42CMDhT6CY=;
        b=D4r0zBgMuLFKXy8Mu/Es4evv9VmvRmI0E9QESf/O82D5zu2pRmI0biElkBM/Ovp3Nw
         jcWB3igfB21YVOVz3+AdNSEURF51NomMc09m+BRFYk7f3Wpq7WPGB4bqg0K4OYBJMTHK
         8K+GWEgE1FQb+N42z+Dpwn39aXSi0ot7SvkQ4lrxe5IalCPtswwbSEprF7t92GLNpS40
         OOlCZMJ8rijpl2FkoglA+DbXUpHpLPmff6D0CYCyoTGOU8M83OL+l8vOAGISdMb06pmI
         7jvtGTJZBKhwR+iiSxRXOZSM3F1pzIlzFVs70nPd4ikGIVKdvwZGY1qJIB8NFqxEAJAY
         sVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779183494; x=1779788294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5w9ev5uT8jYgS/YrJtWGQ7Pmlpe8iBTub42CMDhT6CY=;
        b=PeFozeZHnqWXj42RuFH0DCoqpz2FqvYh1aQhGdOcs2PYyQKAhrKkWd3Fk7f29Kcl2f
         /0+MIRjkon0G2X9Ld5ihZrnqEUr9Nz2C2MR/kWKszsDTARoIOYacu2eqUNKZvLczlsOD
         gc+Y1M3aP2SEETIjG17P1g0PCy2xr4yC8lVCyltdls1szE89ParOy8elMicUWAPgWI8T
         FEZA9E0W6X2evUv0p4KO5C/uU/ZfaWJaJKVSPcYo9tSH091wxFokhFGbyrKFWIMuOn2j
         wWJzR52OVnpYmCRfsrhtFf3tYWtPTB1uI2v+xyf39lnJYroscY76MyQZnXTj8IUtuvth
         tP1A==
X-Forwarded-Encrypted: i=1; AFNElJ8gpfAVzS9zgpgIVx3HxqDGrVHrcmjLX+kadADtXP4aORM5MzR/AZVNfM0bjjbjgFtpc37V5wz5A+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+4q729TJK0s5yKE93jro1K8rfxy6fKAP5HxRThYOPHLPg7sb4
	Ssi8j6QCkRblwsYh6lQ8PhqZv8RuEVN50BjGkamK2vDtIeGPegdyfujHKtr2gFlHoEYjlzeELvs
	knM9pMiE=
X-Gm-Gg: Acq92OFNgkUMSt6dDXOredC4dSvJch3xDoSZBI5G2hO0akLyqsWuO1YzFT5t5w5cTxi
	QSHj11nhc9gSFINf8FdVFEBnqSMFFYvNOYFtUFRUsBIEftBWCk/PBqQ9teixwATHoDZzzCYq4R2
	3JnWANhubAJjOPYrNJr2VAuYz1QZaqUu40/OxV4mD5LL/ZX/lrCXVPSOSx4H7kNmSlpbg+MKUsG
	0KQ7SOfQ+LncpauvbrQGZhY1SqEt5cNQ71OgTMlQ/tl39hndxHIin1lZ2ZQHTk5MlSUlypC+aFh
	ENaGCN0V/PbrmVOGx8f/+DogBFeZ+uxgXfUONYghG5f1Txj1Slv6WguWNEZuWE+r9Abey67q8im
	TW2/D1fYyAFhjwXTTBkbJFuEljhzPKvf256kWHYEDKNWZMMoB20qpd0RL3V6fFW/fWspfCO/10S
	rpxIYXFWfyIMUFRti+Dd3zhEVcDuAIRBu4xakMBKEl0ouJRNi0s4OGO/pIV/4iUs/PJp3VWJnyH
	rKc9B0x62B6S3JkmHwsiY/6DQ==
X-Received: by 2002:a05:600c:34d4:b0:48f:e245:394e with SMTP id 5b1f17b1804b1-48fe631f631mr304965415e9.27.1779183493958;
        Tue, 19 May 2026 02:38:13 -0700 (PDT)
Received: from localhost (p200300f65f47db0428dec7b135f55767.dip0.t-ipconnect.de. [2003:f6:5f47:db04:28de:c7b1:35f5:5767])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48febe794e7sm101611265e9.30.2026.05.19.02.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 02:38:13 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] eeprom: at24: Use named initializers for arrays of i2c_device_data
Date: Tue, 19 May 2026 11:38:05 +0200
Message-ID: <20260519093806.1567914-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5487; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=qRRQXp0U6iWJ6fRxiYMVSIZ4g1MrQM/QNV99ICd0FUA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqDC9+ilqg6HFqf2Af1WyMWKAaYdX5nvQmuxdEY hqtqK4lU9qJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagwvfgAKCRCPgPtYfRL+ TrMOB/0e8DkeZNN+c3X8MebNVJdfcA0IMlTqGfpzOlY+Pl0HC619Mw4MvSHk3QY7u0Eh1vPlp5x ex3rx0FEqpJXekYbA9HR4Ue/BDCuVr9TQXRYKRbjGD0/VUho8P4qDLXDXj6BbqdFlB1fb/eZu7b kmZHo5VbR6HWU7758dxM2iGEzl/bZvyAnqe7kyENvuUgwJvmktA7nOU7MtmGWmT579ApMAuLy97 FZEMa8yJWSMogz0ADXUNhk4GWOnN8WMn3rFn9sf6w501Zb9SVfMhVRTBtRWkVKUHyS7gxgjnqGR D5X4WWQouEH/ai1wD5B3h1quiHak3WEHrC4sPt6GIfk74JZ3
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

The mentioned robustness is relevant for a planned change to struct
i2c_device_id that replaces .driver_data by an anonymous union.

This patch doesn't modify the compiled array, only its representation
in source form benefits. The former was confirmed with x86 and arm64
builds.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

this patch was split from
https://lore.kernel.org/linux-kernel/20260515162734.469327-2-u.kleine-koenig@baylibre.com
on Bartosz's request. I'm not sure if still more should be split out, so
I'm not resending the remaining patch yet.

Best regards
Uwe

 drivers/misc/eeprom/at24.c | 62 +++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 0200288d3a7a..5d5f357a1996 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -215,37 +215,37 @@ AT24_CHIP_DATA(at24_data_24c2048, 2097152 / 8, AT24_FLAG_ADDR16);
 AT24_CHIP_DATA(at24_data_INT3499, 8192 / 8, 0);
 
 static const struct i2c_device_id at24_ids[] = {
-	{ "24c00",	(kernel_ulong_t)&at24_data_24c00 },
-	{ "24c01",	(kernel_ulong_t)&at24_data_24c01 },
-	{ "24cs01",	(kernel_ulong_t)&at24_data_24cs01 },
-	{ "24c02",	(kernel_ulong_t)&at24_data_24c02 },
-	{ "24cs02",	(kernel_ulong_t)&at24_data_24cs02 },
-	{ "24mac402",	(kernel_ulong_t)&at24_data_24mac402 },
-	{ "24mac602",	(kernel_ulong_t)&at24_data_24mac602 },
-	{ "24aa025e48",	(kernel_ulong_t)&at24_data_24aa025e48 },
-	{ "24aa025e64",	(kernel_ulong_t)&at24_data_24aa025e64 },
-	{ "spd",	(kernel_ulong_t)&at24_data_spd },
-	{ "24c02-vaio",	(kernel_ulong_t)&at24_data_24c02_vaio },
-	{ "24c04",	(kernel_ulong_t)&at24_data_24c04 },
-	{ "24cs04",	(kernel_ulong_t)&at24_data_24cs04 },
-	{ "24c08",	(kernel_ulong_t)&at24_data_24c08 },
-	{ "24cs08",	(kernel_ulong_t)&at24_data_24cs08 },
-	{ "24c16",	(kernel_ulong_t)&at24_data_24c16 },
-	{ "24cs16",	(kernel_ulong_t)&at24_data_24cs16 },
-	{ "24c32",	(kernel_ulong_t)&at24_data_24c32 },
-	{ "24c32d-wl",	(kernel_ulong_t)&at24_data_24c32d_wlp },
-	{ "24cs32",	(kernel_ulong_t)&at24_data_24cs32 },
-	{ "24c64",	(kernel_ulong_t)&at24_data_24c64 },
-	{ "24c64-wl",	(kernel_ulong_t)&at24_data_24c64d_wlp },
-	{ "24cs64",	(kernel_ulong_t)&at24_data_24cs64 },
-	{ "24c128",	(kernel_ulong_t)&at24_data_24c128 },
-	{ "24c256",	(kernel_ulong_t)&at24_data_24c256 },
-	{ "24256e-wl",	(kernel_ulong_t)&at24_data_24256e_wlp },
-	{ "24c512",	(kernel_ulong_t)&at24_data_24c512 },
-	{ "24c1024",	(kernel_ulong_t)&at24_data_24c1024 },
-	{ "24c1025",	(kernel_ulong_t)&at24_data_24c1025 },
-	{ "24c2048",    (kernel_ulong_t)&at24_data_24c2048 },
-	{ "at24",	0 },
+	{ .name = "24c00",	.driver_data = (kernel_ulong_t)&at24_data_24c00 },
+	{ .name = "24c01",	.driver_data = (kernel_ulong_t)&at24_data_24c01 },
+	{ .name = "24cs01",	.driver_data = (kernel_ulong_t)&at24_data_24cs01 },
+	{ .name = "24c02",	.driver_data = (kernel_ulong_t)&at24_data_24c02 },
+	{ .name = "24cs02",	.driver_data = (kernel_ulong_t)&at24_data_24cs02 },
+	{ .name = "24mac402",	.driver_data = (kernel_ulong_t)&at24_data_24mac402 },
+	{ .name = "24mac602",	.driver_data = (kernel_ulong_t)&at24_data_24mac602 },
+	{ .name = "24aa025e48",	.driver_data = (kernel_ulong_t)&at24_data_24aa025e48 },
+	{ .name = "24aa025e64",	.driver_data = (kernel_ulong_t)&at24_data_24aa025e64 },
+	{ .name = "spd",	.driver_data = (kernel_ulong_t)&at24_data_spd },
+	{ .name = "24c02-vaio",	.driver_data = (kernel_ulong_t)&at24_data_24c02_vaio },
+	{ .name = "24c04",	.driver_data = (kernel_ulong_t)&at24_data_24c04 },
+	{ .name = "24cs04",	.driver_data = (kernel_ulong_t)&at24_data_24cs04 },
+	{ .name = "24c08",	.driver_data = (kernel_ulong_t)&at24_data_24c08 },
+	{ .name = "24cs08",	.driver_data = (kernel_ulong_t)&at24_data_24cs08 },
+	{ .name = "24c16",	.driver_data = (kernel_ulong_t)&at24_data_24c16 },
+	{ .name = "24cs16",	.driver_data = (kernel_ulong_t)&at24_data_24cs16 },
+	{ .name = "24c32",	.driver_data = (kernel_ulong_t)&at24_data_24c32 },
+	{ .name = "24c32d-wl",	.driver_data = (kernel_ulong_t)&at24_data_24c32d_wlp },
+	{ .name = "24cs32",	.driver_data = (kernel_ulong_t)&at24_data_24cs32 },
+	{ .name = "24c64",	.driver_data = (kernel_ulong_t)&at24_data_24c64 },
+	{ .name = "24c64-wl",	.driver_data = (kernel_ulong_t)&at24_data_24c64d_wlp },
+	{ .name = "24cs64",	.driver_data = (kernel_ulong_t)&at24_data_24cs64 },
+	{ .name = "24c128",	.driver_data = (kernel_ulong_t)&at24_data_24c128 },
+	{ .name = "24c256",	.driver_data = (kernel_ulong_t)&at24_data_24c256 },
+	{ .name = "24256e-wl",	.driver_data = (kernel_ulong_t)&at24_data_24256e_wlp },
+	{ .name = "24c512",	.driver_data = (kernel_ulong_t)&at24_data_24c512 },
+	{ .name = "24c1024",	.driver_data = (kernel_ulong_t)&at24_data_24c1024 },
+	{ .name = "24c1025",	.driver_data = (kernel_ulong_t)&at24_data_24c1025 },
+	{ .name = "24c2048",	.driver_data = (kernel_ulong_t)&at24_data_24c2048 },
+	{ .name = "at24",	.driver_data = 0 },
 	{ /* END OF LIST */ }
 };
 MODULE_DEVICE_TABLE(i2c, at24_ids);

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

