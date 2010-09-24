From: matt mooney <mfm@muteddisk.com>
Subject: [PATCH 05/24] i2c: change to new flag variable
Date: Fri, 24 Sep 2010 12:17:15 -0700
Message-ID: <b3e2061e1e6703f7b84c0484030e07de6000546a.1285355033.git.mfm@muteddisk.com>
References: <e0bdab5d2e8c52041c003de68ba774c3e706716c.1285355033.git.mfm@muteddisk.com>
 <9968d4260be8850200cc9c7dfe08addf611468b4.1285355033.git.mfm@muteddisk.com>
 <036514b5dd23c5af14303519d79d60d79adccbee.1285355033.git.mfm@muteddisk.com>
 <ffbd189ef2d414ea7c87ffe2b40fce87877dc014.1285355033.git.mfm@muteddisk.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ffbd189ef2d414ea7c87ffe2b40fce87877dc014.1285355033.git.mfm@muteddisk.com>
In-Reply-To: <e0bdab5d2e8c52041c003de68ba774c3e706716c.1285355033.git.mfm@muteddisk.com>
References: <e0bdab5d2e8c52041c003de68ba774c3e706716c.1285355033.git.mfm@muteddisk.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel-janitors@vger.kernel.org
Cc: "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Replace EXTRA_CFLAGS with ccflags-y.

Signed-off-by: matt mooney <mfm@muteddisk.com>
---
 drivers/i2c/Makefile        |    4 +---
 drivers/i2c/algos/Makefile  |    4 +---
 drivers/i2c/busses/Makefile |    4 +---
 drivers/i2c/muxes/Makefile  |    4 +---
 4 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index c00fd66..23ac61e 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -9,6 +9,4 @@ obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
 obj-$(CONFIG_I2C_MUX)		+= i2c-mux.o
 obj-y				+= algos/ busses/ muxes/
 
-ifeq ($(CONFIG_I2C_DEBUG_CORE),y)
-EXTRA_CFLAGS += -DDEBUG
-endif
+ccflags-$(CONFIG_I2C_DEBUG_CORE) := -DDEBUG
diff --git a/drivers/i2c/algos/Makefile b/drivers/i2c/algos/Makefile
index 18b3e96..215303f 100644
--- a/drivers/i2c/algos/Makefile
+++ b/drivers/i2c/algos/Makefile
@@ -6,6 +6,4 @@ obj-$(CONFIG_I2C_ALGOBIT)	+= i2c-algo-bit.o
 obj-$(CONFIG_I2C_ALGOPCF)	+= i2c-algo-pcf.o
 obj-$(CONFIG_I2C_ALGOPCA)	+= i2c-algo-pca.o
 
-ifeq ($(CONFIG_I2C_DEBUG_ALGO),y)
-EXTRA_CFLAGS += -DDEBUG
-endif
+ccflags-$(CONFIG_I2C_DEBUG_ALGO) := -DDEBUG
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index c3ef492..033ad41 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -76,6 +76,4 @@ obj-$(CONFIG_I2C_STUB)		+= i2c-stub.o
 obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
 obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
 
-ifeq ($(CONFIG_I2C_DEBUG_BUS),y)
-EXTRA_CFLAGS += -DDEBUG
-endif
+ccflags-$(CONFIG_I2C_DEBUG_BUS) := -DDEBUG
diff --git a/drivers/i2c/muxes/Makefile b/drivers/i2c/muxes/Makefile
index bd83b52..6f49786 100644
--- a/drivers/i2c/muxes/Makefile
+++ b/drivers/i2c/muxes/Makefile
@@ -3,6 +3,4 @@
 
 obj-$(CONFIG_I2C_MUX_PCA954x)	+= pca954x.o
 
-ifeq ($(CONFIG_I2C_DEBUG_BUS),y)
-EXTRA_CFLAGS += -DDEBUG
-endif
+ccflags-$(CONFIG_I2C_DEBUG_BUS) := -DDEBUG
-- 
1.7.2.1
