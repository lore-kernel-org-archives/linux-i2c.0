From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCHv2 1/2] i2c: cadence: Fix the Documentation
Date: Tue, 1 Mar 2016 14:51:04 +0530
Message-ID: <1456824065-22080-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-cys01nam02on0077.outbound.protection.outlook.com ([104.47.37.77]:10499
	"EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752681AbcCAJVR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 1 Mar 2016 04:21:17 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: soren.brinkmann@xilinx.com, michal.simek@xilinx.com, wsa@the-dreams.de, Shubhrajyoti Datta <shubhraj@xilinx.com>

The runtime adaptation patch missed the documentation update.
This fixes the same.

Signed-off-by: Shubhrajyoti Datta <shubhraj@xilinx.com>
---
v2 changes:
fix the dev param description

 drivers/i2c/busses/i2c-cadence.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 6b08d16..f9f485d 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -124,6 +124,8 @@
 
 /**
  * struct cdns_i2c - I2C device private data structure
+ *
+ * @dev:		Pointer to device structure
  * @membase:		Base address of the I2C device
  * @adap:		I2C adapter instance
  * @p_msg:		Message pointer
@@ -815,8 +817,8 @@ static int cdns_i2c_clk_notifier_cb(struct notifier_block *nb, unsigned long
 }
 
 /**
- * cdns_i2c_suspend - Suspend method for the driver
- * @_dev:	Address of the platform_device structure
+ * cdns_i2c_runtime_suspend -  Runtime suspend method for the driver
+ * @dev:	Address of the platform_device structure
  *
  * Put the driver into low power mode.
  *
@@ -833,10 +835,10 @@ static int __maybe_unused cdns_i2c_runtime_suspend(struct device *dev)
 }
 
 /**
- * cdns_i2c_resume - Resume from suspend
- * @_dev:	Address of the platform_device structure
+ * cdns_i2c_runtime_resume - Runtime resume
+ * @dev:	Address of the platform_device structure
  *
- * Resume operation after suspend.
+ * Runtime resume callback.
  *
  * Return: 0 on success and error value on error
  */
-- 
1.7.1
