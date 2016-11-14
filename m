From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2] i2c: mux: fix up dependencies
Date: Mon, 14 Nov 2016 15:34:17 +0100
Message-ID: <1479134057-30653-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:33552 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752752AbcKNOeX (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 14 Nov 2016 09:34:23 -0500
Received: by mail-lf0-f41.google.com with SMTP id c13so59536780lfg.0
        for <linux-i2c@vger.kernel.org>; Mon, 14 Nov 2016 06:34:22 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, stable@vger.kernel.org, Jonathan Cameron <jic23@jic23.retrosnub.co.uk>, Peter Rosin <peda@axentia.se>

We get the following build error from UM Linux after adding
an entry to drivers/iio/gyro/Kconfig that issues "select I2C_MUX":

ERROR: "devm_ioremap_resource"
   [drivers/i2c/muxes/i2c-mux-reg.ko] undefined!
ERROR: "of_address_to_resource"
   [drivers/i2c/muxes/i2c-mux-reg.ko] undefined!

It appears that the I2C mux core code depends on HAS_IOMEM
for historical reasons, while CONFIG_I2C_MUX_REG does *not*
have a direct dependency on HAS_IOMEM.

This creates a situation where a allyesconfig or allmodconfig
for UM Linux will select I2C_MUX, and will implicitly enable
I2C_MUX_REG as well, and the compilation will fail for the
register driver.

Fix this up by making I2C_MUX_REG depend on HAS_IOMEM and
removing the dependency from I2C_MUX.

Cc: stable@vger.kernel.org
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Reported-by: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Peter Rosin <peda@axentia.se>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Drop the assumed dependency on OF from I2C_MUX
---
 drivers/i2c/Kconfig       | 1 -
 drivers/i2c/muxes/Kconfig | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index d223650a97e4..11edabf425ae 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -59,7 +59,6 @@ config I2C_CHARDEV
 
 config I2C_MUX
 	tristate "I2C bus multiplexing support"
-	depends on HAS_IOMEM
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
