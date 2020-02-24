From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 12/40] i2c: digicolor: Use generic definitions for bus frequencies
Date: Mon, 24 Feb 2020 17:15:02 +0200
Message-ID: <20200224151530.31713-12-andriy.shevchenko@linux.intel.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:53971 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbgBXPPi (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Feb 2020 10:15:38 -0500
In-Reply-To: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Baruch Siach <baruch@tkos.co.il>

Since we have generic definitions for bus frequencies, let's use them.

Cc: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-digicolor.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-digicolor.c b/drivers/i2c/busses/i2c-digicolor.c
index 3adf72540db1..79bf187a90b1 100644
--- a/drivers/i2c/busses/i2c-digicolor.c
+++ b/drivers/i2c/busses/i2c-digicolor.c
@@ -18,7 +18,6 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 
-#define DEFAULT_FREQ		100000
 #define TIMEOUT_MS		100
 
 #define II_CONTROL		0x0
@@ -300,7 +299,7 @@ static int dc_i2c_probe(struct platform_device *pdev)
 
 	if (of_property_read_u32(pdev->dev.of_node, "clock-frequency",
 				 &i2c->frequency))
-		i2c->frequency = DEFAULT_FREQ;
+		i2c->frequency = I2C_STANDARD_MODE_FREQ;
 
 	i2c->dev = &pdev->dev;
 	platform_set_drvdata(pdev, i2c);
-- 
2.25.0
