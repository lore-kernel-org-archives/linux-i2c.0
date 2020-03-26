From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH] i2c: refactor parsing of timings
Date: Thu, 26 Mar 2020 11:16:47 +0100
Message-ID: <20200326101647.1756-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:48566 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgCZKQ5 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 26 Mar 2020 06:16:57 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

When I wanted to print the chosen values to debug output, I concluded
that a helper function to parse one timing would be helpful.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

I am not entirely happy because 'dev' and 'u' is the same for each call.
Then again, we can't use a for-loop over an array of parameters, because
some default values depend on previously obtained timings.

Looking for opinions here...

 drivers/i2c/i2c-core-base.c | 78 ++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 40 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 474baaf8c9e7..60b0aa246af2 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1609,6 +1609,18 @@ void i2c_del_adapter(struct i2c_adapter *adap)
 }
 EXPORT_SYMBOL(i2c_del_adapter);
 
+static void i2c_parse_timing(struct device *dev, char *prop_name, u32 *cur_val_p,
+			    u32 def_val, bool use_def)
+{
+	int ret;
+
+	ret = device_property_read_u32(dev, prop_name, cur_val_p);
+	if (ret && use_def)
+		*cur_val_p = def_val;
+
+	dev_dbg(dev, "%s: %u\n", prop_name, *cur_val_p);
+}
+
 /**
  * i2c_parse_fw_timings - get I2C related timing parameters from firmware
  * @dev: The device to scan for I2C timing properties
@@ -1627,49 +1639,35 @@ EXPORT_SYMBOL(i2c_del_adapter);
  */
 void i2c_parse_fw_timings(struct device *dev, struct i2c_timings *t, bool use_defaults)
 {
-	int ret;
-
-	ret = device_property_read_u32(dev, "clock-frequency", &t->bus_freq_hz);
-	if (ret && use_defaults)
-		t->bus_freq_hz = I2C_MAX_STANDARD_MODE_FREQ;
-
-	ret = device_property_read_u32(dev, "i2c-scl-rising-time-ns", &t->scl_rise_ns);
-	if (ret && use_defaults) {
-		if (t->bus_freq_hz <= I2C_MAX_STANDARD_MODE_FREQ)
-			t->scl_rise_ns = 1000;
-		else if (t->bus_freq_hz <= I2C_MAX_FAST_MODE_FREQ)
-			t->scl_rise_ns = 300;
-		else
-			t->scl_rise_ns = 120;
-	}
-
-	ret = device_property_read_u32(dev, "i2c-scl-falling-time-ns", &t->scl_fall_ns);
-	if (ret && use_defaults) {
-		if (t->bus_freq_hz <= I2C_MAX_FAST_MODE_FREQ)
-			t->scl_fall_ns = 300;
-		else
-			t->scl_fall_ns = 120;
-	}
+	bool u = use_defaults;
+	u32 d;
 
-	ret = device_property_read_u32(dev, "i2c-scl-internal-delay-ns", &t->scl_int_delay_ns);
-	if (ret && use_defaults)
-		t->scl_int_delay_ns = 0;
+	i2c_parse_timing(dev, "clock-frequency", &t->bus_freq_hz,
+			 I2C_MAX_STANDARD_MODE_FREQ, u);
 
-	ret = device_property_read_u32(dev, "i2c-sda-falling-time-ns", &t->sda_fall_ns);
-	if (ret && use_defaults)
-		t->sda_fall_ns = t->scl_fall_ns;
-
-	ret = device_property_read_u32(dev, "i2c-sda-hold-time-ns", &t->sda_hold_ns);
-	if (ret && use_defaults)
-		t->sda_hold_ns = 0;
-
-	ret = device_property_read_u32(dev, "i2c-digital-filter-width-ns", &t->digital_filter_width_ns);
-	if (ret && use_defaults)
-		t->digital_filter_width_ns = 0;
+	if (t->bus_freq_hz <= I2C_MAX_STANDARD_MODE_FREQ)
+		d = 1000;
+	else if (t->bus_freq_hz <= I2C_MAX_FAST_MODE_FREQ)
+		d = 300;
+	else
+		d = 120;
+	i2c_parse_timing(dev, "i2c-scl-rising-time-ns", &t->scl_rise_ns, d, u);
 
-	ret = device_property_read_u32(dev, "i2c-analog-filter-cutoff-frequency", &t->analog_filter_cutoff_freq_hz);
-	if (ret && use_defaults)
-		t->analog_filter_cutoff_freq_hz = 0;
+	if (t->bus_freq_hz <= I2C_MAX_FAST_MODE_FREQ)
+		d = 300;
+	else
+		d = 120;
+	i2c_parse_timing(dev, "i2c-scl-falling-time-ns", &t->scl_fall_ns, d, u);
+
+	i2c_parse_timing(dev, "i2c-scl-internal-delay-ns",
+			 &t->scl_int_delay_ns, 0, u);
+	i2c_parse_timing(dev, "i2c-sda-falling-time-ns", &t->sda_fall_ns,
+			 t->scl_fall_ns, u);
+	i2c_parse_timing(dev, "i2c-sda-hold-time-ns", &t->sda_hold_ns, 0, u);
+	i2c_parse_timing(dev, "i2c-digital-filter-width-ns",
+			 &t->digital_filter_width_ns, 0, u);
+	i2c_parse_timing(dev, "i2c-analog-filter-cutoff-frequency",
+			 &t->analog_filter_cutoff_freq_hz, 0, u);
 }
 EXPORT_SYMBOL_GPL(i2c_parse_fw_timings);
 
-- 
2.20.1
