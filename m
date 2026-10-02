Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F47E471CF8
	for <linux-i2c@vger.kernel.org>; Fri,  2 Oct 2026 11:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939604; cv=none; b=W5Shn1CYyAMzYvRJCVQV2qXZbTWsbE2wzzkvvEn3W/tSM8+Ui6SIGHNFo6POq0xUmdsXU6nUJEJ3tNyIL29zWVGQhUrQWGEFsT0U+xeiVDSBAzyO1fAdGwsLF79aJ8oURAlS8roj6WU54kQx74aSM/L4i0S5DY5MSDIaDw0fnkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939604; c=relaxed/simple;
	bh=CZB3d0s8HmbvAL72GW3/vb8pl2fL+6surwRCRWIIfLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eMcJGJ31hOHFlKap8Vp4GCaZaKoLL9CQhqcLdHE6JwgV/QJO/RAOsvHAUZgQhC27/q/KJXzinnnhR1UjtlFsaiSvd+TpnmHYkoPBqYQzc8iPJWBlcEXLyL8YpdL4FWvKlxO4xNk8YbRwZRiRTWnpBcNnwAE98kZSR8VMYoOflC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q90URqVZ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q90URqVZ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2FA2C4E40645;
	Fri,  2 Oct 2026 11:13:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0446B603DC;
	Fri,  2 Oct 2026 11:13:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4ACC2103283A3;
	Fri,  2 Oct 2026 13:13:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790939596; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RdZUJWCKS/E8WmCsMaCgktDd/chgEj6kYxTDM4icMwU=;
	b=Q90URqVZ1jdi8rwkY66jAhEPTqJXhqJO7MmKZ9m3p9+QOGOyB/VbJ7xZFtxg5cf1cZjIeA
	scHqxaoKWG+YWNduAR9pmgbO9F9+fJJIqHFhiwmvsoQrG4/s7sJir+J9cwLtrXqWtjWTIF
	5bEO5J4VKrN32n7oyc4SfCUjhxi2uBZ6dTAg8fPv8CSyvKWjfNfmdTysDsYO7x6++Wdb7S
	K+72EjCFs2TndPXpv7QXXcfFoEl/82AfZS3j6stIyppgLFsWM9pkQbOUoT7mpR8SJ9XI1e
	yOgTUN+CnNazic94NZ1DOeg0Upc/zEQS+iRKF42fBo1wcHKZVESuJMRg3EH+yw==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Fri, 02 Oct 2026 13:12:42 +0200
Subject: [PATCH v4 4/9] mfd: cgbc: Use PLATFORM_DEVID_AUTO for child device
 registration
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-cgbc-i2c-storage-devices-support-v4-4-eb42e0f1df59@bootlin.com>
References: <20261002-cgbc-i2c-storage-devices-support-v4-0-eb42e0f1df59@bootlin.com>
In-Reply-To: <20261002-cgbc-i2c-storage-devices-support-v4-0-eb42e0f1df59@bootlin.com>
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
index 0cd9e6f888cb..8522df882509 100644
--- a/drivers/mfd/cgbc-core.c
+++ b/drivers/mfd/cgbc-core.c
@@ -71,13 +71,11 @@ static const struct mfd_cell cgbc_devs[] = {
 	MFD_CELL_NAME("cgbc-hwmon"),
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
@@ -349,8 +347,8 @@ static int cgbc_init_device(struct cgbc_device_data *cgbc)
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

