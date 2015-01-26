From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH] i2c: designware-baytrail: use proper Kconfig dependencies
Date: Mon, 26 Jan 2015 17:49:34 +0100
Message-ID: <1422290974-24561-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: David Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, kbuild-all-JC7UmRfGjtg@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

IOSF_MBI depends on PCI, so we should not select it but depend on it.
This ensures also we compile on X86 only, other archs will break because
of an arch specific include. Also depend on ACPI since this driver uses
it.

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/busses/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 83062b2c0e6b..442408d2e7b7 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -467,8 +467,7 @@ config I2C_DESIGNWARE_PCI
 
 config I2C_DESIGNWARE_BAYTRAIL
 	bool "Intel Baytrail I2C semaphore support"
-	depends on I2C_DESIGNWARE_PLATFORM
-	select IOSF_MBI
+	depends on I2C_DESIGNWARE_PLATFORM && IOSF_MBI && ACPI
 	help
 	  This driver enables managed host access to the PMIC I2C bus on select
 	  Intel BayTrail platforms using the X-Powers AXP288 PMIC. It allows
-- 
2.1.3
