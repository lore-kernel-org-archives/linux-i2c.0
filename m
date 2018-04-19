From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 6/7] i2c: i2c-xiic: move header to platform_data
Date: Thu, 19 Apr 2018 22:00:12 +0200
Message-ID: <20180419200015.15095-7-wsa@the-dreams.de>
References: <20180419200015.15095-1-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180419200015.15095-1-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

This header only contains platform_data. Move it to the proper directory.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-xiic.c                | 2 +-
 drivers/mfd/timberdale.c                     | 2 +-
 include/linux/{ => platform_data}/i2c-xiic.h | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename include/linux/{ => platform_data}/i2c-xiic.h (100%)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index c80527816ad0..0ff36f6d7a57 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -33,7 +33,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/wait.h>
-#include <linux/i2c-xiic.h>
+#include <linux/platform_data/i2c-xiic.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/of.h>
diff --git a/drivers/mfd/timberdale.c b/drivers/mfd/timberdale.c
index 118d7ef727e6..33abf5a79f2b 100644
--- a/drivers/mfd/timberdale.c
+++ b/drivers/mfd/timberdale.c
@@ -31,7 +31,7 @@
 
 #include <linux/i2c.h>
 #include <linux/platform_data/i2c-ocores.h>
-#include <linux/i2c-xiic.h>
+#include <linux/platform_data/i2c-xiic.h>
 
 #include <linux/spi/spi.h>
 #include <linux/spi/xilinx_spi.h>
diff --git a/include/linux/i2c-xiic.h b/include/linux/platform_data/i2c-xiic.h
similarity index 100%
rename from include/linux/i2c-xiic.h
rename to include/linux/platform_data/i2c-xiic.h
-- 
2.11.0
