From: <ying.zhang22455@nxp.com>
Subject: [PATCH 2/2] drivers/i2c/i2c-imx.c: improve i2c bus error recovery
Date: Wed, 27 Jan 2016 16:44:43 +0800
Message-ID: <1453884283-33414-2-git-send-email-ying.zhang22455@nxp.com>
References: <1453884283-33414-1-git-send-email-ying.zhang22455@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-by2on0058.outbound.protection.outlook.com ([207.46.100.58]:42496
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754186AbcA0IxE (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 27 Jan 2016 03:53:04 -0500
In-Reply-To: <1453884283-33414-1-git-send-email-ying.zhang22455@nxp.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: xiaobo.xie@nxp.com, york.sun@nxp.com, Ying Zhang <b40530@freescale.com>

From: Ying Zhang <b40530@freescale.com>

When a system reset does not cause all I2C devices to be reset, slave can
hold bus low to cause bus hang.
It is necessary to force the I2C module to become the I2C bus master out
of reset and drive SCL.

The patch fixup the bus if a hang has been detected.

Signed-off-by: Ying Zhang <b40530@freescale.com>
---
 drivers/i2c/busses/i2c-imx.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index f1fe599..0e0db81 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -411,6 +411,32 @@ static void i2c_imx_dma_free(struct imx_i2c_struct *i2c_imx)
 	dma->chan_using = NULL;
 }
 
+/*
+ * When a system reset does not cause all I2C devices to be reset, it is
+ * sometimes necessary to force the I2C module to become the I2C bus master
+ * out of reset and drive SCL A slave can hold bus low to cause bus hang.
+ * Thus, SDA can be driven low by another I2C device while this I2C module
+ * is coming out of reset and will stay low indefinitely.
+ * The I2C master has to generate 9 clock pulses to get the bus free or idle.
+ */
+static void imx_i2c_fixup(struct imx_i2c_struct *i2c)
+{
+	int k;
+	u32 delay_val = 1000000 / i2c->real_clk + 1;
+
+	if (delay_val < 2)
+		delay_val = 2;
+
+	for (k = 9; k; k--) {
+		imx_i2c_write_reg(0, i2c_imx, IMX_I2C_I2CR);
+		imx_i2c_write_reg(I2CR_MSTA | I2CR_MTX | I2CR_IEN,
+				  i2c_imx, IMX_I2C_I2CR);
+		imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
+		imx_i2c_write_reg(I2CR_IEN, i2c_imx, IMX_I2C_I2CR);
+		udelay(delay_val << 1);
+	}
+}
+
 static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int for_busy)
 {
 	unsigned long orig_jiffies = jiffies;
@@ -433,8 +459,15 @@ static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int for_busy)
 		if (!for_busy && !(temp & I2SR_IBB))
 			break;
 		if (time_after(jiffies, orig_jiffies + msecs_to_jiffies(500))) {
+			u8 status = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
+
 			dev_dbg(&i2c_imx->adapter.dev,
 				"<%s> I2C bus is busy\n", __func__);
+			if ((status & (I2SR_ICF | I2SR_IBB | I2CR_TXAK)) != 0) {
+				imx_i2c_write_reg(status & ~I2SR_IAL, i2c_imx,
+						  IMX_I2C_I2CR);
+				imx_i2c_fixup();
+			}
 			return -ETIMEDOUT;
 		}
 		schedule();
-- 
2.1.0.27.g96db324
