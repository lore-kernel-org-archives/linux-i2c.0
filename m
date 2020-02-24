From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 21/40] i2c: mv64xxx: Use generic definitions for bus frequencies
Date: Mon, 24 Feb 2020 17:15:11 +0200
Message-ID: <20200224151530.31713-21-andriy.shevchenko@linux.intel.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:59404 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727973AbgBXPPj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Feb 2020 10:15:39 -0500
In-Reply-To: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Gregory CLEMENT <gregory.clement@bootlin.com>

Since we have generic definitions for bus frequencies, let's use them.

Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index febb7c7ea72b..e803c6b0a947 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -810,7 +810,7 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 	tclk = clk_get_rate(drv_data->clk);
 
 	if (of_property_read_u32(np, "clock-frequency", &bus_freq))
-		bus_freq = 100000; /* 100kHz by default */
+		bus_freq = I2C_STANDARD_MODE_FREQ; /* 100kHz by default */
 
 	if (of_device_is_compatible(np, "allwinner,sun4i-a10-i2c") ||
 	    of_device_is_compatible(np, "allwinner,sun6i-a31-i2c"))
@@ -846,14 +846,14 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 	if (of_device_is_compatible(np, "marvell,mv78230-i2c")) {
 		drv_data->offload_enabled = true;
 		/* The delay is only needed in standard mode (100kHz) */
-		if (bus_freq <= 100000)
+		if (bus_freq <= I2C_STANDARD_MODE_FREQ)
 			drv_data->errata_delay = true;
 	}
 
 	if (of_device_is_compatible(np, "marvell,mv78230-a0-i2c")) {
 		drv_data->offload_enabled = false;
 		/* The delay is only needed in standard mode (100kHz) */
-		if (bus_freq <= 100000)
+		if (bus_freq <= I2C_STANDARD_MODE_FREQ)
 			drv_data->errata_delay = true;
 	}
 
-- 
2.25.0
