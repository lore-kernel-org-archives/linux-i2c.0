From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH] i2c: I2C_MT65XX should depend on HAS_DMA
Date: Fri, 26 Jun 2015 14:12:10 +0200
Message-ID: <1435320730-5506-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

If NO_DMA=y:

    ERROR: "dma_unmap_single" [drivers/i2c/busses/i2c-mt65xx.ko] undefined!
    ERROR: "dma_mapping_error" [drivers/i2c/busses/i2c-mt65xx.ko] undefined!
    ERROR: "dma_map_single" [drivers/i2c/busses/i2c-mt65xx.ko] undefined!

Add a dependency on HAS_DMA to fix this.

Signed-off-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
---
 drivers/i2c/busses/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 35ac23768ce9662f..577d58d1f1a19881 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -633,6 +633,7 @@ config I2C_MPC
 config I2C_MT65XX
 	tristate "MediaTek I2C adapter"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on HAS_DMA
 	help
 	  This selects the MediaTek(R) Integrated Inter Circuit bus driver
 	  for MT65xx and MT81xx.
-- 
1.9.1
