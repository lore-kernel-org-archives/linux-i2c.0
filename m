From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v5 6/7] MIPS: dts: mscc: Add i2c on ocelot
Date: Fri, 31 Aug 2018 17:11:13 +0200
Message-ID: <20180831151114.25739-7-alexandre.belloni@bootlin.com>
References: <20180831151114.25739-1-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180831151114.25739-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Allan Nielsen <allan.nielsen@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>
List-Id: linux-i2c@vger.kernel.org

Ocelot has an i2c controller, add it. There is only one possible pinmux
configuration so add it as well.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/mips/boot/dts/mscc/ocelot.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
index f7eb612b46ba..99a9e8555087 100644
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
@@ -183,6 +196,11 @@
 			interrupts = <13>;
 			#interrupt-cells = <2>;
 
+			i2c_pins: i2c-pins {
+				pins = "GPIO_16", "GPIO_17";
+				function = "twi";
+			};
+
 			uart_pins: uart-pins {
 				pins = "GPIO_6", "GPIO_7";
 				function = "uart";
@@ -197,6 +215,7 @@
 				pins = "GPIO_14", "GPIO_15";
 				function = "miim1";
 			};
+
 		};
 
 		mdio0: mdio@107009c {
-- 
2.19.0.rc1
