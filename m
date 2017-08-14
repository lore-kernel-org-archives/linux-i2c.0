From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v3 2/3] i2c: mux: pca954x: move header file out of I2C realm
Date: Mon, 14 Aug 2017 10:23:25 +0200
Message-ID: <20170814082326.9835-3-wsa@the-dreams.de>
References: <20170814082326.9835-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:48674 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751542AbdHNIXi (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 14 Aug 2017 04:23:38 -0400
In-Reply-To: <20170814082326.9835-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>

include/linux/i2c is not for client devices. Move the header file to a
more appropriate location.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/muxes/i2c-mux-pca9541.c            | 2 +-
 drivers/i2c/muxes/i2c-mux-pca954x.c            | 2 +-
 include/linux/{i2c => platform_data}/pca954x.h | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename include/linux/{i2c => platform_data}/pca954x.h (100%)

diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index be961f2855c75f..6a39adaf433f4a 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -20,9 +20,9 @@
 #include <linux/device.h>
 #include <linux/i2c.h>
 #include <linux/i2c-mux.h>
-#include <linux/i2c/pca954x.h>
 #include <linux/jiffies.h>
 #include <linux/module.h>
+#include <linux/platform_data/pca954x.h>
 #include <linux/slab.h>
 
 /*
diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index f1751c290af67c..7b992db3802188 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -39,13 +39,13 @@
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/i2c-mux.h>
-#include <linux/i2c/pca954x.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
+#include <linux/platform_data/pca954x.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
diff --git a/include/linux/i2c/pca954x.h b/include/linux/platform_data/pca954x.h
similarity index 100%
rename from include/linux/i2c/pca954x.h
rename to include/linux/platform_data/pca954x.h
-- 
2.11.0
