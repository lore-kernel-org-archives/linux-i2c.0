Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FA43F328C
	for <linux-i2c@vger.kernel.org>; Fri, 11 Sep 2026 18:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152541; cv=none; b=nqijrOx1MmOpflKJB/qFXD/q9A0Oi3IlmlsPkyLtIYHd+T9ezbpZrHpMcHosyzQWw7Ox5IhumS2IKuTphhzeKIQGBfgWlV0l5a0Sj+fOYfTuvd/zpUkcE6PIcHOn/qyMztVwI+W2rTgD/VgVPzhnbUhahtTO5xZLkVZnGNVb3T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152541; c=relaxed/simple;
	bh=FJCibY2SED60UC7aA/RHHoDR3FiG1f9oWqf3gR4Jrf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jr3eirliUwWgqyR+mQNmXdFruPxKJk21XAhrVPA03twC2ow1NfMcenQgJZfkIELY5IXFr7fXNE3tFoPkitgyOfKM5cIVkBj2IwVxbVbqVIXqKoBudTq9afNJt269gs9tqVu1D2fMnjJ5fZ52Du+8wvDsB98mlxA7BpR6xxAC+bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kx2j/Izp; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kx2j/Izp"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 97AE04E40238;
	Fri, 11 Sep 2026 18:48:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 66B8B60649;
	Fri, 11 Sep 2026 18:48:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D23B011C7AFB3;
	Fri, 11 Sep 2026 20:48:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789152536; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=c14SyQODhVDxLqVpTYDDs1C8FIYSas61YZ9h2+viO6U=;
	b=kx2j/IzppZIaUFiicpKsivQ36NBNzzGdqOdnSzR2STMOhjH0FOYgJ0wu4a3YJyhV85A194
	Sne7zq4uNhjMkpDVOxoWwmxpaUQtfnmpiE6EJmXz+RkxFC1M0Jl7/VGBTk/8oyFm1uqi9Z
	uyLsFKKg3Is8/RIX4L2cbvu8e9S+n0eajWcN8SDaS/OmKSBP7inAun3HMvkWDyBQp3AMfY
	+VZo6ykj7FeHSb+peOcYvy1f/esikKu8aFtqibv/e3pod3G5tPywwobD53yWJ3YrFWktDe
	nq1XmI9GNfNqOuv491dQiE/xh7hwD5MMSS3yy+lGUT9NVYbR+IO6K+1z+9RW9g==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Fri, 11 Sep 2026 20:48:04 +0200
Subject: [PATCH v3 2/9] mfd: cgbc: Add I2C platform data
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-cgbc-i2c-storage-devices-support-v3-2-594b53fbc5ea@bootlin.com>
References: <20260911-cgbc-i2c-storage-devices-support-v3-0-594b53fbc5ea@bootlin.com>
In-Reply-To: <20260911-cgbc-i2c-storage-devices-support-v3-0-594b53fbc5ea@bootlin.com>
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
 MAINTAINERS                            |  1 +
 drivers/mfd/cgbc-core.c                | 39 ++++++++++++++++++++++++++--------
 include/linux/platform_data/i2c-cgbc.h | 22 +++++++++++++++++++
 3 files changed, 53 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6215fcb07770..561f102c2541 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6621,6 +6621,7 @@ F:	drivers/mfd/cgbc-core.c
 F:	drivers/video/backlight/cgbc_bl.c
 F:	drivers/watchdog/cgbc_wdt.c
 F:	include/linux/mfd/cgbc.h
+F:	include/linux/platform_data/i2c-cgbc.h
 
 CONSOLE SUBSYSTEM
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
index 4a409234e66c..321fa3fff2ac 100644
--- a/drivers/mfd/cgbc-core.c
+++ b/drivers/mfd/cgbc-core.c
@@ -16,6 +16,7 @@
 #include <linux/mfd/cgbc.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
+#include <linux/platform_data/i2c-cgbc.h>
 #include <linux/platform_device.h>
 #include <linux/sysfs.h>
 
@@ -55,6 +56,35 @@
 
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
+	{ .name = "cgbc-backlight" },
+	{ .name = "cgbc-gpio" },
+	{ .name = "cgbc-hwmon" },
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
+	{ .name = "cgbc-wdt" },
+};
+
 /* Wait the Board Controller is ready to receive some session commands */
 static int cgbc_wait_device(struct cgbc_device_data *cgbc)
 {
@@ -235,15 +265,6 @@ int cgbc_command(struct cgbc_device_data *cgbc, void *cmd, unsigned int cmd_size
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
diff --git a/include/linux/platform_data/i2c-cgbc.h b/include/linux/platform_data/i2c-cgbc.h
new file mode 100644
index 000000000000..4465e8a7b40e
--- /dev/null
+++ b/include/linux/platform_data/i2c-cgbc.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * i2c-cgbc interface to platform code
+ *
+ * Copyright (C) 2026 congatec GmbH
+ * Author: Thomas Richard <thomas.richard@bootlin.com>
+ */
+
+#ifndef _LINUX_I2C_CGBC_H
+#define _LINUX_I2C_CGBC_H
+
+/**
+ * struct cgbc_platform_data - Platform data of the CGBC I2C driver
+ * @name:		I2C adapter name
+ * @cgbc_bus_id:	I2C bus ID (from Board Controller point of view)
+ */
+struct cgbc_i2c_platform_data {
+	const char *name;
+	int cgbc_bus_id;
+};
+
+#endif /* _LINUX_I2C_CGBC_H */

-- 
2.53.0

