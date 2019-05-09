From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] i2c: Allow selecting BCM2835 I2C controllers on ARCH_BRCMSTB
Date: Thu,  9 May 2019 14:04:36 -0700
Message-ID: <20190509210438.28223-1-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kamal Dasu <kdasu.kdev@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Eddie James <eajames@linux.vnet.ibm.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Ajay Gupta <ajayg@nvidia.com>, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, Juergen Fitschen <jfi@ssv-embedded.de>, Elie Morisse <syniurge@gmail.com>, "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

From: Kamal Dasu <kdasu.kdev@gmail.com>

ARCH_BRCMSTB platforms have the BCM2835 I2C controllers, allow
selecting the i2c-bcm2835 driver on such platforms.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 26186439db6b..7277c1051ca2 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -435,7 +435,7 @@ config I2C_AXXIA
 
 config I2C_BCM2835
 	tristate "Broadcom BCM2835 I2C controller"
-	depends on ARCH_BCM2835
+	depends on ARCH_BCM2835 || ARCH_BRCMSTB
 	help
 	  If you say yes to this option, support will be included for the
 	  BCM2835 I2C controller.
-- 
2.17.1
