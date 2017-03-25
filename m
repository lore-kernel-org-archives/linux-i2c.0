From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v5 04/10] i2c: meson: use i2c core for DT clock-frequency
 parsing
Date: Sat, 25 Mar 2017 14:06:35 +0100
Message-ID: <e051fc67-3747-b84b-220d-6a2d26c465f8@gmail.com>
References: <645519b8-93e6-57b1-ae8f-7804c6beb9b1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33376 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750718AbdCYNOj (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 25 Mar 2017 09:14:39 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11so2860221wma.0
        for <linux-i2c@vger.kernel.org>; Sat, 25 Mar 2017 06:14:37 -0700 (PDT)
In-Reply-To: <645519b8-93e6-57b1-ae8f-7804c6beb9b1@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-amlogic@lists.infradead.org

We don't have to parse the DT manually to retrieve the bus frequency
and we don't have to maintain an own default for the bus frequency.
Let the i2c core do this for us.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
---
v2:
- added Reviewed-by
v3:
- changed order of patches
v4:
- update DT binding documentation
v5:
- remove unused properties from binding documentation
---
 Documentation/devicetree/bindings/i2c/i2c-meson.txt | 2 ++
 drivers/i2c/busses/i2c-meson.c                      | 8 +++-----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-meson.txt b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
index 386357d1..611b934c 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-meson.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
@@ -8,6 +8,8 @@ Required properties:
  - #address-cells: should be <1>
  - #size-cells: should be <0>
 
+For details regarding the following core I2C bindings see also i2c.txt.
+
 Optional properties:
 - clock-frequency: the desired I2C bus clock frequency in Hz; in
   absence of this property the default value is used (100 kHz).
diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
index e597764e..ac0ac82d 100644
--- a/drivers/i2c/busses/i2c-meson.c
+++ b/drivers/i2c/busses/i2c-meson.c
@@ -38,7 +38,6 @@
 #define REG_CTRL_CLKDIV_MASK	((BIT(10) - 1) << REG_CTRL_CLKDIV_SHIFT)
 
 #define I2C_TIMEOUT_MS		500
-#define DEFAULT_FREQ		100000
 
 enum {
 	TOKEN_END = 0,
@@ -387,15 +386,14 @@ static int meson_i2c_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct meson_i2c *i2c;
 	struct resource *mem;
-	u32 freq;
+	struct i2c_timings timings;
 	int irq, ret = 0;
 
 	i2c = devm_kzalloc(&pdev->dev, sizeof(struct meson_i2c), GFP_KERNEL);
 	if (!i2c)
 		return -ENOMEM;
 
-	if (of_property_read_u32(pdev->dev.of_node, "clock-frequency", &freq))
-		freq = DEFAULT_FREQ;
+	i2c_parse_fw_timings(&pdev->dev, &timings, true);
 
 	i2c->dev = &pdev->dev;
 	platform_set_drvdata(pdev, i2c);
@@ -453,7 +451,7 @@ static int meson_i2c_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	meson_i2c_set_clk_div(i2c, freq);
+	meson_i2c_set_clk_div(i2c, timings.bus_freq_hz);
 
 	return 0;
 }
-- 
2.12.0
