From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 1/6] i2c: core: Provide generic definitions for bus frequencies
Date: Tue, 24 Mar 2020 14:32:11 +0200
Message-ID: <20200324123216.78113-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:45700 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727480AbgCXMcZ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 24 Mar 2020 08:32:25 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

There are few maximum bus frequencies being used in the I²C core code.
Provide generic definitions for bus frequencies and use them in the core.

The drivers may use predefined constants where it is appropriate.
Some of them are already using these under slightly different names.
We will convert them later to use newly introduced defines.

Note, the name of modes are chosen to follow well established naming
scheme [1].

These definitions will also help to avoid typos in the numbers that
may lead to subtle errors.

[1]: https://en.wikipedia.org/wiki/I%C2%B2C#Differences_between_modes

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v5: no changes
 drivers/i2c/i2c-core-acpi.c | 2 +-
 drivers/i2c/i2c-core-base.c | 8 ++++----
 include/linux/i2c.h         | 8 ++++++++
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 8b0ff780919b..c8f42f2037cb 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -318,7 +318,7 @@ static acpi_status i2c_acpi_lookup_speed(acpi_handle handle, u32 level,
 		lookup->min_speed = lookup->speed;
 
 	if (acpi_match_device_ids(adev, i2c_acpi_force_400khz_device_ids) == 0)
-		lookup->force_speed = 400000;
+		lookup->force_speed = I2C_MAX_FAST_MODE_FREQ;
 
 	return AE_OK;
 }
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index cefad0881942..9b2972c7faa2 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1612,13 +1612,13 @@ void i2c_parse_fw_timings(struct device *dev, struct i2c_timings *t, bool use_de
 
 	ret = device_property_read_u32(dev, "clock-frequency", &t->bus_freq_hz);
 	if (ret && use_defaults)
-		t->bus_freq_hz = 100000;
+		t->bus_freq_hz = I2C_MAX_STANDARD_MODE_FREQ;
 
 	ret = device_property_read_u32(dev, "i2c-scl-rising-time-ns", &t->scl_rise_ns);
 	if (ret && use_defaults) {
-		if (t->bus_freq_hz <= 100000)
+		if (t->bus_freq_hz <= I2C_MAX_STANDARD_MODE_FREQ)
 			t->scl_rise_ns = 1000;
-		else if (t->bus_freq_hz <= 400000)
+		else if (t->bus_freq_hz <= I2C_MAX_FAST_MODE_FREQ)
 			t->scl_rise_ns = 300;
 		else
 			t->scl_rise_ns = 120;
@@ -1626,7 +1626,7 @@ void i2c_parse_fw_timings(struct device *dev, struct i2c_timings *t, bool use_de
 
 	ret = device_property_read_u32(dev, "i2c-scl-falling-time-ns", &t->scl_fall_ns);
 	if (ret && use_defaults) {
-		if (t->bus_freq_hz <= 400000)
+		if (t->bus_freq_hz <= I2C_MAX_FAST_MODE_FREQ)
 			t->scl_fall_ns = 300;
 		else
 			t->scl_fall_ns = 120;
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index f834687989f7..72e759328cee 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -39,6 +39,14 @@ enum i2c_slave_event;
 typedef int (*i2c_slave_cb_t)(struct i2c_client *client,
 			      enum i2c_slave_event event, u8 *val);
 
+/* I2C Frequency Modes */
+#define I2C_MAX_STANDARD_MODE_FREQ	100000
+#define I2C_MAX_FAST_MODE_FREQ		400000
+#define I2C_MAX_FAST_MODE_PLUS_FREQ	1000000
+#define I2C_MAX_TURBO_MODE_FREQ		1400000
+#define I2C_MAX_HIGH_SPEED_MODE_FREQ	3400000
+#define I2C_MAX_ULTRA_FAST_MODE_FREQ	5000000
+
 struct module;
 struct property_entry;
 
-- 
2.25.1
