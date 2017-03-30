From: Sam Povilus <kernel.development@povil.us>
Subject: [PATCH v6] hwmon: ads7828 optional parameters from the device tree
Date: Wed, 29 Mar 2017 21:46:37 -0600
Message-ID: <20170330034637.29708-1-kernel.development@povil.us>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:33551 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932685AbdC3Dqt (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 29 Mar 2017 23:46:49 -0400
Received: by mail-it0-f68.google.com with SMTP id w11so4424730itb.0
        for <linux-i2c@vger.kernel.org>; Wed, 29 Mar 2017 20:46:48 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: Sam Povilus <kernel.development@povil.us>

Adding the ability for the ads7828 and ads7830 to use the device tree to
get their optional parameters, instead of using platform devices. This
allows people using custom boards to also use the ads7828 in a non-default
manner.

v2: conforming to coding style
v3: changing from "_" to "-" for device tree entries
v4: using regulator subsystem for voltage source, renaming differential
    input property
v5: checking for invalid vref values sooner and returning error if they are
    bad, not warning user.
v6: optimization per Guenter Roeck

Signed-off-by: Sam Povilus <kernel.development@povil.us>
---
 .../devicetree/bindings/hwmon/ads7828.txt          | 26 ++++++++++++++++++++++
 drivers/hwmon/ads7828.c                            | 15 +++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ads7828.txt

diff --git a/Documentation/devicetree/bindings/hwmon/ads7828.txt b/Documentation/devicetree/bindings/hwmon/ads7828.txt
new file mode 100644
index 000000000000..a1251b19079d
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ads7828.txt
@@ -0,0 +1,26 @@
+ads7828 properties
+
+Required properties:
+- compatible: Should be one of
+	       ti,ads7828
+	       ti,ads7830
+- reg: I2C address
+
+Optional properties:
+
+- ti,differential-input
+  Set to use the device in differential mode.
+- vref
+  The external reference on the device is set to this regulators output. If it
+  does not exists the internal reference will be used and output by the ads78xx
+  on the "external vref" pin.
+
+  Example ADS7828 node:
+
+  ads7828: ads@48 {
+  	   comatible = "ti,ads7828";
+	   reg = <0x48>;
+	   vref-supply = <&vref>;
+	   ti,differential-input;
+  };
+
diff --git a/drivers/hwmon/ads7828.c b/drivers/hwmon/ads7828.c
index ee396ff167d9..88330a233b1d 100644
--- a/drivers/hwmon/ads7828.c
+++ b/drivers/hwmon/ads7828.c
@@ -34,6 +34,7 @@
 #include <linux/platform_data/ads7828.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/regulator/consumer.h>
 
 /* The ADS7828 registers */
 #define ADS7828_CMD_SD_SE	0x80	/* Single ended inputs */
@@ -118,9 +119,11 @@ static int ads7828_probe(struct i2c_client *client,
 	struct ads7828_data *data;
 	struct device *hwmon_dev;
 	unsigned int vref_mv = ADS7828_INT_VREF_MV;
+	unsigned int vref_uv;
 	bool diff_input = false;
 	bool ext_vref = false;
 	unsigned int regval;
+	struct regulator *reg;
 
 	data = devm_kzalloc(dev, sizeof(struct ads7828_data), GFP_KERNEL);
 	if (!data)
@@ -131,6 +134,18 @@ static int ads7828_probe(struct i2c_client *client,
 		ext_vref = pdata->ext_vref;
 		if (ext_vref && pdata->vref_mv)
 			vref_mv = pdata->vref_mv;
+	} else if (dev->of_node) {
+		diff_input = of_property_read_bool(dev->of_node,
+						   "ti,differential-input");
+		reg = devm_regulator_get_optional(dev, "vref");
+		if (!IS_ERR(reg)) {
+			vref_uv = regulator_get_voltage(reg);
+			vref_mv = DIV_ROUND_CLOSEST(vref_uv, 1000);
+			if (vref_mv < ADS7828_EXT_VREF_MV_MIN ||
+			    vref_mv > ADS7828_EXT_VREF_MV_MAX)
+				return -EINVAL;
+			ext_vref = true;
+		}
 	}
 
 	/* Bound Vref with min/max values */
-- 
2.11.0
