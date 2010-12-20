From: Xulei <B33228-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH] I2C: Add support for 64bit system.
Date: Mon, 20 Dec 2010 15:37:34 +0800
Message-ID: <1292830654-7056-1-git-send-email-B33228@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Xulei <B33228-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Currently I2C_MPC supports 32bit system only, then this
modification makes it support 32bit and 64bit system both.

Signed-off-by: Xulei <B33228-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/i2c/busses/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 9c6170c..3392f4b 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -422,7 +422,7 @@ config I2C_IXP2000
 
 config I2C_MPC
 	tristate "MPC107/824x/85xx/512x/52xx/83xx/86xx"
-	depends on PPC32
+	depends on PPC32 || PPC64
 	help
 	  If you say yes to this option, support will be included for the
 	  built-in I2C interface on the MPC107, Tsi107, MPC512x, MPC52xx,
-- 
1.7.0.4
