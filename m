Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724573;
	b=W4ikDVv3Z1JxRR2rJWf8sfKigER0wza+au+T9dsqWSNehHmUSQs8sYQDszOoD4zot5uH
	 e4zHmojsCH3Z/SDuaOmBFsZLZrV3LFw6PQxpj3f39Wa+5o6ow4vb/zgZwezNQovfsHYhQ
	 o5MwtEx2l7eIvmNOFmAEwcHNedEBHBsJCD5nTR5kmPv3tWiHHL3QG2UJCTCmMJrpg7/35
	 wGS8NMbzzs2dwRyYH/l8nzgj/cNzQf24TxamUtZXZWckLDNbfVSgcDYCtfKQuUse406sB
	 Ucwc5Y1Nrp4EjmfI4F/QIVQLsk6qrW1uIroz6uiGSeNf8cicRdAP8PvGgujtziwzfTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724573;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=ocCyZzcJxZjGS6tyJsGEy72scc8t6Fmko28IUolWCcI=;
	b=tzDlycZDTEIIBUNpJwDjFxd/zPLdupW4D2uZAJM4hLpwWY4IZYnGlcTSDdIadGp5DiZj
	 f/NzcCnvI1nkmREG2UoCbyUHl4sfzx/nosifjpSPjaC2itcr42xzJbMYkM+YmZVY5LX9X
	 vIFobOyoldh4kxALO1Ph5sojpzaJnp36rrQj4B3M/WNhAJsGIEr2LvpPQnVGPFRppsN4r
	 32TYvWMcGEiogiuBWj/pnwnV+N/pcHjVQbT9Nmu7eX1xn2Hm2PZT6xQCc5nAMzwlNOtE+
	 97tE4IC5fTozvYNxWSROcF4VDuBd7Kp2qPs1FOzimg+wRC/zECO1vriX5EOnqRyiYpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="XrgK/pK/";
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893A7606D81E;
	Tue,  3 Nov 2026 16:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 893A7606D81E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=XrgK/pK/
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C959FC8F463;
	Tue,  3 Nov 2026 16:50:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 275766046C;
	Tue,  3 Nov 2026 16:49:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8D4B4103291EA;
	Tue,  3 Nov 2026 17:49:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793724570; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ocCyZzcJxZjGS6tyJsGEy72scc8t6Fmko28IUolWCcI=;
	b=XrgK/pK/jCAdrRVBiH4Ib+u/DMKUkTkma1OYsHQlkv6egMUR7lRohVG5p5xTcOFbZoY6cB
	8Ug/0pbkaqwxZR4JHtxn6U2ICB+mX0O33XXU5Vr11FPNK5rvBGqRL2k86a45evRky/tY0J
	RM1BO+zHDA5BMZH7ROqIRXJWx+u964c+E4kHArz89eSDsOe5GktBjvKnSj/MfVBjNg12+7
	J30qNmq7SAfnPtHZGiCVzFA5FRVSGqagI9bs2pLuJKomIm1Yt6b0cu5Lm59Ni0vpg0+dPP
	appoEBS10nbbuEOw0V1mRTZ5CZqhCZbpJlNVKThuK95Yud12cgzUlnWBmLpLyA==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Tue, 03 Nov 2026 17:49:11 +0100
Subject: [PATCH v5 3/9] mfd: cgbc: Add I2C platform data
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
Message-Id: <20261103-cgbc-i2c-storage-devices-support-v5-3-ac11f23fae51@bootlin.com>
References: <20261103-cgbc-i2c-storage-devices-support-v5-0-ac11f23fae51@bootlin.com>
In-Reply-To: <20261103-cgbc-i2c-storage-devices-support-v5-0-ac11f23fae51@bootlin.com>
To: Lee Jones <lee@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

Define I2C platform data for each I2C bus in the cgbc MFD driver. Platform
data passes per-bus parameters to the I2C driver, rather than being defined
inside the i2c-cgbc driver itself. This makes the i2c-cgbc driver more
generic.

Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
---
 drivers/mfd/cgbc-core.c  | 38 +++++++++++++++++++++++++++++---------
 include/linux/mfd/cgbc.h | 10 ++++++++++
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
index 02a8c0078287..777930d1169e 100644
--- a/drivers/mfd/cgbc-core.c
+++ b/drivers/mfd/cgbc-core.c
@@ -55,6 +55,35 @@
 
 static struct platform_device *cgbc_pdev;
 
+static const struct cgbc_i2c_platform_data cgbc_i2c_i2c0_pdata = {
+	.name = "cgbc-i2c0",
+	.cgbc_bus_id = 0,
+};
+
+static const struct cgbc_i2c_platform_data cgbc_i2c_ddc0_pdata = {
+	.name  = "cgbc-ddc0",
+	.cgbc_bus_id = 4,
+};
+
+static const struct mfd_cell cgbc_devs[] = {
+	MFD_CELL_NAME("cgbc-backlight"),
+	MFD_CELL_NAME("cgbc-gpio"),
+	MFD_CELL_NAME("cgbc-hwmon"),
+	{
+		.name = "cgbc-i2c",
+		.id = 1,
+		.platform_data = &cgbc_i2c_i2c0_pdata,
+		.pdata_size = sizeof(cgbc_i2c_i2c0_pdata),
+	},
+	{
+		.name = "cgbc-i2c",
+		.id = 2,
+		.platform_data = &cgbc_i2c_ddc0_pdata,
+		.pdata_size = sizeof(cgbc_i2c_ddc0_pdata),
+	},
+	MFD_CELL_NAME("cgbc-wdt"),
+};
+
 /* Wait the Board Controller is ready to receive some session commands */
 static int cgbc_wait_device(struct cgbc_device_data *cgbc)
 {
@@ -236,15 +265,6 @@ int cgbc_command(struct cgbc_device_data *cgbc, void *cmd, unsigned int cmd_size
 }
 EXPORT_SYMBOL_GPL(cgbc_command);
 
-static const struct mfd_cell cgbc_devs[] = {
-	{ .name = "cgbc-wdt"	},
-	{ .name = "cgbc-gpio"	},
-	{ .name = "cgbc-i2c", .id = 1 },
-	{ .name = "cgbc-i2c", .id = 2 },
-	{ .name = "cgbc-hwmon"	},
-	{ .name = "cgbc-backlight" },
-};
-
 static int cgbc_map(struct cgbc_device_data *cgbc)
 {
 	struct device *dev = cgbc->dev;
diff --git a/include/linux/mfd/cgbc.h b/include/linux/mfd/cgbc.h
index 91f501e76c8f..4b6e41b9ca4a 100644
--- a/include/linux/mfd/cgbc.h
+++ b/include/linux/mfd/cgbc.h
@@ -41,4 +41,14 @@ struct cgbc_device_data {
 int cgbc_command(struct cgbc_device_data *cgbc, void *cmd, unsigned int cmd_size,
 		 void *data, unsigned int data_size, u8 *status);
 
+/**
+ * struct cgbc_i2c_platform_data - Platform data of the CGBC I2C driver
+ * @name:		I2C adapter name
+ * @cgbc_bus_id:	I2C bus ID (from Board Controller point of view)
+ */
+struct cgbc_i2c_platform_data {
+	const char *name;
+	int cgbc_bus_id;
+};
+
 #endif /*_LINUX_MFD_CGBC_H_*/

-- 
2.53.0

