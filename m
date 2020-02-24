From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 03/40] i2c: core: Use generic definitions for bus frequencies
Date: Mon, 24 Feb 2020 17:14:53 +0200
Message-ID: <20200224151530.31713-3-andriy.shevchenko@linux.intel.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62974 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728008AbgBXPPo (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Feb 2020 10:15:44 -0500
In-Reply-To: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

Since we have generic definitions for bus frequencies, let's use them.

Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/i2c-core-acpi.c | 2 +-
 drivers/i2c/i2c-core-base.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 8f3dbc97a057..b52d2d8f7258 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -318,7 +318,7 @@ static acpi_status i2c_acpi_lookup_speed(acpi_handle handle, u32 level,
 		lookup->min_speed = lookup->speed;
 
 	if (acpi_match_device_ids(adev, i2c_acpi_force_400khz_device_ids) == 0)
-		lookup->force_speed = 400000;
+		lookup->force_speed = I2C_FAST_MODE_FREQ;
 
 	return AE_OK;
 }
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index cefad0881942..1116d0e2de6d 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1612,13 +1612,13 @@ void i2c_parse_fw_timings(struct device *dev, struct i2c_timings *t, bool use_de
 
 	ret = device_property_read_u32(dev, "clock-frequency", &t->bus_freq_hz);
 	if (ret && use_defaults)
-		t->bus_freq_hz = 100000;
+		t->bus_freq_hz = I2C_STANDARD_MODE_FREQ;
 
 	ret = device_property_read_u32(dev, "i2c-scl-rising-time-ns", &t->scl_rise_ns);
 	if (ret && use_defaults) {
-		if (t->bus_freq_hz <= 100000)
+		if (t->bus_freq_hz <= I2C_STANDARD_MODE_FREQ)
 			t->scl_rise_ns = 1000;
-		else if (t->bus_freq_hz <= 400000)
+		else if (t->bus_freq_hz <= I2C_FAST_MODE_FREQ)
 			t->scl_rise_ns = 300;
 		else
 			t->scl_rise_ns = 120;
@@ -1626,7 +1626,7 @@ void i2c_parse_fw_timings(struct device *dev, struct i2c_timings *t, bool use_de
 
 	ret = device_property_read_u32(dev, "i2c-scl-falling-time-ns", &t->scl_fall_ns);
 	if (ret && use_defaults) {
-		if (t->bus_freq_hz <= 400000)
+		if (t->bus_freq_hz <= I2C_FAST_MODE_FREQ)
 			t->scl_fall_ns = 300;
 		else
 			t->scl_fall_ns = 120;
-- 
2.25.0
