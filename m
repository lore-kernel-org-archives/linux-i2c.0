From: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH] i2c: rk3x: adjust the LOW divison based on characteristics of SCL
Date: Wed, 24 Sep 2014 09:55:43 +0800
Message-ID: <1411523743-3444-1-git-send-email-addy.ke@rock-chips.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org, yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org, caesar.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

As show in I2C specification:
- Standard-mode:
  the minimum HIGH period of the scl clock is 4.0us
  the minimum LOW period of the scl clock is 4.7us
- Fast-mode:
  the minimum HIGH period of the scl clock is 0.6us
  the minimum LOW period of the scl clock is 1.3us
- Fast-mode plus:
  the minimum HIGH period of the scl clock is 0.26us
  the minimum LOW period of the scl clock is 0.5us
- HS-mode(<1.7MHz):
  the minimum HIGH period of the scl clock is 0.12us
  the minimum LOW period of the scl clock is 0.32us
- HS-mode(<3.4MHz):
  the minimum HIGH period of the scl clock is 0.06us
  the minimum LOW period of the scl clock is 0.16us

I have measured i2c SCL waveforms in fast-mode by oscilloscope
on rk3288-pinky board. the LOW period of the scl clock is 1.3us.
It is so critical that we must adjust LOW division to increase
the LOW period of the scl clock.

Thanks Doug for the suggestion about division formula.

Signed-off-by: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
 drivers/i2c/busses/i2c-rk3x.c | 79 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 72 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 93cfc83..49d67b7 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -428,18 +428,83 @@ out:
 	return IRQ_HANDLED;
 }
 
+static void rk3x_i2c_get_ratios(unsigned long scl_rate,
+				unsigned long *high_ratio,
+				unsigned long *low_ratio)
+{
+	/* As show in I2C specification:
+	 * - Standard-mode:
+	 *   the minimum HIGH period of the scl clock is 4.0us
+	 *   the minimum LOW period of the scl clock is 4.7us
+	 * - Fast-mode:
+	 *   the minimum HIGH period of the scl clock is 0.6us
+	 *   the minimum LOW period of the scl clock is 1.3us
+	 * - Fast-mode plus:
+	 *   the minimum HIGH period of the scl clock is 0.26us
+	 *   the minimum LOW period of the scl clock is 0.5us
+	 * - HS-mode(<1.7MHz):
+	 *   the minimum HIGH period of the scl clock is 0.12us
+	 *   the minimum LOW period of the scl clock is 0.32us
+	 * - HS-mode(<3.4MHz):
+	 *   the minimum HIGH period of the scl clock is 0.06us
+	 *   the minimum LOW period of the scl clock is 0.16us
+	 */
+	if (scl_rate <= 100000) {
+		*high_ratio = 40;
+		*low_ratio = 47;
+	} else if (scl_rate <= 400000) {
+		*high_ratio = 6;
+		*low_ratio = 13;
+	} else if (scl_rate <= 1000000) {
+		*high_ratio = 26;
+		*low_ratio = 50;
+	} else if (scl_rate <= 1700000) {
+		*high_ratio = 12;
+		*low_ratio = 32;
+	} else {
+		*high_ratio = 6;
+		*low_ratio = 16;
+	}
+}
+
+static void rk3x_i2c_calc_divs(unsigned long i2c_rate, unsigned long scl_rate,
+			       unsigned long *divh, unsigned long *divl)
+{
+	unsigned long high_ratio, low_ratio;
+	unsigned long ratio_sum;
+
+	rk3x_i2c_get_ratios(scl_rate, &high_ratio, &low_ratio);
+	ratio_sum = high_ratio + low_ratio;
+
+	/* T_high = T_clk * (divh + 1) * 8
+	 * T_low = T_clk * (divl + 1) * 8
+	 * T_scl = T_high + T_low
+	 * T_scl = 1 / scl_rate
+	 * T_clk = 1 / i2c_rate
+	 * T_high : T_low = high_ratio : low_ratio
+	 * ratio_sum = high_ratio + low_ratio
+	 *
+	 * so:
+	 * divh = (i2c_rate * high_ratio) / (scl_rate * ratio_sum * 8) - 1
+	 * divl = (i2c_rate * low_ratio) / (scl_rate * ratio_sum * 8) - 1
+	 */
+	*divh = DIV_ROUND_UP(i2c_rate * high_ratio, scl_rate * ratio_sum * 8);
+	if (*divh)
+		*divh = *divh - 1;
+
+	*divl = DIV_ROUND_UP(i2c_rate * low_ratio, scl_rate * ratio_sum * 8);
+	if (*divl)
+		*divl = *divl - 1;
+}
+
 static void rk3x_i2c_set_scl_rate(struct rk3x_i2c *i2c, unsigned long scl_rate)
 {
 	unsigned long i2c_rate = clk_get_rate(i2c->clk);
-	unsigned int div;
+	unsigned long divh, divl;
 
-	/* set DIV = DIVH = DIVL
-	 * SCL rate = (clk rate) / (8 * (DIVH + 1 + DIVL + 1))
-	 *          = (clk rate) / (16 * (DIV + 1))
-	 */
-	div = DIV_ROUND_UP(i2c_rate, scl_rate * 16) - 1;
+	rk3x_i2c_calc_divs(i2c_rate, scl_rate, &divh, &divl);
 
-	i2c_writel(i2c, (div << 16) | (div & 0xffff), REG_CLKDIV);
+	i2c_writel(i2c, (divh << 16) | (divl & 0xffff), REG_CLKDIV);
 }
 
 /**
-- 
1.8.3.2
