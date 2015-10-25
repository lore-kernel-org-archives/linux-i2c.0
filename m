From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: pnx: remove superfluous assignment
Date: Sun, 25 Oct 2015 16:20:59 +0100
Message-ID: <1445786459-22690-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46235 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751564AbbJYPVJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 25 Oct 2015 11:21:09 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Vladimir Zapolskiy <vz@mleia.com>, Muhammad Falak R Wani <falakreyaz@gmail.com>, Vitaly Wool <vitalywool@gmail.com>

smatch rightfully says:

drivers/i2c/busses/i2c-pnx.c:499 i2c_pnx_xfer warn: unused return: stat = ioread32()

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: Muhammad Falak R Wani <falakreyaz@gmail.com>
Cc: Vitaly Wool <vitalywool@gmail.com>
---
 drivers/i2c/busses/i2c-pnx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index cdbf6320cb909e..1b8bf368be0c15 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -496,7 +496,7 @@ i2c_pnx_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	struct i2c_msg *pmsg;
 	int rc = 0, completed = 0, i;
 	struct i2c_pnx_algo_data *alg_data = adap->algo_data;
-	u32 stat = ioread32(I2C_REG_STS(alg_data));
+	u32 stat;
 
 	dev_dbg(&alg_data->adapter.dev,
 		"%s(): entering: %d messages, stat = %04x.\n",
-- 
2.1.4
