From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 3/6] i2c: rcar: Consolidate timings calls in rcar_i2c_clock_calculate()
Date: Mon, 16 Mar 2020 17:49:26 +0200
Message-ID: <20200316154929.20886-3-andriy.shevchenko@linux.intel.com>
References: <20200316154929.20886-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:42989 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731838AbgCPPtc (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 16 Mar 2020 11:49:32 -0400
In-Reply-To: <20200316154929.20886-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Move i2c_parse_fw_timings() to rcar_i2c_clock_calculate() to consolidate
timings calls in one place.

While here, replace hard coded values with standard bus frequency definitions.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: new patch
 drivers/i2c/busses/i2c-rcar.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index f1f915bfdb9d..a8a136e490fa 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -235,17 +235,20 @@ static int rcar_i2c_bus_barrier(struct rcar_i2c_priv *priv)
 	return i2c_recover_bus(&priv->adap);
 }
 
-static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv, struct i2c_timings *t)
+static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv)
 {
 	u32 scgd, cdf, round, ick, sum, scl, cdf_width;
 	unsigned long rate;
 	struct device *dev = rcar_i2c_priv_to_dev(priv);
+	struct i2c_timings i2c_t, *t = &i2c_t;
 
 	/* Fall back to previously used values if not supplied */
-	t->bus_freq_hz = t->bus_freq_hz ?: 100000;
-	t->scl_fall_ns = t->scl_fall_ns ?: 35;
-	t->scl_rise_ns = t->scl_rise_ns ?: 200;
-	t->scl_int_delay_ns = t->scl_int_delay_ns ?: 50;
+	t->bus_freq_hz = I2C_MAX_STANDARD_MODE_FREQ;
+	t->scl_fall_ns = 35;
+	t->scl_rise_ns = 200;
+	t->scl_int_delay_ns = 50;
+
+	i2c_parse_fw_timings(dev, &i2c_t, false);
 
 	switch (priv->devtype) {
 	case I2C_RCAR_GEN1:
@@ -920,7 +923,6 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	struct rcar_i2c_priv *priv;
 	struct i2c_adapter *adap;
 	struct device *dev = &pdev->dev;
-	struct i2c_timings i2c_t = {0};
 	int ret;
 
 	/* Otherwise logic will break because some bytes must always use PIO */
@@ -957,8 +959,6 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	i2c_set_adapdata(adap, priv);
 	strlcpy(adap->name, pdev->name, sizeof(adap->name));
 
-	i2c_parse_fw_timings(dev, &i2c_t, false);
-
 	/* Init DMA */
 	sg_init_table(&priv->sg, 1);
 	priv->dma_direction = DMA_NONE;
@@ -967,7 +967,7 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	/* Activate device for clock calculation */
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
-	ret = rcar_i2c_clock_calculate(priv, &i2c_t);
+	ret = rcar_i2c_clock_calculate(priv);
 	if (ret < 0)
 		goto out_pm_put;
 
-- 
2.25.1
