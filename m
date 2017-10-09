From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH] i2c: imx: fix misleading bus recovery debug message
Date: Mon,  9 Oct 2017 21:26:14 +0200
Message-ID: <20171009192614.31226-1-clemens.gruber@pqgruber.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.pqgruber.com ([178.189.19.235]:15737 "EHLO
        mail.pqgruber.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754353AbdJITfi (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 9 Oct 2017 15:35:38 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, Clemens Gruber <clemens.gruber@pqgruber.com>

The arguments for SDA and SCL were swapped. Fix it.

Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
 drivers/i2c/busses/i2c-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 54a47b40546f..71a90ed4d01d 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1021,7 +1021,7 @@ static int i2c_imx_init_recovery_info(struct imx_i2c_struct *i2c_imx,
 	}
 
 	dev_dbg(&pdev->dev, "using scl-gpio %d and sda-gpio %d for recovery\n",
-			rinfo->sda_gpio, rinfo->scl_gpio);
+			rinfo->scl_gpio, rinfo->sda_gpio);
 
 	rinfo->prepare_recovery = i2c_imx_prepare_recovery;
 	rinfo->unprepare_recovery = i2c_imx_unprepare_recovery;
-- 
2.14.2
