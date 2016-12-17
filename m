From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH] i2c: mux: pca954x: fix i2c mux selection caching
Date: Sat, 17 Dec 2016 12:10:56 +0000
Message-ID: <E1cIDpI-0005y4-SW@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:42660 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752619AbcLQMLC (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 17 Dec 2016 07:11:02 -0500
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org

smbus functions return -ve on error, 0 on success.  However,
__i2c_transfer() have a different return signature - -ve on error, or
number of buffers transferred (which may be zero or greater.)

The upshot of this is that the sense of the test is reversed when using
the mux on a bus supporting the master_xfer method: we cache the value
and never retry if we fail to transfer any buffers, but if we succeed,
we clear the cached value.

Fix this by making pca954x_reg_write() return a negative error code for
all failure cases.

Fixes: 463e8f845cbf ("i2c: mux: pca954x: retry updating the mux selection on failure")
Acked-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 8bc3d36d2837..9c4ac26c014e 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -151,6 +151,9 @@ static int pca954x_reg_write(struct i2c_adapter *adap,
 		buf[0] = val;
 		msg.buf = buf;
 		ret = __i2c_transfer(adap, &msg, 1);
+
+		if (ret >= 0 && ret != 1)
+			ret = -EREMOTEIO;
 	} else {
 		union i2c_smbus_data data;
 		ret = adap->algo->smbus_xfer(adap, client->addr,
@@ -179,7 +182,7 @@ static int pca954x_select_chan(struct i2c_mux_core *muxc, u32 chan)
 	/* Only select the channel if its different from the last channel */
 	if (data->last_chan != regval) {
 		ret = pca954x_reg_write(muxc->parent, client, regval);
-		data->last_chan = ret ? 0 : regval;
+		data->last_chan = ret < 0 ? 0 : regval;
 	}
 
 	return ret;
-- 
2.7.4
