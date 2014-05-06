From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH] i2c-eg20t: Fix Kconfig dependencies
Date: Tue, 6 May 2014 10:05:21 +0200
Message-ID: <20140506100521.03861792@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: i2c-eg20t: Fix Kconfig dependencies

The i2c-eg20t driver is for a companion chip to the Intel Atom E600
series processors. These are 32-bit x86 processors so the driver is
only needed on X86_32. Add COMPILE_TEST as an alternative, so that the
driver can still be build-tested elsewhere.

Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/busses/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.15-rc4.orig/drivers/i2c/busses/Kconfig	2014-04-14 09:42:29.899075210 +0200
+++ linux-3.15-rc4/drivers/i2c/busses/Kconfig	2014-05-06 09:59:00.175785765 +0200
@@ -449,7 +449,7 @@ config I2C_EFM32
 
 config I2C_EG20T
 	tristate "Intel EG20T PCH/LAPIS Semicon IOH(ML7213/ML7223/ML7831) I2C"
-	depends on PCI
+	depends on PCI && (X86_32 || COMPILE_TEST)
 	help
 	  This driver is for PCH(Platform controller Hub) I2C of EG20T which
 	  is an IOH(Input/Output Hub) for x86 embedded processor.


-- 
Jean Delvare
SUSE L3 Support
