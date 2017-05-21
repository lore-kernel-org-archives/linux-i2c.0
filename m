From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 2/2] i2c: mux: mlxcpld: move header file out of I2C realm
Date: Sun, 21 May 2017 22:37:43 +0200
Message-ID: <20170521203743.6514-3-wsa@the-dreams.de>
References: <20170521203743.6514-1-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170521203743.6514-1-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Vadim Pasternak <vadimp@mellanox.com>, Michael Shych <michaelsh@mellanox.com>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

include/linux/i2c is not for client devices. Move the header file to a
more appropriate location.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/muxes/i2c-mux-mlxcpld.c                | 2 +-
 include/linux/{i2c => platform_data/x86}/mlxcpld.h | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename include/linux/{i2c => platform_data/x86}/mlxcpld.h (100%)

diff --git a/drivers/i2c/muxes/i2c-mux-mlxcpld.c b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
index e53f2abd135070..63458b025ef904 100644
--- a/drivers/i2c/muxes/i2c-mux-mlxcpld.c
+++ b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
@@ -40,7 +40,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-#include <linux/i2c/mlxcpld.h>
+#include <linux/platform_data/x86/mlxcpld.h>
 
 #define CPLD_MUX_MAX_NCHANS	8
 
diff --git a/include/linux/i2c/mlxcpld.h b/include/linux/platform_data/x86/mlxcpld.h
similarity index 100%
rename from include/linux/i2c/mlxcpld.h
rename to include/linux/platform_data/x86/mlxcpld.h
-- 
2.11.0
