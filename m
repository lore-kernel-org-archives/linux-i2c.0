Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F0044CAD3
	for <linux-i2c@vger.kernel.org>; Wed, 27 May 2026 17:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901826; cv=none; b=Tnae2oOLs6uDWKnPZJR4jxMku/glyHpdqtnrMQcnd4S341xQLYT47FtyftOldRY8rgedqw+EyuHt3vqx9wDELM8fCAhLOgBLjD1XeOIuce0r5iZgON7QkOxpGjjWOV9j8mbXDVYk04GeMViNPs7oiBA+5G5ded91MkVDcSgT5JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901826; c=relaxed/simple;
	bh=OTFZL7/TKZtiOSLDKU/FWj1OgAlmrOFX67f30aNa7r0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WVaDIayLT6LmXzuFN75SluSI3ctLdGeQbmdo9u2IjUW6fx3jbqFyP1wMAVNNI411KCVlKJDf9mIrvxK3ztWroVSdJCBbP3t1I65JXcRMRKaN/B8fPYPcF3SwL/5bUYkb7UVyDqVRNQEG7puzR6PPphz1XOua8gG54tu8OtaSTV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=plrBcIbi; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="plrBcIbi"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36abfe17c11so3883112a91.0
        for <linux-i2c@vger.kernel.org>; Wed, 27 May 2026 10:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779901825; x=1780506625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dr1Vh7T1FjGx+SxxnwuCbG7AIOfy8FpD/4EKhw7fhLY=;
        b=plrBcIbi+ylyzM5+XaWlncpaFJjRG1FUOFciKDX5xXrcy9eYcf2IpQl0gIEYxaZrJ0
         PaGwkPN2ogqd76QpsTCqlKKGV3Gl68gsR00BU+tiRB3m/JxGcPgr0Hl0gZ0BNxxgkdgh
         IxTzdEliHhRRJL4qAmGrWfPpuqTxZ1aTnnAgYC1aHUeTZHYEm8GAJks0gkLo/yJUnuRj
         4TdAZH+5+Z5hZOE2LhKpgpawavu9BAdmURr5FUr3tDgNRXFNRzjI5CLunuBcNwS1Dh/3
         M2immbls4/KVlPUfth0Lp29drnYIfQsNT3DXuY3zuQ+iFNC8MITCHuN9C9IhHdpBRBfS
         1UBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779901825; x=1780506625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dr1Vh7T1FjGx+SxxnwuCbG7AIOfy8FpD/4EKhw7fhLY=;
        b=iIP/zHUqhg95wFJBplTVDSPSWc4jXqmtAp81eK5atqfHo1+KxPD7ZIpNozEk5eKwVg
         febG3klQZWus66cuf24KS8OTSwQ40QBmPg2cRuwk40aJrmEZ/PnH4TV7xjvPuVIklSEb
         6c7/Dn+jF3mA/iW2zQieqv4pyAQxvvSYiRWLa+hfCgWcQXd05Td49f0Z2nEOsWyG38fQ
         UPeMGYD/eNLHu1a6ycJuFhoGj01lar+sNEkLvr3TWsiJpGuhn6RERB8UrA0a9TuSgmoS
         6vMySNCrxYSx2oBKDYcVyfd/AvKdzoapZ2eKmSA+TM85XvdVHr8dML59W87Rse6ztClX
         Y8yw==
X-Forwarded-Encrypted: i=1; AFNElJ+QbYWzf/COvwSzXFtOHE6JuiDqOOkwIRb3cNjxGJPSfev6A2QQVMvO7IMYVfBaPQnveCU/E92OCZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlFQENanuNR2Pf/kLhXWiYjZtWHWoKVsZehGbSYa4mRJdNWziM
	yX8aA4RSs7SKXuzhPmtF3AOw/2hQC0K6ms2IW9R27JCr9WnC+HzvcIja
X-Gm-Gg: Acq92OGj1EtfMLCaUJ0+IAg22V1Xje/gng3NkfTy3iDrgmKt8vXYY3dm3qnllfiKQPV
	uV1U0FM7V9CrPGeCpDsUkUB5gWV9QWyZTnqgK9cIoLMjQxufPZfTDvxJaq9whTgR8sCmCjWnBF8
	gyuYbIxRO0xuCkBSO2YncrsEBMxarQnGhCet0A7G61iu/MOX73VIfvBSJH5FRJY24DI6V+KfSZb
	To6m+m2IGJ7Q2iLGWdZIq1AwM9cB/fg5qCBDxR4z0QN/NqrKI1emVkSNB4dqvMxit1KFXrsud+o
	y2y+dQBevSOdHrMYNJBIS2lwAf1vmTc357VJJqDicXwC8XvnBze5USrgjOpgo22co2AwH619mnP
	D+n4wGlM/wnCssFbA4J30VWwu040aMfWcyeM2VyvfCuTuVCDYFW272fel305C6fGjkISrZeYTZ0
	gGcsBeEeD80rZ4jJOuzuxgW33fmwj44h0XAg==
X-Received: by 2002:a17:903:3848:b0:2bd:8fc0:1198 with SMTP id d9443c01a7336-2beb0633629mr262545435ad.5.1779901824674;
        Wed, 27 May 2026 10:10:24 -0700 (PDT)
Received: from ubuntu2204.. ([240e:39b:ee1:f550:f34d:9da7:5be3:2198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5900b8bsm155788875ad.76.2026.05.27.10.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:10:24 -0700 (PDT)
From: Liem <liem16213@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org
Cc: kernel@pengutronix.de,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Liem <liem16213@gmail.com>
Subject: [PATCH] i2c: imx: Switch to new reg_target/unreg_target callbacks
Date: Thu, 28 May 2026 01:10:16 +0800
Message-Id: <20260527171016.67020-1-liem16213@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reg_slave and unreg_slave members of i2c_algorithm are deprecated
and will be removed. The i.MX I2C driver still uses the old names for
both the struct members and the callback implementations.

Switch to the new reg_target and unreg_target members, and rename the
corresponding callback functions from reg_slave/unreg_slave to
reg_target/unreg_target. This aligns the driver with the ongoing
terminology migration in the I2C subsystem and avoids future build
issues.

Signed-off-by: Liem <liem16213@gmail.com>
---
 drivers/i2c/busses/i2c-imx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index a208fefd3c3b..c9ecca3ef580 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -922,7 +922,7 @@ static void i2c_imx_slave_init(struct imx_i2c_struct *i2c_imx)
 	i2c_imx_enable_bus_idle(i2c_imx);
 }
 
-static int i2c_imx_reg_slave(struct i2c_client *client)
+static int i2c_imx_reg_target(struct i2c_client *client)
 {
 	struct imx_i2c_struct *i2c_imx = i2c_get_adapdata(client->adapter);
 	int ret;
@@ -945,7 +945,7 @@ static int i2c_imx_reg_slave(struct i2c_client *client)
 	return 0;
 }
 
-static int i2c_imx_unreg_slave(struct i2c_client *client)
+static int i2c_imx_unreg_target(struct i2c_client *client)
 {
 	struct imx_i2c_struct *i2c_imx = i2c_get_adapdata(client->adapter);
 	int ret;
@@ -1704,8 +1704,8 @@ static const struct i2c_algorithm i2c_imx_algo = {
 	.xfer = i2c_imx_xfer,
 	.xfer_atomic = i2c_imx_xfer_atomic,
 	.functionality = i2c_imx_func,
-	.reg_slave = i2c_imx_reg_slave,
-	.unreg_slave = i2c_imx_unreg_slave,
+	.reg_target = i2c_imx_reg_target,
+	.unreg_target = i2c_imx_unreg_target,
 };
 
 static int i2c_imx_probe(struct platform_device *pdev)
-- 
2.34.1

