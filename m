From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 08/40] i2c: bcm-iproc: Use generic definitions for bus frequencies
Date: Mon, 24 Feb 2020 17:14:58 +0200
Message-ID: <20200224151530.31713-8-andriy.shevchenko@linux.intel.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62976 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728003AbgBXPPo (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Feb 2020 10:15:44 -0500
In-Reply-To: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>

Since we have generic definitions for bus frequencies, let's use them.

Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index 30efb7913b2e..627ad88dcf04 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -858,25 +858,25 @@ static int bcm_iproc_i2c_cfg_speed(struct bcm_iproc_i2c_dev *iproc_i2c)
 	if (ret < 0) {
 		dev_info(iproc_i2c->device,
 			"unable to interpret clock-frequency DT property\n");
-		bus_speed = 100000;
+		bus_speed = I2C_STANDARD_MODE_FREQ;
 	}
 
-	if (bus_speed < 100000) {
+	if (bus_speed < I2C_STANDARD_MODE_FREQ) {
 		dev_err(iproc_i2c->device, "%d Hz bus speed not supported\n",
 			bus_speed);
 		dev_err(iproc_i2c->device,
 			"valid speeds are 100khz and 400khz\n");
 		return -EINVAL;
-	} else if (bus_speed < 400000) {
-		bus_speed = 100000;
+	} else if (bus_speed < I2C_FAST_MODE_FREQ) {
+		bus_speed = I2C_STANDARD_MODE_FREQ;
 	} else {
-		bus_speed = 400000;
+		bus_speed = I2C_FAST_MODE_FREQ;
 	}
 
 	iproc_i2c->bus_speed = bus_speed;
 	val = iproc_i2c_rd_reg(iproc_i2c, TIM_CFG_OFFSET);
 	val &= ~BIT(TIM_CFG_MODE_400_SHIFT);
-	val |= (bus_speed == 400000) << TIM_CFG_MODE_400_SHIFT;
+	val |= (bus_speed == I2C_FAST_MODE_FREQ) << TIM_CFG_MODE_400_SHIFT;
 	iproc_i2c_wr_reg(iproc_i2c, TIM_CFG_OFFSET, val);
 
 	dev_info(iproc_i2c->device, "bus set to %u Hz\n", bus_speed);
@@ -1029,7 +1029,7 @@ static int bcm_iproc_i2c_resume(struct device *dev)
 	/* configure to the desired bus speed */
 	val = iproc_i2c_rd_reg(iproc_i2c, TIM_CFG_OFFSET);
 	val &= ~BIT(TIM_CFG_MODE_400_SHIFT);
-	val |= (iproc_i2c->bus_speed == 400000) << TIM_CFG_MODE_400_SHIFT;
+	val |= (iproc_i2c->bus_speed == I2C_FAST_MODE_FREQ) << TIM_CFG_MODE_400_SHIFT;
 	iproc_i2c_wr_reg(iproc_i2c, TIM_CFG_OFFSET, val);
 
 	bcm_iproc_i2c_enable_disable(iproc_i2c, true);
-- 
2.25.0
