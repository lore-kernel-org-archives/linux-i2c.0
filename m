From: thor.thayer@linux.intel.com
Subject: [PATCHv3 1/4] ARM: dts: socfpga: Add Altera I2C Controller to CycloneV
Date: Fri,  2 Jun 2017 18:52:36 -0500
Message-ID: <1496447559-19782-2-git-send-email-thor.thayer@linux.intel.com>
References: <1496447559-19782-1-git-send-email-thor.thayer@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1496447559-19782-1-git-send-email-thor.thayer@linux.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org, thor.thayer@linux.intel.com
Cc: devicetree@vger.kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, mchehab@kernel.org, davem@davemloft.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add the Altera I2C Controller to the CycloneV SoCFPGA device tree.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
v2  Remove altr, from fifo-size.
    Rename compatible string to "altr,softip-i2c"
v3  Add version to commpatible string "altr,softip-i2c-v1.0"
---
 arch/arm/boot/dts/socfpga.dtsi               | 13 ++++++++++---
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts | 28 +++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index b2674bd..d69c13d 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -133,6 +133,13 @@
 					#address-cells = <1>;
 					#size-cells = <0>;
 
+					clk_0: clk_0 {
+						compatible = "fixed-clock";
+						#clock-cells = <0>;
+						clock-frequency = <50000000>;
+						clock-output-names = "clk_0-clk";
+					};
+
 					osc1: osc1 {
 						#clock-cells = <0>;
 						compatible = "fixed-clock";
@@ -529,11 +536,11 @@
 				};
 		};
 
-		fpga_bridge0: fpga_bridge@ff400000 {
+		fpga_bridge0: fpga_bridge@ff200000 {
 			compatible = "altr,socfpga-lwhps2fpga-bridge";
-			reg = <0xff400000 0x100000>;
+			reg = <0xff200000 0x00200000>;
 			resets = <&rst LWHPS2FPGA_RESET>;
-			clocks = <&l4_main_clk>;
+			clocks = <&clk_0>;
 		};
 
 		fpga_bridge1: fpga_bridge@ff500000 {
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
index 155829f..f99576b 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
@@ -68,6 +68,7 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
+
 };
 
 &can0 {
@@ -101,7 +102,7 @@
 };
 
 &i2c0 {
-	status = "okay";
+	status = "disabled";
 	clock-frequency = <100000>;
 
 	/*
@@ -176,3 +177,28 @@
 &usb1 {
 	status = "okay";
 };
+
+&fpga_bridge0 {
+	reg-names = "axi_h2f_lw";
+	#address-cells = <2>;
+	#size-cells = <1>;
+	ranges = <0x00000001 0x00080000 0xff280000 0x00000040>;
+
+	i2c_0: i2c@0x100080000 {
+		compatible = "altr,softip-i2c-v1.0";
+		reg = <0x00000001 0x00080000 0x00000040>;
+		interrupt-parent = <&intc>;
+		interrupts = <0 43 4>;
+		clocks = <&clk_0>;
+		fifo-size = <4>;
+		clock-frequency = <100000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		eeprom@51 {
+			compatible = "atmel,24c32";
+			reg = <0x51>;
+			pagesize = <32>;
+		};
+	};
+};
-- 
2.7.4
