Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724577;
	b=IXg/R74Fz20UvORKsPty9i831Yxd3X677SqMX8I7ZjclLLvetMTlO65hyiq0s8Br4htp
	 EjdzSpGgbRHH2Rfzs423Pyn6lnrr2pSTywmKgUP5DPeNSkL5cPbW5zNEcBbhC+3O7dsAd
	 s7YIE7lOVg+klwKexTWU9d0IFF7nqykU+N7/RY4yxthNlnEyubg4gQYISAq2QN0YoJiJc
	 Ym46TOLniULDJydtfp+NzvT46J0nebni5vpj01rMX0Gx7vWPrqwmfMdGnZ1XjkvrsF5DS
	 hWex97ccllGJkNdIh2habx8Zwq70n0ey/nIeMdsWS9TvpeysEs6pFBPYxxgrf0nu+sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724577;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=RnwW8JdB5UARoPhC4AEKlAEss5f849c5oZKwccCMzBk=;
	b=i+wLQuMLImRk3ZXmdTPhAOMa42w49kOI4GfP8/4J2Ne7y1gx/dX8nlWTHpuvkhD+Nt1z
	 dj4mOACIU6XRrq+9Qv7uXVOeBGiSk3vCg8XiMKpqTcJF+vYmt6TaLqfCPBeGTe6y/rXZr
	 P+XML1biPCtICV4Yt6oPgbhMHj3JYcXqc4z3XuulxTn/R+VZfFlUpmUujox4ZCNO4T+lJ
	 3XFPbnIoDM2oY5dHY8NpQDHxMRGN12E6aSC6uDt2bJ/wHrq9IrEQkO2NPH5chh0e2LRc6
	 mmrx1VKUH1ZHHZg4k6g7GsIkOxU2SWaERLxD/6+Iuc3klp6Zzswg9xUkiHOGupWUD6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=JN+hHvHV;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3516D606EEA6
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 16:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3516D606EEA6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=JN+hHvHV
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E7F761A143C;
	Tue,  3 Nov 2026 16:49:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B710B6046C;
	Tue,  3 Nov 2026 16:49:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8A341103291A7;
	Tue,  3 Nov 2026 17:49:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793724574; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RnwW8JdB5UARoPhC4AEKlAEss5f849c5oZKwccCMzBk=;
	b=JN+hHvHV6NeIkR3aHisLPynZGqzNnHCsTUAotoMWobbtn4WsPQMM2j9K/07Ri19Pp/KdcU
	3cFQNNBy+T6GwnX78eBIazG+MGHFVAUzgLQxIH2VjfEFNqxDp+SHDHRcq4ScalSfLKiGTo
	EFnX7IG6i0M5LSWrQHRaSByngx0i+GGjpKRqbu3+2jSdhkrSkkwOUsdp0xOhsE85/a8Woc
	zBZ4iTh0g0nV/L3AyMVNo9XWnSIK1m47KbpWapSz5K7800mgBhR9BEe11ZXmYrTc/sJiN3
	ydShOXZw2eUigtZQmB0CKIYdAItJ4qpBqecGUIIJbhUTIAwtj5eNBuViyEFqlg==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Tue, 03 Nov 2026 17:49:15 +0100
Subject: [PATCH v5 7/9] mfd: cgbc: Add virtual I2C bus support
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
Message-Id: <20261103-cgbc-i2c-storage-devices-support-v5-7-ac11f23fae51@bootlin.com>
References: <20261103-cgbc-i2c-storage-devices-support-v5-0-ac11f23fae51@bootlin.com>
In-Reply-To: <20261103-cgbc-i2c-storage-devices-support-v5-0-ac11f23fae51@bootlin.com>
To: Lee Jones <lee@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

Internally the Board Controller has a virtual I2C bus with some virtual
storage devices (EEPROM and RAM). So add a new I2C cell for this I2C
virtual bus.

Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
---
 drivers/mfd/cgbc-core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
index 7f512b4f07f7..e0d9939d8c0d 100644
--- a/drivers/mfd/cgbc-core.c
+++ b/drivers/mfd/cgbc-core.c
@@ -65,6 +65,12 @@ static const struct cgbc_i2c_platform_data cgbc_i2c_ddc0_pdata = {
 	.cgbc_bus_id = 4,
 };
 
+static const struct cgbc_i2c_platform_data cgbc_i2c_i2cv_pdata = {
+	.name  = "cgbc-i2cv",
+	.cgbc_bus_id = 3,
+	.fixed_freq = true,
+};
+
 static const struct mfd_cell cgbc_devs[] = {
 	MFD_CELL_NAME("cgbc-backlight"),
 	MFD_CELL_NAME("cgbc-gpio"),
@@ -79,6 +85,11 @@ static const struct mfd_cell cgbc_devs[] = {
 		.platform_data = &cgbc_i2c_ddc0_pdata,
 		.pdata_size = sizeof(cgbc_i2c_ddc0_pdata),
 	},
+	{
+		.name = "cgbc-i2c",
+		.platform_data = &cgbc_i2c_i2cv_pdata,
+		.pdata_size = sizeof(cgbc_i2c_i2cv_pdata),
+	},
 	MFD_CELL_NAME("cgbc-wdt"),
 };
 

-- 
2.53.0

