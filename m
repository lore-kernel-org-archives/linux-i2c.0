From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 22/40] i2c: mxs: Use generic definitions for bus frequencies
Date: Mon, 24 Feb 2020 17:15:12 +0200
Message-ID: <20200224151530.31713-22-andriy.shevchenko@linux.intel.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:50814 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbgBXPPj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Feb 2020 10:15:39 -0500
In-Reply-To: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>

Since we have generic definitions for bus frequencies, let's use them.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-mxs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 89224913f578..215aa18cc4f5 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -731,18 +731,18 @@ static void mxs_i2c_derive_timing(struct mxs_i2c_dev *i2c, uint32_t speed)
 	 * This is compensated for by subtracting the respective constants
 	 * from the values written to the timing registers.
 	 */
-	if (speed > 100000) {
+	if (speed > I2C_STANDARD_MODE_FREQ) {
 		/* fast mode */
 		low_count = DIV_ROUND_CLOSEST(divider * 13, (13 + 6));
 		high_count = DIV_ROUND_CLOSEST(divider * 6, (13 + 6));
-		leadin = DIV_ROUND_UP(600 * (clk / 1000000), 1000);
-		bus_free = DIV_ROUND_UP(1300 * (clk / 1000000), 1000);
+		leadin = DIV_ROUND_UP(600 * (clk / HZ_PER_MHZ), 1000);
+		bus_free = DIV_ROUND_UP(1300 * (clk / HZ_PER_MHZ), 1000);
 	} else {
 		/* normal mode */
 		low_count = DIV_ROUND_CLOSEST(divider * 47, (47 + 40));
 		high_count = DIV_ROUND_CLOSEST(divider * 40, (47 + 40));
-		leadin = DIV_ROUND_UP(4700 * (clk / 1000000), 1000);
-		bus_free = DIV_ROUND_UP(4700 * (clk / 1000000), 1000);
+		leadin = DIV_ROUND_UP(4700 * (clk / HZ_PER_MHZ), 1000);
+		bus_free = DIV_ROUND_UP(4700 * (clk / HZ_PER_MHZ), 1000);
 	}
 	rcv_count = high_count * 3 / 8;
 	xmit_count = low_count * 3 / 8;
@@ -769,7 +769,7 @@ static int mxs_i2c_get_ofdata(struct mxs_i2c_dev *i2c)
 	ret = of_property_read_u32(node, "clock-frequency", &speed);
 	if (ret) {
 		dev_warn(dev, "No I2C speed selected, using 100kHz\n");
-		speed = 100000;
+		speed = I2C_STANDARD_MODE_FREQ;
 	}
 
 	mxs_i2c_derive_timing(i2c, speed);
-- 
2.25.0
