From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 09/40] i2c: bcm-kona: Use generic definitions for bus frequencies
Date: Mon, 24 Feb 2020 17:14:59 +0200
Message-ID: <20200224151530.31713-9-andriy.shevchenko@linux.intel.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:59400 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727952AbgBXPPi (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Feb 2020 10:15:38 -0500
In-Reply-To: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>

Since we have generic definitions for bus frequencies, let's use them.

Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-bcm-kona.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm-kona.c b/drivers/i2c/busses/i2c-bcm-kona.c
index 4e489a9d16fb..2858639767da 100644
--- a/drivers/i2c/busses/i2c-bcm-kona.c
+++ b/drivers/i2c/busses/i2c-bcm-kona.c
@@ -722,16 +722,16 @@ static int bcm_kona_i2c_assign_bus_speed(struct bcm_kona_i2c_dev *dev)
 	}
 
 	switch (bus_speed) {
-	case 100000:
+	case I2C_STANDARD_MODE_FREQ:
 		dev->std_cfg = &std_cfg_table[BCM_SPD_100K];
 		break;
-	case 400000:
+	case I2C_FAST_MODE_FREQ:
 		dev->std_cfg = &std_cfg_table[BCM_SPD_400K];
 		break;
-	case 1000000:
+	case I2C_FAST_MODE_PLUS_FREQ:
 		dev->std_cfg = &std_cfg_table[BCM_SPD_1MHZ];
 		break;
-	case 3400000:
+	case I2C_HIGH_SPEED_MODE_FREQ:
 		/* Send mastercode at 100k */
 		dev->std_cfg = &std_cfg_table[BCM_SPD_100K];
 		dev->hs_cfg = &hs_cfg_table[BCM_SPD_3P4MHZ];
-- 
2.25.0
