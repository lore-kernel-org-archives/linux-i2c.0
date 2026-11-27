Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795802319;
	b=YfoerKjor7HDxC+KleQxLAE85pKJcRxqLni08Ly9lYUNHFR9rgNJRxSGj13op4viB/f9
	 U6YW25b2bSOXfO+pAeWw8/PWuZIRz+EDKVvqQUwbP2a5C0oBENML3yeFaIbVPblWOFQJK
	 JUeij0GmFZeRM7vbrHKgOH1mYEHIPczTbilBCd8ztxbWjF2yRRmkk6ghzAByTuHXZKo4Z
	 ZWwXz7dbdfY5zVatcfvEPmS2GgpPvOA60xS4BPEQzwmKrfG4Gn4MN8Uz/wjYMZlZpgWYc
	 UDvNwcbhIFkwLg6CErtU3EVK1KIASptKlub/DxzotwBbof70KKPsBQJg1/6j9U4eGrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795802319;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=gtvR9miBTva7s2ycJTQZotb4TSIDS9gAitRlfuCzzCk=;
	b=iSFl1xm4OxTydkTV8Nnc6a4q5Iikkm8JvC2k2FNVncfMTWShC6cYP5DrIqeglfQIXHy5
	 TOr68VSadQ0QYRWkrArORp3MVNFPV3BKIveLn51EN7KwUQAKa/gtM4cml8ki8od76cS6o
	 tn0z8yI+wBEoaZLIOkzlFfheGNEd09lRR/3ADsSRcJc329F8dR29hxkrHFPHjNlH3Tdb1
	 H+lt7WJBfdNNfp7IecMtj8T8AmMR5qrIpfm/Z1mXT1VyvVybioePQBnBRzRyjPEOgrrf0
	 rlR7mLRN5oezMThIJPab2iY3HqxBlqCx+d4/jq57RFolOYxE4T4Eco9Ww3Mveimn+vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=IAcvTDOA;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C90606A691
	for <linux-i2c@vger.kernel.org>; Fri, 27 Nov 2026 17:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58C90606A691
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=IAcvTDOA
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E266CC2AC4E;
	Fri, 27 Nov 2026 17:58:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 154CD6049C;
	Fri, 27 Nov 2026 17:58:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8430310439571;
	Fri, 27 Nov 2026 18:58:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795802317; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gtvR9miBTva7s2ycJTQZotb4TSIDS9gAitRlfuCzzCk=;
	b=IAcvTDOAFMCruGuz5uK8WsbglsjlUlyTPW2ADYBx3+FWf0565p3blavqsTeewnElJzVpDj
	nI2IEN2F0m2a7wxsDAlOGivGPmrEx95Guek4XJpgsW5pXY6gwJ8QcmCPaiGK9p2R8MbaA2
	xeCRvgCIbaQS5yMYLI5RICOSOXrfEMjdrJ9PlBJ6ZuhWUgSfgL075r63cICrhhdU8rDkjA
	A1kjA1oS818IcD+Bj2VYamJTn+Z3wznMk/MT0qiONgxV3Vf7xQBgV/c726Fbv2RXV7mPKE
	PBkHfIzbWw7prrr8jZMG/MXRRQ//raV5KESFkui6l9RF6xhBx6zQgSjK9gu6oA==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Fri, 27 Nov 2026 18:57:54 +0100
Subject: [PATCH v7 10/11] i2c: cgbc: Register known I2C devices on the bus
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
Message-Id: <20261127-cgbc-i2c-storage-devices-support-v7-10-d0e70fc57879@bootlin.com>
References: <20261127-cgbc-i2c-storage-devices-support-v7-0-d0e70fc57879@bootlin.com>
In-Reply-To: <20261127-cgbc-i2c-storage-devices-support-v7-0-d0e70fc57879@bootlin.com>
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
 drivers/i2c/busses/i2c-cgbc.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cgbc.c b/drivers/i2c/busses/i2c-cgbc.c
index 85cbe709bcde..5105b920e919 100644
--- a/drivers/i2c/busses/i2c-cgbc.c
+++ b/drivers/i2c/busses/i2c-cgbc.c
@@ -364,7 +364,8 @@ static int cgbc_i2c_probe(struct platform_device *pdev)
 	struct cgbc_device_data *cgbc = dev_get_drvdata(dev->parent);
 	struct cgbc_i2c_platform_data *pdata;
 	struct cgbc_i2c_data *i2c;
-	int ret;
+	struct i2c_client *client;
+	int ret, i;
 
 	i2c = devm_kzalloc_obj(dev, *i2c);
 	if (!i2c)
@@ -393,7 +394,20 @@ static int cgbc_i2c_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(i2c->dev, ret, "Failed to get I2C bus frequency");
 
-	return i2c_add_numbered_adapter(&i2c->adap);
+	ret = i2c_add_numbered_adapter(&i2c->adap);
+	if (ret)
+		return ret;
+
+	/* Add known devices to the bus */
+	for (i = 0; i < pdata->nb_devices; i++) {
+		client = i2c_new_client_device(&i2c->adap, pdata->devices + i);
+		if (IS_ERR(client)) {
+			i2c_del_adapter(&i2c->adap);
+			return PTR_ERR(client);
+		}
+	}
+
+	return 0;
 }
 
 static void cgbc_i2c_remove(struct platform_device *pdev)

-- 
2.53.0

