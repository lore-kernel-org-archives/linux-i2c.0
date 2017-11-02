From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH RFT 5/5] i2c: sh_mobile: shorten exit of xfer routine
Date: Thu,  2 Nov 2017 13:47:31 +0100
Message-ID: <20171102124731.10484-6-wsa+renesas@sang-engineering.com>
References: <20171102124731.10484-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:33866 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755224AbdKBMrn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 2 Nov 2017 08:47:43 -0400
In-Reply-To: <20171102124731.10484-1-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Jacopo Mondi <jacopo@jmondi.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>

We can use the ternary operator for easier reading.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 1701f193d94acf..39f0ee1cd78c74 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -746,9 +746,7 @@ static int sh_mobile_i2c_xfer(struct i2c_adapter *adapter,
 	clk_disable_unprepare(pd->clk);
 	pm_runtime_put_sync(pd->dev);
 
-	if (!err)
-		err = num;
-	return err;
+	return err ?: num;
 }
 
 static u32 sh_mobile_i2c_func(struct i2c_adapter *adapter)
-- 
2.11.0
