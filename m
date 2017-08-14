From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v3 3/3] i2c: mux: mlxcpld: move header file out of I2C realm
Date: Mon, 14 Aug 2017 10:23:26 +0200
Message-ID: <20170814082326.9835-4-wsa@the-dreams.de>
References: <20170814082326.9835-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:48678 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752389AbdHNIXi (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
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
 drivers/i2c/muxes/i2c-mux-mlxcpld.c                | 2 +-
 include/linux/{i2c => platform_data/x86}/mlxcpld.h | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename include/linux/{i2c => platform_data/x86}/mlxcpld.h (100%)

diff --git a/drivers/i2c/muxes/i2c-mux-mlxcpld.c b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
index e53f2abd135070..12ad8d65faf642 100644
--- a/drivers/i2c/muxes/i2c-mux-mlxcpld.c
+++ b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
@@ -38,9 +38,9 @@
 #include <linux/io.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/platform_data/x86/mlxcpld.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-#include <linux/i2c/mlxcpld.h>
 
 #define CPLD_MUX_MAX_NCHANS	8
 
diff --git a/include/linux/i2c/mlxcpld.h b/include/linux/platform_data/x86/mlxcpld.h
similarity index 100%
rename from include/linux/i2c/mlxcpld.h
rename to include/linux/platform_data/x86/mlxcpld.h
-- 
2.11.0
