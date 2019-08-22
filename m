From: Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH RESEND] i2c: mediatek: disable zero-length transfers for mt8183
Date: Thu, 22 Aug 2019 13:57:37 +0800
Message-ID: <20190822055737.142384-1-hsinyi@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Qii Wang <qii.wang@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>, Jun Gao <jun.gao@mediatek.com>, Thomas Gleixner <tglx@linutronix.de>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandru M Stan <amstan@chromium.org>
List-Id: linux-i2c@vger.kernel.org

When doing i2cdetect quick write mode, we would get transfer
error ENOMEM, and i2cdetect shows there's no device at the address.
Quoting from mt8183 datasheet, the number of transfers to be
transferred in one transaction should be set to bigger than 1,
so we should forbid zero-length transfer and update functionality.

Incorrect return:
localhost ~ # i2cdetect -q -y 0
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

After this patch:
localhost ~ #  i2cdetect -q -y 0
Error: Can't use SMBus Quick Write command on this bus

localhost ~ #  i2cdetect -y 0
Warning: Can't use SMBus Quick Write command, will skip some addresses
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:
10:
20:
30: -- -- -- -- -- -- -- --
40:
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60:
70:

Reported-by: Alexandru M Stan <amstan@chromium.org>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
Previous patch and discussion:
http://patchwork.ozlabs.org/patch/1042684/
---
 drivers/i2c/busses/i2c-mt65xx.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 252edb433fdf..2842ca4b8c3b 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -234,6 +234,10 @@ static const struct i2c_adapter_quirks mt7622_i2c_quirks = {
 	.max_num_msgs = 255,
 };
 
+static const struct i2c_adapter_quirks mt8183_i2c_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN,
+};
+
 static const struct mtk_i2c_compatible mt2712_compat = {
 	.regs = mt_i2c_regs_v1,
 	.pmic_i2c = 0,
@@ -298,6 +302,7 @@ static const struct mtk_i2c_compatible mt8173_compat = {
 };
 
 static const struct mtk_i2c_compatible mt8183_compat = {
+	.quirks = &mt8183_i2c_quirks,
 	.regs = mt_i2c_regs_v2,
 	.pmic_i2c = 0,
 	.dcm = 0,
@@ -870,7 +875,11 @@ static irqreturn_t mtk_i2c_irq(int irqno, void *dev_id)
 
 static u32 mtk_i2c_functionality(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+	if (adap->quirks->flags & I2C_AQ_NO_ZERO_LEN)
+		return I2C_FUNC_I2C |
+			(I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
+	else
+		return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
 
 static const struct i2c_algorithm mtk_i2c_algorithm = {
@@ -933,8 +942,8 @@ static int mtk_i2c_probe(struct platform_device *pdev)
 	i2c->dev = &pdev->dev;
 	i2c->adap.dev.parent = &pdev->dev;
 	i2c->adap.owner = THIS_MODULE;
-	i2c->adap.algo = &mtk_i2c_algorithm;
 	i2c->adap.quirks = i2c->dev_comp->quirks;
+	i2c->adap.algo = &mtk_i2c_algorithm;
 	i2c->adap.timeout = 2 * HZ;
 	i2c->adap.retries = 1;
 
-- 
2.20.1
