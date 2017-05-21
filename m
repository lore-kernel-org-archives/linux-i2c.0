From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 1/2] i2c: mux: pca954x: move header file out of I2C realm
Date: Sun, 21 May 2017 22:37:42 +0200
Message-ID: <20170521203743.6514-2-wsa@the-dreams.de>
References: <20170521203743.6514-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:55100 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755133AbdEUUhs (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 21 May 2017 16:37:48 -0400
In-Reply-To: <20170521203743.6514-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Guenter Roeck <linux@roeck-us.net>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org

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
index 9e318c9516c767..e6da060af88d27 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -24,7 +24,7 @@
 #include <linux/i2c.h>
 #include <linux/i2c-mux.h>
 
-#include <linux/i2c/pca954x.h>
+#include <linux/platform_data/pca954x.h>
 
 /*
  * The PCA9541 is a bus master selector. It supports two I2C masters connected
diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index f1751c290af67c..8de13d1ad223b2 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -39,7 +39,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/i2c-mux.h>
-#include <linux/i2c/pca954x.h>
+#include <linux/platform_data/pca954x.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/module.h>
diff --git a/include/linux/i2c/pca954x.h b/include/linux/platform_data/pca954x.h
similarity index 100%
rename from include/linux/i2c/pca954x.h
rename to include/linux/platform_data/pca954x.h
-- 
2.11.0
