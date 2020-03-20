From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 4/6] =?UTF-8?q?i2c:=20stm32f7:=20switch=20to=20I=C2=B2C?= =?UTF-8?q?=20generic=20property=20parsing?=
Date: Fri, 20 Mar 2020 21:12:47 +0200
Message-ID: <20200320191249.28835-4-andriy.shevchenko@linux.intel.com>
References: <20200320191249.28835-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:24520 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgCTTMw (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 20 Mar 2020 15:12:52 -0400
In-Reply-To: <20200320191249.28835-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Pierre-Yves MORDRET <pierre-yves.mordret@st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Alain Volmat <alain.volmat@st.com>

Switch to the new generic functions: i2c_parse_fw_timings().

While here, replace hard coded values with standard bus frequency definitions.

Cc: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Alain Volmat <alain.volmat@st.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v4: fixed typo in parameter (Alain)
 drivers/i2c/busses/i2c-stm32f7.c | 57 +++++++++++++++-----------------
 1 file changed, 26 insertions(+), 31 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 6418f5982894..330ffed011e0 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -344,9 +344,9 @@ struct stm32f7_i2c_dev {
  */
 static struct stm32f7_i2c_spec i2c_specs[] = {
 	[STM32_I2C_SPEED_STANDARD] = {
-		.rate = 100000,
-		.rate_min = 80000,
-		.rate_max = 100000,
+		.rate = I2C_MAX_STANDARD_MODE_FREQ,
+		.rate_min = I2C_MAX_STANDARD_MODE_FREQ * 8 / 10,	/* 80% */
+		.rate_max = I2C_MAX_STANDARD_MODE_FREQ,
 		.fall_max = 300,
 		.rise_max = 1000,
 		.hddat_min = 0,
@@ -356,9 +356,9 @@ static struct stm32f7_i2c_spec i2c_specs[] = {
 		.h_min = 4000,
 	},
 	[STM32_I2C_SPEED_FAST] = {
-		.rate = 400000,
-		.rate_min = 320000,
-		.rate_max = 400000,
+		.rate = I2C_MAX_FAST_MODE_FREQ,
+		.rate_min = I2C_MAX_FAST_MODE_FREQ * 8 / 10,		/* 80% */
+		.rate_max = I2C_MAX_FAST_MODE_FREQ,
 		.fall_max = 300,
 		.rise_max = 300,
 		.hddat_min = 0,
@@ -368,9 +368,9 @@ static struct stm32f7_i2c_spec i2c_specs[] = {
 		.h_min = 600,
 	},
 	[STM32_I2C_SPEED_FAST_PLUS] = {
-		.rate = 1000000,
-		.rate_min = 800000,
-		.rate_max = 1000000,
+		.rate = I2C_MAX_FAST_MODE_PLUS_FREQ,
+		.rate_min = I2C_MAX_FAST_MODE_PLUS_FREQ * 8 / 10,	/* 80% */
+		.rate_max = I2C_MAX_FAST_MODE_PLUS_FREQ,
 		.fall_max = 100,
 		.rise_max = 120,
 		.hddat_min = 0,
@@ -610,8 +610,25 @@ static int stm32f7_i2c_compute_timing(struct stm32f7_i2c_dev *i2c_dev,
 static int stm32f7_i2c_setup_timing(struct stm32f7_i2c_dev *i2c_dev,
 				    struct stm32f7_i2c_setup *setup)
 {
+	struct i2c_timings timings, *t = &timings;
 	int ret = 0;
 
+	t->bus_freq_hz = I2C_MAX_STANDARD_MODE_FREQ;
+	t->scl_rise_ns = i2c_dev->setup.rise_time;
+	t->scl_fall_ns = i2c_dev->setup.fall_time;
+
+	i2c_parse_fw_timings(i2c_dev->dev, t, false);
+
+	if (t->bus_freq_hz >= I2C_MAX_FAST_MODE_PLUS_FREQ)
+		i2c_dev->speed = STM32_I2C_SPEED_FAST_PLUS;
+	else if (t->bus_freq_hz >= I2C_MAX_FAST_MODE_FREQ)
+		i2c_dev->speed = STM32_I2C_SPEED_FAST;
+	else
+		i2c_dev->speed = STM32_I2C_SPEED_STANDARD;
+
+	i2c_dev->setup.rise_time = t->scl_rise_ns;
+	i2c_dev->setup.fall_time = t->scl_fall_ns;
+
 	setup->speed = i2c_dev->speed;
 	setup->speed_freq = i2c_specs[setup->speed].rate;
 	setup->clock_src = clk_get_rate(i2c_dev->clk);
@@ -1914,7 +1931,6 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
 	struct stm32f7_i2c_dev *i2c_dev;
 	const struct stm32f7_i2c_setup *setup;
 	struct resource *res;
-	u32 clk_rate, rise_time, fall_time;
 	struct i2c_adapter *adap;
 	struct reset_control *rst;
 	dma_addr_t phy_addr;
@@ -1961,17 +1977,6 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	i2c_dev->speed = STM32_I2C_SPEED_STANDARD;
-	ret = device_property_read_u32(&pdev->dev, "clock-frequency",
-				       &clk_rate);
-	if (!ret && clk_rate >= 1000000) {
-		i2c_dev->speed = STM32_I2C_SPEED_FAST_PLUS;
-	} else if (!ret && clk_rate >= 400000) {
-		i2c_dev->speed = STM32_I2C_SPEED_FAST;
-	} else if (!ret && clk_rate >= 100000) {
-		i2c_dev->speed = STM32_I2C_SPEED_STANDARD;
-	}
-
 	rst = devm_reset_control_get(&pdev->dev, NULL);
 	if (IS_ERR(rst)) {
 		dev_err(&pdev->dev, "Error: Missing controller reset\n");
@@ -2011,16 +2016,6 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
 	}
 	i2c_dev->setup = *setup;
 
-	ret = device_property_read_u32(i2c_dev->dev, "i2c-scl-rising-time-ns",
-				       &rise_time);
-	if (!ret)
-		i2c_dev->setup.rise_time = rise_time;
-
-	ret = device_property_read_u32(i2c_dev->dev, "i2c-scl-falling-time-ns",
-				       &fall_time);
-	if (!ret)
-		i2c_dev->setup.fall_time = fall_time;
-
 	ret = stm32f7_i2c_setup_timing(i2c_dev, &i2c_dev->setup);
 	if (ret)
 		goto clk_free;
-- 
2.25.1
