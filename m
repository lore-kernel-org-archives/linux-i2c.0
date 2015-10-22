From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] i2c: i2c-imx: Use -ENXIO as error in the NACK case
Date: Thu, 22 Oct 2015 14:41:20 -0200
Message-ID: <1445532080-30724-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-by2on0136.outbound.protection.outlook.com ([207.46.100.136]:55552
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752982AbbJVQ5F (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 22 Oct 2015 12:57:05 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

According to Documentation/i2c/fault-codes the response to a bus NACK
should be -ENXIO, so fix the error code.

This change is similar to commit 6ff4b1051632 ("i2c: rcar: fix NACK
error code").

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/i2c/busses/i2c-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 785aa67..329cf13 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -461,7 +461,7 @@ static int i2c_imx_acked(struct imx_i2c_struct *i2c_imx)
 {
 	if (imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR) & I2SR_RXAK) {
 		dev_dbg(&i2c_imx->adapter.dev, "<%s> No ACK\n", __func__);
-		return -EIO;  /* No ACK */
+		return -ENXIO;  /* No ACK */
 	}
 
 	dev_dbg(&i2c_imx->adapter.dev, "<%s> ACK received\n", __func__);
-- 
1.9.1
