From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 25/40] i2c: rcar: Use generic definitions for bus frequencies
Date: Mon, 24 Feb 2020 17:15:15 +0200
Message-ID: <20200224151530.31713-25-andriy.shevchenko@linux.intel.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:59397 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727964AbgBXPPj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Feb 2020 10:15:39 -0500
In-Reply-To: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Since we have generic definitions for bus frequencies, let's use them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 879f0e61a496..e9a2c6ba1d28 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -242,7 +242,7 @@ static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv, struct i2c_timin
 	struct device *dev = rcar_i2c_priv_to_dev(priv);
 
 	/* Fall back to previously used values if not supplied */
-	t->bus_freq_hz = t->bus_freq_hz ?: 100000;
+	t->bus_freq_hz = t->bus_freq_hz ?: I2C_STANDARD_MODE_FREQ;
 	t->scl_fall_ns = t->scl_fall_ns ?: 35;
 	t->scl_rise_ns = t->scl_rise_ns ?: 200;
 	t->scl_int_delay_ns = t->scl_int_delay_ns ?: 50;
-- 
2.25.0
