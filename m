From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 23/40] i2c: nomadik: Use generic definitions for bus frequencies
Date: Mon, 24 Feb 2020 17:15:13 +0200
Message-ID: <20200224151530.31713-23-andriy.shevchenko@linux.intel.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62974 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbgBXPPq (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Feb 2020 10:15:46 -0500
In-Reply-To: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>

Since we have generic definitions for bus frequencies, let's use them.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-nomadik.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 01a7d72e5511..4aaaf48b60fb 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -396,7 +396,7 @@ static void setup_i2c_controller(struct nmk_i2c_dev *dev)
 	 * 2 whereas it is 3 for fast and fastplus mode of
 	 * operation. TODO - high speed support.
 	 */
-	div = (dev->clk_freq > 100000) ? 3 : 2;
+	div = (dev->clk_freq > I2C_STANDARD_MODE_FREQ) ? 3 : 2;
 
 	/*
 	 * generate the mask for baud rate counters. The controller
@@ -420,7 +420,7 @@ static void setup_i2c_controller(struct nmk_i2c_dev *dev)
 	if (dev->sm > I2C_FREQ_MODE_FAST) {
 		dev_err(&dev->adev->dev,
 			"do not support this mode defaulting to std. mode\n");
-		brcr2 = i2c_clk/(100000 * 2) & 0xffff;
+		brcr2 = i2c_clk / (I2C_STANDARD_MODE_FREQ * 2) & 0xffff;
 		writel((brcr1 | brcr2), dev->virtbase + I2C_BRCR);
 		writel(I2C_FREQ_MODE_STANDARD << 4,
 				dev->virtbase + I2C_CR);
@@ -949,10 +949,10 @@ static void nmk_i2c_of_probe(struct device_node *np,
 {
 	/* Default to 100 kHz if no frequency is given in the node */
 	if (of_property_read_u32(np, "clock-frequency", &nmk->clk_freq))
-		nmk->clk_freq = 100000;
+		nmk->clk_freq = I2C_STANDARD_MODE_FREQ;
 
 	/* This driver only supports 'standard' and 'fast' modes of operation. */
-	if (nmk->clk_freq <= 100000)
+	if (nmk->clk_freq <= I2C_STANDARD_MODE_FREQ)
 		nmk->sm = I2C_FREQ_MODE_STANDARD;
 	else
 		nmk->sm = I2C_FREQ_MODE_FAST;
-- 
2.25.0
