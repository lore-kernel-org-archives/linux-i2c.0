From: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v6] i2c: rk3x: handle dynamic clock rate changes correctly
Date: Wed, 19 Nov 2014 00:18:27 +0100
Message-ID: <5274716.Gef1fPceY6@typ>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Huang Tao <huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The i2c input clock can change dynamically, e.g. on the RK3066 where
pclk_i2c0 and pclk_i2c1 are connected to the armclk, which changes
rate on cpu frequency scaling.

Until now, we incorrectly called clk_get_rate() while holding the
i2c->lock in rk3x_i2c_xfer() to adapt to clock rate changes.
Thanks to Huang Tao for reporting this issue.

Do it properly now using the clk notifier framework. The callback
logic was taken from i2c-cadence.c.

Also rename all misleading "i2c_rate" variables to "clk_rate", as they
describe the *input* clk rate.

Signed-off-by: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Tested-by: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org> on RK3188
Tested-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> on RK3288
Reviewed-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---

Changes since v5:
 - document rk3x_i2c_calc_divs (Doug Anderson)
 - rename all i2c_rate to clk_rate (Doug Anderson)
 - remove obsolete braces in rk3x_i2c_clk_notifier_cb (Doug Anderson)

Changes since v4:
 - fixed a bug in rk3x_i2c_clk_notifier_cb() which would feed
   the input clock frequency as the desired SCL frequency into
   rk3x_i2c_set_scl_frequency(i2c, scl_rate). Rename & change to
   rk3x_i2c_adapt_div(i2c, clk_rate) to make things clear.
 - trimmed comment in rk3x_i2c_adapt_div() (sugg. by Doug Anderson)

Changes since v3:
 - drop leftover write-only clk_freq variable (sugg. by Doug Anderson)

Changes since v2:
 - allow rate changes which result in lower than
   desired SCL frequencies (sugg. by Doug Anderson)
 - simplified divider range checks (Doug Anderson)
 - removed duplicate clk_enable()/disable() (Doug Anderson)
 - added missing unregister in rk3x_i2c_remove() (Doug Anderson)

Changes since v1:
 - make sure the i2c input clock is active during prescaler
   register write by explicitly enabling/disabling it in
   rk3x_i2c_set_scl_frequency(). Bug found by Addy Ke.

Here are waveforms from rate change tests:

Rate change from default rate to half rate:
http://x-quadraht.de/fast_to_slow.png

>From half rate to default rate:
http://x-quadraht.de/slow_to_fast.png

The third and fourth line show the begin and end of the clk_set_rate() call, 
respectively. You can see nicely that both rate transitions result in a few 
slower SCL cycles, but never in faster ones.

Cheers,
  Max

 drivers/i2c/busses/i2c-rk3x.c | 134 ++++++++++++++++++++++++++++++++----------
 1 file changed, 103 insertions(+), 31 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index e276ffb..67504f2 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -98,6 +98,7 @@ struct rk3x_i2c {
 	/* Hardware resources */
 	void __iomem *regs;
 	struct clk *clk;
+	struct notifier_block clk_rate_nb;
 
 	/* Settings */
 	unsigned int scl_frequency;
@@ -429,15 +430,26 @@ out:
 	return IRQ_HANDLED;
 }
 
-static int rk3x_i2c_calc_divs(unsigned long i2c_rate, unsigned long scl_rate,
-			       unsigned long *div_low, unsigned long *div_high)
+/**
+ * Calculate divider values for desired SCL frequency
+ *
+ * @clk_rate: I2C input clock rate
+ * @scl_rate: Desired SCL rate
+ * @div_low: Divider output for low
+ * @div_high: Divider output for high
+ *
+ * Returns: 0 on success, -EINVAL on unreachable SCL rate. In that case
+ * a best-effort divider value is returned in divs.
+ */
+static int rk3x_i2c_calc_divs(unsigned long clk_rate, unsigned long scl_rate,
+			      unsigned long *div_low, unsigned long *div_high)
 {
 	unsigned long min_low_ns, min_high_ns;
 	unsigned long max_data_hold_ns;
 	unsigned long data_hold_buffer_ns;
 	unsigned long max_low_ns, min_total_ns;
 
-	unsigned long i2c_rate_khz, scl_rate_khz;
+	unsigned long clk_rate_khz, scl_rate_khz;
 
 	unsigned long min_low_div, min_high_div;
 	unsigned long max_low_div;
@@ -480,25 +492,25 @@ static int rk3x_i2c_calc_divs(unsigned long i2c_rate, unsigned long scl_rate,
 	min_total_ns = min_low_ns + min_high_ns;
 
 	/* Adjust to avoid overflow */
-	i2c_rate_khz = DIV_ROUND_UP(i2c_rate, 1000);
+	clk_rate_khz = DIV_ROUND_UP(clk_rate, 1000);
 	scl_rate_khz = scl_rate / 1000;
 
 	/*
 	 * We need the total div to be >= this number
 	 * so we don't clock too fast.
 	 */
-	min_total_div = DIV_ROUND_UP(i2c_rate_khz, scl_rate_khz * 8);
+	min_total_div = DIV_ROUND_UP(clk_rate_khz, scl_rate_khz * 8);
 
 	/* These are the min dividers needed for min hold times. */
-	min_low_div = DIV_ROUND_UP(i2c_rate_khz * min_low_ns, 8 * 1000000);
-	min_high_div = DIV_ROUND_UP(i2c_rate_khz * min_high_ns, 8 * 1000000);
+	min_low_div = DIV_ROUND_UP(clk_rate_khz * min_low_ns, 8 * 1000000);
+	min_high_div = DIV_ROUND_UP(clk_rate_khz * min_high_ns, 8 * 1000000);
 	min_div_for_hold = (min_low_div + min_high_div);
 
 	/*
 	 * This is the maximum divider so we don't go over the max.
 	 * We don't round up here (we round down) since this is a max.
 	 */
-	max_low_div = i2c_rate_khz * max_low_ns / (8 * 1000000);
+	max_low_div = clk_rate_khz * max_low_ns / (8 * 1000000);
 
 	if (min_low_div > max_low_div) {
 		WARN_ONCE(true,
@@ -526,7 +538,7 @@ static int rk3x_i2c_calc_divs(unsigned long i2c_rate, unsigned long scl_rate,
 		 * biasing slightly towards having a higher div
 		 * for low (spend more time low).
 		 */
-		ideal_low_div = DIV_ROUND_UP(i2c_rate_khz * min_low_ns,
+		ideal_low_div = DIV_ROUND_UP(clk_rate_khz * min_low_ns,
 					     scl_rate_khz * 8 * min_total_ns);
 
 		/* Don't allow it to go over the max */
@@ -547,9 +559,9 @@ static int rk3x_i2c_calc_divs(unsigned long i2c_rate, unsigned long scl_rate,
 	}
 
 	/*
-	* Adjust to the fact that the hardware has an implicit "+1".
-	* NOTE: Above calculations always produce div_low > 0 and  div_high > 0.
-	*/
+	 * Adjust to the fact that the hardware has an implicit "+1".
+	 * NOTE: Above calculations always produce div_low > 0 and div_high > 0.
+	 */
 	*div_low = *div_low - 1;
 	*div_high = *div_high - 1;
 
@@ -559,28 +571,79 @@ static int rk3x_i2c_calc_divs(unsigned long i2c_rate, unsigned long scl_rate,
 		return 0;
 }
 
-static int rk3x_i2c_set_scl_rate(struct rk3x_i2c *i2c, unsigned long scl_rate)
+static void rk3x_i2c_adapt_div(struct rk3x_i2c *i2c, unsigned long clk_rate)
 {
-	unsigned long i2c_rate = clk_get_rate(i2c->clk);
 	unsigned long div_low, div_high;
 	u64 t_low_ns, t_high_ns;
-	int ret = 0;
+	int ret;
 
-	ret = rk3x_i2c_calc_divs(i2c_rate, scl_rate, &div_low, &div_high);
-	if (ret < 0)
-		return ret;
+	ret = rk3x_i2c_calc_divs(clk_rate, i2c->scl_frequency, &div_low,
+				 &div_high);
+
+	WARN_ONCE(ret != 0, "Could not reach SCL freq %u", i2c->scl_frequency);
 
+	clk_enable(i2c->clk);
 	i2c_writel(i2c, (div_high << 16) | (div_low & 0xffff), REG_CLKDIV);
+	clk_disable(i2c->clk);
 
-	t_low_ns = div_u64(((u64)div_low + 1) * 8 * 1000000000, i2c_rate);
-	t_high_ns = div_u64(((u64)div_high + 1) * 8 * 1000000000, i2c_rate);
+	t_low_ns = div_u64(((u64)div_low + 1) * 8 * 1000000000, clk_rate);
+	t_high_ns = div_u64(((u64)div_high + 1) * 8 * 1000000000, clk_rate);
 	dev_dbg(i2c->dev,
-		"CLK %lukhz, Req %luns, Act low %lluns high %lluns\n",
-		i2c_rate / 1000,
-		1000000000 / scl_rate,
+		"CLK %lukhz, Req %uns, Act low %lluns high %lluns\n",
+		clk_rate / 1000,
+		1000000000 / i2c->scl_frequency,
 		t_low_ns, t_high_ns);
+}
 
-	return ret;
+/**
+ * rk3x_i2c_clk_notifier_cb - Clock rate change callback
+ * @nb:		Pointer to notifier block
+ * @event:	Notification reason
+ * @data:	Pointer to notification data object
+ *
+ * The callback checks whether a valid bus frequency can be generated after the
+ * change. If so, the change is acknowledged, otherwise the change is aborted.
+ * New dividers are written to the HW in the pre- or post change notification
+ * depending on the scaling direction.
+ *
+ * Code adapted from i2c-cadence.c.
+ *
+ * Return:	NOTIFY_STOP if the rate change should be aborted, NOTIFY_OK
+ *		to acknowedge the change, NOTIFY_DONE if the notification is
+ *		considered irrelevant.
+ */
+static int rk3x_i2c_clk_notifier_cb(struct notifier_block *nb, unsigned long
+				    event, void *data)
+{
+	struct clk_notifier_data *ndata = data;
+	struct rk3x_i2c *i2c = container_of(nb, struct rk3x_i2c, clk_rate_nb);
+	unsigned long div_low, div_high;
+
+	switch (event) {
+	case PRE_RATE_CHANGE:
+		if (rk3x_i2c_calc_divs(ndata->new_rate, i2c->scl_frequency,
+				      &div_low, &div_high) != 0) {
+			return NOTIFY_STOP;
+		}
+
+		/* scale up */
+		if (ndata->new_rate > ndata->old_rate)
+			rk3x_i2c_adapt_div(i2c, ndata->new_rate);
+
+		return NOTIFY_OK;
+	case POST_RATE_CHANGE:
+		/* scale down */
+		if (ndata->new_rate < ndata->old_rate)
+			rk3x_i2c_adapt_div(i2c, ndata->new_rate);
+		return NOTIFY_OK;
+	case ABORT_RATE_CHANGE:
+		/* scale up */
+		if (ndata->new_rate > ndata->old_rate)
+			rk3x_i2c_adapt_div(i2c, ndata->old_rate);
+		return NOTIFY_OK;
+	default:
+		return NOTIFY_DONE;
+	}
 }
 
 /**
@@ -677,11 +740,6 @@ static int rk3x_i2c_xfer(struct i2c_adapter *adap,
 
 	clk_enable(i2c->clk);
 
-	/* The clock rate might have changed, so setup the divider again */
-	ret = rk3x_i2c_set_scl_rate(i2c, i2c->scl_frequency);
-	if (ret < 0)
-		goto exit;
-
 	i2c->is_last_msg = false;
 
 	/*
@@ -728,7 +786,6 @@ static int rk3x_i2c_xfer(struct i2c_adapter *adap,
 		}
 	}
 
-exit:
 	clk_disable(i2c->clk);
 	spin_unlock_irqrestore(&i2c->lock, flags);
 
@@ -768,6 +825,7 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 	int bus_nr;
 	u32 value;
 	int irq;
+	unsigned long clk_rate;
 
 	i2c = devm_kzalloc(&pdev->dev, sizeof(struct rk3x_i2c), GFP_KERNEL);
 	if (!i2c)
@@ -868,16 +926,28 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	i2c->clk_rate_nb.notifier_call = rk3x_i2c_clk_notifier_cb;
+	ret = clk_notifier_register(i2c->clk, &i2c->clk_rate_nb);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "Unable to register clock notifier\n");
+		goto err_clk;
+	}
+
+	clk_rate = clk_get_rate(i2c->clk);
+	rk3x_i2c_adapt_div(i2c, clk_rate);
+
 	ret = i2c_add_adapter(&i2c->adap);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Could not register adapter\n");
-		goto err_clk;
+		goto err_clk_notifier;
 	}
 
 	dev_info(&pdev->dev, "Initialized RK3xxx I2C bus at %p\n", i2c->regs);
 
 	return 0;
 
+err_clk_notifier:
+	clk_notifier_unregister(i2c->clk, &i2c->clk_rate_nb);
 err_clk:
 	clk_unprepare(i2c->clk);
 	return ret;
@@ -888,6 +958,8 @@ static int rk3x_i2c_remove(struct platform_device *pdev)
 	struct rk3x_i2c *i2c = platform_get_drvdata(pdev);
 
 	i2c_del_adapter(&i2c->adap);
+
+	clk_notifier_unregister(i2c->clk, &i2c->clk_rate_nb);
 	clk_unprepare(i2c->clk);
 
 	return 0;
-- 
1.9.1
