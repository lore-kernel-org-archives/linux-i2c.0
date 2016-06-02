From: Weifeng Voon <weifeng.voon@intel.com>
Subject: [PATCH] i2c: designware: Enable ioctl I2C_TIMEOUT
Date: Thu,  2 Jun 2016 15:57:30 +0800
Message-ID: <1464854250-6810-1-git-send-email-weifeng.voon@intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:10775 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751189AbcFBH6f (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 2 Jun 2016 03:58:35 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jui.nee.tan@intel.com, Weifeng Voon <weifeng.voon@intel.com>

This allows applications to set the transfer timeout in 10ms increments via
ioctl I2C_TIMEOUT.

Signed-off-by: Weifeng Voon <weifeng.voon@intel.com>
---
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
