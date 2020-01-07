From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 2/2] i2c: exynos: Update Kconfig documentation
Date: Tue,  7 Jan 2020 09:12:59 +0100
Message-ID: <1578384779-15487-2-git-send-email-krzk@kernel.org>
References: <1578384779-15487-1-git-send-email-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1578384779-15487-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Greg KH <greg@kroah.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

Update the help text to reflect current support devices:
1. The Exynos high speed I2C driver supports Exynos5 (ARMv7), Exynos5433
   and Exynos7 (both ARMv8) SoCs,
2. The S3C I2C driver supports S3C, S5Pv210 and Exynos{3,4,5} SoCs.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. New patch
---
 drivers/i2c/busses/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 132e6f374cd7..43984d5a7fad 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -612,12 +612,12 @@ config I2C_EMEV2
 	  I2C interface on the Renesas Electronics EM/EV family of processors.
 
 config I2C_EXYNOS5
-	tristate "Exynos5 high-speed I2C driver"
+	tristate "Exynos high-speed I2C driver"
 	depends on OF
 	depends on ARCH_EXYNOS || COMPILE_TEST
 	default y if ARCH_EXYNOS
 	help
-	  High-speed I2C controller on Exynos5 based Samsung SoCs.
+	  High-speed I2C controller on Exynos5 and newer Samsung SoCs.
 
 config I2C_GPIO
 	tristate "GPIO-based bitbanging I2C"
@@ -936,11 +936,11 @@ config HAVE_S3C2410_I2C
 	  respective Kconfig file.
 
 config I2C_S3C2410
-	tristate "S3C2410 I2C Driver"
+	tristate "S3C/Exynos I2C Driver"
 	depends on HAVE_S3C2410_I2C || COMPILE_TEST
 	help
 	  Say Y here to include support for I2C controller in the
-	  Samsung SoCs.
+	  Samsung SoCs (S3C, S5Pv210, Exynos).
 
 config I2C_SH7760
 	tristate "Renesas SH7760 I2C Controller"
-- 
2.7.4
