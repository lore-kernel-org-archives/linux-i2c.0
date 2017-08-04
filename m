From: Peter Rosin <peda@axentia.se>
Subject: [PATCH] i2c: mux: rename files to not have superfluous prefixes
Date: Fri,  4 Aug 2017 11:07:36 +0200
Message-ID: <20170804090736.13404-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr00122.outbound.protection.outlook.com ([40.107.0.122]:59750
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751285AbdHDJHy (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 4 Aug 2017 05:07:54 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Peter Korsgaard <peter.korsgaard@barco.com>, Michael Hennerich <michael.hennerich@analog.com>, Michael Shych <michaelsh@mellanox.com>, Guenter Roeck <linux@roeck-us.net>

Keep the module names intact using extra lines in the Makefile.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 MAINTAINERS                                                 |  8 ++++----
 drivers/i2c/muxes/Makefile                                  | 13 +++++++++++++
 .../{i2c-arb-gpio-challenge.c => arb-gpio-challenge.c}      |  0
 drivers/i2c/muxes/{i2c-demux-pinctrl.c => demux-pinctrl.c}  |  0
 drivers/i2c/muxes/{i2c-mux-gpio.c => gpio.c}                |  0
 drivers/i2c/muxes/{i2c-mux-gpmux.c => gpmux.c}              |  0
 drivers/i2c/muxes/{i2c-mux-ltc4306.c => ltc4306.c}          |  0
 drivers/i2c/muxes/{i2c-mux-mlxcpld.c => mlxcpld.c}          |  0
 drivers/i2c/muxes/{i2c-mux-pca9541.c => pca9541.c}          |  0
 drivers/i2c/muxes/{i2c-mux-pca954x.c => pca954x.c}          |  0
 drivers/i2c/muxes/{i2c-mux-pinctrl.c => pinctrl.c}          |  0
 drivers/i2c/muxes/{i2c-mux-reg.c => reg.c}                  |  0
 12 files changed, 17 insertions(+), 4 deletions(-)
 rename drivers/i2c/muxes/{i2c-arb-gpio-challenge.c => arb-gpio-challenge.c} (100%)
 rename drivers/i2c/muxes/{i2c-demux-pinctrl.c => demux-pinctrl.c} (100%)
 rename drivers/i2c/muxes/{i2c-mux-gpio.c => gpio.c} (100%)
 rename drivers/i2c/muxes/{i2c-mux-gpmux.c => gpmux.c} (100%)
 rename drivers/i2c/muxes/{i2c-mux-ltc4306.c => ltc4306.c} (100%)
 rename drivers/i2c/muxes/{i2c-mux-mlxcpld.c => mlxcpld.c} (100%)
 rename drivers/i2c/muxes/{i2c-mux-pca9541.c => pca9541.c} (100%)
 rename drivers/i2c/muxes/{i2c-mux-pca954x.c => pca954x.c} (100%)
 rename drivers/i2c/muxes/{i2c-mux-pinctrl.c => pinctrl.c} (100%)
 rename drivers/i2c/muxes/{i2c-mux-reg.c => reg.c} (100%)

Hi Wolfram!

In the light of the rant from Linus the other week [1], I thought this
might be a good idea?

Cheers,
peda

[1] https://lkml.org/lkml/2017/7/12/430

diff --git a/MAINTAINERS b/MAINTAINERS
index 205d3977ac46..46356c87f0c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5687,7 +5687,7 @@ GENERIC GPIO I2C MULTIPLEXER DRIVER
 M:	Peter Korsgaard <peter.korsgaard@barco.com>
 L:	linux-i2c@vger.kernel.org
 S:	Supported
-F:	drivers/i2c/muxes/i2c-mux-gpio.c
+F:	drivers/i2c/muxes/gpio.c
 F:	include/linux/i2c-mux-gpio.h
 F:	Documentation/i2c/muxes/i2c-mux-gpio
 
@@ -7998,7 +7998,7 @@ M:	Michael Hennerich <michael.hennerich@analog.com>
 W:	http://ez.analog.com/community/linux-device-drivers
 L:	linux-i2c@vger.kernel.org
 S:	Supported
-F:	drivers/i2c/muxes/i2c-mux-ltc4306.c
+F:	drivers/i2c/muxes/ltc4306.c
 F:	Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
 
 LTP (Linux Test Project)
@@ -8558,7 +8558,7 @@ M:	Michael Shych <michaelsh@mellanox.com>
 L:	linux-i2c@vger.kernel.org
 S:	Supported
 F:	drivers/i2c/busses/i2c-mlxcpld.c
-F:	drivers/i2c/muxes/i2c-mux-mlxcpld.c
+F:	drivers/i2c/muxes/mlxcpld.c
 F:	Documentation/i2c/busses/i2c-mlxcpld
 
 MELLANOX MLXCPLD LED DRIVER
@@ -10018,7 +10018,7 @@ PCA9541 I2C BUS MASTER SELECTOR DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-i2c@vger.kernel.org
 S:	Maintained
-F:	drivers/i2c/muxes/i2c-mux-pca9541.c
+F:	drivers/i2c/muxes/pca9541.c
 
 PCDP - PRIMARY CONSOLE AND DEBUG PORT
 M:	Khalid Aziz <khalid@gonehiking.org>
diff --git a/drivers/i2c/muxes/Makefile b/drivers/i2c/muxes/Makefile
index 4a67d3199877..b9f7a78d7604 100644
--- a/drivers/i2c/muxes/Makefile
+++ b/drivers/i2c/muxes/Makefile
@@ -1,6 +1,19 @@
 #
 # Makefile for multiplexer I2C chip drivers.
 
+i2c-arb-gpio-challenge-objs	:= arb-gpio-challenge.o
+
+i2c-demux-pinctrl-objs		:= demux-pinctrl.o
+
+i2c-mux-gpio-objs		:= gpio.o
+i2c-mux-gpmux-objs		:= gpmux.o
+i2c-mux-ltc4306-objs		:= ltc4306.o
+i2c-mux-mlxcpld-objs		:= mlxcpld.o
+i2c-mux-pca9541-objs		:= pca9541.o
+i2c-mux-pca954x-objs		:= pca954x.o
+i2c-mux-pinctrl-objs		:= pinctrl.o
+i2c-mux-reg-objs		:= reg.o
+
 obj-$(CONFIG_I2C_ARB_GPIO_CHALLENGE)	+= i2c-arb-gpio-challenge.o
 
 obj-$(CONFIG_I2C_DEMUX_PINCTRL)		+= i2c-demux-pinctrl.o
diff --git a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c b/drivers/i2c/muxes/arb-gpio-challenge.c
similarity index 100%
rename from drivers/i2c/muxes/i2c-arb-gpio-challenge.c
rename to drivers/i2c/muxes/arb-gpio-challenge.c
diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/demux-pinctrl.c
similarity index 100%
rename from drivers/i2c/muxes/i2c-demux-pinctrl.c
rename to drivers/i2c/muxes/demux-pinctrl.c
diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/gpio.c
similarity index 100%
rename from drivers/i2c/muxes/i2c-mux-gpio.c
rename to drivers/i2c/muxes/gpio.c
diff --git a/drivers/i2c/muxes/i2c-mux-gpmux.c b/drivers/i2c/muxes/gpmux.c
similarity index 100%
rename from drivers/i2c/muxes/i2c-mux-gpmux.c
rename to drivers/i2c/muxes/gpmux.c
diff --git a/drivers/i2c/muxes/i2c-mux-ltc4306.c b/drivers/i2c/muxes/ltc4306.c
similarity index 100%
rename from drivers/i2c/muxes/i2c-mux-ltc4306.c
rename to drivers/i2c/muxes/ltc4306.c
diff --git a/drivers/i2c/muxes/i2c-mux-mlxcpld.c b/drivers/i2c/muxes/mlxcpld.c
similarity index 100%
rename from drivers/i2c/muxes/i2c-mux-mlxcpld.c
rename to drivers/i2c/muxes/mlxcpld.c
diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/pca9541.c
similarity index 100%
rename from drivers/i2c/muxes/i2c-mux-pca9541.c
rename to drivers/i2c/muxes/pca9541.c
diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/pca954x.c
similarity index 100%
rename from drivers/i2c/muxes/i2c-mux-pca954x.c
rename to drivers/i2c/muxes/pca954x.c
diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/pinctrl.c
similarity index 100%
rename from drivers/i2c/muxes/i2c-mux-pinctrl.c
rename to drivers/i2c/muxes/pinctrl.c
diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/reg.c
similarity index 100%
rename from drivers/i2c/muxes/i2c-mux-reg.c
rename to drivers/i2c/muxes/reg.c
-- 
2.11.0
