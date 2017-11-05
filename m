From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 1/2] ARM: pxa: move declarations to proper place
Date: Sun,  5 Nov 2017 15:12:25 +0100
Message-ID: <20171105141226.13624-2-wsa@the-dreams.de>
References: <20171105141226.13624-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:47360 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751192AbdKEOMi (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 5 Nov 2017 09:12:38 -0500
In-Reply-To: <20171105141226.13624-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Robert Jarzmik <robert.jarzmik@free.fr>, Wolfram Sang <wsa@the-dreams.de>

Platform data is not the right place for such declarations, use
devices.h in the mach-directory where the rest is located. Note that the
board file for Zeus needed an additional include for this to work.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 arch/arm/mach-pxa/devices.h |  9 +++++++++
 arch/arm/mach-pxa/zeus.c    |  1 +
 include/linux/i2c/pxa-i2c.h | 11 -----------
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-pxa/devices.h b/arch/arm/mach-pxa/devices.h
index 04580c407276cd..dfd0d121fc1799 100644
--- a/arch/arm/mach-pxa/devices.h
+++ b/arch/arm/mach-pxa/devices.h
@@ -55,3 +55,12 @@ extern struct platform_device pxa93x_device_gpio;
 
 void __init pxa_register_device(struct platform_device *dev, void *data);
 void __init pxa2xx_set_dmac_info(int nb_channels, int nb_requestors);
+
+struct i2c_pxa_platform_data;
+extern void pxa_set_i2c_info(struct i2c_pxa_platform_data *info);
+#ifdef CONFIG_PXA27x
+extern void pxa27x_set_i2c_power_info(struct i2c_pxa_platform_data *info);
+#endif
+#ifdef CONFIG_PXA3xx
+extern void pxa3xx_set_i2c_power_info(struct i2c_pxa_platform_data *info);
+#endif
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index ecbcaee5a2d5f8..8b16ba46c8c3bf 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -40,6 +40,7 @@
 #include <asm/mach/map.h>
 
 #include "pxa27x.h"
+#include "devices.h"
 #include <mach/regs-uart.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <linux/platform_data/mmc-pxamci.h>
diff --git a/include/linux/i2c/pxa-i2c.h b/include/linux/i2c/pxa-i2c.h
index 53aab243cbd834..5236f216dfaefd 100644
--- a/include/linux/i2c/pxa-i2c.h
+++ b/include/linux/i2c/pxa-i2c.h
@@ -71,15 +71,4 @@ struct i2c_pxa_platform_data {
 	unsigned char		master_code;
 	unsigned long		rate;
 };
-
-extern void pxa_set_i2c_info(struct i2c_pxa_platform_data *info);
-
-#ifdef CONFIG_PXA27x
-extern void pxa27x_set_i2c_power_info(struct i2c_pxa_platform_data *info);
-#endif
-
-#ifdef CONFIG_PXA3xx
-extern void pxa3xx_set_i2c_power_info(struct i2c_pxa_platform_data *info);
-#endif
-
 #endif
-- 
2.11.0
