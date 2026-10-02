Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F78748641F
	for <linux-i2c@vger.kernel.org>; Fri,  2 Oct 2026 11:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939616; cv=none; b=AN01ZNK16TvO2TrunSvu6zhBto5OjSF0OceXW+1o7Ql7c691u4pA7jlJrIYBI1jaf4GIWuNXFNzlkuKO+BNUSD885UcfRtqEDNLDvjw58Gl+OBLVAW4inySQbgDjSmj2xNzu/qMSVVjoK5eBlRLkKKOQ6c9oUsEbnkavBkeTOoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939616; c=relaxed/simple;
	bh=IoCMlw2y2nqnbUJ6sWTqGPvlSnPQjG1rwEZhiFeLYuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t0563+bQPtsJXOsJz4M59eiFuvPpjsUbAVFN35NkOXUpk5AGH/GERyGJ5PsGbI70ONRWd3ptXVa65ZNeh7KaeIuGoWOuepoPkRCEFyvk3ABadv4GX0efRy3cTbOCcFTDZu8r7ZDLxO4miW2BJoyO1yoFJaySHRDYY418gSajUhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QZCjlOc7; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QZCjlOc7"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9DA694E40645;
	Fri,  2 Oct 2026 11:13:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6BE49603DC;
	Fri,  2 Oct 2026 11:13:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4A1D7103282D2;
	Fri,  2 Oct 2026 13:13:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790939608; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=H8L/jhFTRHbpYZ+V1vMG3aU6fZmEFSMlhqQeRdelAOQ=;
	b=QZCjlOc7r15xAHGMlJ6JxiP+vj1oycNjnuWByS6jNpms6PhcoqJdGcB9oMNgdracjK59gh
	0Jv6KOuQIENgAZ49BY/qoi9oySpUZuceZEjmUGwcLX/Yx0E/QtU9timvQncMQlWv80f7XZ
	mhYaIVNgeXvAvgGSs0g7eTxVLRbWLznlj8zW298pZmi349EyF353M7GCSC3kxInjqLOUrN
	n/BdP1I/iy37Kk4SUMlsiUlOXHQHkYWgfz2rMPwF/lWYaAlyy3KkyyH6kYwZcsbzD8xnuO
	K5TWTqwt8NSoMCMIT/OnzQidLkEEgGYn+Mv6FIG6eC8vr/rduT+hqEQKG0UY1A==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Fri, 02 Oct 2026 13:12:47 +0200
Subject: [PATCH v4 9/9] i2c: cgbc: Register known I2C devices on the bus
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-cgbc-i2c-storage-devices-support-v4-9-eb42e0f1df59@bootlin.com>
References: <20261002-cgbc-i2c-storage-devices-support-v4-0-eb42e0f1df59@bootlin.com>
In-Reply-To: <20261002-cgbc-i2c-storage-devices-support-v4-0-eb42e0f1df59@bootlin.com>
To: Lee Jones <lee@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

Register any I2C devices defined for the bus at probe time.

Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
---
 drivers/i2c/busses/i2c-cgbc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cgbc.c b/drivers/i2c/busses/i2c-cgbc.c
index f7ddeca1d701..682ba639d887 100644
--- a/drivers/i2c/busses/i2c-cgbc.c
+++ b/drivers/i2c/busses/i2c-cgbc.c
@@ -341,7 +341,7 @@ static int cgbc_i2c_probe(struct platform_device *pdev)
 	struct cgbc_device_data *cgbc = dev_get_drvdata(dev->parent);
 	struct cgbc_i2c_platform_data *pdata;
 	struct cgbc_i2c_data *i2c;
-	int ret;
+	int ret, i;
 
 	i2c = devm_kzalloc(dev, sizeof(*i2c), GFP_KERNEL);
 	if (!i2c)
@@ -370,7 +370,15 @@ static int cgbc_i2c_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(i2c->dev, ret, "Failed to get I2C bus frequency");
 
-	return i2c_add_numbered_adapter(&i2c->adap);
+	ret = i2c_add_numbered_adapter(&i2c->adap);
+	if (ret)
+		return ret;
+
+	/* Add known devices to the bus */
+	for (i = 0; i < pdata->nb_devices; i++)
+		i2c_new_client_device(&i2c->adap, pdata->devices + i);
+
+	return 0;
 }
 
 static void cgbc_i2c_remove(struct platform_device *pdev)

-- 
2.53.0

