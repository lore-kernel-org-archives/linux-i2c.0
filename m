From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 39/40] i2c: uniphier: Use generic definitions for bus frequencies
Date: Mon, 24 Feb 2020 17:15:29 +0200
Message-ID: <20200224151530.31713-39-andriy.shevchenko@linux.intel.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62982 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728022AbgBXPPq (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Feb 2020 10:15:46 -0500
In-Reply-To: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Masahiro Yamada <yamada.masahiro@socionext.com>

Since we have generic definitions for bus frequencies, let's use them.

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-uniphier.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-uniphier.c b/drivers/i2c/busses/i2c-uniphier.c
index 0270090c0360..782bf452b4a9 100644
--- a/drivers/i2c/busses/i2c-uniphier.c
+++ b/drivers/i2c/busses/i2c-uniphier.c
@@ -35,9 +35,6 @@
 #define UNIPHIER_I2C_NOISE	0x1c	/* noise filter control */
 #define UNIPHIER_I2C_SETUP	0x20	/* setup time control */
 
-#define UNIPHIER_I2C_DEFAULT_SPEED	100000
-#define UNIPHIER_I2C_MAX_SPEED		400000
-
 struct uniphier_i2c_priv {
 	struct completion comp;
 	struct i2c_adapter adap;
@@ -333,9 +330,9 @@ static int uniphier_i2c_probe(struct platform_device *pdev)
 	}
 
 	if (of_property_read_u32(dev->of_node, "clock-frequency", &bus_speed))
-		bus_speed = UNIPHIER_I2C_DEFAULT_SPEED;
+		bus_speed = I2C_STANDARD_MODE_FREQ;
 
-	if (!bus_speed || bus_speed > UNIPHIER_I2C_MAX_SPEED) {
+	if (!bus_speed || bus_speed > I2C_FAST_MODE_FREQ) {
 		dev_err(dev, "invalid clock-frequency %d\n", bus_speed);
 		return -EINVAL;
 	}
-- 
2.25.0
