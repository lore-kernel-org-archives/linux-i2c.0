From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH] i2c: designware-baytrail: another fixup for proper Kconfig dependencies
Date: Thu, 19 Feb 2015 17:05:50 +0100
Message-ID: <1424361950-3424-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "David E. Box" <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

IOSF_MBI is tristate. Baytrail driver isn't.

Reported-by: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Acked-by: David E. Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 3de426e..81a3ce9 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -477,7 +477,7 @@ config I2C_DESIGNWARE_PCI
 
 config I2C_DESIGNWARE_BAYTRAIL
 	bool "Intel Baytrail I2C semaphore support"
-	depends on I2C_DESIGNWARE_PLATFORM && IOSF_MBI && ACPI
+	depends on I2C_DESIGNWARE_PLATFORM && IOSF_MBI=y && ACPI
 	help
 	  This driver enables managed host access to the PMIC I2C bus on select
 	  Intel BayTrail platforms using the X-Powers AXP288 PMIC. It allows
-- 
2.1.4
