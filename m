From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH RFT 3/5] i2c: sh_mobile: manually "inline" two short functions
Date: Thu,  2 Nov 2017 13:47:29 +0100
Message-ID: <20171102124731.10484-4-wsa+renesas@sang-engineering.com>
References: <20171102124731.10484-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:33858 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754894AbdKBMrm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 2 Nov 2017 08:47:42 -0400
In-Reply-To: <20171102124731.10484-1-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Jacopo Mondi <jacopo@jmondi.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>

Those two functions are very short and only called once. The code
becomes easier to understand if the code is directly put into the main
xfer function.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index a1253df9574594..cdd7a746b9d1ed 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -298,23 +298,6 @@ static int sh_mobile_i2c_init(struct sh_mobile_i2c_data *pd)
 	return 0;
 }
 
-static void activate_ch(struct sh_mobile_i2c_data *pd)
-{
-	/* Wake up device and enable clock */
-	pm_runtime_get_sync(pd->dev);
-	clk_prepare_enable(pd->clk);
-}
-
-static void deactivate_ch(struct sh_mobile_i2c_data *pd)
-{
-	/* Disable channel */
-	iic_set_clr(pd, ICCR, 0, ICCR_ICE);
-
-	/* Disable clock and mark device as idle */
-	clk_disable_unprepare(pd->clk);
-	pm_runtime_put_sync(pd->dev);
-}
-
 static unsigned char i2c_op(struct sh_mobile_i2c_data *pd,
 			    enum sh_mobile_i2c_op op, unsigned char data)
 {
@@ -717,7 +700,9 @@ static int sh_mobile_i2c_xfer(struct i2c_adapter *adapter,
 	int i;
 	long timeout;
 
-	activate_ch(pd);
+	/* Wake up device and enable clock */
+	pm_runtime_get_sync(pd->dev);
+	clk_prepare_enable(pd->clk);
 
 	/* Process all messages */
 	for (i = 0; i < num; i++) {
@@ -754,7 +739,12 @@ static int sh_mobile_i2c_xfer(struct i2c_adapter *adapter,
 			break;
 	}
 
-	deactivate_ch(pd);
+	/* Disable channel */
+	iic_set_clr(pd, ICCR, 0, ICCR_ICE);
+
+	/* Disable clock and mark device as idle */
+	clk_disable_unprepare(pd->clk);
+	pm_runtime_put_sync(pd->dev);
 
 	if (!err)
 		err = num;
-- 
2.11.0
