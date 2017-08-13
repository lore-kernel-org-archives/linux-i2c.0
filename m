From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v2 1/2] i2c: mux: pca954x: move header file out of I2C realm
Date: Sun, 13 Aug 2017 15:58:55 +0200
Message-ID: <20170813135856.3454-2-wsa@the-dreams.de>
References: <20170813135856.3454-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:46425 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750880AbdHMN7X (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 13 Aug 2017 09:59:23 -0400
In-Reply-To: <20170813135856.3454-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>

include/linux/i2c is not for client devices. Move the header file to a
more appropriate location.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/muxes/i2c-mux-pca9541.c            | 3 +--
 drivers/i2c/muxes/i2c-mux-pca954x.c            | 2 +-
 include/linux/{i2c => platform_data}/pca954x.h | 0
 3 files changed, 2 insertions(+), 3 deletions(-)
 rename include/linux/{i2c => platform_data}/pca954x.h (100%)

diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index 9e318c9516c767..56e1f550b2ed0b 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -23,8 +23,7 @@
 #include <linux/device.h>
 #include <linux/i2c.h>
 #include <linux/i2c-mux.h>
-
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
