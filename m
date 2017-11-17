From: Yixun Lan <yixun.lan@amlogic.com>
Subject: [PATCH 4/5] ARM64: dts: meson-axg: describe pin DT info for I2C controller
Date: Fri, 17 Nov 2017 16:02:35 +0800
Message-ID: <20171117080236.32504-5-yixun.lan@amlogic.com>
References: <20171117080236.32504-1-yixun.lan@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-sh2.amlogic.com ([58.32.228.45]:57064 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965059AbdKQIDQ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 17 Nov 2017 03:03:16 -0500
In-Reply-To: <20171117080236.32504-1-yixun.lan@amlogic.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <carlo@caione.org>, Yixun Lan <yixun.lan@amlogic.com>, Jian Hu <jian.hu@amlogic.com>, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

From: Jian Hu <jian.hu@amlogic.com>

Describe all the pin mux for the I2C controller which found in
Meson-AXG SoC.

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 64 ++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 99e967aff439..edbfd6022078 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -304,6 +304,70 @@
 						function = "eth";
 					};
 				};
+
+				i2c_m0_pins: i2c_m0 {
+					mux {
+						groups = "i2c_sck_m0",
+							"i2c_sda_m0";
+						function = "i2c_m0";
+					};
+				};
+
+				i2c_m1_z_pins: i2c_m1_z {
+					mux {
+						groups = "i2c_sck_m1_z",
+							"i2c_sda_m1_z";
+						function = "i2c_m1";
+					};
+				};
+
+				i2c_m1_x_pins: i2c_m1_x {
+					mux {
+						groups = "i2c_sck_m1_x",
+							"i2c_sda_m1_x";
+						function = "i2c_m1";
+					};
+				};
+
+				i2c_m2_x_pins: i2c_m2_x {
+					mux {
+						groups = "i2c_sck_m2_x",
+							"i2c_sda_m2_x";
+						function = "i2c_m2";
+					};
+				};
+
+				i2c_m2_a_pins: i2c_m2_a {
+					mux {
+						groups = "i2c_sck_m2_a",
+							"i2c_sda_m2_a";
+						function = "i2c_m2";
+					};
+				};
+
+				i2c_m3_a6_pins: i2c_m3_a6 {
+					mux {
+						groups = "i2c_sda_m3_a6",
+							"i2c_sck_m3_a7";
+						function = "i2c_m3";
+					};
+				};
+
+				i2c_m3_a12_pins: i2c_m3_a12 {
+					mux {
+						groups = "i2c_sda_m3_a12",
+							"i2c_sck_m3_a13";
+						function = "i2c_m3";
+					};
+				};
+
+				i2c_m3_a19_pins: i2c_m3_a19 {
+					mux {
+						groups = "i2c_sda_m3_a19",
+							"i2c_sck_m3_a20";
+						function = "i2c_m3";
+					};
+				};
 			};
 		};
 
-- 
2.14.1
