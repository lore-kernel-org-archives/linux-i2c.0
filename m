From: Weifeng Voon <weifeng.voon@intel.com>
Subject: [PATCH 4/5] i2c: designware: set the common config before the if else
Date: Thu, 26 May 2016 16:01:11 +0800
Message-ID: <1464249672-24566-5-git-send-email-weifeng.voon@intel.com>
References: <1464249672-24566-1-git-send-email-weifeng.voon@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464249672-24566-1-git-send-email-weifeng.voon@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jui.nee.tan@intel.com
List-Id: linux-i2c@vger.kernel.org

DW_IC_CON_MASTER, DW_IC_CON_SLAVE_DISABLE and DW_IC_CON_RESTART_EN are
common config that need to be set for i2c designware master. So, configure
it first without having to repeat inside the if else.

Signed-off-by: Weifeng Voon <weifeng.voon@intel.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index ea92e9f..d45481e 100644
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
1.9.1
