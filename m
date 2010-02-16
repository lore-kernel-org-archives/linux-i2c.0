From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Build core and algo drivers with -Wshadow
Date: Tue, 16 Feb 2010 12:21:52 +0100
Message-ID: <20100216122152.29dbbeb5@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

I like building with -Wshadow, it helps catch bugs or at least bad
choices in variable names.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
Any objection?

 drivers/hwmon/Makefile      |    1 +
 drivers/i2c/Makefile        |    1 +
 drivers/i2c/algos/Makefile  |    1 +
 drivers/i2c/busses/Makefile |    1 +
 drivers/i2c/chips/Makefile  |    1 +
 5 files changed, 5 insertions(+)

--- linux-2.6.33-rc8.orig/drivers/i2c/Makefile	2010-02-16 10:59:43.000000000 +0100
+++ linux-2.6.33-rc8/drivers/i2c/Makefile	2010-02-16 11:09:07.000000000 +0100
@@ -8,6 +8,7 @@ obj-$(CONFIG_I2C_SMBUS)		+= i2c-smbus.o
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
 obj-y				+= busses/ chips/ algos/
 
+EXTRA_CFLAGS += -Wshadow
 ifeq ($(CONFIG_I2C_DEBUG_CORE),y)
 EXTRA_CFLAGS += -DDEBUG
 endif
--- linux-2.6.33-rc8.orig/drivers/i2c/algos/Makefile	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6.33-rc8/drivers/i2c/algos/Makefile	2010-02-16 11:19:59.000000000 +0100
@@ -6,6 +6,7 @@ obj-$(CONFIG_I2C_ALGOBIT)	+= i2c-algo-bi
 obj-$(CONFIG_I2C_ALGOPCF)	+= i2c-algo-pcf.o
 obj-$(CONFIG_I2C_ALGOPCA)	+= i2c-algo-pca.o
 
+EXTRA_CFLAGS += -Wshadow
 ifeq ($(CONFIG_I2C_DEBUG_ALGO),y)
 EXTRA_CFLAGS += -DDEBUG
 endif


-- 
Jean Delvare
