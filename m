From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] i2c: designware: Fix standard mode speed when configuring the slave mode
Date: Wed,  9 Aug 2017 15:24:44 +0300
Message-ID: <20170809122444.13461-1-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:32954 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751945AbdHIMYw (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 9 Aug 2017 08:24:52 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Luis Oliveira <Luis.Oliveira@synopsys.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

Code sets bit DW_IC_CON_SPEED_FAST (0x4) always when configuring the slave
mode. This results incorrect register value DW_IC_CON_SPEED_HIGH (0x6)
when OR'ed together with DW_IC_CON_SPEED_STD (0x2).

Remove this and let the code set the speed mode bits according to clock
frequency or default to fast mode.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index efb7191c6a6c..f55f2cdbbae3 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -198,8 +198,7 @@ static void i2c_dw_configure_slave(struct dw_i2c_dev *dev)
 	dev->functionality = I2C_FUNC_SLAVE | DW_IC_DEFAULT_FUNCTIONALITY;
 
 	dev->slave_cfg = DW_IC_CON_RX_FIFO_FULL_HLD_CTRL |
-			 DW_IC_CON_RESTART_EN | DW_IC_CON_STOP_DET_IFADDRESSED |
-			 DW_IC_CON_SPEED_FAST;
+			 DW_IC_CON_RESTART_EN | DW_IC_CON_STOP_DET_IFADDRESSED;
 
 	dev->mode = DW_IC_SLAVE;
 
-- 
2.13.2
