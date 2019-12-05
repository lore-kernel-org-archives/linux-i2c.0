From: Hyunki Koo <hyunki00.koo@gmail.com>
Subject: [PATCH] ANDROID: i2c: exynos5: remove default enable in Kconfig
Date: Fri,  6 Dec 2019 00:04:58 +0900
Message-ID: <20191205150500.21762-1-hyunki00.koo@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: Hyunki Koo <hyunki00.koo@samsung.com>, Jean Delvare <jdelvare@suse.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Max Staudt <max@enpas.org>, Juergen Fitschen <jfi@ssv-embedded.de>, Krzysztof Kozlowski <krzk@kernel.org>, Elie Morisse <syniurge@gmail.com>, Stefan Roese <sr@denx.de>, Baolin Wang <baolin.wang@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Hyunki Koo <hyunki00.koo@samsung.com>

There are many exynos device and not all exynos device does not have
HSI2C controllers. Thus remove select this by default

Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
---
 drivers/i2c/busses/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 6a0aa76859f3..3955315f48c7 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -612,7 +612,6 @@ config I2C_EMEV2
 config I2C_EXYNOS5
 	tristate "Exynos5 high-speed I2C driver"
 	depends on ARCH_EXYNOS && OF
-	default y
 	help
 	  High-speed I2C controller on Exynos5 based Samsung SoCs.
 
-- 
2.17.1
