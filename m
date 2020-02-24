From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 38/40] i2c: uniphier-f: Use generic definitions for bus frequencies
Date: Mon, 24 Feb 2020 17:15:28 +0200
Message-ID: <20200224151530.31713-38-andriy.shevchenko@linux.intel.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:59407 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbgBXPPl (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Feb 2020 10:15:41 -0500
In-Reply-To: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Masahiro Yamada <yamada.masahiro@socionext.com>

Since we have generic definitions for bus frequencies, let's use them.

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-uniphier-f.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
index 4241aac79e7e..47b78ebfb291 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -73,8 +73,6 @@
 #define UNIPHIER_FI2C_BYTE_WISE		BIT(3)
 #define UNIPHIER_FI2C_DEFER_STOP_COMP	BIT(4)
 
-#define UNIPHIER_FI2C_DEFAULT_SPEED	100000
-#define UNIPHIER_FI2C_MAX_SPEED		400000
 #define UNIPHIER_FI2C_FIFO_SIZE		8
 
 struct uniphier_fi2c_priv {
@@ -537,9 +535,9 @@ static int uniphier_fi2c_probe(struct platform_device *pdev)
 	}
 
 	if (of_property_read_u32(dev->of_node, "clock-frequency", &bus_speed))
-		bus_speed = UNIPHIER_FI2C_DEFAULT_SPEED;
+		bus_speed = I2C_STANDARD_MODE_FREQ;
 
-	if (!bus_speed || bus_speed > UNIPHIER_FI2C_MAX_SPEED) {
+	if (!bus_speed || bus_speed > I2C_FAST_MODE_FREQ) {
 		dev_err(dev, "invalid clock-frequency %d\n", bus_speed);
 		return -EINVAL;
 	}
-- 
2.25.0
