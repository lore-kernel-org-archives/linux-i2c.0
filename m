From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 07/40] i2c: axxia: Use generic definitions for bus frequencies
Date: Mon, 24 Feb 2020 17:14:57 +0200
Message-ID: <20200224151530.31713-7-andriy.shevchenko@linux.intel.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62974 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbgBXPPp (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Feb 2020 10:15:45 -0500
In-Reply-To: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Krzysztof Adamski <krzysztof.adamski@nokia.com>

Since we have generic definitions for bus frequencies, let's use them.

Cc: Krzysztof Adamski <krzysztof.adamski@nokia.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-axxia.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.c
index 0214daa913ff..ac9a4b7ec7fc 100644
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -176,7 +176,7 @@ static u32 ns_to_clk(u64 ns, u32 clk_mhz)
 static int axxia_i2c_init(struct axxia_i2c_dev *idev)
 {
 	u32 divisor = clk_get_rate(idev->i2c_clk) / idev->bus_clk_rate;
-	u32 clk_mhz = clk_get_rate(idev->i2c_clk) / 1000000;
+	u32 clk_mhz = clk_get_rate(idev->i2c_clk) / HZ_PER_MHZ;
 	u32 t_setup;
 	u32 t_high, t_low;
 	u32 tmo_clk;
@@ -199,7 +199,7 @@ static int axxia_i2c_init(struct axxia_i2c_dev *idev)
 	/* Enable Master Mode */
 	writel(0x1, idev->base + GLOBAL_CONTROL);
 
-	if (idev->bus_clk_rate <= 100000) {
+	if (idev->bus_clk_rate <= I2C_STANDARD_MODE_FREQ) {
 		/* Standard mode SCL 50/50, tSU:DAT = 250 ns */
 		t_high = divisor * 1 / 2;
 		t_low = divisor * 1 / 2;
@@ -765,7 +765,7 @@ static int axxia_i2c_probe(struct platform_device *pdev)
 
 	of_property_read_u32(np, "clock-frequency", &idev->bus_clk_rate);
 	if (idev->bus_clk_rate == 0)
-		idev->bus_clk_rate = 100000;	/* default clock rate */
+		idev->bus_clk_rate = I2C_STANDARD_MODE_FREQ;	/* default clock rate */
 
 	ret = clk_prepare_enable(idev->i2c_clk);
 	if (ret) {
-- 
2.25.0
