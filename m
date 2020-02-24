From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 35/40] i2c: st: Use generic definitions for bus frequencies
Date: Mon, 24 Feb 2020 17:15:25 +0200
Message-ID: <20200224151530.31713-35-andriy.shevchenko@linux.intel.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:55902 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727994AbgBXPPl (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Feb 2020 10:15:41 -0500
In-Reply-To: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Patrice Chotard <patrice.chotard@st.com>

Since we have generic definitions for bus frequencies, let's use them.

Cc: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-st.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-st.c b/drivers/i2c/busses/i2c-st.c
index 54e1fc8a495e..441fc2245f25 100644
--- a/drivers/i2c/busses/i2c-st.c
+++ b/drivers/i2c/busses/i2c-st.c
@@ -213,7 +213,7 @@ static inline void st_i2c_clr_bits(void __iomem *reg, u32 mask)
  */
 static struct st_i2c_timings i2c_timings[] = {
 	[I2C_MODE_STANDARD] = {
-		.rate			= 100000,
+		.rate			= I2C_STANDARD_MODE_FREQ,
 		.rep_start_hold		= 4400,
 		.rep_start_setup	= 5170,
 		.start_hold		= 4400,
@@ -222,7 +222,7 @@ static struct st_i2c_timings i2c_timings[] = {
 		.bus_free_time		= 5170,
 	},
 	[I2C_MODE_FAST] = {
-		.rate			= 400000,
+		.rate			= I2C_FAST_MODE_FREQ,
 		.rep_start_hold		= 660,
 		.rep_start_setup	= 660,
 		.start_hold		= 660,
@@ -835,7 +835,7 @@ static int st_i2c_probe(struct platform_device *pdev)
 
 	i2c_dev->mode = I2C_MODE_STANDARD;
 	ret = of_property_read_u32(np, "clock-frequency", &clk_rate);
-	if ((!ret) && (clk_rate == 400000))
+	if (!ret && (clk_rate == I2C_FAST_MODE_FREQ))
 		i2c_dev->mode = I2C_MODE_FAST;
 
 	i2c_dev->dev = &pdev->dev;
-- 
2.25.0
