From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 06/40] i2c: aspeed: Use generic definitions for bus frequencies
Date: Mon, 24 Feb 2020 17:14:56 +0200
Message-ID: <20200224151530.31713-6-andriy.shevchenko@linux.intel.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:50806 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727946AbgBXPPi (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Feb 2020 10:15:38 -0500
In-Reply-To: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Brendan Higgins <brendanhiggins@google.com>

Since we have generic definitions for bus frequencies, let's use them.

Cc: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index a7be6f24450b..ed0004a54278 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -997,7 +997,7 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
 	if (ret < 0) {
 		dev_err(&pdev->dev,
 			"Could not read bus-frequency property\n");
-		bus->bus_frequency = 100000;
+		bus->bus_frequency = I2C_STANDARD_MODE_FREQ;
 	}
 
 	match = of_match_node(aspeed_i2c_bus_of_table, pdev->dev.of_node);
-- 
2.25.0
