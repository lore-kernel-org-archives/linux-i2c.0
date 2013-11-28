From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/3] i2c: nomadik: remove platform data header
Date: Thu, 28 Nov 2013 23:12:07 +0100
Message-ID: <1385676727-15089-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The Nomadik I2C is now configured from the device tree on all platforms
using this controller. Delete the platform data header and move the
definitions into the driver so it is all contained in one single file.

Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c          | 24 +++++++++++++++++++++-
 include/linux/platform_data/i2c-nomadik.h | 34 -------------------------------
 2 files changed, 23 insertions(+), 35 deletions(-)
 delete mode 100644 include/linux/platform_data/i2c-nomadik.h

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 51e61d8127cb..4443613514ee 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -22,7 +22,6 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/pm_runtime.h>
-#include <linux/platform_data/i2c-nomadik.h>
 #include <linux/of.h>
 #include <linux/pinctrl/consumer.h>
 
@@ -104,6 +103,29 @@
 /* maximum threshold value */
 #define MAX_I2C_FIFO_THRESHOLD	15
 
+enum i2c_freq_mode {
+	I2C_FREQ_MODE_STANDARD,		/* up to 100 Kb/s */
+	I2C_FREQ_MODE_FAST,		/* up to 400 Kb/s */
+	I2C_FREQ_MODE_HIGH_SPEED,	/* up to 3.4 Mb/s */
+	I2C_FREQ_MODE_FAST_PLUS,	/* up to 1 Mb/s */
+};
+
+/**
+ * struct nmk_i2c_controller - client specific controller configuration
+ * @clk_freq:	clock frequency for the operation mode
+ * @tft:	Tx FIFO Threshold in bytes
+ * @rft:	Rx FIFO Threshold in bytes
+ * @timeout	Slave response timeout(ms)
+ * @sm:		speed mode
+ */
+struct nmk_i2c_controller {
+	u32             clk_freq;
+	unsigned char	tft;
+	unsigned char	rft;
+	int timeout;
+	enum i2c_freq_mode	sm;
+};
+
 /**
  * struct i2c_vendor_data - per-vendor variations
  * @has_mtdws: variant has the MTDWS bit
diff --git a/include/linux/platform_data/i2c-nomadik.h b/include/linux/platform_data/i2c-nomadik.h
deleted file mode 100644
index 8681893f7b66..000000000000
--- a/include/linux/platform_data/i2c-nomadik.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * Copyright (C) 2009 ST-Ericsson
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2, as
- * published by the Free Software Foundation.
- */
-#ifndef __PDATA_I2C_NOMADIK_H
-#define __PDATA_I2C_NOMADIK_H
-
-enum i2c_freq_mode {
-	I2C_FREQ_MODE_STANDARD,		/* up to 100 Kb/s */
-	I2C_FREQ_MODE_FAST,		/* up to 400 Kb/s */
-	I2C_FREQ_MODE_HIGH_SPEED,	/* up to 3.4 Mb/s */
-	I2C_FREQ_MODE_FAST_PLUS,	/* up to 1 Mb/s */
-};
-
-/**
- * struct nmk_i2c_controller - client specific controller configuration
- * @clk_freq:	clock frequency for the operation mode
- * @tft:	Tx FIFO Threshold in bytes
- * @rft:	Rx FIFO Threshold in bytes
- * @timeout	Slave response timeout(ms)
- * @sm:		speed mode
- */
-struct nmk_i2c_controller {
-	u32             clk_freq;
-	unsigned char	tft;
-	unsigned char	rft;
-	int timeout;
-	enum i2c_freq_mode	sm;
-};
-
-#endif	/* __PDATA_I2C_NOMADIK_H */
-- 
1.8.3.1
