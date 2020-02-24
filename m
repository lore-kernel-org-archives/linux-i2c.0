From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 34/40] i2c: stu300: Use generic definitions for bus frequencies
Date: Mon, 24 Feb 2020 17:15:24 +0200
Message-ID: <20200224151530.31713-34-andriy.shevchenko@linux.intel.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:59404 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbgBXPPk (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Feb 2020 10:15:40 -0500
In-Reply-To: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>

Since we have generic definitions for bus frequencies, let's use them.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-stu300.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-stu300.c
index 42e0a53e7fa4..d5fef98796bb 100644
--- a/drivers/i2c/busses/i2c-stu300.c
+++ b/drivers/i2c/busses/i2c-stu300.c
@@ -132,7 +132,7 @@ enum stu300_error {
 #define NUM_ADDR_RESEND_ATTEMPTS 12
 
 /* I2C clock speed, in Hz 0-400kHz*/
-static unsigned int scl_frequency = 100000;
+static unsigned int scl_frequency = I2C_STANDARD_MODE_FREQ;
 module_param(scl_frequency, uint,  0644);
 
 /**
@@ -497,7 +497,7 @@ static int stu300_set_clk(struct stu300_dev *dev, unsigned long clkrate)
 	dev_dbg(&dev->pdev->dev, "Clock rate %lu Hz, I2C bus speed %d Hz "
 		"virtbase %p\n", clkrate, dev->speed, dev->virtbase);
 
-	if (dev->speed > 100000)
+	if (dev->speed > I2C_STANDARD_MODE_FREQ)
 		/* Fast Mode I2C */
 		val = ((clkrate/dev->speed) - 9)/3 + 1;
 	else
@@ -518,7 +518,7 @@ static int stu300_set_clk(struct stu300_dev *dev, unsigned long clkrate)
 		return -EINVAL;
 	}
 
-	if (dev->speed > 100000) {
+	if (dev->speed > I2C_STANDARD_MODE_FREQ) {
 		/* CC6..CC0 */
 		stu300_wr8((val & I2C_CCR_CC_MASK) | I2C_CCR_FMSM,
 			   dev->virtbase + I2C_CCR);
-- 
2.25.0
