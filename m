From: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/1] i2c: Include linux/of.h header
Date: Wed, 16 Oct 2013 15:26:33 +0530
Message-ID: <1381917393-4499-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

'of_match_ptr' is defined in linux/of.h. Include it explicitly to
avoid build breakage in the future.

Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-gpio.c       |    1 +
 drivers/i2c/busses/i2c-pnx.c        |    1 +
 drivers/i2c/busses/i2c-s3c2410.c    |    1 +
 drivers/i2c/busses/i2c-xiic.c       |    1 +
 drivers/i2c/muxes/i2c-mux-pinctrl.c |    1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index bfa02c6..d9f7e18 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
+#include <linux/of.h>
 #include <linux/of_gpio.h>
 
 struct i2c_gpio_private_data {
diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index 1a9ea25..c9a352f 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -23,6 +23,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 
 #define I2C_PNX_TIMEOUT_DEFAULT		10 /* msec */
 #define I2C_PNX_SPEED_KHZ_DEFAULT	100
diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 3747b9b..bf8fb94 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -36,6 +36,7 @@
 #include <linux/cpufreq.h>
 #include <linux/slab.h>
 #include <linux/io.h>
+#include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
 
diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 6e7b09c..fc2716a 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -40,6 +40,7 @@
 #include <linux/i2c-xiic.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 
 #define DRIVER_NAME "xiic-i2c"
 
diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c
index 68a3715..d7978dc 100644
--- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
@@ -24,6 +24,7 @@
 #include <linux/i2c-mux-pinctrl.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 
 struct i2c_mux_pinctrl {
 	struct device *dev;
-- 
1.7.9.5
