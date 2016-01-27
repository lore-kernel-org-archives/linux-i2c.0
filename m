From: <ying.zhang22455@nxp.com>
Subject: [PATCH 1/2] i2c: ls1/ls2: add workaround for erratum ERR010027
Date: Wed, 27 Jan 2016 16:44:42 +0800
Message-ID: <1453884283-33414-1-git-send-email-ying.zhang22455@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-by2on0095.outbound.protection.outlook.com ([207.46.100.95]:55648
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751803AbcA0JH6 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 27 Jan 2016 04:07:58 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: xiaobo.xie@nxp.com, york.sun@nxp.com, Ying Zhang <b40530@freescale.com>

From: Ying Zhang <b40530@freescale.com>

ERR010027/ERR008951: Attempting a start cycle while the
bus is busy may generate a short clock pulse.

Software must ensure that the I2C BUS is idle by checking the
bus busy before switching to master mode and attempting a Start
cycle.

Signed-off-by: Ying Zhang <b40530@freescale.com>
---
 drivers/i2c/busses/i2c-imx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index a2b132c..f1fe599 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -889,6 +889,13 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
 
 	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
 
+	/* workround for ERR010027: ensure that the I2C BUS is idle
+	   before switching to master mode and attempting a Start cycle
+	 */
+	result =  i2c_imx_bus_busy(i2c_imx, 0);
+	if (result)
+		goto fail0;
+
 	result = pm_runtime_get_sync(i2c_imx->adapter.dev.parent);
 	if (result < 0)
 		goto out;
-- 
2.1.0.27.g96db324
