From: Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH] i2c: imx: fix the i2c bus hang issue when do repeat restart
Date: Wed, 30 Apr 2014 14:24:58 +0800
Message-ID: <1398839098-6907-1-git-send-email-B38611@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: b38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org, b20596-KZfg59tc24xl57MIdRCFDg@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Test i2c device Maxim max44009, datasheet is located at:
http://www.maximintegrated.com/datasheet/index.mvp/id/7175

The max44009 support repeat operation like:
read -> repeat restart -> read/write

The current i2c imx host controller driver don't support this
operation that causes i2c bus hang due to "MTX" is cleared in
.i2c_imx_read(). If "read" is the last message there have no problem,
so the current driver supports all SMbus operation like:
write -> repeat restart -> read/write

IMX i2c controller for master receiver has some limitation:
- If it is the last byte for one operation, it must generate STOP
  signal before read I2DR to prevent controller from generating another
  clock cycle.
- If it is the last byte in the read, and then do repeat restart, it must
  set "MTX" before read I2DR to prevent controller from generating another
  extra clock cycle.

The patch is to fix the issue.

Signed-off-by: Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/i2c/busses/i2c-imx.c |   41 ++++++++++++++++++++++++++++++-----------
 1 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index db895fb..6c2ac05 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -458,7 +458,7 @@ static int i2c_imx_write(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs)
 	return 0;
 }
 
-static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs)
+static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs, bool is_lastmsg)
 {
 	int i, result;
 	unsigned int temp;
@@ -494,15 +494,30 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs)
 		if (result)
 			return result;
 		if (i == (msgs->len - 1)) {
-			/* It must generate STOP before read I2DR to prevent
-			   controller from generating another clock cycle */
-			dev_dbg(&i2c_imx->adapter.dev,
-				"<%s> clear MSTA\n", __func__);
-			temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
-			temp &= ~(I2CR_MSTA | I2CR_MTX);
-			imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
-			i2c_imx_bus_busy(i2c_imx, 0);
-			i2c_imx->stopped = 1;
+			if (is_lastmsg) {
+				/*
+				 * It must generate STOP before read I2DR to prevent
+				 * controller from generating another clock cycle
+				 */
+				dev_dbg(&i2c_imx->adapter.dev,
+					"<%s> clear MSTA\n", __func__);
+				temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
+				temp &= ~(I2CR_MSTA | I2CR_MTX);
+				imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
+				i2c_imx_bus_busy(i2c_imx, 0);
+				i2c_imx->stopped = 1;
+			} else {
+				/*
+				 * For i2c master receiver repeat restart operation like:
+				 * read -> repeat MSTA -> read/write
+				 * The controller must set MTX before read the last byte in
+				 * the first read operation, otherwise the first read cost
+				 * one extra clock cycle.
+				 */
+				temp = readb(i2c_imx->base + IMX_I2C_I2CR);
+				temp |= I2CR_MTX;
+				writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
+			}
 		} else if (i == (msgs->len - 2)) {
 			dev_dbg(&i2c_imx->adapter.dev,
 				"<%s> set TXAK\n", __func__);
@@ -523,6 +538,7 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
 {
 	unsigned int i, temp;
 	int result;
+	bool is_lastmsg = false;
 	struct imx_i2c_struct *i2c_imx = i2c_get_adapdata(adapter);
 
 	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
@@ -534,6 +550,9 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
 
 	/* read/write data */
 	for (i = 0; i < num; i++) {
+		if (i == num - 1)
+			is_lastmsg = true;
+
 		if (i) {
 			dev_dbg(&i2c_imx->adapter.dev,
 				"<%s> repeated start\n", __func__);
@@ -564,7 +583,7 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
 			(temp & I2SR_RXAK ? 1 : 0));
 #endif
 		if (msgs[i].flags & I2C_M_RD)
-			result = i2c_imx_read(i2c_imx, &msgs[i]);
+			result = i2c_imx_read(i2c_imx, &msgs[i], is_lastmsg);
 		else
 			result = i2c_imx_write(i2c_imx, &msgs[i]);
 		if (result)
-- 
1.7.2.rc3
