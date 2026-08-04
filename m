Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60184582D4
	for <linux-i2c@vger.kernel.org>; Tue,  4 Aug 2026 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785855382; cv=none; b=IMck9CPPlJZaGOnpWckHXLiFd4cLvxK47HfWoBliI7q92PERC/JBC9Q8VUsf2wtfwiNmz6KSn9TJz1TuQ45bAmvD2qcvXYue4rIQ3xaxZK2xS5SnKO7jAoGLYXkFzwNMFBQLx0oAGu1D2h2ICzyYJaFQ0BD1wFGLGh9eNvlKuwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785855382; c=relaxed/simple;
	bh=ZLgJuGU8Ic5vC5CZea8olQRzH82TCCtZe6fwZgqol4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zjn/wg+vrIDxXxDBAO3zko+L5xcPDwcW0uInm8PI+541tHigycADp4g4DIK2ajKNkn1dz9lX+INk03qRs3QoXOC16bCla5D/RyJlg5fe6nGDRFO70v0fRTRgjC6s2m8bcZHVPWR8v5jDyYWk4sxAno4241rBnlzkcuMnxjEdMQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c4SBPcpG; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="c4SBPcpG"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 297411A140C;
	Tue,  4 Aug 2026 14:56:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E8AE36029E;
	Tue,  4 Aug 2026 14:56:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C392C11C32F33;
	Tue,  4 Aug 2026 16:56:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785855374; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wpVsJatbmKsVB9MeKoIPsRTovacTGNP+K3jGdUo8QQI=;
	b=c4SBPcpGR3y961C/PATwCD2A5ZIdopV4tcYceUoDFwQ9/ikIIvk5Tn0WJKjHVEtzz6Mk4l
	uJsJCFN3cEFnLc3y+cdwLGZUWAwBMgGnEgg4WjT6qs/50WP9XcGCLhgOJ4DcoyChiaz5Jc
	jypnaXFwN8fp5/m1EjZ376f69BLUrqCC7b9svzgBDEi8trOL1b1tSbhy+12SSAzqkPjC20
	/xp6sqtLEHiNddC3nSvy9rdXpmQlLpTcBhfV2xlw1CvqMSqRoq2fmjMTcg45HeELKjcGcE
	LaNBq0riDPYQYcGsxMA/S0YkPBDPvkuGBum00tB30Fzg5eIQLLe4S15U29YyfQ==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Tue, 04 Aug 2026 16:55:52 +0200
Subject: [PATCH 2/4] i2c: cgbc: Add virtual I2C bus support
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-cgbc-i2c-storage-devices-support-v1-2-fed38510671c@bootlin.com>
References: <20260804-cgbc-i2c-storage-devices-support-v1-0-fed38510671c@bootlin.com>
In-Reply-To: <20260804-cgbc-i2c-storage-devices-support-v1-0-fed38510671c@bootlin.com>
To: Lee Jones <lee@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

Internally the Board Controller has a virtual I2C bus with some virtual
storage devices on it. Add support for it by defining a i2c_adapter entry.
This virtual bus has a fixed frequency that cannot be changed.

Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
---
 drivers/i2c/busses/i2c-cgbc.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cgbc.c b/drivers/i2c/busses/i2c-cgbc.c
index 25a74fa51aa0..c3f1c83b105a 100644
--- a/drivers/i2c/busses/i2c-cgbc.c
+++ b/drivers/i2c/busses/i2c-cgbc.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 
 #define CGBC_I2C_PRIMARY_BUS_ID	0
+#define CGBC_I2C_VIRTUAL_BUS_ID	3
 #define CGBC_I2C_PM_BUS_ID	4
 
 #define CGBC_I2C_CMD_START	0x40
@@ -147,11 +148,14 @@ static int cgbc_i2c_set_frequency(struct i2c_adapter *adap,
 	cmd[0] = CGBC_I2C_CMD_SPEED | algo_data->bus_id;
 	cmd[1] = cgbc_i2c_freq_to_reg(bus_frequency);
 
-	ret = cgbc_command(cgbc, &cmd, sizeof(cmd), &data, 1, NULL);
-	if (ret)
-		return dev_err_probe(i2c->dev, ret,
-				     "Failed to initialize I2C bus %s",
-				     adap->name);
+	/* Virtual bus has a fixed frequency */
+	if (algo_data->bus_id != CGBC_I2C_VIRTUAL_BUS_ID) {
+		ret = cgbc_command(cgbc, &cmd, sizeof(cmd), &data, 1, NULL);
+		if (ret)
+			return dev_err_probe(i2c->dev, ret,
+					     "Failed to initialize I2C bus %s",
+					     adap->name);
+	}
 
 	cmd[1] = 0x00;
 
@@ -338,6 +342,7 @@ static const struct i2c_algorithm cgbc_i2c_algorithm = {
 static struct i2c_algo_cgbc_data cgbc_i2c_algo_data[] = {
 	{ .bus_id = CGBC_I2C_PRIMARY_BUS_ID },
 	{ .bus_id = CGBC_I2C_PM_BUS_ID },
+	{ .bus_id = CGBC_I2C_VIRTUAL_BUS_ID },
 };
 
 static const struct i2c_adapter cgbc_i2c_adapter[] = {
@@ -357,6 +362,14 @@ static const struct i2c_adapter cgbc_i2c_adapter[] = {
 		.algo_data	= &cgbc_i2c_algo_data[1],
 		.nr		= -1,
 	},
+	{
+		.owner          = THIS_MODULE,
+		.name           = "Congatec Virtual I2C adapter",
+		.class          = I2C_CLASS_DEPRECATED,
+		.algo           = &cgbc_i2c_algorithm,
+		.algo_data      = &cgbc_i2c_algo_data[2],
+		.nr             = -1,
+	},
 };
 
 static int cgbc_i2c_probe(struct platform_device *pdev)

-- 
2.53.0

