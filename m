Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795802318;
	b=jJ3qpVbIBTFHRPBHsO7iBRsSyuTfslphsh89Up1h5Nd3Yh9MBpwOMpYl6uc1EQPWm2rU
	 4/NX2K8DEHkXieBg1xWf+HdJSDreavpfp1Pk5d5zfgIcTpf31h9/OgX5RMtIk+nJ3aUZf
	 rsmFIZrBiy2fkZ5rkrEnciGs/EmzP+Q+DcKU9dv+G0f1Sd+M/2JRsDJUD/sk8lnZIJsll
	 eMnY/5bAqNVe9Lblyl/oyIpzAeklQd8rC1n1zqMcxrg7zztJFwgYnFK85MahdQsTaoc/j
	 Pdr+kdXosmlN5mrRCuRI6m/qEFIVDKxxsWktM/8PVF5nSw958FkjhpXFk0MlkK2hXPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795802318;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=cqykWOtScnn2p0ZVOutyoQbXZ/i7/ANOa2dg8wfH+fw=;
	b=oiF8U763qISM3gNm47l5XFYuknDQXaNHivA5GQguGY5BEOQ+IKJpFbuIS2E4bP2IUmY0
	 86g9kLddqXG4CiornzLQUEx1zhJ9exr28O+x9fMf26hq4b7DrADVGv5h7WbjvC/bv/OfK
	 1xJIjJAT/73xUji27IwkziTfWu56UrO5L+i6neONX33cArIs0TuT8QFwtsEX6qWAwN3JM
	 2ub7EzGyK43tjc03h/FLhvAqyrf1wyph/bCVsD1GSceQysK1RpTLWIxd9CN+FvAWCEZMX
	 jbzVaka6Z/YzffCC3MccAplMbMOUh13M3+SnXbvG7PmhAm6oZM51rn8CWOevPBKCkfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=u+wNYVs3;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B56F606A321;
	Fri, 27 Nov 2026 17:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B56F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=u+wNYVs3
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 305111A1841;
	Fri, 27 Nov 2026 17:58:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EAAF86049C;
	Fri, 27 Nov 2026 17:58:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B9165104395A9;
	Fri, 27 Nov 2026 18:58:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795802315; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cqykWOtScnn2p0ZVOutyoQbXZ/i7/ANOa2dg8wfH+fw=;
	b=u+wNYVs3VFfkWZo1bu9fhu1LazRu5kfc21TnbXIf+yONFDbvsd7bYFSSab8h9aLK8dPJXj
	7FgTgJB8v3xb7rHoIeaegyLm8C036TrgtWsXwQd+m8QyjH41gKVZCIhAaIOLyesSKbssDU
	EdSJBzH0s//zKndf9MnFfr7ud7ztySj+qqiM0aCV2Od9D1C7AJVZXoec9SGJiVX0ZoEB78
	K5XrKu5tjCedv7QyUKqqUd59NcChNOz2OVCE7LPCiMw0Fz+uDoFTJ7dUboBrv8hIUZJPNe
	WR1OBgP+2pvhHyDV/7bgheeCbBi57Oy0l20QVWYGothMDzeWuincIlWoIOMn+g==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Fri, 27 Nov 2026 18:57:52 +0100
Subject: [PATCH v7 08/11] mfd: cgbc: Add virtual I2C bus support
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
Message-Id: <20261127-cgbc-i2c-storage-devices-support-v7-8-d0e70fc57879@bootlin.com>
References: <20261127-cgbc-i2c-storage-devices-support-v7-0-d0e70fc57879@bootlin.com>
In-Reply-To: <20261127-cgbc-i2c-storage-devices-support-v7-0-d0e70fc57879@bootlin.com>
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

