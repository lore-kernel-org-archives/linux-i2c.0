From: Andrew Bresticker <abrestic@chromium.org>
Subject: [PATCH] i2c: img-scb: Allow building for MIPS
Date: Tue, 18 Nov 2014 15:58:33 -0800
Message-ID: <1416355113-8942-1-git-send-email-abrestic@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>, James Hogan <james.hogan@imgtec.com>, James Hartley <james.hartley@imgtec.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Bresticker <abrestic@chromium.org>
List-Id: linux-i2c@vger.kernel.org

The SCB is present on IMG SoCs other than the META-based TZ1090,
such as the MIPS-based Pistachio SoC.  Relax the Kconfig dependency
so that it can be built on any MIPS or META machine.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
Based on i2c/for-next
---
 drivers/i2c/busses/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 03c6119..16c649a 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -526,10 +526,10 @@ config I2C_IBM_IIC
 
 config I2C_IMG
 	tristate "Imagination Technologies I2C SCB Controller"
-	depends on SOC_TZ1090 || COMPILE_TEST
+	depends on MIPS || METAG || COMPILE_TEST
 	help
 	  Say Y here if you want to use the IMG I2C SCB controller,
-	  available on the TZ1090 SoC.
+	  available on the TZ1090 and other IMG SoCs.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-img-scb.
-- 
2.1.0.rc2.206.gedb03e5
