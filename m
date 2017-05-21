From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 2/2] misc: bh1770glc: move header file out of I2C realm
Date: Sun, 21 May 2017 22:42:33 +0200
Message-ID: <20170521204233.6745-3-wsa@the-dreams.de>
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
 drivers/misc/bh1770glc.c                         | 2 +-
 include/linux/{i2c => platform_data}/bh1770glc.h | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename include/linux/{i2c => platform_data}/bh1770glc.h (100%)

diff --git a/drivers/misc/bh1770glc.c b/drivers/misc/bh1770glc.c
index 845466e45b9593..38fcfe219d1cf1 100644
--- a/drivers/misc/bh1770glc.c
+++ b/drivers/misc/bh1770glc.c
@@ -27,7 +27,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/mutex.h>
-#include <linux/i2c/bh1770glc.h>
+#include <linux/platform_data/bh1770glc.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/workqueue.h>
diff --git a/include/linux/i2c/bh1770glc.h b/include/linux/platform_data/bh1770glc.h
similarity index 100%
rename from include/linux/i2c/bh1770glc.h
rename to include/linux/platform_data/bh1770glc.h
-- 
2.11.0
