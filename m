From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH v2] i2c: mxs: Let i2c-mxs be built for MX23
Date: Fri, 21 Oct 2011 16:27:44 -0200
Message-ID: <1319221664-3018-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

MX23 and MX28 share the same I2C block, so let i2c-mxs be built for MX23 too.

Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
Changes since v1:
- Remove unneeded parenthesis

 drivers/i2c/busses/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 646068e..08748db 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -456,11 +456,11 @@ config I2C_MV64XXX
 	  will be called i2c-mv64xxx.
 
 config I2C_MXS
-	tristate "Freescale i.MX28 I2C interface"
-	depends on SOC_IMX28
+	tristate "Freescale i.MXS I2C interface"
+	depends on SOC_IMX28 || SOC_IMX23
 	help
 	  Say Y here if you want to use the I2C bus controller on
-	  the Freescale i.MX28 processors.
+	  the Freescale i.MXS processors.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-mxs.
-- 
1.7.1
