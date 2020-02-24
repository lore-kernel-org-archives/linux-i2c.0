From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 30/40] i2c: sirf: Use generic definitions for bus frequencies
Date: Mon, 24 Feb 2020 17:15:20 +0200
Message-ID: <20200224151530.31713-30-andriy.shevchenko@linux.intel.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62974 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbgBXPPq (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Feb 2020 10:15:46 -0500
In-Reply-To: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Barry Song <baohua@kernel.org>

Since we have generic definitions for bus frequencies, let's use them.

Cc: Barry Song <baohua@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-sirf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
index fb7a046b3226..bbd022181b13 100644
--- a/drivers/i2c/busses/i2c-sirf.c
+++ b/drivers/i2c/busses/i2c-sirf.c
@@ -62,7 +62,6 @@
 #define SIRFSOC_I2C_STOP		BIT(6)
 #define SIRFSOC_I2C_START		BIT(7)
 
-#define SIRFSOC_I2C_DEFAULT_SPEED 100000
 #define SIRFSOC_I2C_ERR_NOACK      1
 #define SIRFSOC_I2C_ERR_TIMEOUT    2
 
@@ -353,7 +352,7 @@ static int i2c_sirfsoc_probe(struct platform_device *pdev)
 	err = of_property_read_u32(pdev->dev.of_node,
 		"clock-frequency", &bitrate);
 	if (err < 0)
-		bitrate = SIRFSOC_I2C_DEFAULT_SPEED;
+		bitrate = I2C_STANDARD_MODE_FREQ;
 
 	/*
 	 * Due to some hardware design issues, we need to tune the formula.
-- 
2.25.0
