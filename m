From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] i2c: s3c24xx: allow compile-testing
Date: Tue,  7 Jan 2020 22:53:53 +0100
Message-ID: <20200107215406.1632417-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Max Staudt <max@enpas.org>, Juergen Fitschen <jfi@ssv-embedded.de>, Elie Morisse <syniurge@gmail.com>, Stefan Roese <sr@denx.de>, Kamal Dasu <kdasu.kdev@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The PHY_EXYNOS5250_SATA driver can now be selected on
any platform for compile testing, but this results in a Kconfig
warning:

WARNING: unmet direct dependencies detected for I2C_S3C2410
  Depends on [n]: I2C [=y] && HAS_IOMEM [=y] && HAVE_S3C2410_I2C [=n]
  Selected by [y]:
  - PHY_EXYNOS5250_SATA [=y] && (SOC_EXYNOS5250 || COMPILE_TEST [=y]) && HAS_IOMEM [=y] && OF [=y]

Allow the I2C driver to be compile-tested as well.

Fixes: 1544133d48c3 ("phy: Enable compile testing for some of drivers")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 6a0aa76859f3..ac453c16483d 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -933,7 +933,7 @@ config HAVE_S3C2410_I2C
 
 config I2C_S3C2410
 	tristate "S3C2410 I2C Driver"
-	depends on HAVE_S3C2410_I2C
+	depends on HAVE_S3C2410_I2C || COMPILE_TEST
 	help
 	  Say Y here to include support for I2C controller in the
 	  Samsung SoCs.
-- 
2.20.0
