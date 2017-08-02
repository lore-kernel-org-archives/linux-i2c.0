From: Peter Rosin <peda@axentia.se>
Subject: [PATCH] i2c: mux: i2c-arb-gpio-challenge: allow compiling w/o OF support
Date: Wed,  2 Aug 2017 11:32:51 +0200
Message-ID: <20170802093251.29567-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

It simplifies some tests.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
index 1bba95ecc7c0..55a10946abb6 100644
--- a/drivers/i2c/muxes/Kconfig
+++ b/drivers/i2c/muxes/Kconfig
@@ -8,7 +8,7 @@ menu "Multiplexer I2C Chip support"
 config I2C_ARB_GPIO_CHALLENGE
 	tristate "GPIO-based I2C arbitration"
 	depends on GPIOLIB || COMPILE_TEST
-	depends on OF
+	depends on OF || COMPILE_TEST
 	help
 	  If you say yes to this option, support will be included for an
 	  I2C multimaster arbitration scheme using GPIOs and a challenge &
-- 
2.11.0
