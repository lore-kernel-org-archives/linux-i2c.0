Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A752A3F328C;
	Fri, 11 Sep 2026 18:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152545; cv=none; b=hd3Z5s3ZMGaoDL2dfDdWmfv1dvCKKtTTI1TCfSCcMpRcR0pP3E3tRVcxn0DzYxw0L5x4B0gnq9m8wVwnG2K9tlJZfpKrJuFFiCUmGnkTKZ5DxbkKxj4E3JolTTeHefdRbYTVbveqAzMwf7dvQ56Rs1rnyYv7eZlrLeGI7Sr6Ngk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152545; c=relaxed/simple;
	bh=ChRDlnowrHBTyQOyHPBrLY9OaP/SjK6/nMboVF04o4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ag6J4OLP7fQ+qpAJp1ZdwCwPYV7UrDBnw2AOh5KZau9PmMvCjWVn2D6W+A2aXIuTcPPWrSY2a9spDRQwyFExM9uN20vUsgYubbdcHYWuFjk4Nmtc2lx900c+///ToyTXUJHndTPGdd3GCWnS3qWJVUT77dho8ehAeTzGfLyilMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dNskOCmB; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dNskOCmB"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 81A6E4E4023E;
	Fri, 11 Sep 2026 18:49:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 56575606D2;
	Fri, 11 Sep 2026 18:49:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D738111C7A23F;
	Fri, 11 Sep 2026 20:48:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789152539; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Am4haarr/NpR5iw1+rTp6Nr/xWwoCkxN2vOAeKnE8cs=;
	b=dNskOCmBEApm+5kmAmk5reCLbdG+D0/8ItlMud6xlCwqdqt8OpC5h0YPezM9J7y3YMZg3D
	Yxgnr6/7THSo6ySnx4RuGsU8GUs+6hDI4Omwk+UA6gmEUXqt82ohMhLDIgGCX+PG/jLJTj
	VxX+wfWbxm3Ke3gv2jSqdoMdjHp65vD6PJMgaAjPpoWtsp71VnshBcvd5NZHMSeBhupNKI
	W/7Emxs5SjT5NuJssA26xvBReW8DO9piWZHnl4JPyk8T84Jfk4NSKNUNdyIYwVvLmEEMrc
	o3ksqWSGTj5s74iVvhhU2/pArsLebdJ1mDJXianUQ8/ELBeAM3YvuJKRy4xatQ==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Fri, 11 Sep 2026 20:48:07 +0200
Subject: [PATCH v3 5/9] mfd: cgbc: Use real I2C bus names
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-cgbc-i2c-storage-devices-support-v3-5-594b53fbc5ea@bootlin.com>
References: <20260911-cgbc-i2c-storage-devices-support-v3-0-594b53fbc5ea@bootlin.com>
In-Reply-To: <20260911-cgbc-i2c-storage-devices-support-v3-0-594b53fbc5ea@bootlin.com>
To: Lee Jones <lee@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

The adapter names described the expected purpose of the buses ("General
Purpose I2C adapter", "Power Management I2C adapter") on conga-sa7 board
rather than their actual names on the Board Controller.

Rename them to the real bus names "cgbc-i2c0" and "cgbc-ddc0", matching
the naming used by Congatec, and update the variable names accordingly.

Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
---
 drivers/mfd/cgbc-core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
index bb26b358da26..dff14cd98271 100644
--- a/drivers/mfd/cgbc-core.c
+++ b/drivers/mfd/cgbc-core.c
@@ -56,13 +56,13 @@
 
 static struct platform_device *cgbc_pdev;
 
-static const struct cgbc_i2c_platform_data cgbc_i2c_gp_pdata = {
-	.name = "Congatec General Purpose I2C adapter",
+static const struct cgbc_i2c_platform_data cgbc_i2c_i2c0_pdata = {
+	.name = "cgbc-i2c0",
 	.cgbc_bus_id = 0,
 };
 
-static const struct cgbc_i2c_platform_data cgbc_i2c_pm_pdata = {
-	.name  = "Congatec Power Management I2C adapter",
+static const struct cgbc_i2c_platform_data cgbc_i2c_ddc0_pdata = {
+	.name  = "cgbc-ddc0",
 	.cgbc_bus_id = 4,
 };
 
@@ -72,13 +72,13 @@ static const struct mfd_cell cgbc_devs[] = {
 	{ .name = "cgbc-hwmon" },
 	{
 		.name = "cgbc-i2c",
-		.platform_data = &cgbc_i2c_gp_pdata,
-		.pdata_size = sizeof(cgbc_i2c_gp_pdata),
+		.platform_data = &cgbc_i2c_i2c0_pdata,
+		.pdata_size = sizeof(cgbc_i2c_i2c0_pdata),
 	},
 	{
 		.name = "cgbc-i2c",
-		.platform_data = &cgbc_i2c_pm_pdata,
-		.pdata_size = sizeof(cgbc_i2c_pm_pdata),
+		.platform_data = &cgbc_i2c_ddc0_pdata,
+		.pdata_size = sizeof(cgbc_i2c_ddc0_pdata),
 	},
 	{ .name = "cgbc-wdt" },
 };

-- 
2.53.0

