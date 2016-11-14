From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] i2c: mux: fix up dependencies
Date: Mon, 14 Nov 2016 14:03:06 +0100
Message-ID: <1479128586-17052-1-git-send-email-linus.walleij@linaro.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, stable@vger.kernel.org, Jonathan Cameron <jic23@jic23.retrosnub.co.uk>, Peter Rosin <peda@axentia.se>
List-Id: linux-i2c@vger.kernel.org

We get the following build error from UM Linux after adding
an entry to drivers/iio/gyro/Kconfig that issues "select I2C_MUX":

ERROR: "devm_ioremap_resource"
   [drivers/i2c/muxes/i2c-mux-reg.ko] undefined!
ERROR: "of_address_to_resource"
   [drivers/i2c/muxes/i2c-mux-reg.ko] undefined!

It appears that the I2C mux core code actually only requires
CONFIG_OF, but depends on HAS_IOMEM for historical reasons,
while CONFIG_I2C_MUX_REG does *not* have a direct dependency
on HAS_IOMEM.

This creates a situation where a allyesconfig or allmodconfig
for UM Linux will select I2C_MUX, and will implicitly enable
I2C_MUX_REG as well, and the compilation will fail for the
register driver.

Fix this up by making I2C_MUX_REG depend on HAS_IOMEM and
the I2C_MUX depend on OF.

Cc: stable@vger.kernel.org
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Reported-by: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Peter Rosin <peda@axentia.se>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/i2c/Kconfig       | 2 +-
 drivers/i2c/muxes/Kconfig | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index d223650a97e4..b9e378cfe1d1 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -59,7 +59,7 @@ config I2C_CHARDEV
 
 config I2C_MUX
 	tristate "I2C bus multiplexing support"
-	depends on HAS_IOMEM
+	depends on OF
 	help
 	  Say Y here if you want the I2C core to support the ability to
 	  handle multiplexed I2C bus topologies, by presenting each
diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
index e280c8ecc0b5..96de9ce5669b 100644
--- a/drivers/i2c/muxes/Kconfig
+++ b/drivers/i2c/muxes/Kconfig
@@ -63,6 +63,7 @@ config I2C_MUX_PINCTRL
 
 config I2C_MUX_REG
 	tristate "Register-based I2C multiplexer"
+	depends on HAS_IOMEM
 	help
 	  If you say yes to this option, support will be included for a
 	  register based I2C multiplexer. This driver provides access to
-- 
2.7.4
