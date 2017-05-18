From: Michael Thalmeier <michael.thalmeier@hale.at>
Subject: [PATCH] i2c: mxs: dont print error on NAK
Date: Thu, 18 May 2017 16:14:50 +0200
Message-ID: <20170518141450.30938-1-michael.thalmeier@hale.at>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gw.hale.at ([89.26.116.210]:45732 "EHLO gw.hale.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755323AbdEROXm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 18 May 2017 10:23:42 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>, michael@thalmeier.at

When mxs_i2c_pio_wait_xfer_end returns with a return code of -ENXIO, the
NO_SLAVE_ACK_IRQ bit is set in CTRL1.
In this case, do not print an error message, because every NAK would
otherwise generate a new message.

Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>
---
 drivers/i2c/busses/i2c-mxs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 5738556..e2dbb9c 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -527,7 +527,7 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
 
 			/* Wait for the end of the transfer. */
 			ret = mxs_i2c_pio_wait_xfer_end(i2c);
-			if (ret) {
+			if (ret && ret != -ENXIO) {
 				dev_err(i2c->dev,
 					"PIO: Failed to finish WRITE cmd!\n");
 				break;
-- 
2.9.2
