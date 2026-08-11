Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213EF44CADF
	for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464943; cv=none; b=XUgo95iY43iTd/s+jU5E/StJYa1HKGKK/16tUs+rY4vxWS3xnXVjeUN0aB5Ba5/VBFCVdDwFqZFJyuyygLjhFmnosC72J67/eOpsdjg0pGvWIBIWyE8PMkGDzCSFevSIaJljuiFjjZxZ3O0QLm4y64MORANEIQWHw/i5swyhIVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464943; c=relaxed/simple;
	bh=ZLgJuGU8Ic5vC5CZea8olQRzH82TCCtZe6fwZgqol4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GYL3bVjp1TBzlsfBVmk2ZgA0WChN/T4l+iBjf/v005mYECi6+xpmVAwxjznWHshaA9VbhHraCgz/VlniBI3XfNF2HRq6yktWDDq74A9iI8ajfFZIxaXjdkulrcDFxAfWTa+CliY2Q1ayQAXQlEkAWn/40LtdW6p0/wD1StNbbF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zRw6td3f; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zRw6td3f"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8A5E41A1570;
	Tue, 11 Aug 2026 16:15:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 581FD6033C;
	Tue, 11 Aug 2026 16:15:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E8D2111C48FAB;
	Tue, 11 Aug 2026 18:15:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786464935; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wpVsJatbmKsVB9MeKoIPsRTovacTGNP+K3jGdUo8QQI=;
	b=zRw6td3fTafqIuJCZzLjdu6yppEhY4klmqi0X93T8qwODxhrdV7yp50TSIWGClpFfzPI8d
	fCN0UW1Zk57xBxWXlpRQMJtpLVWr6lWVUEg0m80Rwgl4KRDy7XlVQunckIdrPoTgoMhIq4
	RXOQrIAiMgHlkypUQkUi776+7ERu1wNGn/ZiWkoe/xnt1Ge4gvsDppP0E1R1K1u8E+3GK0
	xMFgXMv+j9dIfKesACSDrqNZXKs5rhgCmJKbK+/81Kl2nKJ9/1KosdJxFrm7X0kAZTrRiP
	yjYqUL3jHKfiDUKJtvXeapG0cLBCCTuzD4K26Qf979bKNnb5+1uAmMpHnyV7XQ==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Tue, 11 Aug 2026 18:15:04 +0200
Subject: [PATCH v2 3/5] i2c: cgbc: Add virtual I2C bus support
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-cgbc-i2c-storage-devices-support-v2-3-3efa998e0ef5@bootlin.com>
References: <20260811-cgbc-i2c-storage-devices-support-v2-0-3efa998e0ef5@bootlin.com>
In-Reply-To: <20260811-cgbc-i2c-storage-devices-support-v2-0-3efa998e0ef5@bootlin.com>
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

