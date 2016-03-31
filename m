From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v5 11/14] i2c: octeon: Rename driver to prepare for split
Date: Thu, 31 Mar 2016 12:28:24 +0200
Message-ID: <88a0971c5abaea58e66cfddda9899081f06dcbe6.1459352583.git.jglauber@cavium.com>
References: <cover.1459327368.git.jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1459327368.git.jglauber@cavium.com>
In-Reply-To: <cover.1459352583.git.jglauber@cavium.com>
References: <cover.1459352583.git.jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

This is just an intermediate commit in preparation of
the driver split. The module rename in this commit
will be reverted in the next patch, this is just done
to make the series bisectible.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/Makefile                            | 2 +-
 drivers/i2c/busses/{i2c-octeon.c => i2c-octeon-core.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/i2c/busses/{i2c-octeon.c => i2c-octeon-core.c} (100%)

diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 37f2819..3405286 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -91,7 +91,7 @@ obj-$(CONFIG_I2C_UNIPHIER)	+= i2c-uniphier.o
 obj-$(CONFIG_I2C_UNIPHIER_F)	+= i2c-uniphier-f.o
 obj-$(CONFIG_I2C_VERSATILE)	+= i2c-versatile.o
 obj-$(CONFIG_I2C_WMT)		+= i2c-wmt.o
-obj-$(CONFIG_I2C_OCTEON)	+= i2c-octeon.o
+obj-$(CONFIG_I2C_OCTEON)	+= i2c-octeon-core.o
 obj-$(CONFIG_I2C_XILINX)	+= i2c-xiic.o
 obj-$(CONFIG_I2C_XLR)		+= i2c-xlr.o
 obj-$(CONFIG_I2C_XLP9XX)	+= i2c-xlp9xx.o
diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon-core.c
similarity index 100%
rename from drivers/i2c/busses/i2c-octeon.c
rename to drivers/i2c/busses/i2c-octeon-core.c
-- 
1.9.1
