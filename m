Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794908883;
	b=wn2lVeB98qSLkNhrNzT7v9Le00tb4ZsR5MH6FDDJ/jiLLBl3CTpmmtawaJqW16MOtWNS
	 tbcLetS4iFPkPhkPSjNePLl3REoR4FEY9ozuOPsX8fKlBxN6BJdcTte9gIlAEBLtuCh9m
	 8t1bkrFTEAwTTJ1apDRjjJizdIEtW0yTXFZDzHsZHYyvJxPo3fDCazKj8Dwy9Eu4Eg0sN
	 vNpiAbghRm1G2JBQzwudKYHkQHraRYq+GY7JArtxu9IPkH5+8eKt2JQUwpokW+Ay51Eli
	 KOeNtsTDfY5xrQ33WOfaTKLWW9piiupG5zN1mmx49UvyKbq06k7tf3h3YZ+maBMLrvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794908883;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=cqykWOtScnn2p0ZVOutyoQbXZ/i7/ANOa2dg8wfH+fw=;
	b=GGH7hZKerQ6DrhR8XbuT3ib+8F7q6CsGrtuwfXc+k0veuX5q1AZzUXRJfxXqYG3CfPlw
	 QkN4cVTZozmDtj9OgJLp+CwmmDPaORHSgnpjrMAFxf4mKZLGEqZvHNIeMqnJSBh0ZKaPa
	 5pJ5kaHwCGYgx9F0mSBbaPtFSEqgVAXbHLOiVdYw8m0SUWlbD63C6z/hBx8+jBSlkoq8u
	 wf0PZLfhGReJ/JGkXxrrg1/u9yJIfS7Ds+4QpdxNHIfoywZZl8CXuoRSRlEXgQ5DJ9FOl
	 AiJ1+39LVdbFq/aVBdNJFvjNzgaCyzUJ5aop6SFRa3rgC/d84YCoPIlFUGVfZAG84Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=MX3Unka6;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45436606A896
	for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 09:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45436606A896
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=MX3Unka6
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1F0134E414C3;
	Tue, 17 Nov 2026 09:48:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E9A935FC81;
	Tue, 17 Nov 2026 09:48:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9131611BC1129;
	Tue, 17 Nov 2026 10:48:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794908881; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cqykWOtScnn2p0ZVOutyoQbXZ/i7/ANOa2dg8wfH+fw=;
	b=MX3Unka6Ei3hP55SeH9CApmxMf23WBtjEeq8cL5mpN25qjGkZfE3EsimbqI6lFvR2jRIPT
	WwJNEHTxTbD/88ATIoS8StkACl4LkHGjDfsC+onoAWveOanqqsVqfH1aDeEOWWFfmH/CLG
	mYnJcaqK7lTl7C7JboowqZEKFBHGUXfUsSMUECkGcbcFIPDUKcGnsPYOK2CA3O1jhKYmDn
	4NR5vTujfNw9Qdu7Loze9LohSvJkuh1JMYaUb3TAHABtMS6xlJcywakumX+tmz5flGmgOG
	IMaB7Gs5MC5oYJIfdM77WFiayko/mYBgZZcRwTqckp0olwgs4wX/z8dGFza4dw==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Tue, 17 Nov 2026 10:47:48 +0100
Subject: [PATCH v6 08/10] mfd: cgbc: Add virtual I2C bus support
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
Message-Id: <20261117-cgbc-i2c-storage-devices-support-v6-8-bb070ad3e9aa@bootlin.com>
References: <20261117-cgbc-i2c-storage-devices-support-v6-0-bb070ad3e9aa@bootlin.com>
In-Reply-To: <20261117-cgbc-i2c-storage-devices-support-v6-0-bb070ad3e9aa@bootlin.com>
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
index dbd6a7539d8e..db22674affbd 100644
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

