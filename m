Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794908881;
	b=xsZI9mCESjy3qDBcakWRGBMzflh0sCyZZoeaTKqFb3Sa9qFvf1TCBE2b6s4UElWsy+fb
	 Q7IvAnXKyjslrn1l9N7pSyphtbsmw4fTTfjvo3fQvgaLfkFPsykmKfcPCL6b3W/+2AGbZ
	 tWfugS8eqz/y4KSgbFe9y6DZ7GqK9IYyrI8P8p1uDWVXJWgUO/rBVpDzMIiGkPv4AXVLU
	 1nAXcmiDZXNwkyUlu9QwWJvamql9SVTTtRZHSgBvfy7j1CyEmuH2AgI0EunQXOJWQC+9q
	 5JiGP5xbfIBrM0Lk1VesfJBfNQtZTFqUB3M+45tWLAklzQnCGMSIGaWczT3vu2bs9MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794908881;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=+AsUTeuDtoqWFfTi16/5lRvZw+5Sfn1TyWGKEkc3fRc=;
	b=0qk1JfEH6smZsKUZ3EgJKijl39G4p2+bI3cCJ7haexvMLutWmtyIoGpoet7cGHV3WznU
	 gQ2KfGAv/+WrEG88jyDZY9b+ifZkNkP5L2d3Wj+wQVXtiboXTsoGJFUrrbkwBw5W8VXMU
	 L2Vfli7kcrAOC2qyjAX5RGCcnA/dyKVPCPjwijUm+s/43igRjvCGMTHrCGq/oeHZ8Kywo
	 8IWEkFeB2K7KzADCN9ci7ED7nIbAiXmvk7VFbMFYBhjNQROMUO02sLyvhahxnGQJfttAo
	 /wqhA60jt1mL/zG0tIQOcg2SNjFpXh7esC47nsFj1JC4QUoV4lGl8utJoUaicPrYiMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ptIgS0jc;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458DE606A336
	for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 09:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 458DE606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ptIgS0jc
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2A5AA1A158C;
	Tue, 17 Nov 2026 09:48:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F36D85FC81;
	Tue, 17 Nov 2026 09:47:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0ECB211BC0C04;
	Tue, 17 Nov 2026 10:47:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794908879; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+AsUTeuDtoqWFfTi16/5lRvZw+5Sfn1TyWGKEkc3fRc=;
	b=ptIgS0jcmqIyGSMWrcy5rS3wdqOa40UL7QImnlMt41o5yVXtB+OmcmM6f+VvJbnX6nf7H2
	UB74E1aV+tmZaw8niSi/pyOUYBpXqpNS/jjSH/fr5jh5S7xsDyWfwMc8XPpy0IqbHNFuey
	RY1SvvZCvdByzCa+gzSq4iGhQTA/SKo50dIW7D/k2isc4TkzTtfuOA3HNx5t2+Wu4X1zNM
	8d4EzSiPwimg1t2i4fo82zTkxx3JtWSyDJX3uhdrk3qYVPATcOHzglJlCWgbeUuBw8Y1Ua
	Yg7xneWITZ1R17SWj2XVXuRP17k6ZrGafh0V+936w6DdXYavZAXNyDB2DQmuLg==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Tue, 17 Nov 2026 10:47:46 +0100
Subject: [PATCH v6 06/10] mfd: cgbc: Use PLATFORM_DEVID_AUTO for child
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
Message-Id: <20261117-cgbc-i2c-storage-devices-support-v6-6-bb070ad3e9aa@bootlin.com>
References: <20261117-cgbc-i2c-storage-devices-support-v6-0-bb070ad3e9aa@bootlin.com>
In-Reply-To: <20261117-cgbc-i2c-storage-devices-support-v6-0-bb070ad3e9aa@bootlin.com>
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

