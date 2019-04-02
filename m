From: Qii Wang <qii.wang@mediatek.com>
Subject: [PATCH RESEND v6 3/6] i2c: mediatek: Add arb clock in i2c driver
Date: Tue, 2 Apr 2019 20:35:57 +0800
Message-ID: <1554208560-14817-4-git-send-email-qii.wang@mediatek.com>
References: <1554208560-14817-1-git-send-email-qii.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554208560-14817-1-git-send-email-qii.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, leilk.liu@mediatek.com, qii.wang@mediatek.com, xinping.qian@mediatek.com, liguo.zhang@mediatek.com, robh@kernel.org
List-Id: linux-i2c@vger.kernel.org

When two i2c controllers are internally connected to the same
GPIO pins, the arb clock is needed to ensure that the waveforms
do not interfere with each other. And we also need to enable
the interrupt to find arb lost, old i2c controllers also have
the bit.

Signed-off-by: Qii Wang <qii.wang@mediatek.com>
Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>
---
 drivers/i2c/busses/i2c-mt65xx.c |   25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index be36018..1a7235e 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -35,6 +35,7 @@
 #include <linux/slab.h>
 
 #define I2C_RS_TRANSFER			(1 << 4)
+#define I2C_ARB_LOST			(1 << 3)
 #define I2C_HS_NACKERR			(1 << 2)
 #define I2C_ACKERR			(1 << 1)
 #define I2C_TRANSAC_COMP		(1 << 0)
@@ -181,6 +182,7 @@ struct mtk_i2c {
 	struct clk *clk_main;		/* main clock for i2c bus */
 	struct clk *clk_dma;		/* DMA clock for i2c via DMA */
 	struct clk *clk_pmic;		/* PMIC clock for i2c from PMIC */
+	struct clk *clk_arb;		/* Arbitrator clock for i2c */
 	bool have_pmic;			/* can use i2c pins from PMIC */
 	bool use_push_pull;		/* IO config push-pull mode */
 
@@ -299,8 +301,18 @@ static int mtk_i2c_clock_enable(struct mtk_i2c *i2c)
 		if (ret)
 			goto err_pmic;
 	}
+
+	if (i2c->clk_arb) {
+		ret = clk_prepare_enable(i2c->clk_arb);
+		if (ret)
+			goto err_arb;
+	}
+
 	return 0;
 
+err_arb:
+	if (i2c->have_pmic)
+		clk_disable_unprepare(i2c->clk_pmic);
 err_pmic:
 	clk_disable_unprepare(i2c->clk_main);
 err_main:
@@ -311,6 +323,9 @@ static int mtk_i2c_clock_enable(struct mtk_i2c *i2c)
 
 static void mtk_i2c_clock_disable(struct mtk_i2c *i2c)
 {
+	if (i2c->clk_arb)
+		clk_disable_unprepare(i2c->clk_arb);
+
 	if (i2c->have_pmic)
 		clk_disable_unprepare(i2c->clk_pmic);
 
@@ -519,13 +534,13 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 
 	/* Clear interrupt status */
 	mtk_i2c_writew(i2c, restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
-	       I2C_TRANSAC_COMP, OFFSET_INTR_STAT);
+			    I2C_ARB_LOST | I2C_TRANSAC_COMP, OFFSET_INTR_STAT);
 
 	mtk_i2c_writew(i2c, I2C_FIFO_ADDR_CLR, OFFSET_FIFO_ADDR_CLR);
 
 	/* Enable interrupt */
 	mtk_i2c_writew(i2c, restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
-	       I2C_TRANSAC_COMP, OFFSET_INTR_MASK);
+			    I2C_ARB_LOST | I2C_TRANSAC_COMP, OFFSET_INTR_MASK);
 
 	/* Set transfer and transaction len */
 	if (i2c->op == I2C_MASTER_WRRD) {
@@ -659,7 +674,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 
 	/* Clear interrupt mask */
 	mtk_i2c_writew(i2c, ~(restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
-	       I2C_TRANSAC_COMP), OFFSET_INTR_MASK);
+			    I2C_ARB_LOST | I2C_TRANSAC_COMP), OFFSET_INTR_MASK);
 
 	if (i2c->op == I2C_MASTER_WR) {
 		dma_unmap_single(i2c->dev, wpaddr,
@@ -884,6 +899,10 @@ static int mtk_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(i2c->clk_dma);
 	}
 
+	i2c->clk_arb = devm_clk_get(&pdev->dev, "arb");
+	if (IS_ERR(i2c->clk_arb))
+		i2c->clk_arb = NULL;
+
 	clk = i2c->clk_main;
 	if (i2c->have_pmic) {
 		i2c->clk_pmic = devm_clk_get(&pdev->dev, "pmic");
-- 
1.7.9.5
