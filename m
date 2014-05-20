From: Fugang Duan <b38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH] i2c: imx: update i2c clock divider for each transaction
Date: Tue, 20 May 2014 10:21:45 +0800
Message-ID: <1400552505-22954-1-git-send-email-b38611@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, b38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org, B20596-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Since IMX serial SOCs support low bus freq mode, some clocks freq
may change to save power. I2C needs to check the clock source and
update the divider.

For example:
i.MX6SL I2C clk is from IPG_PERCLK which is sourced from IPG_CLK.
Under normal operation, IPG_CLK is 66MHz, ipg_perclk is at 22MHz.
In low bus freq mode, IPG_CLK is at 12MHz and IPG_PERCLK is down
to 4MHz. So the I2C driver must update the divider register for
each transaction when the current IPG_PERCLK is not equal to the
clock of previous transaction.

Signed-off-by: Fugang Duan  <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/i2c/busses/i2c-imx.c |   94 ++++++++++++++++++++++-------------------
 1 files changed, 50 insertions(+), 44 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 6c2ac05..2fdff4d 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -183,6 +183,8 @@ struct imx_i2c_struct {
 	unsigned int 		disable_delay;
 	int			stopped;
 	unsigned int		ifdr; /* IMX_I2C_IFDR */
+	unsigned int		cur_clk;
+	unsigned int		bitrate;
 	const struct imx_i2c_hwdata	*hwdata;
 };
 
@@ -305,6 +307,49 @@ static int i2c_imx_acked(struct imx_i2c_struct *i2c_imx)
 	return 0;
 }
 
+static void i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx)
+{
+	struct imx_i2c_clk_pair *i2c_clk_div = i2c_imx->hwdata->clk_div;
+	unsigned int i2c_clk_rate;
+	unsigned int div;
+	int i;
+
+	/* Divider value calculation */
+	i2c_clk_rate = clk_get_rate(i2c_imx->clk);
+	if (i2c_imx->cur_clk == i2c_clk_rate)
+		return;
+	else
+		i2c_imx->cur_clk = i2c_clk_rate;
+
+	div = (i2c_clk_rate + i2c_imx->bitrate - 1) / i2c_imx->bitrate;
+	if (div < i2c_clk_div[0].div)
+		i = 0;
+	else if (div > i2c_clk_div[i2c_imx->hwdata->ndivs - 1].div)
+		i = i2c_imx->hwdata->ndivs - 1;
+	else
+		for (i = 0; i2c_clk_div[i].div < div; i++);
+
+	/* Store divider value */
+	i2c_imx->ifdr = i2c_clk_div[i].val;
+
+	/*
+	 * There dummy delay is calculated.
+	 * It should be about one I2C clock period long.
+	 * This delay is used in I2C bus disable function
+	 * to fix chip hardware bug.
+	 */
+	i2c_imx->disable_delay = (500000U * i2c_clk_div[i].div
+		+ (i2c_clk_rate / 2) - 1) / (i2c_clk_rate / 2);
+
+	/* dev_dbg() can't be used, because adapter is not yet registered */
+#ifdef CONFIG_I2C_DEBUG_BUS
+	dev_dbg(&i2c_imx->adapter.dev, "<%s> I2C_CLK=%d, REQ DIV=%d\n",
+		__func__, i2c_clk_rate, div);
+	dev_dbg(&i2c_imx->adapter.dev, "<%s> IFDR[IC]=0x%x, REAL DIV=%d\n",
+		__func__, i2c_clk_div[i].val, i2c_clk_div[i].div);
+#endif
+}
+
 static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
 {
 	unsigned int temp = 0;
@@ -312,6 +357,8 @@ static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
 
 	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
 
+	i2c_imx_set_clk(i2c_imx);
+
 	result = clk_prepare_enable(i2c_imx->clk);
 	if (result)
 		return result;
@@ -367,45 +414,6 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
 	clk_disable_unprepare(i2c_imx->clk);
 }
 
-static void i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
-							unsigned int rate)
-{
-	struct imx_i2c_clk_pair *i2c_clk_div = i2c_imx->hwdata->clk_div;
-	unsigned int i2c_clk_rate;
-	unsigned int div;
-	int i;
-
-	/* Divider value calculation */
-	i2c_clk_rate = clk_get_rate(i2c_imx->clk);
-	div = (i2c_clk_rate + rate - 1) / rate;
-	if (div < i2c_clk_div[0].div)
-		i = 0;
-	else if (div > i2c_clk_div[i2c_imx->hwdata->ndivs - 1].div)
-		i = i2c_imx->hwdata->ndivs - 1;
-	else
-		for (i = 0; i2c_clk_div[i].div < div; i++);
-
-	/* Store divider value */
-	i2c_imx->ifdr = i2c_clk_div[i].val;
-
-	/*
-	 * There dummy delay is calculated.
-	 * It should be about one I2C clock period long.
-	 * This delay is used in I2C bus disable function
-	 * to fix chip hardware bug.
-	 */
-	i2c_imx->disable_delay = (500000U * i2c_clk_div[i].div
-		+ (i2c_clk_rate / 2) - 1) / (i2c_clk_rate / 2);
-
-	/* dev_dbg() can't be used, because adapter is not yet registered */
-#ifdef CONFIG_I2C_DEBUG_BUS
-	dev_dbg(&i2c_imx->adapter.dev, "<%s> I2C_CLK=%d, REQ DIV=%d\n",
-		__func__, i2c_clk_rate, div);
-	dev_dbg(&i2c_imx->adapter.dev, "<%s> IFDR[IC]=0x%x, REAL DIV=%d\n",
-		__func__, i2c_clk_div[i].val, i2c_clk_div[i].div);
-#endif
-}
-
 static irqreturn_t i2c_imx_isr(int irq, void *dev_id)
 {
 	struct imx_i2c_struct *i2c_imx = dev_id;
@@ -619,7 +627,6 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	struct imxi2c_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	void __iomem *base;
 	int irq, ret;
-	u32 bitrate;
 
 	dev_dbg(&pdev->dev, "<%s>\n", __func__);
 
@@ -683,12 +690,11 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	i2c_set_adapdata(&i2c_imx->adapter, i2c_imx);
 
 	/* Set up clock divider */
-	bitrate = IMX_I2C_BIT_RATE;
+	i2c_imx->bitrate = IMX_I2C_BIT_RATE;
 	ret = of_property_read_u32(pdev->dev.of_node,
-				   "clock-frequency", &bitrate);
+				   "clock-frequency", &i2c_imx->bitrate);
 	if (ret < 0 && pdata && pdata->bitrate)
-		bitrate = pdata->bitrate;
-	i2c_imx_set_clk(i2c_imx, bitrate);
+		i2c_imx->bitrate = pdata->bitrate;
 
 	/* Set up chip registers to defaults */
 	imx_i2c_write_reg(i2c_imx->hwdata->i2cr_ien_opcode ^ I2CR_IEN,
-- 
1.7.8
