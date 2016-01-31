From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] i2c: uniphier: add COMPILE_TEST option
Date: Sun, 31 Jan 2016 22:34:02 +0900
Message-ID: <1454247242-25167-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

Add COMPILE_TEST for the compilation test coverage.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/i2c/busses/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 0299dfa..a2e456a 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -908,7 +908,7 @@ config I2C_TEGRA
 
 config I2C_UNIPHIER
 	tristate "UniPhier FIFO-less I2C controller"
-	depends on ARCH_UNIPHIER
+	depends on ARCH_UNIPHIER || COMPILE_TEST
 	help
 	  If you say yes to this option, support will be included for
 	  the UniPhier FIFO-less I2C interface embedded in PH1-LD4, PH1-sLD8,
@@ -916,7 +916,7 @@ config I2C_UNIPHIER
 
 config I2C_UNIPHIER_F
 	tristate "UniPhier FIFO-builtin I2C controller"
-	depends on ARCH_UNIPHIER
+	depends on ARCH_UNIPHIER || COMPILE_TEST
 	help
 	  If you say yes to this option, support will be included for
 	  the UniPhier FIFO-builtin I2C interface embedded in PH1-Pro4,
-- 
1.9.1
