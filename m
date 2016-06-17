From: Weifeng Voon <weifeng.voon@intel.com>
Subject: [PATCH v3] i2c: designware: Use transfer timeout from ioctl I2C_TIMEOUT
Date: Fri, 17 Jun 2016 09:46:35 +0800
Message-ID: <1466127995-28318-1-git-send-email-weifeng.voon@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jui.nee.tan@intel.com, Weifeng Voon <weifeng.voon@intel.com>
List-Id: linux-i2c@vger.kernel.org

This allows applications to set the transfer timeout in 10ms increments via
ioctl I2C_TIMEOUT.

Signed-off-by: Weifeng Voon <weifeng.voon@intel.com>
---
 changelog v2:
 * No code change, just change to a more suitable title

 changelog v3:
 * Move changelog out of commit log

 drivers/i2c/busses/i2c-designware-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 99b54be..c6922b8 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -663,7 +663,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	i2c_dw_xfer_init(dev);
 
 	/* wait for tx to complete */
-	if (!wait_for_completion_timeout(&dev->cmd_complete, HZ)) {
+	if (!wait_for_completion_timeout(&dev->cmd_complete, adap->timeout)) {
 		dev_err(dev->dev, "controller timed out\n");
 		/* i2c_dw_init implicitly disables the adapter */
 		i2c_dw_init(dev);
-- 
1.9.1
