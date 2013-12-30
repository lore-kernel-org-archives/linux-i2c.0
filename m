From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH] i2c: designware: remove HAVE_CLK build dependecy
Date: Mon, 30 Dec 2013 10:31:19 +0200
Message-ID: <f3ebead75d45623e4b649c7a8d0112584ffd1788.1388392279.git.baruch@tkos.co.il>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Since 93abe8e4 (clk: add non CONFIG_HAVE_CLK routines) code using clk.h need
not depend on HAVE_CLK. Also, remove a redundant clk.h include from core driver
file.

Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
 drivers/i2c/busses/Kconfig               | 1 -
 drivers/i2c/busses/i2c-designware-core.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 3b26129..2b6056a 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -412,7 +412,6 @@ config I2C_DESIGNWARE_CORE
 
 config I2C_DESIGNWARE_PLATFORM
 	tristate "Synopsys DesignWare Platform"
-	depends on HAVE_CLK
 	select I2C_DESIGNWARE_CORE
 	help
 	  If you say yes to this option, support will be included for the
diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index e89e3e2..14c4b30 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -26,7 +26,6 @@
  *
  */
 #include <linux/export.h>
-#include <linux/clk.h>
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
-- 
1.8.5.2
