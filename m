From: Jayachandran C <jnair@caviumnetworks.com>
Subject: [PATCH] i2c: xlp9xx: update for ARCH_THUNDER2
Date: Sun, 12 Mar 2017 10:54:55 +0000
Message-ID: <1489316095-5244-1-git-send-email-jnair@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-dm3nam03on0077.outbound.protection.outlook.com ([104.47.41.77]:51684
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755694AbdCLKzQ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 12 Mar 2017 06:55:16 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: Jayachandran C <jnair@caviumnetworks.com>

ARCH_VULCAN arm64 platform (for Broadcom Vulcan ARM64 processors) has
been discontinued. Cavium's ThunderX2 CN99XX (ARCH_THUNDER2) will be
the next revision of the platform.

Update compile dependencies and ACPI ID to reflect this change. There
is not need to retain ARCH_VULCAN since the Vulcan processor was never
in production and the config option will be removed soon.

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
---
 drivers/i2c/busses/Kconfig      | 2 +-
 drivers/i2c/busses/i2c-xlp9xx.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 8adc0f1..cbdb274 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -1021,7 +1021,7 @@ config I2C_XLR
 
 config I2C_XLP9XX
 	tristate "XLP9XX I2C support"
-	depends on CPU_XLP || ARCH_VULCAN || COMPILE_TEST
+	depends on CPU_XLP || ARCH_THUNDER2 || COMPILE_TEST
 	help
 	  This driver enables support for the on-chip I2C interface of
 	  the Broadcom XLP9xx/XLP5xx MIPS and Vulcan ARM64 processors.
diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
index 66b464d..ae80228 100644
--- a/drivers/i2c/busses/i2c-xlp9xx.c
+++ b/drivers/i2c/busses/i2c-xlp9xx.c
@@ -432,6 +432,7 @@ MODULE_DEVICE_TABLE(of, xlp9xx_i2c_of_match);
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id xlp9xx_i2c_acpi_ids[] = {
 	{"BRCM9007", 0},
+	{"CAV9007",  0},
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, xlp9xx_i2c_acpi_ids);
-- 
2.7.4
