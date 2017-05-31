From: Michael Thalmeier <michael.thalmeier@hale.at>
Subject: [PATCH] i2c: mxs: change error printing to debug for mxs_i2c_pio_wait_xfer_end
Date: Wed, 31 May 2017 11:40:03 +0200
Message-ID: <20170531094003.21997-1-michael.thalmeier@hale.at>
References: <20170519124402.4xkaguxjzgyvbwcl@ninjato>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gw.hale.at ([89.26.116.210]:34064 "EHLO gw.hale.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751063AbdEaJl2 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 31 May 2017 05:41:28 -0400
In-Reply-To: <20170519124402.4xkaguxjzgyvbwcl@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>

Instead of printing errors after mxs_i2c_pio_wait_xfer_end returns with
an error code just print a debug message.

NAKs and timeouts can occur in this situation normally, so do not treat
them as errors.

Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>
---
 drivers/i2c/busses/i2c-mxs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 5738556..d4e8f19 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -419,7 +419,7 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
 
 		ret = mxs_i2c_pio_wait_xfer_end(i2c);
 		if (ret) {
-			dev_err(i2c->dev,
+			dev_dbg(i2c->dev,
 				"PIO: Failed to send SELECT command!\n");
 			goto cleanup;
 		}
@@ -431,7 +431,7 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
 
 		ret = mxs_i2c_pio_wait_xfer_end(i2c);
 		if (ret) {
-			dev_err(i2c->dev,
+			dev_dbg(i2c->dev,
 				"PIO: Failed to send READ command!\n");
 			goto cleanup;
 		}
@@ -528,7 +528,7 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
 			/* Wait for the end of the transfer. */
 			ret = mxs_i2c_pio_wait_xfer_end(i2c);
 			if (ret) {
-				dev_err(i2c->dev,
+				dev_dbg(i2c->dev,
 					"PIO: Failed to finish WRITE cmd!\n");
 				break;
 			}
-- 
2.9.2
