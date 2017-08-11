From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] i2c: designware: Fix oops from i2c_dw_irq_handler_slave
Date: Fri, 11 Aug 2017 14:44:55 +0300
Message-ID: <20170811114455.26950-1-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:9060 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752943AbdHKLpC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 11 Aug 2017 07:45:02 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Luis Oliveira <Luis.Oliveira@synopsys.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

When i2c-designware is initialized in slave mode the
i2c-designware-slave.c: i2c_dw_irq_handler_slave() can hit a NULL
pointer dereference when I2C slave backend is not registered but code is
accessing the struct dw_i2c_dev.slave without testing is it NULL.

We might get spurious interrupts from other devices or from IRQ core
during unloading the driver when CONFIG_DEBUG_SHIRQ is set. Existing
check for enable and IRQ status is not enough since device can be power
gated and those bits may read 1.

Fix this by handling the interrupt only when also struct dw_i2c_dev.slave
is set.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-slave.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
index 0548c7ea578c..4b62a3872763 100644
--- a/drivers/i2c/busses/i2c-designware-slave.c
+++ b/drivers/i2c/busses/i2c-designware-slave.c
@@ -272,7 +272,7 @@ static int i2c_dw_irq_handler_slave(struct dw_i2c_dev *dev)
 	slave_activity = ((dw_readl(dev, DW_IC_STATUS) &
 		DW_IC_STATUS_SLAVE_ACTIVITY) >> 6);
 
-	if (!enabled || !(raw_stat & ~DW_IC_INTR_ACTIVITY))
+	if (!enabled || !(raw_stat & ~DW_IC_INTR_ACTIVITY) || !dev->slave)
 		return 0;
 
 	dev_dbg(dev->dev,
-- 
2.13.2
