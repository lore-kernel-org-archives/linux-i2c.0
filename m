From: Tanmay Jagdale <tanmay.jagdale@broadcom.com>
Subject: i2c: xlp9xx: add ACPI support for Broadcom Vulcan
Date: Tue, 24 May 2016 13:39:03 +0530
Message-ID: <1464077343-1665-1-git-send-email-tanmay.jagdale@broadcom.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:54343 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754323AbcEXIJv (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 24 May 2016 04:09:51 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, jayachandran.chandrashekaran@broadcom.com, tanmay.jagdale@broadcom.com

Added ACPI support for the I2C controller present on Broadcom's
Vulcan ARM64 processor. ACPI ID used by the controller is BRCM9007.

Signed-off-by: Tanmay Jagdale <tanmay.jagdale@broadcom.com>
---
 drivers/i2c/busses/i2c-xlp9xx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
index c941418..62a7cff 100644
--- a/drivers/i2c/busses/i2c-xlp9xx.c
+++ b/drivers/i2c/busses/i2c-xlp9xx.c
@@ -13,6 +13,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/acpi.h>
 #include <linux/platform_device.h>
 
 #define XLP9XX_I2C_DIV			0x0
@@ -429,12 +430,21 @@ static const struct of_device_id xlp9xx_i2c_of_match[] = {
 	{ /* sentinel */ },
 };
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id vulcan_i2c_acpi_ids[] = {
+	{"BRCM9007", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, vulcan_i2c_acpi_ids);
+#endif
+
 static struct platform_driver xlp9xx_i2c_driver = {
 	.probe = xlp9xx_i2c_probe,
 	.remove = xlp9xx_i2c_remove,
 	.driver = {
 		.name = "xlp9xx-i2c",
 		.of_match_table = xlp9xx_i2c_of_match,
+		.acpi_match_table = ACPI_PTR(vulcan_i2c_acpi_ids),
 	},
 };
 
-- 
2.1.0
