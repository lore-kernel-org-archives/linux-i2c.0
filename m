From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 2/2] i2c: designware: Fix runtime PM for I2C slave mode
Date: Tue, 15 Aug 2017 17:34:45 +0300
Message-ID: <20170815143445.26167-2-jarkko.nikula@linux.intel.com>
References: <20170815143445.26167-1-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17087 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752148AbdHOOl2 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 15 Aug 2017 10:41:28 -0400
In-Reply-To: <20170815143445.26167-1-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Luis Oliveira <Luis.Oliveira@synopsys.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

I2C slave controller must be powered and active all the time when I2C
slave backend is registered in order to let master address and
communicate with us.

Now if the controller is runtime PM capable it will be suspended after
probe and cannot ever respond to the master or generate interrupts.

Fix this by resuming the controller when I2C slave backend is registered
and let it suspend after unregistering.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-slave.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
index bb8f738cab14..ea9578ab19a1 100644
--- a/drivers/i2c/busses/i2c-designware-slave.c
+++ b/drivers/i2c/busses/i2c-designware-slave.c
@@ -177,6 +177,8 @@ static int i2c_dw_reg_slave(struct i2c_client *slave)
 		return -EBUSY;
 	if (slave->flags & I2C_CLIENT_TEN)
 		return -EAFNOSUPPORT;
+	pm_runtime_get_sync(dev->dev);
+
 	/*
 	 * Set slave address in the IC_SAR register,
 	 * the address to which the DW_apb_i2c responds.
@@ -205,6 +207,7 @@ static int i2c_dw_unreg_slave(struct i2c_client *slave)
 	dev->disable_int(dev);
 	dev->disable(dev);
 	dev->slave = NULL;
+	pm_runtime_put(dev->dev);
 
 	return 0;
 }
-- 
2.14.1
