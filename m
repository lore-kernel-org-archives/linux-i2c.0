From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4/5] hwmon: max6639: move header file out of I2C realm
Date: Sun, 21 May 2017 22:34:42 +0200
Message-ID: <20170521203443.6387-5-wsa@the-dreams.de>
References: <20170521203443.6387-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:55082 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756494AbdEUUeu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 21 May 2017 16:34:50 -0400
In-Reply-To: <20170521203443.6387-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org

include/linux/i2c is not for client devices. Move the header file to a
more appropriate location.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/hwmon/max6639.c                        | 2 +-
 include/linux/{i2c => platform_data}/max6639.h | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename include/linux/{i2c => platform_data}/max6639.h (100%)

diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index dac6d85f2fd956..f98a83c79ff147 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -32,7 +32,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
-#include <linux/i2c/max6639.h>
+#include <linux/platform_data/max6639.h>
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
diff --git a/include/linux/i2c/max6639.h b/include/linux/platform_data/max6639.h
similarity index 100%
rename from include/linux/i2c/max6639.h
rename to include/linux/platform_data/max6639.h
-- 
2.11.0
