From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 4/8] i2c: designware: set the common config before the if else
Date: Fri, 12 Aug 2016 17:02:50 +0300
Message-ID: <1471010574-28598-5-git-send-email-jarkko.nikula@linux.intel.com>
References: <1471010574-28598-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:54302 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596AbcHLODN (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 12 Aug 2016 10:03:13 -0400
In-Reply-To: <1471010574-28598-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Weifeng Voon <weifeng.voon@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

From: Weifeng Voon <weifeng.voon@intel.com>

DW_IC_CON_MASTER, DW_IC_CON_SLAVE_DISABLE and DW_IC_CON_RESTART_EN are
common config that need to be set for i2c designware master. So, configure
it first without having to repeat inside the if else.

Signed-off-by: Weifeng Voon <weifeng.voon@intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index ea92e9f3fba1..d45481ee1b56 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -217,12 +217,14 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 		I2C_FUNC_SMBUS_BYTE_DATA |
 		I2C_FUNC_SMBUS_WORD_DATA |
 		I2C_FUNC_SMBUS_I2C_BLOCK;
+
+	dev->master_cfg = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
+			  DW_IC_CON_RESTART_EN;
+
 	if (dev->clk_freq == 100000)
-		dev->master_cfg =  DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
-			DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_STD;
+		dev->master_cfg |= DW_IC_CON_SPEED_STD;
 	else
-		dev->master_cfg =  DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
-			DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;
+		dev->master_cfg |= DW_IC_CON_SPEED_FAST;
 
 	dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (!i2c_dw_plat_prepare_clk(dev, true)) {
-- 
2.8.1
