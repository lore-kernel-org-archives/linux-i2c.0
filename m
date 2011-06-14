From: Eric Miao <eric.miao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] i2c: imx: choose the better clock divider
Date: Tue, 14 Jun 2011 15:17:05 +0800
Message-ID: <1308035825-22410-1-git-send-email-eric.miao@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eric Miao <eric.miao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Richard Zhao <richard.zhao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The original algorithm doesn't perform very well in some cases, e.g.

  When the source clock of the I2C controller is 66MHz, and the
  requested rate is 100KHz, it gives a divider of 768 instead of
  the better 640.

Choose a better clock divider so the final clock rate is closer to
the requested one by comparing the rate distances calculated by
two adjacent dividers.

Cc: Richard Zhao <richard.zhao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Eric Miao <eric.miao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-imx.c |   46 ++++++++++++++++++++++++++++-------------
 1 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 4c2a62b..cd640ff 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -112,6 +112,8 @@ static u16 __initdata i2c_clk_div[50][2] = {
 	{ 3072,	0x1E }, { 3840,	0x1F }
 };
 
+#define I2C_CLK_DIV_NUM		ARRAY_SIZE(i2c_clk_div)
+
 struct imx_i2c_struct {
 	struct i2c_adapter	adapter;
 	struct resource		*res;
@@ -240,22 +242,37 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
 	clk_disable(i2c_imx->clk);
 }
 
-static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
-							unsigned int rate)
+/* find the index into i2c_clk_div[] array, compare with the two
+ * dividers found, return the one with smaller error
+ */
+static int find_div(unsigned long i2c_clk_rate, unsigned long rate)
 {
-	unsigned int i2c_clk_rate;
-	unsigned int div;
+	unsigned long div, delta_l, delta_h;
 	int i;
 
-	/* Divider value calculation */
-	i2c_clk_rate = clk_get_rate(i2c_imx->clk);
 	div = (i2c_clk_rate + rate - 1) / rate;
+
 	if (div < i2c_clk_div[0][0])
-		i = 0;
-	else if (div > i2c_clk_div[ARRAY_SIZE(i2c_clk_div) - 1][0])
-		i = ARRAY_SIZE(i2c_clk_div) - 1;
-	else
-		for (i = 0; i2c_clk_div[i][0] < div; i++);
+		return 0;
+
+	if (div > i2c_clk_div[I2C_CLK_DIV_NUM - 1][0])
+		return I2C_CLK_DIV_NUM;
+
+	for (i = 0; i < I2C_CLK_DIV_NUM; i++)
+		if (i2c_clk_div[i][0] > div)
+			break;
+
+	delta_h = (i2c_clk_rate / i2c_clk_div[i - 1][0]) - rate;
+	delta_l = rate - (i2c_clk_rate / i2c_clk_div[i][0]);
+
+	return (delta_l < delta_h) ? i : i - 1;
+}
+
+static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
+				   unsigned int rate)
+{
+	unsigned long i2c_clk_rate = clk_get_rate(i2c_imx->clk);
+	int i = find_div(i2c_clk_rate, rate);
 
 	/* Store divider value */
 	i2c_imx->ifdr = i2c_clk_div[i][1];
@@ -271,10 +288,9 @@ static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
 
 	/* dev_dbg() can't be used, because adapter is not yet registered */
 #ifdef CONFIG_I2C_DEBUG_BUS
-	printk(KERN_DEBUG "I2C: <%s> I2C_CLK=%d, REQ DIV=%d\n",
-		__func__, i2c_clk_rate, div);
-	printk(KERN_DEBUG "I2C: <%s> IFDR[IC]=0x%x, REAL DIV=%d\n",
-		__func__, i2c_clk_div[i][1], i2c_clk_div[i][0]);
+	pr_debug("<%s> I2C_CLK=%ld, REQ RATE=%d, DIV=%d, IFDR[IC]=0x%x\n",
+		__func__, i2c_clk_rate, rate,
+		i2c_clk_div[i][0], i2c_clk_div[i][1]);
 #endif
 }
 
-- 
1.7.4.1
