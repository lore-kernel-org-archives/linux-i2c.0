From: David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v9 2/8] i2c: rk3x: use struct "rk3x_i2c_calced_timings"
Date: Thu, 12 May 2016 15:53:00 +0800
Message-ID: <1463039586-8134-3-git-send-email-david.wu@rock-chips.com>
References: <1463039586-8134-1-git-send-email-david.wu@rock-chips.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463039586-8134-1-git-send-email-david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, briannorris-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, davidriley-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The "div_high" and "div_low" values are always used together.
Group them into a structure to make it easier to pass them
both around. This structure also provides a place for future
calculated timings.

Signed-off-by: David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Reviewed-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
Change in v9:
- none

Change in v8:
- add commit description.

 drivers/i2c/busses/i2c-rk3x.c | 55 +++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 7e45d51..1e2677a 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -75,6 +75,16 @@ enum {
 #define WAIT_TIMEOUT      1000 /* ms */
 #define DEFAULT_SCL_RATE  (100 * 1000) /* Hz */
 
+/**
+ * struct rk3x_i2c_calced_timings:
+ * @div_low: Divider output for low
+ * @div_high: Divider output for high
+ */
+struct rk3x_i2c_calced_timings {
+	unsigned long div_low;
+	unsigned long div_high;
+};
+
 enum rk3x_i2c_state {
 	STATE_IDLE,
 	STATE_START,
@@ -454,9 +464,8 @@ out:
  * Calculate divider values for desired SCL frequency
  *
  * @clk_rate: I2C input clock rate
- * @t: Known I2C timing information.
- * @div_low: Divider output for low
- * @div_high: Divider output for high
+ * @t: Known I2C timing information
+ * @t_calc: Caculated rk3x private timings that would be written into regs
  *
  * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow. In that case
  * a best-effort divider value is returned in divs. If the target rate is
@@ -464,8 +473,7 @@ out:
  */
 static int rk3x_i2c_calc_divs(unsigned long clk_rate,
 			      struct i2c_timings *t,
-			      unsigned long *div_low,
-			      unsigned long *div_high)
+			      struct rk3x_i2c_calced_timings *t_calc)
 {
 	unsigned long spec_min_low_ns, spec_min_high_ns;
 	unsigned long spec_setup_start, spec_max_data_hold_ns;
@@ -572,8 +580,8 @@ static int rk3x_i2c_calc_divs(unsigned long clk_rate,
 		 * Time needed to meet hold requirements is important.
 		 * Just use that.
 		 */
-		*div_low = min_low_div;
-		*div_high = min_high_div;
+		t_calc->div_low = min_low_div;
+		t_calc->div_high = min_high_div;
 	} else {
 		/*
 		 * We've got to distribute some time among the low and high
@@ -602,25 +610,25 @@ static int rk3x_i2c_calc_divs(unsigned long clk_rate,
 
 		/* Give low the "ideal" and give high whatever extra is left */
 		extra_low_div = ideal_low_div - min_low_div;
-		*div_low = ideal_low_div;
-		*div_high = min_high_div + (extra_div - extra_low_div);
+		t_calc->div_low = ideal_low_div;
+		t_calc->div_high = min_high_div + (extra_div - extra_low_div);
 	}
 
 	/*
 	 * Adjust to the fact that the hardware has an implicit "+1".
 	 * NOTE: Above calculations always produce div_low > 0 and div_high > 0.
 	 */
-	*div_low = *div_low - 1;
-	*div_high = *div_high - 1;
+	t_calc->div_low--;
+	t_calc->div_high--;
 
 	/* Maximum divider supported by hw is 0xffff */
-	if (*div_low > 0xffff) {
-		*div_low = 0xffff;
+	if (t_calc->div_low > 0xffff) {
+		t_calc->div_low = 0xffff;
 		ret = -EINVAL;
 	}
 
-	if (*div_high > 0xffff) {
-		*div_high = 0xffff;
+	if (t_calc->div_high > 0xffff) {
+		t_calc->div_high = 0xffff;
 		ret = -EINVAL;
 	}
 
@@ -630,19 +638,21 @@ static int rk3x_i2c_calc_divs(unsigned long clk_rate,
 static void rk3x_i2c_adapt_div(struct rk3x_i2c *i2c, unsigned long clk_rate)
 {
 	struct i2c_timings *t = &i2c->t;
-	unsigned long div_low, div_high;
+	struct rk3x_i2c_calced_timings calc;
 	u64 t_low_ns, t_high_ns;
 	int ret;
 
-	ret = rk3x_i2c_calc_divs(clk_rate, t, &div_low, &div_high);
+	ret = rk3x_i2c_calc_divs(clk_rate, t, &calc);
 	WARN_ONCE(ret != 0, "Could not reach SCL freq %u", t->bus_freq_hz);
 
 	clk_enable(i2c->clk);
-	i2c_writel(i2c, (div_high << 16) | (div_low & 0xffff), REG_CLKDIV);
+	i2c_writel(i2c, (calc.div_high << 16) | (calc.div_low & 0xffff),
+		   REG_CLKDIV);
 	clk_disable(i2c->clk);
 
-	t_low_ns = div_u64(((u64)div_low + 1) * 8 * 1000000000, clk_rate);
-	t_high_ns = div_u64(((u64)div_high + 1) * 8 * 1000000000, clk_rate);
+	t_low_ns = div_u64(((u64)calc.div_low + 1) * 8 * 1000000000, clk_rate);
+	t_high_ns = div_u64(((u64)calc.div_high + 1) * 8 * 1000000000,
+			    clk_rate);
 	dev_dbg(i2c->dev,
 		"CLK %lukhz, Req %uns, Act low %lluns high %lluns\n",
 		clk_rate / 1000,
@@ -672,12 +682,11 @@ static int rk3x_i2c_clk_notifier_cb(struct notifier_block *nb, unsigned long
 {
 	struct clk_notifier_data *ndata = data;
 	struct rk3x_i2c *i2c = container_of(nb, struct rk3x_i2c, clk_rate_nb);
-	unsigned long div_low, div_high;
+	struct rk3x_i2c_calced_timings calc;
 
 	switch (event) {
 	case PRE_RATE_CHANGE:
-		if (rk3x_i2c_calc_divs(ndata->new_rate, &i2c->t,
-				       &div_low, &div_high) != 0)
+		if (rk3x_i2c_calc_divs(ndata->new_rate, &i2c->t, &calc) != 0)
 			return NOTIFY_STOP;
 
 		/* scale up */
-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
