From: Biwen Li <biwen.li@oss.nxp.com>
Subject: [PATCH] i2c: slave: support I2C_SLAVE_STOP event for the read transactions
Date: Mon, 30 Mar 2020 18:50:38 +0800
Message-ID: <20200330105038.22546-1-biwen.li@oss.nxp.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from inva020.nxp.com ([92.121.34.13]:36550 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729214AbgC3KyS (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 30 Mar 2020 06:54:18 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: leoyang.li@nxp.com, linux@rempel-privat.de, kernel@pengutronix.de, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, jiafei.pan@nxp.com, Biwen Li <biwen.li@nxp.com>

From: Biwen Li <biwen.li@nxp.com>

Support I2C_SLAVE_STOP event for the read transactions(master read from slave)

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
 drivers/i2c/busses/i2c-imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 62517a41b32d..1fd0d87885d5 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1464,6 +1464,7 @@ static irqreturn_t i2c_imx_slave_isr(struct imx_i2c_struct *i2c_imx)
 		ctl &= ~I2CR_MTX;
 		imx_i2c_write_reg(ctl, i2c_imx, IMX_I2C_I2CR);
 		imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
+		i2c_slave_event(i2c_imx->slave, I2C_SLAVE_STOP, &value);
 	}
 	return IRQ_HANDLED;
 }
-- 
2.17.1
