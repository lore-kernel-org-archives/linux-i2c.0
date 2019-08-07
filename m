From: Schrempf Frieder <frieder.schrempf@kontron.de>
Subject: [PATCH] i2c: imx: Allow the driver to be built for ARM64 SoCs such as
 i.MX8M
Date: Wed, 7 Aug 2019 11:44:06 +0000
Message-ID: <20190807114332.13312-1-frieder.schrempf@kontron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Juergen Fitschen <jfi@ssv-embedded.de>, Ajay Gupta <ajayg@nvidia.com>, Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>, Vignesh R <vigneshr@ti.com>, Elie Morisse <syniurge@gmail.com>, Stefan Roese <sr@denx.de>, Paul Cercueil <paul@crapouillou.net>, Kamal Dasu <kdasu.kdev@gmail.com>, Schrempf Frieder <frieder.schrempf@kontron.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The imx I2C controller is used in some ARM64 SoCs such as i.MX8M.
To make use of it, append ARM64 to the list of dependencies.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 09367fc014c3..46b653621513 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -664,7 +664,7 @@ config I2C_IMG
 
 config I2C_IMX
 	tristate "IMX I2C interface"
-	depends on ARCH_MXC || ARCH_LAYERSCAPE || COLDFIRE
+	depends on ARCH_MXC || ARCH_LAYERSCAPE || COLDFIRE || ARM64
 	help
 	  Say Y here if you want to use the IIC bus controller on
 	  the Freescale i.MX/MXC, Layerscape or ColdFire processors.
-- 
2.17.1
