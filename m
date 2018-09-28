From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] i2c: brcmstb: Allow enabling the driver on DSL SoCs
Date: Fri, 28 Sep 2018 15:39:44 -0700
Message-ID: <20180928223947.20751-1-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: kdasu.kdev@gmail.com, Florian Fainelli <f.fainelli@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jean Delvare <jdelvare@suse.de>, Andy Shevchenko <andy.shevchenko@gmail.com>, M'boumba Cedric Madianga <cedric.madianga@gmail.com>, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Pierre-Yves MORDRET <pierre-yves.mordret@st.com>, Eddie James <eajames@linux.vnet.ibm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

ARCH_BCM_63XX which is used by ARM-based DSL SoCs from Broadcom uses the
same controller, make it possible to select the STB driver and update
the Kconfig and help text a bit.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/i2c/busses/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 451d4ae50e66..fc3fd987f718 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -432,12 +432,13 @@ config I2C_BCM_KONA
 	  If you do not need KONA I2C interface, say N.
 
 config I2C_BRCMSTB
-	tristate "BRCM Settop I2C controller"
-	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
+	tristate "BRCM Settop/DSL I2C controller"
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST || \
+		   ARCH_BCM_63XX
 	default y
 	help
 	  If you say yes to this option, support will be included for the
-	  I2C interface on the Broadcom Settop SoCs.
+	  I2C interface on the Broadcom Settop/DSL SoCs.
 
 	  If you do not need I2C interface, say N.
 
-- 
2.17.1
