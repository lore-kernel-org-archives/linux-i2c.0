From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 13/40] i2c: diolan-u2c: Use generic definitions for bus frequencies
Date: Mon, 24 Feb 2020 17:15:03 +0200
Message-ID: <20200224151530.31713-13-andriy.shevchenko@linux.intel.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62976 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728011AbgBXPPp (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Feb 2020 10:15:45 -0500
In-Reply-To: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>

Since we have generic definitions for bus frequencies, let's use them.

Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-diolan-u2c.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-diolan-u2c.c b/drivers/i2c/busses/i2c-diolan-u2c.c
index 382f105e0fe3..9ac79547d30b 100644
--- a/drivers/i2c/busses/i2c-diolan-u2c.c
+++ b/drivers/i2c/busses/i2c-diolan-u2c.c
@@ -64,8 +64,6 @@
 #define U2C_I2C_SPEED_2KHZ	242	/* 2 kHz, minimum speed */
 #define U2C_I2C_SPEED(f)	((DIV_ROUND_UP(1000000, (f)) - 10) / 2 + 1)
 
-#define U2C_I2C_FREQ_FAST	400000
-#define U2C_I2C_FREQ_STD	100000
 #define U2C_I2C_FREQ(s)		(1000000 / (2 * (s - 1) + 10))
 
 #define DIOLAN_USB_TIMEOUT	100	/* in ms */
@@ -87,7 +85,7 @@ struct i2c_diolan_u2c {
 	int ocount;			/* Number of enqueued messages */
 };
 
-static uint frequency = U2C_I2C_FREQ_STD;	/* I2C clock frequency in Hz */
+static uint frequency = I2C_STANDARD_MODE_FREQ;	/* I2C clock frequency in Hz */
 
 module_param(frequency, uint, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(frequency, "I2C clock frequency in hertz");
@@ -299,12 +297,12 @@ static int diolan_init(struct i2c_diolan_u2c *dev)
 {
 	int speed, ret;
 
-	if (frequency >= 200000) {
+	if (frequency >= 2 * I2C_STANDARD_MODE_FREQ) {
 		speed = U2C_I2C_SPEED_FAST;
-		frequency = U2C_I2C_FREQ_FAST;
-	} else if (frequency >= 100000 || frequency == 0) {
+		frequency = I2C_FAST_MODE_FREQ;
+	} else if (frequency >= I2C_STANDARD_MODE_FREQ || frequency == 0) {
 		speed = U2C_I2C_SPEED_STD;
-		frequency = U2C_I2C_FREQ_STD;
+		frequency = I2C_STANDARD_MODE_FREQ;
 	} else {
 		speed = U2C_I2C_SPEED(frequency);
 		if (speed > U2C_I2C_SPEED_2KHZ)
-- 
2.25.0
