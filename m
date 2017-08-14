From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v3 1/3] i2c: mux: pca9541: sort include files
Date: Mon, 14 Aug 2017 10:23:24 +0200
Message-ID: <20170814082326.9835-2-wsa@the-dreams.de>
References: <20170814082326.9835-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:48670 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752246AbdHNIXh (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 14 Aug 2017 04:23:37 -0400
In-Reply-To: <20170814082326.9835-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>

Make it consistent with the other drivers.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/muxes/i2c-mux-pca9541.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index 9e318c9516c767..be961f2855c75f 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -16,15 +16,14 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <linux/module.h>
-#include <linux/jiffies.h>
 #include <linux/delay.h>
-#include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/i2c.h>
 #include <linux/i2c-mux.h>
-
 #include <linux/i2c/pca954x.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/slab.h>
 
 /*
  * The PCA9541 is a bus master selector. It supports two I2C masters connected
-- 
2.11.0
