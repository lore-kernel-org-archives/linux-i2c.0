From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 29/40] i2c: sh_mobile: Use generic definitions for bus frequencies
Date: Mon, 24 Feb 2020 17:15:19 +0200
Message-ID: <20200224151530.31713-29-andriy.shevchenko@linux.intel.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:59400 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbgBXPPj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Feb 2020 10:15:39 -0500
In-Reply-To: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Since we have generic definitions for bus frequencies, let's use them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 82b3b795e0bd..dc29a29904df 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -145,9 +145,6 @@ struct sh_mobile_dt_config {
 
 #define IIC_FLAG_HAS_ICIC67	(1 << 0)
 
-#define STANDARD_MODE		100000
-#define FAST_MODE		400000
-
 /* Register offsets */
 #define ICDR			0x00
 #define ICCR			0x04
@@ -270,11 +267,11 @@ static int sh_mobile_i2c_init(struct sh_mobile_i2c_data *pd)
 
 	i2c_clk_khz = clk_get_rate(pd->clk) / 1000 / pd->clks_per_count;
 
-	if (pd->bus_speed == STANDARD_MODE) {
+	if (pd->bus_speed == I2C_STANDARD_MODE_FREQ) {
 		tLOW	= 47;	/* tLOW = 4.7 us */
 		tHIGH	= 40;	/* tHD;STA = tHIGH = 4.0 us */
 		tf	= 3;	/* tf = 0.3 us */
-	} else if (pd->bus_speed == FAST_MODE) {
+	} else if (pd->bus_speed == I2C_FAST_MODE_FREQ) {
 		tLOW	= 13;	/* tLOW = 1.3 us */
 		tHIGH	= 6;	/* tHD;STA = tHIGH = 0.6 us */
 		tf	= 3;	/* tf = 0.3 us */
@@ -851,7 +848,7 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 		return PTR_ERR(pd->reg);
 
 	ret = of_property_read_u32(dev->dev.of_node, "clock-frequency", &bus_speed);
-	pd->bus_speed = (ret || !bus_speed) ? STANDARD_MODE : bus_speed;
+	pd->bus_speed = (ret || !bus_speed) ? I2C_STANDARD_MODE_FREQ : bus_speed;
 	pd->clks_per_count = 1;
 
 	/* Newer variants come with two new bits in ICIC */
-- 
2.25.0
