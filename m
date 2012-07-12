From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] i2c: mv64xxxx: remove EXPERIMENTAL tag
Date: Thu, 12 Jul 2012 16:00:06 +0200
Message-ID: <1342101607-21538-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>, Florian Fainelli <ffainelli-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

As git history indicates, the driver might be older than the kernel
itself and is heavily used and worked on since. Not EXPERIMENTAL
anymore.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
Cc: Florian Fainelli <ffainelli-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
---
 drivers/i2c/busses/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index e9f9c5d..52a825a 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -458,7 +458,7 @@ config I2C_MPC
 
 config I2C_MV64XXX
 	tristate "Marvell mv64xxx I2C Controller"
-	depends on (MV64X60 || PLAT_ORION) && EXPERIMENTAL
+	depends on (MV64X60 || PLAT_ORION)
 	help
 	  If you say yes to this option, support will be included for the
 	  built-in I2C interface on the Marvell 64xxx line of host bridges.
-- 
1.7.10.4
