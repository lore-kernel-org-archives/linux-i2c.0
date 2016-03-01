From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 1/2] i2c: cadence: Fix the Documentation
Date: Tue, 1 Mar 2016 12:02:38 +0530
Message-ID: <1456813959-20398-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bl2nam02on0042.outbound.protection.outlook.com ([104.47.38.42]:58528
	"EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750820AbcCAGr7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 1 Mar 2016 01:47:59 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: soren.brinkmann@xilinx.com, michal.simek@xilinx.com, wsa@the-dreams.de, Shubhrajyoti Datta <shubhraj@xilinx.com>

The runtime adaptation patch missed the documentation update.
This fixes the same.
No functional change.

Signed-off-by: Shubhrajyoti Datta <shubhraj@xilinx.com>
---
 drivers/i2c/busses/i2c-cadence.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 6b08d16..a761520 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -815,7 +815,7 @@ static int cdns_i2c_clk_notifier_cb(struct notifier_block *nb, unsigned long
 }
 
 /**
- * cdns_i2c_suspend - Suspend method for the driver
+ * cdns_i2c_runtime_suspend -  Runtime suspend method for the driver
  * @_dev:	Address of the platform_device structure
  *
  * Put the driver into low power mode.
@@ -833,7 +833,7 @@ static int __maybe_unused cdns_i2c_runtime_suspend(struct device *dev)
 }
 
 /**
- * cdns_i2c_resume - Resume from suspend
+ * cdns_i2c_runtime_resume - Runtime resume
  * @_dev:	Address of the platform_device structure
  *
  * Resume operation after suspend.
-- 
1.7.1
