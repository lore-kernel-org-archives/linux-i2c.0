From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 1/2] misc: apds990x: move header file out of I2C realm
Date: Sun, 21 May 2017 22:42:32 +0200
Message-ID: <20170521204233.6745-2-wsa@the-dreams.de>
References: <20170521204233.6745-1-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170521204233.6745-1-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

include/linux/i2c is not for client devices. Move the header file to a
more appropriate location.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/misc/apds990x.c                         | 2 +-
 include/linux/{i2c => platform_data}/apds990x.h | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename include/linux/{i2c => platform_data}/apds990x.h (100%)

diff --git a/drivers/misc/apds990x.c b/drivers/misc/apds990x.c
index dfb72ecfa60461..c341164edaad01 100644
--- a/drivers/misc/apds990x.c
+++ b/drivers/misc/apds990x.c
@@ -32,7 +32,7 @@
 #include <linux/delay.h>
 #include <linux/wait.h>
 #include <linux/slab.h>
-#include <linux/i2c/apds990x.h>
+#include <linux/platform_data/apds990x.h>
 
 /* Register map */
 #define APDS990X_ENABLE	 0x00 /* Enable of states and interrupts */
diff --git a/include/linux/i2c/apds990x.h b/include/linux/platform_data/apds990x.h
similarity index 100%
rename from include/linux/i2c/apds990x.h
rename to include/linux/platform_data/apds990x.h
-- 
2.11.0
