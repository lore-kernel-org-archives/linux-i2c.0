From: Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>
Subject: [PATCH] i2c: mv64xxx: Remove useless parens
Date: Wed, 31 Oct 2012 12:46:05 +0900
Message-ID: <1351655165-27876-1-git-send-email-iwamatsu@nigauri.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org, Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>
---
 drivers/i2c/busses/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 65dd599..38abd47 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -474,7 +474,7 @@ config I2C_MPC
 
 config I2C_MV64XXX
 	tristate "Marvell mv64xxx I2C Controller"
-	depends on (MV64X60 || PLAT_ORION)
+	depends on MV64X60 || PLAT_ORION
 	help
 	  If you say yes to this option, support will be included for the
 	  built-in I2C interface on the Marvell 64xxx line of host bridges.
-- 
1.7.10.4
