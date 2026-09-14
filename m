Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432D4403EA5
	for <linux-i2c@vger.kernel.org>; Mon, 14 Sep 2026 08:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376140; cv=none; b=jZdxrInbyjVW0vsi0/s1MEHJq+0LYpnH7FVrZy52oRI3aFAUCHUA0vPwIh0ZDQrSl8oTvmzfH9EEN+4l2xfJpUkWfU3Gb5msn3q5X4wONk308EcOsQut/4TdBLxFZInCoThdbytqG0Dy33yB5gnzUgol1IDptX4xwwMu+aCYYSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376140; c=relaxed/simple;
	bh=RvwfwsibcIKVeXocpg4YyIcnyvBRCDfLjxr1o0x/eoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dNUW4JeyCT6Qi71YN9uu03wCSwUL3qUQB49cAC4bIEGhFeuZUlEG6n2+zJzIfaARlcBWIMhgT60D4MCuHRReR0fG78lu4HmMlgsjYms+MurGN7THXsRS5reUVdWEUx7pjOarWFiiB0KHUBSWCzvFm93OmD+aiair3ETM9SfpzWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awJgfLgY; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awJgfLgY"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4ae2cso1810793a12.0
        for <linux-i2c@vger.kernel.org>; Mon, 14 Sep 2026 01:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789376133; x=1789980933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NHO8MqohSxSNmUhoqWgAJs04LZZgNjwjhI5rapZreFA=;
        b=awJgfLgYusmxP2DeGei/AKFb0VQklQzErtugbI8dZpAJgWOewxdNsSh4xYrK6OZxCi
         NA7RyH8IjkFQjW8rM8W1zEmFN/h8n5zjex/sPsSgp7OF6cVKhfSMgqACSuUQBRNaHJcg
         Y+Cq53rvvD0Hi84Sety6F+HiCJlzTxu/nqtkt6vXMQ673V6XzSKKK8pyAjYywuRZ0mwz
         gY/GwDZGcPGWeERfIYkU7SPIGICWZbwV4+S3dzaftpU89LfA/g7fZvxxUoggZb0ys59n
         EguyZkV7OuPJILWGCoX/OYuntOitzdwh23EaJvMPrgfKY1d61n8YbrgkusgBJ2Agnm1t
         4F4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789376133; x=1789980933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NHO8MqohSxSNmUhoqWgAJs04LZZgNjwjhI5rapZreFA=;
        b=LgGC/Eg2RXOL4xAb1Bi7YYb2eTDJTtos8vOLm3a4LNjxXU8F69J9Yn55dt+Kf2GF2b
         HuaVlyG9Qz4D7ds+cA0BC/REvPxuYdGpybjBnoWqMLFTW93W2PFg4Vrfzi5nObkvcZq8
         0bLcrBMDLeeqHNqDvg5kPH9n+WAk5391XBTLxAQXqP26gxvKazxP4VlcLkY0B3zdQ+cY
         lbJCXiEqJtapIQTVZd06HGy2f6WPtBeKrpmNgo3GGx4BoxlLTUNyR2QwEXPjQ0QXNFr5
         YzOtr25C7aFxqeYY+0QHZM26NFSG2zDsPfT/z5mMAqhrAD8Oy+oXOIgscnWZSqvmIXsQ
         lA9g==
X-Forwarded-Encrypted: i=1; AKwUvBxTWQxzar1y+KbaVYNuPOWtFn8GRrH0Z4EI2E6AnwzxwdjQU7wPWBd0NxB0If+IhgnrF0CLQdqGerQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nhmVgYIsaN5smHK8HtlUDFssamf0yDjBgKnNHezWftxwrMXn8W
	KMbDJbqYmaRhh7cc9odWR+itzEbrHTcyX8Kr9Q4102fWh2K1g0m7BwmI
X-Gm-Gg: AYBFou1S7vo8sD3GuVwtq/JwgCjGfcHSbNWDn21rxUkMGzsbyQGjkApO+q1J0oSHDy/
	++RlPU3rDQYp61Wx3nUwW+zwFk/hjM4PqMv4ZBUkJZYv9vRRBfauY0s65xfDVumZ7++/mhZdcIM
	oGwavitKID4b9FIGoDnk6sdJFPmTI4e40RLA8w77n+CLHzm9WJHH41x2ev/ATJupV+KC5g+epsZ
	Sc+4p7oN7lg45lwmcY7W7zDtrLqdn0aU65TKtZonrKVnmPOwl/Ab+RV8LxHOTjLZow+1AeBBqIx
	xc0OtrdLLDW636BcFZWhbiH0ublQg+KMN0ycu4TEBWoUjxN9T2tCDGqgEH88TPoDi84suzl+0/S
	vkWOQswCD6EG2GfjPWg6BXm7qvpxNq69O2120xiTl9JOwFMHxNuC8eeoAv5kAF9MwEIYMT3kXEz
	GcloySS0cYOy/rRZHYtozmDfUMu9lEr/TCL/GLxRnJmd0oxe3Ek2OwoQ==
X-Received: by 2002:a17:90b:1dc6:b0:39d:84af:a0b3 with SMTP id 98e67ed59e1d1-39dec09cf6dmr3712915a91.18.1789376133103;
        Mon, 14 Sep 2026 01:55:33 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d9d7ff2c5sm4885197a91.2.2026.09.14.01.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 01:55:31 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Ed Blake <ed.blake@sondrel.com>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: img-scb: disable autosuspend on remove
Date: Mon, 14 Sep 2026 16:55:19 +0800
Message-ID: <20260914085519.1665498-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

img_i2c_probe() enables runtime PM autosuspend with
pm_runtime_use_autosuspend(). The probe error path correctly undoes
this setting with pm_runtime_dont_use_autosuspend(), but the normal
remove path only disables runtime PM and leaves autosuspend enabled.

The runtime PM API requires pm_runtime_use_autosuspend() to be undone
with pm_runtime_dont_use_autosuspend() at driver exit unless runtime PM
was enabled with devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() call to the remove
path so that the runtime PM state is fully restored when the driver is
unbound.

This issue was found by manual code inspection.

Fixes: 93222bd9b966 ("i2c: img-scb: Add runtime PM")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/i2c/busses/i2c-img-scb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 88192c25c44c..9cfa403cda8e 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -1415,6 +1415,7 @@ static void img_i2c_remove(struct platform_device *dev)
 	pm_runtime_disable(&dev->dev);
 	if (!pm_runtime_status_suspended(&dev->dev))
 		img_i2c_runtime_suspend(&dev->dev);
+	pm_runtime_dont_use_autosuspend(&dev->dev);
 }
 
 static int img_i2c_runtime_suspend(struct device *dev)
-- 
2.43.0

