From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCHv3 2/2] i2c: cadence: Remove the suspended flag
Date: Tue, 24 Nov 2015 13:01:57 +0530
Message-ID: <1448350317-37077-2-git-send-email-shubhraj@xilinx.com>
References: <1448350317-37077-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bl2nam02on0087.outbound.protection.outlook.com ([104.47.38.87]:15271
	"EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751714AbbKXHrc (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 24 Nov 2015 02:47:32 -0500
In-Reply-To: <1448350317-37077-1-git-send-email-shubhraj@xilinx.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: soren.brinkmann@xilinx.com, michal.simek@xilinx.com, anirudh@xilinx.com, wsa@the-dreams.de, Shubhrajyoti Datta <shubhraj@xilinx.com>

The suspended flag is a flag holding the device's PM status.
The runtime framework does that for us.
Use pm_runtime_suspended call instead.

Signed-off-by: Shubhrajyoti Datta <shubhraj@xilinx.com>
---
v3: split the patches

 drivers/i2c/busses/i2c-cadence.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index d54ad46..6b08d16 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -131,7 +131,6 @@
  * @xfer_done:		Transfer complete status
  * @p_send_buf:		Pointer to transmit buffer
  * @p_recv_buf:		Pointer to receive buffer
- * @suspended:		Flag holding the device's PM status
  * @send_count:		Number of bytes still expected to send
  * @recv_count:		Number of bytes still expected to receive
  * @curr_recv_count:	Number of bytes to be received in current transfer
@@ -152,7 +151,6 @@ struct cdns_i2c {
 	struct completion xfer_done;
 	unsigned char *p_send_buf;
 	unsigned char *p_recv_buf;
-	u8 suspended;
 	unsigned int send_count;
 	unsigned int recv_count;
 	unsigned int curr_recv_count;
@@ -776,7 +774,7 @@ static int cdns_i2c_clk_notifier_cb(struct notifier_block *nb, unsigned long
 	struct clk_notifier_data *ndata = data;
 	struct cdns_i2c *id = to_cdns_i2c(nb);
 
-	if (id->suspended)
+	if (pm_runtime_suspended(id->dev))
 		return NOTIFY_OK;
 
 	switch (event) {
@@ -830,7 +828,6 @@ static int __maybe_unused cdns_i2c_runtime_suspend(struct device *dev)
 	struct cdns_i2c *xi2c = platform_get_drvdata(pdev);
 
 	clk_disable(xi2c->clk);
-	xi2c->suspended = 1;
 
 	return 0;
 }
@@ -855,8 +852,6 @@ static int __maybe_unused cdns_i2c_runtime_resume(struct device *dev)
 		return ret;
 	}
 
-	xi2c->suspended = 0;
-
 	return 0;
 }
 
-- 
1.7.1
