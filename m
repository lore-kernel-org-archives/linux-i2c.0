From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: rephrase explanation of I2C_CLASS_DEPRECATED
Date: Sat, 29 Jul 2017 14:11:43 +0200
Message-ID: <20170729121143.3980-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:42986 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753166AbdG2MLq (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 29 Jul 2017 08:11:46 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, Wolfram Sang <wsa@the-dreams.de>

Hopefully making clear that it is not needed for new drivers.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---

Is this more undestandable?

 include/linux/i2c.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 00ca5b86a753f8..d501d3956f13f0 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -689,7 +689,8 @@ i2c_unlock_adapter(struct i2c_adapter *adapter)
 #define I2C_CLASS_HWMON		(1<<0)	/* lm_sensors, ... */
 #define I2C_CLASS_DDC		(1<<3)	/* DDC bus on graphics adapters */
 #define I2C_CLASS_SPD		(1<<7)	/* Memory modules */
-#define I2C_CLASS_DEPRECATED	(1<<8)	/* Warn users that adapter will stop using classes */
+/* Warn users that the adapter doesn't support classes anymore */
+#define I2C_CLASS_DEPRECATED	(1<<8)
 
 /* Internal numbers to terminate lists */
 #define I2C_CLIENT_END		0xfffeU
-- 
2.11.0
