From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 1/2] i2c: designware: Make HW init functions static
Date: Wed, 28 Jun 2017 17:23:28 +0300
Message-ID: <20170628142329.14818-2-jarkko.nikula@linux.intel.com>
References: <20170628142329.14818-1-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:2993 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751672AbdF1OZi (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 28 Jun 2017 10:25:38 -0400
In-Reply-To: <20170628142329.14818-1-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Luis Oliveira <lolivei@synopsys.com>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

Recent i2c-designware slave support patches use master or slave HW init
functions through the function pointer so we can declare them static.

While at it, rename i2c_dw_init() as i2c_dw_init_master().

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-core.h   | 2 --
 drivers/i2c/busses/i2c-designware-master.c | 7 +++----
 drivers/i2c/busses/i2c-designware-slave.c  | 3 +--
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 7bfbcc62f6c5..a403dcdfca4b 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -306,8 +306,6 @@ int i2c_dw_handle_tx_abort(struct dw_i2c_dev *dev);
 u32 i2c_dw_func(struct i2c_adapter *adap);
 void i2c_dw_disable(struct dw_i2c_dev *dev);
 void i2c_dw_disable_int(struct dw_i2c_dev *dev);
-int i2c_dw_init(struct dw_i2c_dev *dev);
-int i2c_dw_init_slave(struct dw_i2c_dev *dev);
 
 extern u32 i2c_dw_read_comp_param(struct dw_i2c_dev *dev);
 extern int i2c_dw_probe(struct dw_i2c_dev *dev);
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index eefc4db1ee3e..418c233075d3 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -51,7 +51,7 @@ static void i2c_dw_configure_fifo_master(struct dw_i2c_dev *dev)
  * This function is called during I2C init function, and in case of timeout at
  * run time.
  */
-int i2c_dw_init(struct dw_i2c_dev *dev)
+static int i2c_dw_init_master(struct dw_i2c_dev *dev)
 {
 	u32 hcnt, lcnt;
 	u32 reg, comp_param1;
@@ -171,7 +171,6 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(i2c_dw_init);
 
 static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 {
@@ -444,7 +443,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	if (!wait_for_completion_timeout(&dev->cmd_complete, adap->timeout)) {
 		dev_err(dev->dev, "controller timed out\n");
 		/* i2c_dw_init implicitly disables the adapter */
-		i2c_dw_init(dev);
+		i2c_dw_init_master(dev);
 		ret = -ETIMEDOUT;
 		goto done;
 	}
@@ -622,7 +621,7 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 
 	init_completion(&dev->cmd_complete);
 
-	dev->init = i2c_dw_init;
+	dev->init = i2c_dw_init_master;
 	dev->disable = i2c_dw_disable;
 	dev->disable_int = i2c_dw_disable_int;
 
diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
index 4012c74e9785..1b82a8611eb5 100644
--- a/drivers/i2c/busses/i2c-designware-slave.c
+++ b/drivers/i2c/busses/i2c-designware-slave.c
@@ -49,7 +49,7 @@ static void i2c_dw_configure_fifo_slave(struct dw_i2c_dev *dev)
  * This function is called during I2C init function, and in case of timeout at
  * run time.
  */
-int i2c_dw_init_slave(struct dw_i2c_dev *dev)
+static int i2c_dw_init_slave(struct dw_i2c_dev *dev)
 {
 	u32 sda_falling_time, scl_falling_time;
 	u32 reg, comp_param1;
@@ -168,7 +168,6 @@ int i2c_dw_init_slave(struct dw_i2c_dev *dev)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(i2c_dw_init_slave);
 
 static int i2c_dw_reg_slave(struct i2c_client *slave)
 {
-- 
2.11.0
