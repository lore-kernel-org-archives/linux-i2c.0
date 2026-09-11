Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7013DAACE
	for <linux-i2c@vger.kernel.org>; Fri, 11 Sep 2026 18:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152543; cv=none; b=CJuHLZyLZNAnvrGrNVbzSTCpDHc36kui+sb3WdusE9QNM+pnuZRMtpSqMkaqdoRASvERrve79zhWa6mNV2tiAM324L4em+p5ZaVVlD0GReHG5z4cRaV1p/qqmEiAUBb9iGNvCj563fJZS8TmPyVK3YQbf1cjfNbK2EyYm00HNXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152543; c=relaxed/simple;
	bh=18qWW3RTW3gbNpD6yD1sScGuT7/roe5IdWoYPFCAUY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H5hE1yh+wOedElNlr0hBnKx4utBc2iSUQVJy7zoK5o86fIPvkSuovOz2Vypo6z+4Vm1IQJuEKH/itLP/tlzp0Pf/UuDItqN6FpL2dqBJy14+KBBLTrEWMz6cmMRRhbmf38QFMB8nExFr9tC4P1PAxCItMalHoMH+ZZQmgWBWvp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hCYWr3eS; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hCYWr3eS"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 79C074E401F3;
	Fri, 11 Sep 2026 18:48:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4F545606CC;
	Fri, 11 Sep 2026 18:48:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EDC7F11C7AFAD;
	Fri, 11 Sep 2026 20:48:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789152538; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MpKgVlL6pZuspcUVghBf8UNZYhdMFqssWfvyazmQE/U=;
	b=hCYWr3eSsK4T81GNMJ+bCMZUMEcQfelUUqbljgxpTwnOEHcRV8K0IZum56Sz4L1C3Sg7H+
	uppghw/xOoePbref0Kx4YeMDYxYvOwZRn5xS3PAn+KlZ6gHGTBzPbqaATOYzsRj2tRqnYf
	u/cHPWVF9iU6UrbYRRQwdwFEoIdFh1f2W4bDIRhn9CFKkhJsrAAMkLHu8dxd/kW9+PmCnv
	lmJI7+CcdpQYItjxBN4m+HSd5nNYgWljdm0A9EX/Y/2ZN4T8gXZeBIKksnC0K9VZ156F/x
	CcI5X43x4gc7qF4yniAyPwDSh85ViV0pNLvYDHsssejqPsMbrO8A5DOjQTgayw==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Fri, 11 Sep 2026 20:48:06 +0200
Subject: [PATCH v3 4/9] mfd: cgbc: Use PLATFORM_DEVID_AUTO for child device
 registration
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-cgbc-i2c-storage-devices-support-v3-4-594b53fbc5ea@bootlin.com>
References: <20260911-cgbc-i2c-storage-devices-support-v3-0-594b53fbc5ea@bootlin.com>
In-Reply-To: <20260911-cgbc-i2c-storage-devices-support-v3-0-594b53fbc5ea@bootlin.com>
To: Lee Jones <lee@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

Since parameters are now passed to the i2c-cgbc driver via platform
data, the I2C driver no longer depends on the platform device ID to probe
the correct I2C buses. Drop the hardcoded cell ID in favor of
PLATFORM_DEVID_AUTO.

Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
---
 drivers/mfd/cgbc-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
index 321fa3fff2ac..bb26b358da26 100644
--- a/drivers/mfd/cgbc-core.c
+++ b/drivers/mfd/cgbc-core.c
@@ -72,13 +72,11 @@ static const struct mfd_cell cgbc_devs[] = {
 	{ .name = "cgbc-hwmon" },
 	{
 		.name = "cgbc-i2c",
-		.id = 1,
 		.platform_data = &cgbc_i2c_gp_pdata,
 		.pdata_size = sizeof(cgbc_i2c_gp_pdata),
 	},
 	{
 		.name = "cgbc-i2c",
-		.id = 2,
 		.platform_data = &cgbc_i2c_pm_pdata,
 		.pdata_size = sizeof(cgbc_i2c_pm_pdata),
 	},
@@ -350,8 +348,8 @@ static int cgbc_init_device(struct cgbc_device_data *cgbc)
 	if (ret)
 		goto release_session;
 
-	ret = mfd_add_devices(cgbc->dev, -1, cgbc_devs, ARRAY_SIZE(cgbc_devs),
-			      NULL, 0, NULL);
+	ret = mfd_add_devices(cgbc->dev, PLATFORM_DEVID_AUTO, cgbc_devs,
+			      ARRAY_SIZE(cgbc_devs), NULL, 0, NULL);
 	if (ret)
 		goto release_session;
 

-- 
2.53.0

