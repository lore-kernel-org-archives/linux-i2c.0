From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v10 1/8] i2c: octeon: Rename driver to prepare for split
Date: Wed, 15 Jun 2016 15:51:27 +0200
Message-ID: <9a3368bcf49132fd8656f158de53627c426dd3a7.1465997603.git.jglauber@cavium.com>
References: <cover.1465997603.git.jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1465997603.git.jglauber@cavium.com>
In-Reply-To: <cover.1465997603.git.jglauber@cavium.com>
References: <cover.1465997603.git.jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Steven.Hill@caviumnetworks.com, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

This is an intermediate commit in preparation of the driver split.
The module rename in this commit will be reverted in the next patch,
this is just done to make the series bisectible.

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
