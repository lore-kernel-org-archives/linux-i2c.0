From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 28/40] i2c: s3c2410: Use generic definitions for bus frequencies
Date: Mon, 24 Feb 2020 17:15:18 +0200
Message-ID: <20200224151530.31713-28-andriy.shevchenko@linux.intel.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:4188 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbgBXPPj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Feb 2020 10:15:39 -0500
In-Reply-To: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>

Since we have generic definitions for bus frequencies, let's use them.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-s3c2410.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index c98ef4c4a0c9..21631fa65da0 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -835,13 +835,13 @@ static int s3c24xx_i2c_clockrate(struct s3c24xx_i2c *i2c, unsigned int *got)
 	int freq;
 
 	i2c->clkrate = clkin;
-	clkin /= 1000;		/* clkin now in KHz */
+	clkin /= HZ_PER_KHZ;	/* clkin now in KHz */
 
 	dev_dbg(i2c->dev, "pdata desired frequency %lu\n", pdata->frequency);
 
-	target_frequency = pdata->frequency ? pdata->frequency : 100000;
+	target_frequency = pdata->frequency ?: I2C_STANDARD_MODE_FREQ;
 
-	target_frequency /= 1000; /* Target frequency now in KHz */
+	target_frequency /= HZ_PER_KHZ; /* Target frequency now in KHz */
 
 	freq = s3c24xx_i2c_calcdivisor(clkin, target_frequency, &div1, &divs);
 
-- 
2.25.0
