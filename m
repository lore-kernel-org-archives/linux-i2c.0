From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH] i2c: riic, sh_mobile, rcar: Use ARCH_RENESAS
Date: Mon, 22 Feb 2016 10:15:19 +0900
Message-ID: <1456103719-10818-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-i2c@vger.kernel.org

Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.

This is part of an ongoing process to migrate from ARCH_SHMOBILE to
ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/i2c/busses/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Based on the for-next branch of Wolfram's tree on kernel.org.

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index a2e456a0f3e2..faa8e6821fea 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -789,7 +789,7 @@ config I2C_QUP
 
 config I2C_RIIC
 	tristate "Renesas RIIC adapter"
-	depends on ARCH_SHMOBILE || COMPILE_TEST
+	depends on ARCH_RENESAS || COMPILE_TEST
 	help
 	  If you say yes to this option, support will be included for the
 	  Renesas RIIC I2C interface.
@@ -833,7 +833,7 @@ config I2C_SH7760
 config I2C_SH_MOBILE
 	tristate "SuperH Mobile I2C Controller"
 	depends on HAS_DMA
-	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
+	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
 	help
 	  If you say yes to this option, support will be included for the
 	  built-in I2C interface on the Renesas SH-Mobile processor.
@@ -985,7 +985,7 @@ config I2C_XLP9XX
 
 config I2C_RCAR
 	tristate "Renesas R-Car I2C Controller"
-	depends on ARCH_SHMOBILE || COMPILE_TEST
+	depends on ARCH_RENESAS || COMPILE_TEST
 	select I2C_SLAVE
 	help
 	  If you say yes to this option, support will be included for the
-- 
2.1.4
