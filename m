From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 06/27] i2c: Allow compile test of GPIO consumers if !GPIOLIB
Date: Tue,  5 May 2015 18:32:22 +0200
Message-ID: <1430843563-18615-6-git-send-email-geert@linux-m68k.org>
References: <1430836404-15513-1-git-send-email-geert@linux-m68k.org>
 <1430843563-18615-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430843563-18615-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The GPIO subsystem provides dummy GPIO consumer functions if GPIOLIB is
not enabled. Hence drivers that depend on GPIOLIB, but use GPIO consumer
functionality only, can still be compiled if GPIOLIB is not enabled.

Relax the dependency on GPIOLIB if COMPILE_TEST is enabled, where
appropriate.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org
---
 drivers/i2c/busses/Kconfig | 4 ++--
 drivers/i2c/muxes/Kconfig  | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 2255af23b9c70e69..5c9750ac486cdfa5 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -419,7 +419,7 @@ config I2C_CADENCE
 
 config I2C_CBUS_GPIO
 	tristate "CBUS I2C driver"
-	depends on GPIOLIB
+	depends on GPIOLIB || COMPILE_TEST
 	help
 	  Support for CBUS access using I2C API. Mostly relevant for Nokia
 	  Internet Tablets (770, N800 and N810).
@@ -525,7 +525,7 @@ config I2C_EXYNOS5
 
 config I2C_GPIO
 	tristate "GPIO-based bitbanging I2C"
-	depends on GPIOLIB
+	depends on GPIOLIB || COMPILE_TEST
 	select I2C_ALGOBIT
 	help
 	  This is a very simple bitbanging I2C driver utilizing the
diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
index f6d313e528de3453..fdd0769c84a31a02 100644
--- a/drivers/i2c/muxes/Kconfig
+++ b/drivers/i2c/muxes/Kconfig
@@ -7,7 +7,8 @@ menu "Multiplexer I2C Chip support"
 
 config I2C_ARB_GPIO_CHALLENGE
 	tristate "GPIO-based I2C arbitration"
-	depends on GPIOLIB && OF
+	depends on GPIOLIB || COMPILE_TEST
+	depends on OF
 	help
 	  If you say yes to this option, support will be included for an
 	  I2C multimaster arbitration scheme using GPIOs and a challenge &
@@ -40,7 +41,7 @@ config I2C_MUX_PCA9541
 
 config I2C_MUX_PCA954x
 	tristate "Philips PCA954x I2C Mux/switches"
-	depends on GPIOLIB
+	depends on GPIOLIB || COMPILE_TEST
 	help
 	  If you say yes here you get support for the Philips PCA954x
 	  I2C mux/switch devices.
-- 
1.9.1
