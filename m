From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 10/40] i2c: cadence: Use generic definitions for bus frequencies
Date: Mon, 24 Feb 2020 17:15:00 +0200
Message-ID: <20200224151530.31713-10-andriy.shevchenko@linux.intel.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:59397 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbgBXPPh (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Feb 2020 10:15:37 -0500
In-Reply-To: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Michal Simek <michal.simek@xilinx.com>

Since we have generic definitions for bus frequencies, let's use them.

Cc: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-cadence.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 1105aee6634a..9886daae505f 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -104,9 +104,6 @@
 
 #define DRIVER_NAME		"cdns-i2c"
 
-#define CDNS_I2C_SPEED_MAX	400000
-#define CDNS_I2C_SPEED_DEFAULT	100000
-
 #define CDNS_I2C_DIVA_MAX	4
 #define CDNS_I2C_DIVB_MAX	64
 
@@ -949,8 +946,8 @@ static int cdns_i2c_probe(struct platform_device *pdev)
 
 	ret = of_property_read_u32(pdev->dev.of_node, "clock-frequency",
 			&id->i2c_clk);
-	if (ret || (id->i2c_clk > CDNS_I2C_SPEED_MAX))
-		id->i2c_clk = CDNS_I2C_SPEED_DEFAULT;
+	if (ret || (id->i2c_clk > I2C_FAST_MODE_FREQ))
+		id->i2c_clk = I2C_STANDARD_MODE_FREQ;
 
 	cdns_i2c_writereg(CDNS_I2C_CR_ACK_EN | CDNS_I2C_CR_NEA | CDNS_I2C_CR_MS,
 			  CDNS_I2C_CR_OFFSET);
-- 
2.25.0
