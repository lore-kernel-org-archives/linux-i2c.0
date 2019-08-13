From: Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 02/13] ARM: dts: bcm283x: Move BCM2835/6/7 specific to
 bcm2835-common.dtsi
Date: Tue, 13 Aug 2019 18:20:37 +0200
Message-ID: <1565713248-4906-3-git-send-email-wahrenst@gmx.net>
References: <1565713248-4906-1-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1565713248-4906-1-git-send-email-wahrenst@gmx.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

As preparation we want all common BCM2711 + BCM2835/6/7 functions in
bcm283x.dtsi and all BCM2835/6/7 specific in the new
bcm2835-common.dtsi.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Acked-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm2835-common.dtsi | 183 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm2835.dtsi        |   1 +
 arch/arm/boot/dts/bcm2836.dtsi        |   1 +
 arch/arm/boot/dts/bcm2837.dtsi        |   1 +
 arch/arm/boot/dts/bcm283x.dtsi        | 164 +-----------------------------
 5 files changed, 187 insertions(+), 163 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2835-common.dtsi

diff --git a/arch/arm/boot/dts/bcm2835-common.dtsi b/arch/arm/boot/dts/bcm2835-common.dtsi
new file mode 100644
index 0000000..003bbb6
--- /dev/null
+++ b/arch/arm/boot/dts/bcm2835-common.dtsi
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* This include file covers the common peripherals and configuration between
+ * bcm2835, bcm2836 and bcm2837 implementations.
+ */
+
+/ {
+	interrupt-parent = <&intc>;
+
+	soc {
+		dma: dma@7e007000 {
+			compatible = "brcm,bcm2835-dma";
+			reg = <0x7e007000 0xf00>;
+			interrupts = <1 16>,
+				     <1 17>,
+				     <1 18>,
+				     <1 19>,
+				     <1 20>,
+				     <1 21>,
+				     <1 22>,
+				     <1 23>,
+				     <1 24>,
+				     <1 25>,
+				     <1 26>,
+				     /* dma channel 11-14 share one irq */
+				     <1 27>,
+				     <1 27>,
+				     <1 27>,
+				     <1 27>,
+				     /* unused shared irq for all channels */
+				     <1 28>;
+			interrupt-names = "dma0",
+					  "dma1",
+					  "dma2",
+					  "dma3",
+					  "dma4",
+					  "dma5",
+					  "dma6",
+					  "dma7",
+					  "dma8",
+					  "dma9",
+					  "dma10",
+					  "dma11",
+					  "dma12",
+					  "dma13",
+					  "dma14",
+					  "dma-shared-all";
+			#dma-cells = <1>;
+			brcm,dma-channel-mask = <0x7f35>;
+		};
+
+		intc: interrupt-controller@7e00b200 {
+			compatible = "brcm,bcm2835-armctrl-ic";
+			reg = <0x7e00b200 0x200>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		pm: watchdog@7e100000 {
+			compatible = "brcm,bcm2835-pm", "brcm,bcm2835-pm-wdt";
+			#power-domain-cells = <1>;
+			#reset-cells = <1>;
+			reg = <0x7e100000 0x114>,
+			      <0x7e00a000 0x24>;
+			clocks = <&clocks BCM2835_CLOCK_V3D>,
+				 <&clocks BCM2835_CLOCK_PERI_IMAGE>,
+				 <&clocks BCM2835_CLOCK_H264>,
+				 <&clocks BCM2835_CLOCK_ISP>;
+			clock-names = "v3d", "peri_image", "h264", "isp";
+			system-power-controller;
+		};
+
+		pixelvalve@7e206000 {
+			compatible = "brcm,bcm2835-pixelvalve0";
+			reg = <0x7e206000 0x100>;
+			interrupts = <2 13>; /* pwa0 */
+		};
+
+		pixelvalve@7e207000 {
+			compatible = "brcm,bcm2835-pixelvalve1";
+			reg = <0x7e207000 0x100>;
+			interrupts = <2 14>; /* pwa1 */
+		};
+
+		thermal: thermal@7e212000 {
+			compatible = "brcm,bcm2835-thermal";
+			reg = <0x7e212000 0x8>;
+			clocks = <&clocks BCM2835_CLOCK_TSENS>;
+			#thermal-sensor-cells = <0>;
+			status = "disabled";
+		};
+
+		pixelvalve@7e807000 {
+			compatible = "brcm,bcm2835-pixelvalve2";
+			reg = <0x7e807000 0x100>;
+			interrupts = <2 10>; /* pixelvalve */
+		};
+
+		hdmi: hdmi@7e902000 {
+			compatible = "brcm,bcm2835-hdmi";
+			reg = <0x7e902000 0x600>,
+			      <0x7e808000 0x100>;
+			interrupts = <2 8>, <2 9>;
+			ddc = <&i2c2>;
+			clocks = <&clocks BCM2835_PLLH_PIX>,
+				 <&clocks BCM2835_CLOCK_HSM>;
+			clock-names = "pixel", "hdmi";
+			dmas = <&dma 17>;
+			dma-names = "audio-rx";
+			status = "disabled";
+		};
+
+		v3d: v3d@7ec00000 {
+			compatible = "brcm,bcm2835-v3d";
+			reg = <0x7ec00000 0x1000>;
+			interrupts = <1 10>;
+		};
+
+		vc4: gpu {
+			compatible = "brcm,bcm2835-vc4";
+		};
+	};
+};
+
+&cpu_thermal {
+	thermal-sensors = <&thermal>;
+};
+
+&gpio {
+	i2c_slave_gpio18: i2c_slave_gpio18 {
+		brcm,pins = <18 19 20 21>;
+		brcm,function = <BCM2835_FSEL_ALT3>;
+	};
+
+	jtag_gpio4: jtag_gpio4 {
+		brcm,pins = <4 5 6 12 13>;
+		brcm,function = <BCM2835_FSEL_ALT5>;
+	};
+
+	pwm0_gpio12: pwm0_gpio12 {
+		brcm,pins = <12>;
+		brcm,function = <BCM2835_FSEL_ALT0>;
+	};
+	pwm0_gpio18: pwm0_gpio18 {
+		brcm,pins = <18>;
+		brcm,function = <BCM2835_FSEL_ALT5>;
+	};
+	pwm0_gpio40: pwm0_gpio40 {
+		brcm,pins = <40>;
+		brcm,function = <BCM2835_FSEL_ALT0>;
+	};
+	pwm1_gpio13: pwm1_gpio13 {
+		brcm,pins = <13>;
+		brcm,function = <BCM2835_FSEL_ALT0>;
+	};
+	pwm1_gpio19: pwm1_gpio19 {
+		brcm,pins = <19>;
+		brcm,function = <BCM2835_FSEL_ALT5>;
+	};
+	pwm1_gpio41: pwm1_gpio41 {
+		brcm,pins = <41>;
+		brcm,function = <BCM2835_FSEL_ALT0>;
+	};
+	pwm1_gpio45: pwm1_gpio45 {
+		brcm,pins = <45>;
+		brcm,function = <BCM2835_FSEL_ALT0>;
+	};
+};
+
+&i2s {
+	dmas = <&dma 2>, <&dma 3>;
+	dma-names = "tx", "rx";
+};
+
+&sdhost {
+	dmas = <&dma 13>;
+	dma-names = "rx-tx";
+};
+
+&spi {
+	dmas = <&dma 6>, <&dma 7>;
+	dma-names = "tx", "rx";
+};
diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index a5c3824..53bf457 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "bcm283x.dtsi"
+#include "bcm2835-common.dtsi"

 / {
 	compatible = "brcm,bcm2835";
diff --git a/arch/arm/boot/dts/bcm2836.dtsi b/arch/arm/boot/dts/bcm2836.dtsi
index c933e84..82d6c46 100644
--- a/arch/arm/boot/dts/bcm2836.dtsi
+++ b/arch/arm/boot/dts/bcm2836.dtsi
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "bcm283x.dtsi"
+#include "bcm2835-common.dtsi"

 / {
 	compatible = "brcm,bcm2836";
diff --git a/arch/arm/boot/dts/bcm2837.dtsi b/arch/arm/boot/dts/bcm2837.dtsi
index beb6c50..9e95fee 100644
--- a/arch/arm/boot/dts/bcm2837.dtsi
+++ b/arch/arm/boot/dts/bcm2837.dtsi
@@ -1,4 +1,5 @@
 #include "bcm283x.dtsi"
+#include "bcm2835-common.dtsi"

 / {
 	compatible = "brcm,bcm2837";
diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 2d191fc..cbc9422 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -18,7 +18,6 @@
 / {
 	compatible = "brcm,bcm2835";
 	model = "BCM2835";
-	interrupt-parent = <&intc>;
 	#address-cells = <1>;
 	#size-cells = <1>;

@@ -36,8 +35,6 @@
 			polling-delay-passive = <0>;
 			polling-delay = <1000>;

-			thermal-sensors = <&thermal>;
-
 			trips {
 				cpu-crit {
 					temperature	= <80000>;
@@ -73,68 +70,6 @@
 			interrupts = <1 11>;
 		};

-		dma: dma@7e007000 {
-			compatible = "brcm,bcm2835-dma";
-			reg = <0x7e007000 0xf00>;
-			interrupts = <1 16>,
-				     <1 17>,
-				     <1 18>,
-				     <1 19>,
-				     <1 20>,
-				     <1 21>,
-				     <1 22>,
-				     <1 23>,
-				     <1 24>,
-				     <1 25>,
-				     <1 26>,
-				     /* dma channel 11-14 share one irq */
-				     <1 27>,
-				     <1 27>,
-				     <1 27>,
-				     <1 27>,
-				     /* unused shared irq for all channels */
-				     <1 28>;
-			interrupt-names = "dma0",
-					  "dma1",
-					  "dma2",
-					  "dma3",
-					  "dma4",
-					  "dma5",
-					  "dma6",
-					  "dma7",
-					  "dma8",
-					  "dma9",
-					  "dma10",
-					  "dma11",
-					  "dma12",
-					  "dma13",
-					  "dma14",
-					  "dma-shared-all";
-			#dma-cells = <1>;
-			brcm,dma-channel-mask = <0x7f35>;
-		};
-
-		intc: interrupt-controller@7e00b200 {
-			compatible = "brcm,bcm2835-armctrl-ic";
-			reg = <0x7e00b200 0x200>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-
-		pm: watchdog@7e100000 {
-			compatible = "brcm,bcm2835-pm", "brcm,bcm2835-pm-wdt";
-			#power-domain-cells = <1>;
-			#reset-cells = <1>;
-			reg = <0x7e100000 0x114>,
-			      <0x7e00a000 0x24>;
-			clocks = <&clocks BCM2835_CLOCK_V3D>,
-				 <&clocks BCM2835_CLOCK_PERI_IMAGE>,
-				 <&clocks BCM2835_CLOCK_H264>,
-				 <&clocks BCM2835_CLOCK_ISP>;
-			clock-names = "v3d", "peri_image", "h264", "isp";
-			system-power-controller;
-		};
-
 		clocks: cprman@7e101000 {
 			compatible = "brcm,bcm2835-cprman";
 			#clock-cells = <1>;
@@ -184,8 +119,7 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;

-			/* Defines pin muxing groups according to
-			 * BCM2835-ARM-Peripherals.pdf page 102.
+			/* Defines common pin muxing groups
 			 *
 			 * While each pin can have its mux selected
 			 * for various functions individually, some
@@ -263,15 +197,7 @@
 				brcm,pins = <44 45>;
 				brcm,function = <BCM2835_FSEL_ALT2>;
 			};
-			i2c_slave_gpio18: i2c_slave_gpio18 {
-				brcm,pins = <18 19 20 21>;
-				brcm,function = <BCM2835_FSEL_ALT3>;
-			};

-			jtag_gpio4: jtag_gpio4 {
-				brcm,pins = <4 5 6 12 13>;
-				brcm,function = <BCM2835_FSEL_ALT5>;
-			};
 			jtag_gpio22: jtag_gpio22 {
 				brcm,pins = <22 23 24 25 26 27>;
 				brcm,function = <BCM2835_FSEL_ALT4>;
@@ -286,35 +212,6 @@
 				brcm,function = <BCM2835_FSEL_ALT2>;
 			};

-			pwm0_gpio12: pwm0_gpio12 {
-				brcm,pins = <12>;
-				brcm,function = <BCM2835_FSEL_ALT0>;
-			};
-			pwm0_gpio18: pwm0_gpio18 {
-				brcm,pins = <18>;
-				brcm,function = <BCM2835_FSEL_ALT5>;
-			};
-			pwm0_gpio40: pwm0_gpio40 {
-				brcm,pins = <40>;
-				brcm,function = <BCM2835_FSEL_ALT0>;
-			};
-			pwm1_gpio13: pwm1_gpio13 {
-				brcm,pins = <13>;
-				brcm,function = <BCM2835_FSEL_ALT0>;
-			};
-			pwm1_gpio19: pwm1_gpio19 {
-				brcm,pins = <19>;
-				brcm,function = <BCM2835_FSEL_ALT5>;
-			};
-			pwm1_gpio41: pwm1_gpio41 {
-				brcm,pins = <41>;
-				brcm,function = <BCM2835_FSEL_ALT0>;
-			};
-			pwm1_gpio45: pwm1_gpio45 {
-				brcm,pins = <45>;
-				brcm,function = <BCM2835_FSEL_ALT0>;
-			};
-
 			sdhost_gpio48: sdhost_gpio48 {
 				brcm,pins = <48 49 50 51 52 53>;
 				brcm,function = <BCM2835_FSEL_ALT0>;
@@ -410,8 +307,6 @@
 			reg = <0x7e202000 0x100>;
 			interrupts = <2 24>;
 			clocks = <&clocks BCM2835_CLOCK_VPU>;
-			dmas = <&dma 13>;
-			dma-names = "rx-tx";
 			status = "disabled";
 		};

@@ -419,10 +314,6 @@
 			compatible = "brcm,bcm2835-i2s";
 			reg = <0x7e203000 0x24>;
 			clocks = <&clocks BCM2835_CLOCK_PCM>;
-
-			dmas = <&dma 2>,
-			       <&dma 3>;
-			dma-names = "tx", "rx";
 			status = "disabled";
 		};

@@ -431,8 +322,6 @@
 			reg = <0x7e204000 0x200>;
 			interrupts = <2 22>;
 			clocks = <&clocks BCM2835_CLOCK_VPU>;
-			dmas = <&dma 6>, <&dma 7>;
-			dma-names = "tx", "rx";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -448,18 +337,6 @@
 			status = "disabled";
 		};

-		pixelvalve@7e206000 {
-			compatible = "brcm,bcm2835-pixelvalve0";
-			reg = <0x7e206000 0x100>;
-			interrupts = <2 13>; /* pwa0 */
-		};
-
-		pixelvalve@7e207000 {
-			compatible = "brcm,bcm2835-pixelvalve1";
-			reg = <0x7e207000 0x100>;
-			interrupts = <2 14>; /* pwa1 */
-		};
-
 		dpi: dpi@7e208000 {
 			compatible = "brcm,bcm2835-dpi";
 			reg = <0x7e208000 0x8c>;
@@ -490,14 +367,6 @@

 		};

-		thermal: thermal@7e212000 {
-			compatible = "brcm,bcm2835-thermal";
-			reg = <0x7e212000 0x8>;
-			clocks = <&clocks BCM2835_CLOCK_TSENS>;
-			#thermal-sensor-cells = <0>;
-			status = "disabled";
-		};
-
 		aux: aux@7e215000 {
 			compatible = "brcm,bcm2835-aux";
 			#clock-cells = <1>;
@@ -605,26 +474,6 @@
 			status = "disabled";
 		};

-		pixelvalve@7e807000 {
-			compatible = "brcm,bcm2835-pixelvalve2";
-			reg = <0x7e807000 0x100>;
-			interrupts = <2 10>; /* pixelvalve */
-		};
-
-		hdmi: hdmi@7e902000 {
-			compatible = "brcm,bcm2835-hdmi";
-			reg = <0x7e902000 0x600>,
-			      <0x7e808000 0x100>;
-			interrupts = <2 8>, <2 9>;
-			ddc = <&i2c2>;
-			clocks = <&clocks BCM2835_PLLH_PIX>,
-				 <&clocks BCM2835_CLOCK_HSM>;
-			clock-names = "pixel", "hdmi";
-			dmas = <&dma 17>;
-			dma-names = "audio-rx";
-			status = "disabled";
-		};
-
 		usb: usb@7e980000 {
 			compatible = "brcm,bcm2835-usb";
 			reg = <0x7e980000 0x10000>;
@@ -636,17 +485,6 @@
 			phys = <&usbphy>;
 			phy-names = "usb2-phy";
 		};
-
-		v3d: v3d@7ec00000 {
-			compatible = "brcm,bcm2835-v3d";
-			reg = <0x7ec00000 0x1000>;
-			interrupts = <1 10>;
-			power-domains = <&pm BCM2835_POWER_DOMAIN_GRAFX_V3D>;
-		};
-
-		vc4: gpu {
-			compatible = "brcm,bcm2835-vc4";
-		};
 	};

 	clocks {
--
2.7.4
