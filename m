From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 2/5] hwmon: ds620: move header file out of I2C realm
Date: Sun, 21 May 2017 22:34:40 +0200
Message-ID: <20170521203443.6387-3-wsa@the-dreams.de>
References: <20170521203443.6387-1-wsa@the-dreams.de>
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-Reply-To: <20170521203443.6387-1-wsa@the-dreams.de>
Sender: linux-hwmon-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

include/linux/i2c is not for client devices. Move the header file to a
more appropriate location.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/hwmon/ds620.c                        | 2 +-
 include/linux/{i2c => platform_data}/ds620.h | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename include/linux/{i2c => platform_data}/ds620.h (100%)

diff --git a/drivers/hwmon/ds620.c b/drivers/hwmon/ds620.c
index 0043a4c02b85b4..57d6958c74b8fa 100644
--- a/drivers/hwmon/ds620.c
+++ b/drivers/hwmon/ds620.c
@@ -30,7 +30,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
-#include <linux/i2c/ds620.h>
+#include <linux/platform_data/ds620.h>
 
 /*
  * Many DS620 constants specified below
diff --git a/include/linux/i2c/ds620.h b/include/linux/platform_data/ds620.h
similarity index 100%
rename from include/linux/i2c/ds620.h
rename to include/linux/platform_data/ds620.h
-- 
2.11.0

