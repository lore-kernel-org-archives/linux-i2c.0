From: <ying.zhang22455@nxp.com>
Subject: [PATCH 1/2] i2c: imx: add workaround for erratum ERR010027
Date: Fri, 17 Nov 2017 16:21:03 +0800
Message-ID: <20171117082104.18140-1-ying.zhang22455@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-dm3nam03on0076.outbound.protection.outlook.com ([104.47.41.76]:18688
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965444AbdKQIja (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 17 Nov 2017 03:39:30 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Zhang Ying-22455 <ying.zhang22455@nxp.com>

From: Zhang Ying-22455 <ying.zhang22455@nxp.com>

ERR010027: Attempting a start cycle while the bus is busy may
generate a short clock pulse.

Software must ensure that the I2C BUS is idle by checking the
bus busy before switching to master mode and attempting a Start
cycle.

Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
---
 drivers/i2c/busses/i2c-imx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index f96830ffd9f1..5df381c5f70d 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -889,6 +889,14 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
 
 	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
 
+	/*
+	 * workround for ERR010027: ensure that the I2C BUS is idle
+	 * before switching to master mode and attempting a Start cycle
+	 */
+	result =  i2c_imx_bus_busy(i2c_imx, 0);
+	if (result)
+		goto out;
+
 	result = pm_runtime_get_sync(i2c_imx->adapter.dev.parent);
 	if (result < 0)
 		goto out;
-- 
2.14.1
