From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Subject: [PATCH] i2c: i2c-mux-pca954x: only reset last channel on error
Date: Fri, 16 Dec 2016 16:08:43 -0500
Message-ID: <20161216210843.26853-1-vivien.didelot@savoirfairelinux.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:52198 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758293AbcLPVJc (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 16 Dec 2016 16:09:32 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com, Vivien Didelot <vivien.didelot@savoirfairelinux.com>

The current code is selecting the mux channel before each operation and
does not benefit from the cached value (data->last_chan).

That is because pca954x_select_chan() considers any non-zero values from
pca954x_reg_write() as an error. But this function (via __i2c_transfer)
returns either a negative error code or the positive number of messages
executed.

Only check "ret" against negative values to restore the caching.

Fixes: 463e8f845cbf ("i2c: mux: pca954x: retry updating the mux selection on failure")
Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 8bc3d36..0469f1e 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -179,7 +179,7 @@ static int pca954x_select_chan(struct i2c_mux_core *muxc, u32 chan)
 	/* Only select the channel if its different from the last channel */
 	if (data->last_chan != regval) {
 		ret = pca954x_reg_write(muxc->parent, client, regval);
-		data->last_chan = ret ? 0 : regval;
+		data->last_chan = ret < 0 ? 0 : regval;
 	}
 
 	return ret;
-- 
2.10.2
