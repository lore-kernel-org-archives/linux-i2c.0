Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795802309;
	b=PS1nsZtPA1D2e8/0VS+YGLKbvdCRDeQHVivlVVJpAVriSqpWJeSssnlVPvZVIhr8gd5x
	 4GAH7fVnsQmFJBcLj8D2N2TRFRWIDCXYGUIqOZEEbuYEFSt30ufF0Jnptm8LCcUe51eZ9
	 ubKOsQo7AnNR+z1KMm1mkD3afAG20Cup0c/n52l1PkuQ2CJk+meZ6IzV26H8u/221svpw
	 0IO+/Ib9lr75fN7OE79/MGIPajU0SXtpQyBhPXcIesSQTM/S3LN0xRstkW7sO0a9lCh5H
	 9CFcV+3SIOB27/OzcFK2dFO7OfMfSWdjS0OX4fR9E/h4WDco/4wpWFCXKHL6f2LJKvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795802309;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=Z5tNyvrsvWQDj36l9ZXx0fUEovQVfoABaDt4gVc+4AI=;
	b=rk2aQD4S5uh/0PKdTEj3DW0zJ8yLddfAsLIiD0tpGBGdjTjkgopsAvnlvoA3jVGOtxUk
	 CWcjxOJ3YnsTAcosedMjZyrTPe5F2SfXV/2u3Q3j88YuyLoJ90ZCxenp+o9ZtzslTmzzR
	 NEP+VjLaPkcopDLviJ0C2JB+swuhqzGgrmVDwCEmXhmqGy6N7xMOwb/VkffecRrj7kRva
	 Ugt0LIjLpEBVXqPDfjWHi33VPu2cRoD81vvunIofiDkK/3YedNWsABsz7WVFFYqCI7XTC
	 ApMy0iif98MTp/4IC45Pj5c0UDJJp3rmU3HDHj3hWLDLnKyZrQaTLQfkk9HYoaAWwmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=NZv0XSNq;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BCC606A327
	for <linux-i2c@vger.kernel.org>; Fri, 27 Nov 2026 17:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6BCC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=NZv0XSNq
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6B52B4E417CA
	for <linux-i2c@vger.kernel.org>; Fri, 27 Nov 2026 17:58:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 40C666049C;
	Fri, 27 Nov 2026 17:58:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BB639104395A8;
	Fri, 27 Nov 2026 18:58:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795802302; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Z5tNyvrsvWQDj36l9ZXx0fUEovQVfoABaDt4gVc+4AI=;
	b=NZv0XSNqC1IGGArwUlEv8FsgnbMRZ1S5NQZI6C4Spr0pWCJ/vAc2LSWeSTnCItE1VuiQxb
	/mE3F6QbqvCyrDDhRCzOhBHDvk+iwARunuTulgj87w/wh3QuwH9NstK4NCap5huo3xphEh
	9DZVEJjzz+mqsGG5/S0+U35zfffwnrrr/Lz9Yj74Lhjdg9619o6idkyQk7C3BMp7PIczYp
	v9VRDGnBOszMLnoVMruiisiCaG739J5NcJLwHK9HcirdfzxfnBOdDumMzEQKRjoq81lJ7P
	u0DlTCo5/H3dwWOh9ILxPExVUufvDj7pD8sbxZvd54jv/9O9nErBY6a1HwYT8w==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Fri, 27 Nov 2026 18:57:47 +0100
Subject: [PATCH v7 03/11] i2c: cgbc: Use real I2C bus names
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
Message-Id: <20261127-cgbc-i2c-storage-devices-support-v7-3-d0e70fc57879@bootlin.com>
References: <20261127-cgbc-i2c-storage-devices-support-v7-0-d0e70fc57879@bootlin.com>
In-Reply-To: <20261127-cgbc-i2c-storage-devices-support-v7-0-d0e70fc57879@bootlin.com>
To: Lee Jones <lee@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

The adapter names described the expected purpose of the buses ("General
Purpose I2C adapter", "Power Management I2C adapter") on conga-sa7 board
rather than their actual names on the Board Controller.

Rename them to the real bus names "cgbc-i2c0" and "cgbc-ddc0", matching
the naming used by Congatec.

Acked-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
---
 drivers/i2c/busses/i2c-cgbc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cgbc.c b/drivers/i2c/busses/i2c-cgbc.c
index dfdb9ffc6447..baf02bfe090c 100644
--- a/drivers/i2c/busses/i2c-cgbc.c
+++ b/drivers/i2c/busses/i2c-cgbc.c
@@ -358,7 +358,7 @@ static struct i2c_algo_cgbc_data cgbc_i2c_algo_data[] = {
 static const struct i2c_adapter cgbc_i2c_adapter[] = {
 	{
 		.owner		= THIS_MODULE,
-		.name		= "Congatec General Purpose I2C adapter",
+		.name		= "cgbc-i2c0",
 		.class		= I2C_CLASS_DEPRECATED,
 		.algo		= &cgbc_i2c_algorithm,
 		.algo_data	= &cgbc_i2c_algo_data[0],
@@ -366,7 +366,7 @@ static const struct i2c_adapter cgbc_i2c_adapter[] = {
 	},
 	{
 		.owner		= THIS_MODULE,
-		.name		= "Congatec Power Management I2C adapter",
+		.name		= "cgbc-ddc0",
 		.class		= I2C_CLASS_DEPRECATED,
 		.algo		= &cgbc_i2c_algorithm,
 		.algo_data	= &cgbc_i2c_algo_data[1],

-- 
2.53.0

