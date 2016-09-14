From: Peter Rosin <peda@axentia.se>
Subject: [PATCH] i2c: i2c-mux-pca954x: retry updating the mux selection on failure
Date: Wed, 14 Sep 2016 15:24:12 +0200
Message-ID: <1473859452-8069-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-he1eur01on0101.outbound.protection.outlook.com ([104.47.0.101]:43952
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757910AbcINNY3 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 14 Sep 2016 09:24:29 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "open list:I2C MUXES" <linux-i2c@vger.kernel.org>
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, open list <linux-kernel@vger.kernel.org>

The cached value of the last selected channel prevents retries on the
next call, even on failure to update the selected channel. Fix that.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 528e755c468f..3278ebf1cc5c 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -164,7 +164,7 @@ static int pca954x_select_chan(struct i2c_mux_core *muxc, u32 chan)
 	/* Only select the channel if its different from the last channel */
 	if (data->last_chan != regval) {
 		ret = pca954x_reg_write(muxc->parent, client, regval);
-		data->last_chan = regval;
+		data->last_chan = ret ? 0 : regval;
 	}
 
 	return ret;
-- 
2.1.4
