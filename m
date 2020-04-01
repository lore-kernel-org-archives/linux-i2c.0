From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] i2c: refactor parsing of timings
Date: Wed,  1 Apr 2020 21:30:18 +0200
Message-ID: <20200401193018.368-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

When I wanted to print the chosen values to debug output, I concluded
that a helper function to parse one timing would be helpful.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Not RFC anymore because it seems we agreed on the approach. Only change
since RFC is the use of the ternary operator (Thanks, Geert!). Also
thanks to Andy for the idea of a seperate helper to get the bus
frequency. This will be a seperate patchset, though.

Tested on a Renesas Lager board (R-Car H2).

 drivers/i2c/i2c-core-base.c | 69 ++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 39 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 474baaf8c9e7..be73b498cf64 100644
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
@@ -1627,49 +1639,28 @@ EXPORT_SYMBOL(i2c_del_adapter);
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
-
-	ret = device_property_read_u32(dev, "i2c-scl-internal-delay-ns", &t->scl_int_delay_ns);
-	if (ret && use_defaults)
-		t->scl_int_delay_ns = 0;
+	bool u = use_defaults;
+	u32 d;
 
-	ret = device_property_read_u32(dev, "i2c-sda-falling-time-ns", &t->sda_fall_ns);
-	if (ret && use_defaults)
-		t->sda_fall_ns = t->scl_fall_ns;
+	i2c_parse_timing(dev, "clock-frequency", &t->bus_freq_hz,
+			 I2C_MAX_STANDARD_MODE_FREQ, u);
 
-	ret = device_property_read_u32(dev, "i2c-sda-hold-time-ns", &t->sda_hold_ns);
-	if (ret && use_defaults)
-		t->sda_hold_ns = 0;
+	d = t->bus_freq_hz <= I2C_MAX_STANDARD_MODE_FREQ ? 1000 :
+	    t->bus_freq_hz <= I2C_MAX_FAST_MODE_FREQ ? 300 : 120;
+	i2c_parse_timing(dev, "i2c-scl-rising-time-ns", &t->scl_rise_ns, d, u);
 
-	ret = device_property_read_u32(dev, "i2c-digital-filter-width-ns", &t->digital_filter_width_ns);
-	if (ret && use_defaults)
-		t->digital_filter_width_ns = 0;
+	d = t->bus_freq_hz <= I2C_MAX_FAST_MODE_FREQ ? 300 : 120;
+	i2c_parse_timing(dev, "i2c-scl-falling-time-ns", &t->scl_fall_ns, d, u);
 
-	ret = device_property_read_u32(dev, "i2c-analog-filter-cutoff-frequency", &t->analog_filter_cutoff_freq_hz);
-	if (ret && use_defaults)
-		t->analog_filter_cutoff_freq_hz = 0;
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
