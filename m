From: Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH v2] i2c: imx: Add arbitration lost check
Date: Wed, 3 Sep 2014 13:52:07 +0800
Message-ID: <1409723527-30603-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

According to the i.mx spec, for multimaster mode, if I2C is
enabled when the bus is busy and asserts start, hardware inhibits
the transmission, clears MSTA without signaling a stop, generate
an interrupt, and set I2C_I2SR[IAL] to indicate a failed attempt
to engage the bus, which means arbitration lost. In this case,
we should first test I2C_I2SR[IAL], and clear this bit if it is
set, and then I2C controller default to slave receive mode.

This patch check the IAL bit every time before an I2c transmission.
if IAL is set, clear it and make I2C controller to default mode.

Signed-off-by: Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Acked-by: Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
Changes for V2:
-Use 'EAGAIN' instead of 'EIO' for arbitration lost
-Modify the comment style

 drivers/i2c/busses/i2c-imx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 613069b..ceff87c 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -268,6 +268,14 @@ static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int for_busy)
 
 	while (1) {
 		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
+
+		/* check for arbitration lost */
+		if (temp & I2SR_IAL) {
+			temp &= ~I2SR_IAL;
+			imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2SR);
+			return -EAGAIN;
+		}
+
 		if (for_busy && (temp & I2SR_IBB))
 			break;
 		if (!for_busy && !(temp & I2SR_IBB))
-- 
1.9.1
