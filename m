From: Feng Kan <fkan@apm.com>
Subject: [PATCH RESEND V4 2/4] i2c: busses: xgene: add acpi support for i2c xgene SLIMpro driver
Date: Fri, 24 Apr 2015 15:17:51 -0700
Message-ID: <1429913873-13627-3-git-send-email-fkan@apm.com>
References: <1429913873-13627-1-git-send-email-fkan@apm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429913873-13627-1-git-send-email-fkan@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: patches@apm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: Feng Kan <fkan@apm.com>
List-Id: linux-i2c@vger.kernel.org

This adds support for ACPI for the APM X-Gene I2C SLIMpro proxy
driver.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 drivers/i2c/busses/i2c-xgene-slimpro.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/i2c/busses/i2c-xgene-slimpro.c b/drivers/i2c/busses/i2c-xgene-slimpro.c
index f994b8a0..0b33aa2e 100644
--- a/drivers/i2c/busses/i2c-xgene-slimpro.c
+++ b/drivers/i2c/busses/i2c-xgene-slimpro.c
@@ -22,6 +22,7 @@
  * using the APM X-Gene SLIMpro mailbox driver.
  *
  */
+#include <linux/acpi.h>
 #include <linux/dma-mapping.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
@@ -442,12 +443,21 @@ static const struct of_device_id xgene_slimpro_i2c_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, xgene_slimpro_i2c_dt_ids);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id xgene_slimpro_i2c_acpi_ids[] = {
+	{"APMC0D40", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, xgene_slimpro_i2c_acpi_ids);
+#endif
+
 static struct platform_driver xgene_slimpro_i2c_driver = {
 	.probe	= xgene_slimpro_i2c_probe,
 	.remove	= xgene_slimpro_i2c_remove,
 	.driver	= {
 		.name	= "xgene-slimpro-i2c",
 		.of_match_table = of_match_ptr(xgene_slimpro_i2c_dt_ids),
+		.acpi_match_table = ACPI_PTR(xgene_slimpro_i2c_acpi_ids)
 	},
 };
 
-- 
1.9.1
