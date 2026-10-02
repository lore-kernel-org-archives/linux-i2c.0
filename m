Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDF4471CF8;
	Fri,  2 Oct 2026 11:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939594; cv=none; b=eyOE7VikC8tNFhziKgPeOqOzJkTxY32m9mI8aI0TBb7yP4iiRP4AOIoN64IdELwzuKH1ozgPpWANyYW7/UDn6REirGwlCLDMFMbMX4YAaV4htBd9strb5yK1tPI4E2jCuWD7si7AmFdgq45Jjg7pddsztD5TddpITEP4q0bXbnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939594; c=relaxed/simple;
	bh=ZmUemuIz9ZB3kpy9aZ/HShhD+i/i8ZxZNqPWuezOEFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S6NdkG65HHHR9j07bfxIdJ1bNWhNkZXUv0V4Sohh9ua/qYgFGnUVaaiLtRwe+JjWHFvjWr15ZihX86GfigIhIsgGDnLuELPDiCSNyFWdj/JXLmoZTdMtbSraFKre4ppCJMJD5uHRbnXbL9kSerN7NUaaFwp3NG1Ue2JxHRfJeDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UzctTtoU; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UzctTtoU"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id F02441A10C9;
	Fri,  2 Oct 2026 11:13:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BDBA4603DC;
	Fri,  2 Oct 2026 11:13:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 758CD103282FC;
	Fri,  2 Oct 2026 13:13:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790939586; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=LPiMulcS/Ndb/2UyQ5q9l9W3XztZd+mBvVH13QVFNh4=;
	b=UzctTtoUgNAg9t8b+hT7HORiDuS1/egNuecXlqFplKaXibgVo0iWzS3hGtxTPt2qnHcUnN
	ipmH5cOJUtj5o8zrk2kn3IktmsfxJk/wMWoFe2y2bqlRZO5h6qiSzv4w6ERnjlV7R6Ri14
	AkHUaLwV34KqtzJxzCzhaWlMM4uvbMjLFtlSzRtzRpiPWXcioKU52AlwOE8eX9Mhg17nBP
	xocINpB/FGV/8PA5pyQuuSmxrrOnaOexJhES2D1gnsGjIaD2CcMwUDZIXuaefX9IfnnGyg
	/jLdVPxtCZne4I3t+d6BJyqZhfo+XZg/q9WFNbVLv0B1zhJOcVyzN9Z9m63uOQ==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Fri, 02 Oct 2026 13:12:40 +0200
Subject: [PATCH v4 2/9] mfd: cgbc: Add I2C platform data
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-cgbc-i2c-storage-devices-support-v4-2-eb42e0f1df59@bootlin.com>
References: <20261002-cgbc-i2c-storage-devices-support-v4-0-eb42e0f1df59@bootlin.com>
In-Reply-To: <20261002-cgbc-i2c-storage-devices-support-v4-0-eb42e0f1df59@bootlin.com>
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
index 4a409234e66c..0cd9e6f888cb 100644
--- a/drivers/mfd/cgbc-core.c
+++ b/drivers/mfd/cgbc-core.c
@@ -55,6 +55,35 @@
 
 static struct platform_device *cgbc_pdev;
 
+static const struct cgbc_i2c_platform_data cgbc_i2c_gp_pdata = {
+	.name = "Congatec General Purpose I2C adapter",
+	.cgbc_bus_id = 0,
+};
+
+static const struct cgbc_i2c_platform_data cgbc_i2c_pm_pdata = {
+	.name  = "Congatec Power Management I2C adapter",
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
+		.platform_data = &cgbc_i2c_gp_pdata,
+		.pdata_size = sizeof(cgbc_i2c_gp_pdata),
+	},
+	{
+		.name = "cgbc-i2c",
+		.id = 2,
+		.platform_data = &cgbc_i2c_pm_pdata,
+		.pdata_size = sizeof(cgbc_i2c_pm_pdata),
+	},
+	MFD_CELL_NAME("cgbc-wdt"),
+};
+
 /* Wait the Board Controller is ready to receive some session commands */
 static int cgbc_wait_device(struct cgbc_device_data *cgbc)
 {
@@ -235,15 +264,6 @@ int cgbc_command(struct cgbc_device_data *cgbc, void *cmd, unsigned int cmd_size
 }
 EXPORT_SYMBOL_GPL(cgbc_command);
 
-static struct mfd_cell cgbc_devs[] = {
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

