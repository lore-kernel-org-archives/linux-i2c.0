From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v2] i2c: brcmstb: Allow enabling the driver on DSL SoCs
Date: Mon,  1 Oct 2018 10:43:47 -0700
Message-ID: <20181001174349.26357-1-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: kdasu.kdev@gmail.com, geert@linux-m68k.org, Florian Fainelli <f.fainelli@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jean Delvare <jdelvare@suse.de>, Andy Shevchenko <andy.shevchenko@gmail.com>, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Eddie James <eajames@linux.vnet.ibm.com>, James Hogan <jhogan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

ARCH_BCM_63XX which is used by ARM-based DSL SoCs from Broadcom uses the
same controller, make it possible to select the STB driver and update
the Kconfig and help text a bit.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:

- Make COMPILE_TEST last, as per Geert's recommendation

 drivers/i2c/busses/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 451d4ae50e66..56ccb1ea7da5 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -432,12 +432,13 @@ config I2C_BCM_KONA
 	  If you do not need KONA I2C interface, say N.
 
 config I2C_BRCMSTB
-	tristate "BRCM Settop I2C controller"
-	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
+	tristate "BRCM Settop/DSL I2C controller"
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC || ARCH_BCM_63XX || \
+		   COMPILE_TEST
 	default y
 	help
 	  If you say yes to this option, support will be included for the
-	  I2C interface on the Broadcom Settop SoCs.
+	  I2C interface on the Broadcom Settop/DSL SoCs.
 
 	  If you do not need I2C interface, say N.
 
-- 
2.17.1
