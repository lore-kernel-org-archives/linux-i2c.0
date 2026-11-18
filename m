Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794999010;
	b=fWOG5B89ZX3mXYRcmcDc3E4UqFbYitKdoGLnY7U4k380Z5QWKhQtjSKfturI/NcDyBsn
	 N68S5jGR9QqkrY7EGItqac8SQK38taGu6hYGFe6Ku8MOtp0TwWn2GFP0tZGcGuivYxxpt
	 4qsCXiyLXWksGVqJTOihLessOFaXbKO0DdM+nFd6hWEBojVOyxmavrAFVZyFJfv7UrW4u
	 opovDC1CiozFERywAzAOncHQwwl0XnU4Waad6ZsPjKGB++XJJfdZ1QwCu92bbZ8zXSR1f
	 TFxsoXw1aEgJogF+TxhDS5Z+Q82DLnDYP+RXGngXQDUW9xAwwRu3HB0XIf/hOf3NLGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pcrm3vnLSGimQb5rCI5RJTtZbp3UKYK7ig1rjNTiXnM=;
	b=Qe7Ip5GcxcgrvdE7y/YtNenYuHXFaFL057BsaBrj4sl0e4vtK0gJI/aF143LnKt/sPPh
	 fr8N7DyfYvUzdtw+tFDcb65XQXwJ6HCOYqlTpw+3Js1Tb4WB0vZsaaKCgJ2uJC7vo9SWl
	 SA/2B7x8ZMcmYrSbhxREn/fgbPe+6WWXW4v5JFBNkIGmIaVOoqUmSsALeVxgzpp3LRIwa
	 9zqQIsdxhQ31xkyPpVRYHYDkAqldUylSGUKe2H/0j9RmHONXkki0mhjWy6J+gs9s8mfmS
	 g+odInh3nivFzbvJn/Nfy8STGGACSPk/XY1gOKrsp6Fa0+HLwK66TCFiBS54qIvebQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VjYIpOgJ;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABB7606A325
	for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 10:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AABB7606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VjYIpOgJ
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-38318d69173so199642eec.0
        for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 02:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794999009; x=1795603809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pcrm3vnLSGimQb5rCI5RJTtZbp3UKYK7ig1rjNTiXnM=;
        b=VjYIpOgJ5WkRQHK1x1tOlm+PipZQNIeO7ws2Qxf+gGLE8nsTRg+6cwQvBAcEdJ6FuP
         W9o86ptdUA9vgM5aIGJtsZzKoV2TD4kciDHci39IlVR6UgSf8aVWFRSk1UlZr87w7fxk
         Nwf7Oq0Mulw5hKiuT+StH12IqeiTwEesX6AyzGtpvlCMoEa7VJxtoz3as+DabHUDkZFR
         ESkND7xTxQQk+YPUD6fs6k4Deq46VD+ncjZ84psj8ZWjQlU7MIZTxRH/1QBOhcKrk7dX
         3e8DWMMcyLM07Z3F8orjVGQX2++0QDlVKZjJ5X71xOqXKfIOMlIIMq2ecweTLjERQ8TI
         E9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794999009; x=1795603809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pcrm3vnLSGimQb5rCI5RJTtZbp3UKYK7ig1rjNTiXnM=;
        b=yNE/XHZZO2ok0hrnRv7XE6yJdbAPPRxi9uSkc/2ooZCl45BHPTCzUjLg8zhJvJ32uZ
         vDFWgtKphKs32mWJ0u8n4GdGk4tcJ07bj6QS2zpxRefzn/XoWdfwp/gx4Qq7uKiVbnpG
         UdV3Ly2a3oXAW0LaWpVmEpq+QYoyoRjneDZ9fq0ZSSk/EL2iNbV3bCc0Urlfe2Jp/Xek
         5sa8X7KPQrWFhwjSw7hYZg5YySVY9E5nx/YwDRqx7AdENZ3SWwlH3Kebla73k90oF0sv
         Bx5w+lWl7wV/2c4M8jrGrAhQVtcf0RBxfw0GoppentM+IEZfvLCJ3LN8XmLd5lK9D5jQ
         QHFw==
X-Forwarded-Encrypted: i=1; AL+hErGM/JjBagbEbIk7frbpsrfrV2LISyS+r87/NsakmxX319Qc/sroT34tgX1M7bqq5BwMDNU97l307mc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9bf9HFphEF264aleN+o+MR4pca9uoKjnLSKwUsHH0tIKwh03l+
	mzXDHSlmL05PuZWmJ1o7pCuPzdWg6DWZMccU61y8yni/JECJbWKK9bfc
X-Gm-Gg: AZFdTZdsEvyI5CzK9U9Ex4IQyMrM53dUXIvK74+cC5mdqSRIpShIBXnkdZ19X528sMm
	U5UE7JQ1B3FUa2lckaxisMsd4vHkgcRJD8q8mO3CyJMStTpsd6U3IbvDzPAIEWXYwYH+kSSa9su
	wcWCokJ8gDeJVi5CC4GQQT9Paf0aMXGSRR3lVIDgnII3PH5jB/O7FlqAj6I0dE8d5xSZMO1eYSB
	V3jEh5R6LklWAjjL5EWlbV1wVEiJntaCQuTzLDryJkhkUHURH2iM3bMfl/WXQeEdMJ+BiLw3mPx
	HQGzMAwKUFi0PH90Pt9vXJTJnL66Vg5DW3S4LhVRu0canS4nzpBZOfhKS+kTx5POUsymRoc4Vwb
	TSpDNYLHBmcYovcKlC1fg0ucAkIe2anSfLYvOhmFrLgXeC1E6e7rMjiXpBeyeFUxDsEY75rGG1f
	Tk/9wQlWsFm2lhuM1ZaEQ/Gg1Ip7wT0erHY6CtJJVPJHVCOxgH0BMKCWDR+KSTECvkvypSRcxRa
	AWy6sRWkOLAsmFk3pHzTL3M1JibHZwOxPiiHdsiyS67KthE2IOGwLs1kRaCeRn5okGTOVGRScO9
	lFo4L7CkRqbYSqaLjH7ac91x1qC2DwE8
X-Received: by 2002:a05:693c:2113:b0:37a:a9db:6bd2 with SMTP id 5a478bee46e88-3828026960bmr2342283eec.11.1794999008833;
        Wed, 18 Nov 2026 02:50:08 -0800 (PST)
Received: from archl-rock5b ([45.112.0.182])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a45260a8sm11729913eec.3.2026.11.18.02.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 02:50:08 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>,
	Aurelien Jarno <aurelien@aurel32.net>,
	linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-i2c@vger.kernel.org (open list:I2C SUBSYSTEM HOST DRIVERS),
	linux-pm@vger.kernel.org (open list:SYSTEM RESET/SHUTDOWN DRIVERS),
	spacemit@lists.linux.dev (open list:RISC-V SPACEMIT SoC Support)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v2 3/3] power: reset: Remove SpacemiT P1 reboot driver
Date: Wed, 18 Nov 2026 16:19:15 +0530
Message-ID: <20261118104935.1716-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118104935.1716-1-linux.amoon@gmail.com>
References: <20261118104935.1716-1-linux.amoon@gmail.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SpacemiT P1 reboot driver uses I2C-backed regmap operations to
request system shutdown and restart through the PMIC.

The system-off handlers run in atomic context, where regmap operations
may sleep. This can trigger invalid wait context and
scheduling-while-atomic warnings during shutdown or restart.

On SpacemiT K1 platforms, system poweroff and restart are handled by
OpenSBI through the SBI System Reset (SRST) extension. The Linux PMIC
reboot driver duplicates this firmware functionality and is no longer
needed.

Remove the driver along with its Kconfig and Makefile entries.
The P1 MFD driver and its other functionality remain unaffected.

Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
New patch
---
 drivers/power/reset/Kconfig              |  9 ---
 drivers/power/reset/Makefile             |  1 -
 drivers/power/reset/spacemit-p1-reboot.c | 87 ------------------------
 3 files changed, 97 deletions(-)
 delete mode 100644 drivers/power/reset/spacemit-p1-reboot.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index bce996bbef28..9e997d58fcc6 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -295,15 +295,6 @@ config POWER_RESET_KEYSTONE
 	help
 	  Reboot support for the KEYSTONE SoCs.
 
-config POWER_RESET_SPACEMIT_P1
-	tristate "SpacemiT P1 poweroff and reset driver"
-	depends on ARCH_SPACEMIT || COMPILE_TEST
-	depends on MFD_SPACEMIT_P1
-	default MFD_SPACEMIT_P1
-	help
-	  This driver supports power-off and reset operations for the SpacemiT
-	  P1 PMIC.
-
 config POWER_RESET_SYSCON
 	bool "Generic SYSCON regmap reset driver"
 	depends on OF
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index e31cab4ba78e..2d5bdd1584cc 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -25,7 +25,6 @@ obj-$(CONFIG_POWER_RESET_LTC2952) += ltc2952-poweroff.o
 obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
 obj-$(CONFIG_POWER_RESET_REGULATOR) += regulator-poweroff.o
 obj-$(CONFIG_POWER_RESET_RESTART) += restart-poweroff.o
-obj-$(CONFIG_POWER_RESET_SPACEMIT_P1) += spacemit-p1-reboot.o
 obj-$(CONFIG_POWER_RESET_ST) += st-poweroff.o
 obj-$(CONFIG_POWER_RESET_TH1520_AON) += th1520-aon-reboot.o
 obj-$(CONFIG_POWER_RESET_TORADEX_EC) += tdx-ec-poweroff.o
diff --git a/drivers/power/reset/spacemit-p1-reboot.c b/drivers/power/reset/spacemit-p1-reboot.c
deleted file mode 100644
index c0454b547718..000000000000
--- a/drivers/power/reset/spacemit-p1-reboot.c
+++ /dev/null
@@ -1,87 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2025 by Aurelien Jarno
- */
-
-#include <linux/bits.h>
-#include <linux/platform_device.h>
-#include <linux/regmap.h>
-#include <linux/reboot.h>
-
-/* Power Control Register 2 */
-#define PWR_CTRL2		0x7e
-#define PWR_CTRL2_SHUTDOWN	BIT(2)	/* Shutdown request */
-#define PWR_CTRL2_RST		BIT(1)	/* Reset request */
-
-static int spacemit_p1_pwroff_handler(struct sys_off_data *data)
-{
-	struct regmap *regmap = data->cb_data;
-	int ret;
-
-	/* Put the PMIC into shutdown state */
-	ret = regmap_set_bits(regmap, PWR_CTRL2, PWR_CTRL2_SHUTDOWN);
-	if (ret) {
-		dev_err(data->dev, "shutdown failed: %d\n", ret);
-		return notifier_from_errno(ret);
-	}
-
-	return NOTIFY_DONE;
-}
-
-static int spacemit_p1_restart_handler(struct sys_off_data *data)
-{
-	struct regmap *regmap = data->cb_data;
-	int ret;
-
-	/* Put the PMIC into reset state */
-	ret = regmap_set_bits(regmap, PWR_CTRL2, PWR_CTRL2_RST);
-	if (ret) {
-		dev_err(data->dev, "restart failed: %d\n", ret);
-		return notifier_from_errno(ret);
-	}
-
-	return NOTIFY_DONE;
-}
-
-static int spacemit_p1_reboot_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct regmap *regmap;
-	int ret;
-
-	regmap = dev_get_regmap(dev->parent, NULL);
-	if (!regmap)
-		return -ENODEV;
-
-	ret = devm_register_power_off_handler(dev, &spacemit_p1_pwroff_handler,
-					      regmap);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Failed to register power off handler\n");
-
-	ret = devm_register_restart_handler(dev, spacemit_p1_restart_handler,
-					    regmap);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Failed to register restart handler\n");
-
-	return 0;
-}
-
-static const struct platform_device_id spacemit_p1_reboot_id_table[] = {
-	{ .name = "spacemit-p1-reboot" },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(platform, spacemit_p1_reboot_id_table);
-
-static struct platform_driver spacemit_p1_reboot_driver = {
-	.driver = {
-		.name = "spacemit-p1-reboot",
-	},
-	.probe = spacemit_p1_reboot_probe,
-	.id_table = spacemit_p1_reboot_id_table,
-};
-module_platform_driver(spacemit_p1_reboot_driver);
-
-MODULE_DESCRIPTION("SpacemiT P1 reboot/poweroff driver");
-MODULE_LICENSE("GPL");
-- 
2.56.0

