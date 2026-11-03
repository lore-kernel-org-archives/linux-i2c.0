Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724574;
	b=Qgs1/8YmAGtsM8O0c+QCXmZqjX3qwwN7uy+yRTIM8u1wjD37Ik+jIecfAyTn7Jq6a3co
	 1zigsVYkmXaK3w2nTL2iR4142lpJDXiI56+TubH/BqIKVb2KhodSAbuz7apukWGCY2Ajk
	 9HR+wwiSHDaV3xb1utQvqdbUJskUkm2+wGKfuNcl25XODVgvUGEWoD3Aer+cuWu1BHsjW
	 Xz8X93ukt0JFClPEJqn/05r07HNNz58YKefm0ZWIGAlNMU4UIv9tPkUnMjUFKUgS6/zf/
	 3/78IjZUfh3ar2F3ve4Cq1jmKrJhtYekI+1QW/iYtsQTfZ8Qq1AKqIrnkFYhcP4Zjmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724574;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=ubpxFXcGelEbnwoa2InvY9UP99/HYatKKNT8MLzTmr0=;
	b=higTbLLZ2KW+jIcRhIkniDf7ry2qZbvvG9nMZ7mfyvKNaUI3Smz0bUc5wc8DP5Sdt5l+
	 /Hj1Bkh8hwgOrdejz0OYKaxSep1F7pBUBBdHDXPBCj09PCqsLNx6Cu/7aeN3W2AkPJGhG
	 CmNoDj6b6cc/IXcy+rF1gzTWQSP7NQPJh05xxFBDRpZ+wepwxuFZBW/n54CK6iQjTCo+g
	 cPxmfBpIlsdhyEUjdZVhZsjBsmhoCMMF3WSMQErZg2zoiO+pL3bbuN6Xua9jhYRRVMPa2
	 8AnOFLwuUJRWdYk/V+/EE4cZJxe/eRj+G4oWifQeXludhsfHSr3BH9FtNPP4OqBkSKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=aAKEw3ms;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779D3606D83E;
	Tue,  3 Nov 2026 16:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 779D3606D83E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=aAKEw3ms
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C8B92C49F46;
	Tue,  3 Nov 2026 16:50:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3503E6046C;
	Tue,  3 Nov 2026 16:49:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 981DA10328C5E;
	Tue,  3 Nov 2026 17:49:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793724572; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ubpxFXcGelEbnwoa2InvY9UP99/HYatKKNT8MLzTmr0=;
	b=aAKEw3msVBTBZ0MkuLAwRwDUiL/I+M14tddqYD/j6oN4Gut80MUoQwOASpP1mbKYOpEKx2
	2ZAx1EEM3ao7zHhO9X3ei7g4o1Apr2fRf8ZFcRprmjWPtqN8UklU1TRkowzcSeS84zTsuw
	R6VfGNhMTW02qSj/NnmhlAeDUjQ2d4TphdoaJQ7lgTnYLeQDu0xrfNOJkA8Uj3qwoSkeUZ
	A+5+08IGq+8yql9sa1iSAUzS6ErYITHbuPa/iJzRBmBd8HBMcfoQOdj/IWiScPVcp/bc5u
	CkPhzQ8MyBXf12VSE/N44LIHopn+bsNbv6sTf4sPwGJIFrFuMpAK3ubbrLG1xw==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Tue, 03 Nov 2026 17:49:13 +0100
Subject: [PATCH v5 5/9] mfd: cgbc: Use PLATFORM_DEVID_AUTO for child device
 registration
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
Message-Id: <20261103-cgbc-i2c-storage-devices-support-v5-5-ac11f23fae51@bootlin.com>
References: <20261103-cgbc-i2c-storage-devices-support-v5-0-ac11f23fae51@bootlin.com>
In-Reply-To: <20261103-cgbc-i2c-storage-devices-support-v5-0-ac11f23fae51@bootlin.com>
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
index 777930d1169e..7f512b4f07f7 100644
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

