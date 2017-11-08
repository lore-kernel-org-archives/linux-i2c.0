From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFT] i2c: sh_mobile: let RuntimePM do the clock handling
Date: Wed,  8 Nov 2017 09:50:37 +0100
Message-ID: <20171108085037.1318-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:59902 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750735AbdKHIur (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 8 Nov 2017 03:50:47 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Jacopo Mondi <jacopo@jmondi.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert+renesas@glider.be>

No need to do it manually.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

jacopo: can you test this on Migo-R, please, on top of the other I2C patches?

I tested it on a Lager and it worked there. Will try Gen3 later, too.

 drivers/i2c/busses/i2c-sh_mobile.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index ebd146ccb24465..80561ffbcf7b46 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -702,7 +702,6 @@ static int sh_mobile_i2c_xfer(struct i2c_adapter *adapter,
 
 	/* Wake up device and enable clock */
 	pm_runtime_get_sync(pd->dev);
-	clk_prepare_enable(pd->clk);
 
 	/* Process all messages */
 	for (i = 0; i < num; i++) {
@@ -743,7 +742,6 @@ static int sh_mobile_i2c_xfer(struct i2c_adapter *adapter,
 	iic_wr(pd, ICCR, 0);
 
 	/* Disable clock and mark device as idle */
-	clk_disable_unprepare(pd->clk);
 	pm_runtime_put_sync(pd->dev);
 
 	return err ?: num;
-- 
2.11.0
