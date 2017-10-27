From: Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH v2] i2c: riic: remove clock and frequency restrictions
Date: Fri, 27 Oct 2017 10:37:56 -0500
Message-ID: <20171027153756.90447-1-chris.brandt@renesas.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:9075 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751380AbdJ0PjR (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 27 Oct 2017 11:39:17 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Chris Brandt <chris.brandt@renesas.com>

Remove the restriction that the parent clock has to be a specific frequency
and also allow any speed to be supported.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
v2:
 * switched to using DIV_ROUND_UP()
 * Added spaces around operators
 * As for Geert's suggestion about increasing precision, I found
   it adds more complexity doing 64-bit math and after some
   analysis and experiments, it's not really worth it.

Tested on the RZ/A1H RSK board with the following DT:
&i2c3 {
	pinctrl-names = "default";
	pinctrl-0 = <&i2c3_pins>;
	status = "okay";
	clock-frequency = <400000>; /* tested values from 10k-400k */
	i2c-scl-rising-time-ns = <300>;
	i2c-scl-falling-time-ns = <250>;
};
---
 drivers/i2c/busses/i2c-riic.c | 115 +++++++++++++++++++++++++++++-------------
 1 file changed, 81 insertions(+), 34 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index c811af4c8d81..95c2f1ce3cad 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -84,12 +84,7 @@
 
 #define ICSR2_NACKF	0x10
 
-/* ICBRx (@ PCLK 33MHz) */
 #define ICBR_RESERVED	0xe0 /* Should be 1 on writes */
-#define ICBRL_SP100K	(19 | ICBR_RESERVED)
-#define ICBRH_SP100K	(16 | ICBR_RESERVED)
-#define ICBRL_SP400K	(21 | ICBR_RESERVED)
-#define ICBRH_SP400K	(9 | ICBR_RESERVED)
 
 #define RIIC_INIT_MSG	-1
 
@@ -288,48 +283,99 @@ static const struct i2c_algorithm riic_algo = {
 	.functionality	= riic_func,
 };
 
-static int riic_init_hw(struct riic_dev *riic, u32 spd)
+static int riic_init_hw(struct riic_dev *riic, struct i2c_timings *t)
 {
 	int ret;
 	unsigned long rate;
+	int total_ticks, cks, brl, brh;
 
 	ret = clk_prepare_enable(riic->clk);
 	if (ret)
 		return ret;
 
+	if (t->bus_freq_hz > 400000) {
+		dev_err(&riic->adapter.dev,
+			"unsupported bus speed (%dHz). 400000 max\n",
+			t->bus_freq_hz);
+		clk_disable_unprepare(riic->clk);
+		return -EINVAL;
+	}
+
+	rate = clk_get_rate(riic->clk);
+
 	/*
-	 * TODO: Implement formula to calculate the timing values depending on
-	 * variable parent clock rate and arbitrary bus speed
+	 * Assume the default register settings:
+	 *  FER.SCLE = 1 (SCL sync circuit enabled, adds 2 or 3 cycles)
+	 *  FER.NFE = 1 (noise circuit enabled)
+	 *  MR3.NF = 0 (1 cycle of noise filtered out)
+	 *
+	 * Freq (CKS=000) = (I2CCLK + tr + tf)/ (BRH + 3 + 1) + (BRL + 3 + 1)
+	 * Freq (CKS!=000) = (I2CCLK + tr + tf)/ (BRH + 2 + 1) + (BRL + 2 + 1)
 	 */
-	rate = clk_get_rate(riic->clk);
-	if (rate != 33325000) {
-		dev_err(&riic->adapter.dev,
-			"invalid parent clk (%lu). Must be 33325000Hz\n", rate);
+
+	/*
+	 * Determine reference clock rate. We must be able to get the desired
+	 * frequency with only 62 clock ticks max (31 high, 31 low).
+	 * Aim for a duty of 60% LOW, 40% HIGH.
+	 */
+	total_ticks = DIV_ROUND_UP(rate, t->bus_freq_hz);
+
+	for (cks = 0; cks < 7; cks++) {
+		/*
+		 * 60% low time must be less than BRL + 2 + 1
+		 * BRL max register value is 0x1F.
+		 */
+		brl = ((total_ticks * 6) / 10);
+		if (brl <= (0x1F + 3))
+			break;
+
+		total_ticks /= 2;
+		rate /= 2;
+	}
+
+	if (brl > (0x1F + 3)) {
+		dev_err(&riic->adapter.dev, "invalid speed (%lu). Too slow.\n",
+			(unsigned long)t->bus_freq_hz);
 		clk_disable_unprepare(riic->clk);
 		return -EINVAL;
 	}
 
+	brh = total_ticks - brl;
+
+	/* Remove automatic clock ticks for sync circuit and NF */
+	if (cks == 0) {
+		brl -= 4;
+		brh -= 4;
+	} else {
+		brl -= 3;
+		brh -= 3;
+	}
+
+	/*
+	 * Remove clock ticks for rise and fall times. Convert ns to clock
+	 * ticks.
+	 */
+	brl -= t->scl_fall_ns / (1000000000 / rate);
+	brh -= t->scl_rise_ns / (1000000000 / rate);
+
+	/* Adjust for min register values for when SCLE=1 and NFE=1 */
+	if (brl < 1)
+		brl = 1;
+	if (brh < 1)
+		brh = 1;
+
+	pr_debug("i2c-riic: freq=%lu, duty=%d, fall=%lu, rise=%lu, cks=%d, brl=%d, brh=%d\n",
+		 rate / total_ticks, ((brl + 3) * 100) / (brl + brh + 6),
+		 t->scl_fall_ns / (1000000000 / rate),
+		 t->scl_rise_ns / (1000000000 / rate), cks, brl, brh);
+
 	/* Changing the order of accessing IICRST and ICE may break things! */
 	writeb(ICCR1_IICRST | ICCR1_SOWP, riic->base + RIIC_ICCR1);
 	riic_clear_set_bit(riic, 0, ICCR1_ICE, RIIC_ICCR1);
 
-	switch (spd) {
-	case 100000:
-		writeb(ICMR1_CKS(3), riic->base + RIIC_ICMR1);
-		writeb(ICBRH_SP100K, riic->base + RIIC_ICBRH);
-		writeb(ICBRL_SP100K, riic->base + RIIC_ICBRL);
-		break;
-	case 400000:
-		writeb(ICMR1_CKS(1), riic->base + RIIC_ICMR1);
-		writeb(ICBRH_SP400K, riic->base + RIIC_ICBRH);
-		writeb(ICBRL_SP400K, riic->base + RIIC_ICBRL);
-		break;
-	default:
-		dev_err(&riic->adapter.dev,
-			"unsupported bus speed (%dHz). Use 100000 or 400000\n", spd);
-		clk_disable_unprepare(riic->clk);
-		return -EINVAL;
-	}
+	writeb(ICMR1_CKS(cks), riic->base + RIIC_ICMR1);
+	writeb(brh | ICBR_RESERVED, riic->base + RIIC_ICBRH);
+	writeb(brl | ICBR_RESERVED, riic->base + RIIC_ICBRL);
 
 	writeb(0, riic->base + RIIC_ICSER);
 	writeb(ICMR3_ACKWP | ICMR3_RDRFS, riic->base + RIIC_ICMR3);
@@ -351,11 +397,10 @@ static struct riic_irq_desc riic_irqs[] = {
 
 static int riic_i2c_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	struct riic_dev *riic;
 	struct i2c_adapter *adap;
 	struct resource *res;
-	u32 bus_rate = 0;
+	struct i2c_timings i2c_t;
 	int i, ret;
 
 	riic = devm_kzalloc(&pdev->dev, sizeof(*riic), GFP_KERNEL);
@@ -396,8 +441,9 @@ static int riic_i2c_probe(struct platform_device *pdev)
 
 	init_completion(&riic->msg_done);
 
-	of_property_read_u32(np, "clock-frequency", &bus_rate);
-	ret = riic_init_hw(riic, bus_rate);
+	i2c_parse_fw_timings(&pdev->dev, &i2c_t, true);
+
+	ret = riic_init_hw(riic, &i2c_t);
 	if (ret)
 		return ret;
 
@@ -408,7 +454,8 @@ static int riic_i2c_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, riic);
 
-	dev_info(&pdev->dev, "registered with %dHz bus speed\n", bus_rate);
+	dev_info(&pdev->dev, "registered with %dHz bus speed\n",
+		 i2c_t.bus_freq_hz);
 	return 0;
 }
 
-- 
2.14.1
