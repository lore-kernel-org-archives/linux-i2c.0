From: Qii Wang <qii.wang@mediatek.com>
Subject: [PATCH v5 4/5] i2c: mediatek: Add i2c and apdma sync in i2c driver
Date: Tue, 26 Feb 2019 21:10:59 +0800
Message-ID: <1551186660-16902-5-git-send-email-qii.wang@mediatek.com>
References: <1551186660-16902-1-git-send-email-qii.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551186660-16902-1-git-send-email-qii.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, leilk.liu@mediatek.com, qii.wang@mediatek.com, xinping.qian@mediatek.com, liguo.zhang@mediatek.com, robh@kernel.org
List-Id: linux-i2c@vger.kernel.org

When i2c and apdma use different source clocks, we should enable
synchronization between them.

Signed-off-by: Qii Wang <qii.wang@mediatek.com>
---
 drivers/i2c/busses/i2c-mt65xx.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 14d6b38..75d88e1 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -77,6 +77,8 @@
 #define I2C_CONTROL_DIR_CHANGE          (0x1 << 4)
 #define I2C_CONTROL_ACKERR_DET_EN       (0x1 << 5)
 #define I2C_CONTROL_TRANSFER_LEN_CHANGE (0x1 << 6)
+#define I2C_CONTROL_DMAACK_EN           (0x1 << 8)
+#define I2C_CONTROL_ASYNC_MODE          (0x1 << 9)
 #define I2C_CONTROL_WRAPPER             (0x1 << 0)
 
 #define I2C_DRV_NAME		"i2c-mt65xx"
@@ -169,6 +171,7 @@ struct mtk_i2c_compatible {
 	unsigned char aux_len_reg: 1;
 	unsigned char support_33bits: 1;
 	unsigned char timing_adjust: 1;
+	unsigned char dma_sync: 1;
 };
 
 struct mtk_i2c {
@@ -218,6 +221,7 @@ struct mtk_i2c {
 	.aux_len_reg = 1,
 	.support_33bits = 1,
 	.timing_adjust = 1,
+	.dma_sync = 0,
 };
 
 static const struct mtk_i2c_compatible mt6577_compat = {
@@ -229,6 +233,7 @@ struct mtk_i2c {
 	.aux_len_reg = 0,
 	.support_33bits = 0,
 	.timing_adjust = 0,
+	.dma_sync = 0,
 };
 
 static const struct mtk_i2c_compatible mt6589_compat = {
@@ -240,6 +245,7 @@ struct mtk_i2c {
 	.aux_len_reg = 0,
 	.support_33bits = 0,
 	.timing_adjust = 0,
+	.dma_sync = 0,
 };
 
 static const struct mtk_i2c_compatible mt7622_compat = {
@@ -251,6 +257,7 @@ struct mtk_i2c {
 	.aux_len_reg = 1,
 	.support_33bits = 0,
 	.timing_adjust = 0,
+	.dma_sync = 0,
 };
 
 static const struct mtk_i2c_compatible mt8173_compat = {
@@ -261,6 +268,7 @@ struct mtk_i2c {
 	.aux_len_reg = 1,
 	.support_33bits = 1,
 	.timing_adjust = 0,
+	.dma_sync = 0,
 };
 
 static const struct of_device_id mtk_i2c_of_match[] = {
@@ -360,6 +368,9 @@ static void mtk_i2c_init_hw(struct mtk_i2c *i2c)
 
 	control_reg = I2C_CONTROL_ACKERR_DET_EN |
 		      I2C_CONTROL_CLK_EXT_EN | I2C_CONTROL_DMA_EN;
+	if (i2c->dev_comp->dma_sync)
+		control_reg |= I2C_CONTROL_DMAACK_EN | I2C_CONTROL_ASYNC_MODE;
+
 	mtk_i2c_writew(i2c, control_reg, OFFSET_CONTROL);
 	mtk_i2c_writew(i2c, I2C_DELAY_LEN, OFFSET_DELAY_LEN);
 
-- 
1.7.9.5
