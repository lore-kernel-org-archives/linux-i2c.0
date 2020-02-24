From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 19/40] i2c: lpc2k: Use generic definitions for bus frequencies
Date: Mon, 24 Feb 2020 17:15:09 +0200
Message-ID: <20200224151530.31713-19-andriy.shevchenko@linux.intel.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:14877 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbgBXPPj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Feb 2020 10:15:39 -0500
In-Reply-To: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vladimir Zapolskiy <vz@mleia.com>

Since we have generic definitions for bus frequencies, let's use them.

Cc: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-lpc2k.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-lpc2k.c b/drivers/i2c/busses/i2c-lpc2k.c
index deea18b14add..159ebec5861c 100644
--- a/drivers/i2c/busses/i2c-lpc2k.c
+++ b/drivers/i2c/busses/i2c-lpc2k.c
@@ -396,7 +396,7 @@ static int i2c_lpc2k_probe(struct platform_device *pdev)
 	ret = of_property_read_u32(pdev->dev.of_node, "clock-frequency",
 				   &bus_clk_rate);
 	if (ret)
-		bus_clk_rate = 100000; /* 100 kHz default clock rate */
+		bus_clk_rate = I2C_STANDARD_MODE_FREQ; /* 100 kHz default clock rate */
 
 	clkrate = clk_get_rate(i2c->clk);
 	if (clkrate == 0) {
@@ -407,9 +407,9 @@ static int i2c_lpc2k_probe(struct platform_device *pdev)
 
 	/* Setup I2C dividers to generate clock with proper duty cycle */
 	clkrate = clkrate / bus_clk_rate;
-	if (bus_clk_rate <= 100000)
+	if (bus_clk_rate <= I2C_STANDARD_MODE_FREQ)
 		scl_high = (clkrate * I2C_STD_MODE_DUTY) / 100;
-	else if (bus_clk_rate <= 400000)
+	else if (bus_clk_rate <= I2C_FAST_MODE_FREQ)
 		scl_high = (clkrate * I2C_FAST_MODE_DUTY) / 100;
 	else
 		scl_high = (clkrate * I2C_FAST_MODE_PLUS_DUTY) / 100;
-- 
2.25.0
