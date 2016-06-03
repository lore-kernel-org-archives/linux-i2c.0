From: Tanmay Jagdale <tanmay.jagdale@broadcom.com>
Subject: [PATCH v2] i2c: xlp9xx: add ACPI support for Broadcom Vulcan
Date: Fri,  3 Jun 2016 16:44:34 +0530
Message-ID: <1464952474-15714-1-git-send-email-tanmay.jagdale@broadcom.com>
References: <1464077343-1665-1-git-send-email-tanmay.jagdale@broadcom.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:45395 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161050AbcFCLOv (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 3 Jun 2016 07:14:51 -0400
In-Reply-To: <1464077343-1665-1-git-send-email-tanmay.jagdale@broadcom.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, jayachandran.chandrashekaran@broadcom.com, Tanmay Jagdale <tanmay.jagdale@broadcom.com>

Added ACPI support for the I2C controller present on Broadcom's
Vulcan ARM64 processor. ACPI ID used by the controller is BRCM9007.

Changed the xlp9xx_i2c_get_frequency() function to use
device_property_read_u32() API so that the "clock-frequency" value
can be read from _DSD in ACPI mode.

Signed-off-by: Tanmay Jagdale <tanmay.jagdale@broadcom.com>
---
Changes in v2:
	Changed of_property_read_u32() to device_property_read_u32()
	so that the "clock-frequency" can be read from DTS or ACPI.

 drivers/i2c/busses/i2c-xlp9xx.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
index c941418..049aa4d 100644
--- a/drivers/i2c/busses/i2c-xlp9xx.c
+++ b/drivers/i2c/busses/i2c-xlp9xx.c
@@ -13,6 +13,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/acpi.h>
 #include <linux/platform_device.h>
 
 #define XLP9XX_I2C_DIV			0x0
@@ -341,11 +342,10 @@ static struct i2c_algorithm xlp9xx_i2c_algo = {
 static int xlp9xx_i2c_get_frequency(struct platform_device *pdev,
 				    struct xlp9xx_i2c_dev *priv)
 {
-	struct device_node *np = pdev->dev.of_node;
 	u32 freq;
 	int err;
 
-	err = of_property_read_u32(np, "clock-frequency", &freq);
+	err = device_property_read_u32(&pdev->dev, "clock-frequency", &freq);
 	if (err) {
 		freq = XLP9XX_I2C_DEFAULT_FREQ;
 		dev_dbg(&pdev->dev, "using default frequency %u\n", freq);
@@ -429,12 +429,21 @@ static const struct of_device_id xlp9xx_i2c_of_match[] = {
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
