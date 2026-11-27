Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795802316;
	b=Mo+gbqArt4T7WEKlOrbmE01WwnbnQ4cXr6lZynkHu1PSB19bubTVl2t57Pq3eMxy5NCv
	 4nCvZVlOC4/RYtq20HEOZAwiBVyg0ziwGO8/6liebPw/fy5ALOpIqm7ppvD1ziWt1ANzn
	 FSRRzTeaUokrIV2GoaE/D2sRqgYQu426GAQZ5vp91Srw2qFtp8Lb4u8XsR2y6JDEr+e0s
	 HPOX0b3ukYIl3sChXNZ4uxNR1OJDKXA2uy57oaOwHyHDP4gY8KlEqIHphfEyufcZInQ1B
	 LIfIhl8U1+zRtVUBa01w0xkJ8YKbmpHqbB4VImV8d8YldNzMj6SUHu3EEDDSQgHa0Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795802316;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=+AsUTeuDtoqWFfTi16/5lRvZw+5Sfn1TyWGKEkc3fRc=;
	b=BiwtFx033gwHfr28CRlSGOkrYjoIcV7+mixYPYkKC1fRra2ythP/1/0WULTC1uAnGbnK
	 xRU2lnxSCLLzHx73KHLV66ZQ+c/EULGh705vYbeXk/WIqzo201yVAB3I0o2sQUrYoEiRB
	 KzXD2v7pkiPkJllBlD4yTv0Z6eUP0FfOT8+aGPWWz9RmBdoBlxK+aBLyYLLoegeBgLSIF
	 rSFd2XHhEugnfAEqcAsy2j2Wie0gSkMDpZ+zNiopmwErMELyaOd04vHOkxWaOZx0k9RI8
	 18E0YPzGglneIZZb7wQpUN+zgdesUzro9EjM87khfBa9ZuQ89MZzKJtCo4QgG8Y6m+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=BeqXkpqX;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A01606A32D
	for <linux-i2c@vger.kernel.org>; Fri, 27 Nov 2026 17:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29A01606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=BeqXkpqX
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7BAB14E417CB;
	Fri, 27 Nov 2026 17:58:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 49AF56049C;
	Fri, 27 Nov 2026 17:58:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F0D8B104395A8;
	Fri, 27 Nov 2026 18:58:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795802313; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+AsUTeuDtoqWFfTi16/5lRvZw+5Sfn1TyWGKEkc3fRc=;
	b=BeqXkpqXEGtyk2kFpN97HQ4lafiuUdXgLnybTU3tf0bGYGh0DD0N0dbzR2P7tXZ3NWBaKx
	0gbRs/FBPDb2E6GSYIVvQ6WYDAw0D38nIeeGVlHuSmdxuksjIKUdIxv28TDZpG64enkWIU
	VfFKSGu5nXUsNkUwDY4mAL5rnuMrGn3HuVbrvRD4A28epyL5PxnEZwUjvftOzyA1hRx0D1
	uQWn+R142P4jaA9OXd2DBbYiJ5m57zXfigDpE+/jrBS5FWnwzvydwFcTwfNfBSIxsgtzXu
	lp7PcBJ9Q2xlk00wdreHWOH2drxn4ePZyuY8PhxQgpHjKL8zoIvaaI8qFrXIaw==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Fri, 27 Nov 2026 18:57:50 +0100
Subject: [PATCH v7 06/11] mfd: cgbc: Use PLATFORM_DEVID_AUTO for child
 device registration
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-cgbc-i2c-storage-devices-support-v7-6-d0e70fc57879@bootlin.com>
References: <20261127-cgbc-i2c-storage-devices-support-v7-0-d0e70fc57879@bootlin.com>
In-Reply-To: <20261127-cgbc-i2c-storage-devices-support-v7-0-d0e70fc57879@bootlin.com>
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
index 6c1fbff323e6..dbd6a7539d8e 100644
--- a/drivers/mfd/cgbc-core.c
+++ b/drivers/mfd/cgbc-core.c
@@ -71,13 +71,11 @@ static const struct mfd_cell cgbc_devs[] = {
 	MFD_CELL_NAME("cgbc-hwmon"),
 	{
 		.name = "cgbc-i2c",
-		.id = 1,
 		.platform_data = &cgbc_i2c_i2c0_pdata,
 		.pdata_size = sizeof(cgbc_i2c_i2c0_pdata),
 	},
 	{
 		.name = "cgbc-i2c",
-		.id = 2,
 		.platform_data = &cgbc_i2c_ddc0_pdata,
 		.pdata_size = sizeof(cgbc_i2c_ddc0_pdata),
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

