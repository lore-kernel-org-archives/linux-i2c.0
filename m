From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 15/40] i2c: hix5hd2: Use generic definitions for bus frequencies
Date: Mon, 24 Feb 2020 17:15:05 +0200
Message-ID: <20200224151530.31713-15-andriy.shevchenko@linux.intel.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62974 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728010AbgBXPPp (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Feb 2020 10:15:45 -0500
In-Reply-To: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Since we have generic definitions for bus frequencies, let's use them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-hix5hd2.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-hix5hd2.c b/drivers/i2c/busses/i2c-hix5hd2.c
index 8497c7a95dd4..961bc1336021 100644
--- a/drivers/i2c/busses/i2c-hix5hd2.c
+++ b/drivers/i2c/busses/i2c-hix5hd2.c
@@ -68,8 +68,6 @@
 #define I2C_ARBITRATE_INTR	BIT(1)
 #define I2C_OVER_INTR		BIT(0)
 
-#define HIX5I2C_MAX_FREQ	400000		/* 400k */
-
 enum hix5hd2_i2c_state {
 	HIX5I2C_STAT_RW_ERR = -1,
 	HIX5I2C_STAT_INIT,
@@ -400,12 +398,12 @@ static int hix5hd2_i2c_probe(struct platform_device *pdev)
 
 	if (of_property_read_u32(np, "clock-frequency", &freq)) {
 		/* use 100k as default value */
-		priv->freq = 100000;
+		priv->freq = I2C_STANDARD_MODE_FREQ;
 	} else {
-		if (freq > HIX5I2C_MAX_FREQ) {
-			priv->freq = HIX5I2C_MAX_FREQ;
+		if (freq > I2C_FAST_MODE_FREQ) {
+			priv->freq = I2C_FAST_MODE_FREQ;
 			dev_warn(priv->dev, "use max freq %d instead\n",
-				 HIX5I2C_MAX_FREQ);
+				 I2C_FAST_MODE_FREQ);
 		} else {
 			priv->freq = freq;
 		}
-- 
2.25.0
