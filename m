From: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v6 3/3] I2C: mediatek: Add driver for MediaTek MT8173 I2C controller
Date: Wed, 1 Apr 2015 13:29:49 +0800
Message-ID: <1427866189-19262-4-git-send-email-eddie.huang@mediatek.com>
References: <1427866189-19262-1-git-send-email-eddie.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1427866189-19262-1-git-send-email-eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, David Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>, Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Jim Cromie <jim.cromie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>, Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Liguo Zhang <liguo.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Add mediatek MT8173 I2C controller driver. Compare to I2C controller
of earlier mediatek SoC, MT8173 fix write-then-read limitation, and
also increase message size to 64kb.

Signed-off-by: Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Liguo Zhang <liguo.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/i2c/busses/i2c-mt65xx.c | 104 +++++++++++++++++++++++++++++-----------
 1 file changed, 76 insertions(+), 28 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 2ecf0d1..80df0df 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -33,10 +33,13 @@
 #include <linux/clk.h>
 #include <linux/completion.h>
 
+#define I2C_RS_TRANSFER			(1 << 4)
 #define I2C_HS_NACKERR			(1 << 2)
 #define I2C_ACKERR			(1 << 1)
 #define I2C_TRANSAC_COMP		(1 << 0)
 #define I2C_TRANSAC_START		(1 << 0)
+#define I2C_RS_MUL_CNFG			(1 << 15)
+#define I2C_RS_MUL_TRIG			(1 << 14)
 #define I2C_TIMING_STEP_DIV_MASK	(0x3f << 0)
 #define I2C_TIMING_SAMPLE_COUNT_MASK	(0x7 << 0)
 #define I2C_TIMING_SAMPLE_DIV_MASK	(0x7 << 8)
@@ -67,6 +70,9 @@
 #define MAX_MSG_NUM_MT6577		1
 #define MAX_DMA_TRANS_SIZE_MT6577	255
 #define MAX_WRRD_TRANS_SIZE_MT6577	31
+#define MAX_MSG_NUM_MT8173		65535
+#define MAX_DMA_TRANS_SIZE_MT8173	65535
+#define MAX_WRRD_TRANS_SIZE_MT8173	65535
 #define MAX_SAMPLE_CNT_DIV		8
 #define MAX_STEP_CNT_DIV		64
 #define MAX_HS_STEP_CNT_DIV		8
@@ -139,6 +145,7 @@ struct mtk_i2c_compatible {
 	const struct i2c_adapter_quirks *quirks;
 	unsigned char pmic_i2c;
 	unsigned char dcm;
+	unsigned char auto_restart;
 };
 
 struct mtk_i2c {
@@ -172,21 +179,39 @@ static const struct i2c_adapter_quirks mt6577_i2c_quirks = {
 	.max_comb_2nd_msg_len = MAX_WRRD_TRANS_SIZE_MT6577,
 };
 
+static const struct i2c_adapter_quirks mt8173_i2c_quirks = {
+	.max_num_msgs = MAX_MSG_NUM_MT8173,
+	.max_write_len = MAX_DMA_TRANS_SIZE_MT8173,
+	.max_read_len = MAX_DMA_TRANS_SIZE_MT8173,
+	.max_comb_1st_msg_len = MAX_DMA_TRANS_SIZE_MT8173,
+	.max_comb_2nd_msg_len = MAX_WRRD_TRANS_SIZE_MT8173,
+};
+
 static const struct mtk_i2c_compatible mt6577_compat = {
 	.quirks = &mt6577_i2c_quirks,
 	.pmic_i2c = 0,
 	.dcm = 1,
+	.auto_restart = 0,
 };
 
 static const struct mtk_i2c_compatible mt6589_compat = {
 	.quirks = &mt6577_i2c_quirks,
 	.pmic_i2c = 1,
 	.dcm = 0,
+	.auto_restart = 0,
+};
+
+static const struct mtk_i2c_compatible mt8173_compat = {
+	.quirks = &mt8173_i2c_quirks,
+	.pmic_i2c = 0,
+	.dcm = 1,
+	.auto_restart = 1,
 };
 
 static const struct of_device_id mtk_i2c_of_match[] = {
 	{ .compatible = "mediatek,mt6577-i2c", .data = (void *)&mt6577_compat },
 	{ .compatible = "mediatek,mt6589-i2c", .data = (void *)&mt6589_compat },
+	{ .compatible = "mediatek,mt8173-i2c", .data = (void *)&mt8173_compat },
 	{}
 };
 MODULE_DEVICE_TABLE(of, mtk_i2c_match);
@@ -343,9 +368,11 @@ static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int clk_src_in_hz)
 	return 0;
 }
 
-static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs)
+static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
+					int num, int left_num)
 {
 	u16 addr_reg;
+	u16 start_reg;
 	u16 control_reg;
 	dma_addr_t rpaddr = 0;
 	dma_addr_t wpaddr = 0;
@@ -361,6 +388,8 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs)
 		control_reg |= I2C_CONTROL_RS;
 	if (i2c->op == I2C_MASTER_WRRD)
 		control_reg |= I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS;
+	if (left_num >= 1)
+		control_reg |= I2C_CONTROL_RS;
 	mtk_i2c_writew(control_reg, i2c, OFFSET_CONTROL);
 
 	/* set start condition */
@@ -375,13 +404,13 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs)
 	mtk_i2c_writew(addr_reg, i2c, OFFSET_SLAVE_ADDR);
 
 	/* Clear interrupt status */
-	mtk_i2c_writew(I2C_HS_NACKERR | I2C_ACKERR | I2C_TRANSAC_COMP,
-		i2c, OFFSET_INTR_STAT);
+	mtk_i2c_writew(I2C_RS_TRANSFER | I2C_HS_NACKERR | I2C_ACKERR
+			| I2C_TRANSAC_COMP, i2c, OFFSET_INTR_STAT);
 	mtk_i2c_writew(I2C_FIFO_ADDR_CLR, i2c, OFFSET_FIFO_ADDR_CLR);
 
 	/* Enable interrupt */
-	mtk_i2c_writew(I2C_HS_NACKERR | I2C_ACKERR | I2C_TRANSAC_COMP,
-		i2c, OFFSET_INTR_MASK);
+	mtk_i2c_writew(I2C_RS_TRANSFER | I2C_HS_NACKERR | I2C_ACKERR
+			| I2C_TRANSAC_COMP, i2c, OFFSET_INTR_MASK);
 
 	/* Set transfer and transaction len */
 	if (i2c->op == I2C_MASTER_WRRD) {
@@ -390,7 +419,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs)
 		mtk_i2c_writew(I2C_WRRD_TRANAC_VALUE, i2c, OFFSET_TRANSAC_LEN);
 	} else {
 		mtk_i2c_writew(msgs->len, i2c, OFFSET_TRANSFER_LEN);
-		mtk_i2c_writew(I2C_RD_TRANAC_VALUE, i2c, OFFSET_TRANSAC_LEN);
+		mtk_i2c_writew(num, i2c, OFFSET_TRANSAC_LEN);
 	}
 
 	/* Prepare buffer data to start transfer */
@@ -436,13 +465,23 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs)
 	/* flush before sending start */
 	mb();
 	mtk_i2c_writel_dma(I2C_DMA_START_EN, i2c, OFFSET_EN);
-	mtk_i2c_writew(I2C_TRANSAC_START, i2c, OFFSET_START);
+
+	if (!i2c->dev_comp->auto_restart) {
+		start_reg = I2C_TRANSAC_START;
+	} else {
+		if (left_num >= 1)
+			start_reg = I2C_TRANSAC_START | I2C_RS_MUL_CNFG
+					| I2C_RS_MUL_TRIG;
+		else
+			start_reg = I2C_TRANSAC_START | I2C_RS_MUL_TRIG;
+	}
+	mtk_i2c_writew(start_reg, i2c, OFFSET_START);
 
 	ret = wait_for_completion_timeout(&i2c->msg_complete,
 				i2c->adap.timeout);
 
 	/* Clear interrupt mask */
-	mtk_i2c_writew(~(I2C_HS_NACKERR | I2C_ACKERR
+	mtk_i2c_writew(~(I2C_RS_TRANSFER | I2C_HS_NACKERR | I2C_ACKERR
 			| I2C_TRANSAC_COMP), i2c, OFFSET_INTR_MASK);
 
 	if (i2c->op == I2C_MASTER_WR) {
@@ -472,6 +511,10 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs)
 		return -EREMOTEIO;
 	}
 
+	if (i2c->irq_stat & I2C_RS_TRANSFER)
+		dev_dbg(i2c->dev, "addr: %x, restart transfer interrupt.\n",
+				msgs->addr);
+
 	return 0;
 }
 
@@ -486,28 +529,33 @@ static int mtk_i2c_transfer(struct i2c_adapter *adap,
 	if (ret)
 		return ret;
 
-	if (msgs->buf == NULL) {
-		dev_dbg(i2c->dev, "data buffer is NULL.\n");
-		ret = -EINVAL;
-		goto err_exit;
-	}
-
-	if (msgs->flags & I2C_M_RD)
-		i2c->op = I2C_MASTER_RD;
-	else
-		i2c->op = I2C_MASTER_WR;
+	while (left_num--) {
+		if (msgs->buf == NULL) {
+			dev_dbg(i2c->dev, "data buffer is NULL.\n");
+			ret = -EINVAL;
+			goto err_exit;
+		}
 
-	if (num > 1) {
-		/* combined two messages into one transaction */
-		i2c->op = I2C_MASTER_WRRD;
-		left_num--;
-	}
+		if (msgs->flags & I2C_M_RD)
+			i2c->op = I2C_MASTER_RD;
+		else
+			i2c->op = I2C_MASTER_WR;
+
+		if (!i2c->dev_comp->auto_restart) {
+			if (num > 1) {
+				/* combined two messages into one transaction */
+				i2c->op = I2C_MASTER_WRRD;
+				left_num--;
+			}
+		}
 
-	/* always use DMA mode. */
-	ret = mtk_i2c_do_transfer(i2c, msgs);
-	if (ret < 0)
-		goto err_exit;
+		/* always use DMA mode. */
+		ret = mtk_i2c_do_transfer(i2c, msgs, num, left_num);
+		if (ret < 0)
+			goto err_exit;
 
+		msgs++;
+	}
 	/* the return value is number of executed messages */
 	ret = num;
 
@@ -521,7 +569,7 @@ static irqreturn_t mtk_i2c_irq(int irqno, void *dev_id)
 	struct mtk_i2c *i2c = dev_id;
 
 	i2c->irq_stat = mtk_i2c_readw(i2c, OFFSET_INTR_STAT);
-	mtk_i2c_writew(I2C_HS_NACKERR | I2C_ACKERR
+	mtk_i2c_writew(I2C_RS_TRANSFER | I2C_HS_NACKERR | I2C_ACKERR
 			| I2C_TRANSAC_COMP, i2c, OFFSET_INTR_STAT);
 
 	complete(&i2c->msg_complete);
-- 
1.8.1.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
