From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCHv3 1/2] i2c: cadence: Fix the Documentation
Date: Thu, 3 Mar 2016 11:20:39 +0530
Message-ID: <1456984240-17389-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-cys01nam02on0050.outbound.protection.outlook.com ([104.47.37.50]:25066
	"EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751004AbcCCFuu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 3 Mar 2016 00:50:50 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: anirudh@xilinx.com, soren.brinkmann@xilinx.com, michal.simek@xilinx.com, wsa@the-dreams.de, Shubhrajyoti Datta <shubhraj@xilinx.com>

The runtime adaptation patch missed the documentation update.
This fixes the same.

Tested-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Shubhrajyoti Datta <shubhraj@xilinx.com>
---
v2 changes:
fix the dev param description

v3 changes
Fix the cdns_i2c_clear_bus_hold

 drivers/i2c/busses/i2c-cadence.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 6b08d16..90bbd9f 100644
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
@@ -171,7 +173,7 @@ struct cdns_platform_data {
 					     clk_rate_change_nb)
 
 /**
- * cdns_i2c_clear_bus_hold() - Clear bus hold bit
+ * cdns_i2c_clear_bus_hold - Clear bus hold bit
  * @id:	Pointer to driver data struct
  *
  * Helper to clear the controller's bus hold bit.
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
