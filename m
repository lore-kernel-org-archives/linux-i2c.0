From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 3/5] hwmon: ltc4245: move header file out of I2C realm
Date: Sun, 21 May 2017 22:34:41 +0200
Message-ID: <20170521203443.6387-4-wsa@the-dreams.de>
References: <20170521203443.6387-1-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170521203443.6387-1-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

include/linux/i2c is not for client devices. Move the header file to a
more appropriate location.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 Documentation/hwmon/ltc4245                    | 2 +-
 drivers/hwmon/ltc4245.c                        | 2 +-
 include/linux/{i2c => platform_data}/ltc4245.h | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename include/linux/{i2c => platform_data}/ltc4245.h (100%)

diff --git a/Documentation/hwmon/ltc4245 b/Documentation/hwmon/ltc4245
index b478b086496586..4ca7a9da09f918 100644
--- a/Documentation/hwmon/ltc4245
+++ b/Documentation/hwmon/ltc4245
@@ -96,7 +96,7 @@ slowly, -EAGAIN will be returned when you read the sysfs attribute containing
 the sensor reading.
 
 The LTC4245 chip can be configured to sample all GPIO pins with two methods:
-1) platform data -- see include/linux/i2c/ltc4245.h
+1) platform data -- see include/linux/platform_data/ltc4245.h
 2) OF device tree -- add the "ltc4245,use-extra-gpios" property to each chip
 
 The default mode of operation is to sample a single GPIO pin.
diff --git a/drivers/hwmon/ltc4245.c b/drivers/hwmon/ltc4245.c
index 4680d89556ce80..082f0a0bd8a0f1 100644
--- a/drivers/hwmon/ltc4245.c
+++ b/drivers/hwmon/ltc4245.c
@@ -23,7 +23,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/jiffies.h>
-#include <linux/i2c/ltc4245.h>
+#include <linux/platform_data/ltc4245.h>
 
 /* Here are names of the chip's registers (a.k.a. commands) */
 enum ltc4245_cmd {
diff --git a/include/linux/i2c/ltc4245.h b/include/linux/platform_data/ltc4245.h
similarity index 100%
rename from include/linux/i2c/ltc4245.h
rename to include/linux/platform_data/ltc4245.h
-- 
2.11.0
