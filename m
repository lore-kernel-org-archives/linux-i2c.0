Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724587;
	b=GL+vE53wIVljTL72M+dSdayb8TTpR1hcgYj9vxB1ldxSCsN3vU0C0859phVrLR+2EOYQ
	 d5LqhOhvMXvMz5wxZJGLrMcuh/lJpfVdMc22yrR/zx/MHNv0yPvD+iAQxNMwgQg2hYOmk
	 x3SlDMgbNq7T4QpcuWbjvVYcJ1hi/l1KrbL9vS1Y0BGEluZVVfUPcY6BTbu/nyIL7JHIy
	 NEpbC+Y5UwikN5kl4GNjdaWvE5GZ2043QfDkpSqbuvYZ2Xqs7vKMEJggK4/k5t+IDTyVG
	 Y0gYIAeEtsqpKHZ9IVjPTK/4a+Z5UXbmbYSJZqiTss/9U6+uTuuEioBDdfqTKkZdL/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724587;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=vrUn30d9aD0WnkF3mVI+esdhIKk+wHZiOxoTi2poybM=;
	b=i7voeOCkbJwZuHYjteuBgZuzu1AwJMA33ckDzQl84g/7IwHmqmhtPsAfJdajMbCYu5Ig
	 ByRjUilQeeUc5z8PWNfoyUdHyMjZz0CJMouoAbnsAUnzk/6uJ7LVPl9vM9GuaEw2+w7df
	 hiJD1cIkRJPlOAxOeWo61rXLiyDP237YVYbCtVzr/jCHR/rp39xCXqECKUQynuBjsvI5N
	 pE84ATiiepWkV6JVq0lCqA97z9D2t/24eu8oGrGeqNOkSyd6MipLM2Tv22opxm+B/XFhq
	 CPchqTfyhM7v+kapQz+Bmu4oDTihJG4JQcwxrWVpz8cwnomFThvfr2freADN5DHi6mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=mCRY34IV;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA6A606A337
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 16:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DA6A606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=mCRY34IV
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CBFAB4E413E6;
	Tue,  3 Nov 2026 16:49:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9B8F36046C;
	Tue,  3 Nov 2026 16:49:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4797C1032920A;
	Tue,  3 Nov 2026 17:49:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793724580; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vrUn30d9aD0WnkF3mVI+esdhIKk+wHZiOxoTi2poybM=;
	b=mCRY34IVz7fqYO7fRkIu/hXLV8B1XzmlL4cOftlKpmK9mf1fWl3VrBkw3IkqM2eQj992XR
	bXLdcbBCYlQOxNqOk6H6p02nzcaZYgmPAMUhpU5zXyF+rXbl6RJVhuYxhmvJ31xuC0v+P4
	7lC4Xh2pBIX5FKwLoqT6yfGmoKXvUT4Jti5qOKk73Bl4L7eCMEh+V15I0R17anNkhDymGC
	LBKzhva9WFjMq8kSx+/8UQMITw1vEZmLJlBQ/HLpqbs5hzN/QgZL2rXSRLJbdsjSFu0jVB
	4iTLWwegAchfyFLDWLY5kDR8jQAPe/QCEBMkX8uXHGGx1ulacghZR2VJat6uEw==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Tue, 03 Nov 2026 17:49:17 +0100
Subject: [PATCH v5 9/9] i2c: cgbc: Register known I2C devices on the bus
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
Message-Id: <20261103-cgbc-i2c-storage-devices-support-v5-9-ac11f23fae51@bootlin.com>
References: <20261103-cgbc-i2c-storage-devices-support-v5-0-ac11f23fae51@bootlin.com>
In-Reply-To: <20261103-cgbc-i2c-storage-devices-support-v5-0-ac11f23fae51@bootlin.com>
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
index 8623a5d03636..3226838cca46 100644
--- a/drivers/i2c/busses/i2c-cgbc.c
+++ b/drivers/i2c/busses/i2c-cgbc.c
@@ -356,7 +356,7 @@ static int cgbc_i2c_probe(struct platform_device *pdev)
 	struct cgbc_device_data *cgbc = dev_get_drvdata(dev->parent);
 	struct cgbc_i2c_platform_data *pdata;
 	struct cgbc_i2c_data *i2c;
-	int ret;
+	int ret, i;
 
 	i2c = devm_kzalloc(dev, sizeof(*i2c), GFP_KERNEL);
 	if (!i2c)
@@ -385,7 +385,15 @@ static int cgbc_i2c_probe(struct platform_device *pdev)
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

