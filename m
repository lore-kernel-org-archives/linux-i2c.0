From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 5/6] MIPS: dts: mscc: Add i2c on ocelot
Date: Mon,  6 Aug 2018 20:54:11 +0200
Message-ID: <20180806185412.7210-6-alexandre.belloni@bootlin.com>
References: <20180806185412.7210-1-alexandre.belloni@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180806185412.7210-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Hogan <jhogan@kernel.org>
Cc: Paul Burton <paul.burton@mips.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Allan Nielsen <allan.nielsen@microsemi.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>
List-Id: linux-i2c@vger.kernel.org

Ocelot has an i2c controller, add it. There is only one possible pinmux
configuration so add it as well.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/mips/boot/dts/mscc/ocelot.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
index 4f33dbc67348..34093acebc0d 100644
--- a/arch/mips/boot/dts/mscc/ocelot.dtsi
+++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
@@ -78,6 +78,19 @@
 			status = "disabled";
 		};
 
+		i2c: i2c@100400 {
+			compatible = "mscc,ocelot-i2c", "snps,designware-i2c";
+			pinctrl-0 = <&i2c_pins>;
+			pinctrl-names = "default";
+			reg = <0x100400 0x100>, <0x198 0x8>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <8>;
+			clocks = <&ahb_clk>;
+
+			status = "disabled";
+		};
+
 		uart2: serial@100800 {
 			pinctrl-0 = <&uart2_pins>;
 			pinctrl-names = "default";
@@ -178,6 +191,11 @@
 				pins = "GPIO_12", "GPIO_13";
 				function = "uart2";
 			};
+
+			i2c_pins: i2c-pins {
+				pins = "GPIO_16", "GPIO_17";
+				function = "twi";
+			};
 		};
 
 		mdio0: mdio@107009c {
-- 
2.18.0
