From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 40/40] i2c: xlp9xx: Use generic definitions for bus frequencies
Date: Mon, 24 Feb 2020 17:15:30 +0200
Message-ID: <20200224151530.31713-40-andriy.shevchenko@linux.intel.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:59404 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbgBXPPl (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Feb 2020 10:15:41 -0500
In-Reply-To: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, George Cherian <gcherian@marvell.com>

Since we have generic definitions for bus frequencies, let's use them.

Cc: George Cherian <gcherian@marvell.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-xlp9xx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
index 8a873975cf12..4328b0fc6002 100644
--- a/drivers/i2c/busses/i2c-xlp9xx.c
+++ b/drivers/i2c/busses/i2c-xlp9xx.c
@@ -71,8 +71,6 @@
 #define XLP9XX_I2C_SLAVEADDR_ADDR_SHIFT		1
 
 #define XLP9XX_I2C_IP_CLK_FREQ		133000000UL
-#define XLP9XX_I2C_DEFAULT_FREQ		100000
-#define XLP9XX_I2C_HIGH_FREQ		400000
 #define XLP9XX_I2C_FIFO_SIZE		0x80U
 #define XLP9XX_I2C_TIMEOUT_MS		1000
 #define XLP9XX_I2C_BUSY_TIMEOUT		50
@@ -476,12 +474,12 @@ static int xlp9xx_i2c_get_frequency(struct platform_device *pdev,
 
 	err = device_property_read_u32(&pdev->dev, "clock-frequency", &freq);
 	if (err) {
-		freq = XLP9XX_I2C_DEFAULT_FREQ;
+		freq = I2C_STANDARD_MODE_FREQ;
 		dev_dbg(&pdev->dev, "using default frequency %u\n", freq);
-	} else if (freq == 0 || freq > XLP9XX_I2C_HIGH_FREQ) {
+	} else if (freq == 0 || freq > I2C_FAST_MODE_FREQ) {
 		dev_warn(&pdev->dev, "invalid frequency %u, using default\n",
 			 freq);
-		freq = XLP9XX_I2C_DEFAULT_FREQ;
+		freq = I2C_STANDARD_MODE_FREQ;
 	}
 	priv->clk_hz = freq;
 
-- 
2.25.0
