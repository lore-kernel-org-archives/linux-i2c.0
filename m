From: <ying.zhang22455@nxp.com>
Subject: [PATCH] The input clock of I2C should be platform/2
Date: Wed, 27 Jan 2016 15:48:13 +0800
Message-ID: <1453880893-3015-1-git-send-email-ying.zhang22455@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-by2on0073.outbound.protection.outlook.com ([207.46.100.73]:35376
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752262AbcA0ILJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 27 Jan 2016 03:11:09 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: xiaobo.xie@nxp.com, york.sun@nxp.com, b45385@freescale.com, Ying Zhang <b40530@freescale.com>

From: Ying Zhang <b40530@freescale.com>

Signed-off-by: Ying Zhang <b40530@freescale.com>
---
 drivers/i2c/busses/i2c-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index a2b132c..806cb99 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -475,7 +475,7 @@ static void i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx)
 	int i;
 
 	/* Divider value calculation */
-	i2c_clk_rate = clk_get_rate(i2c_imx->clk);
+	i2c_clk_rate = clk_get_rate(i2c_imx->clk) / 2;
 	if (i2c_imx->cur_clk == i2c_clk_rate)
 		return;
 
-- 
2.1.0.27.g96db324
