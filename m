From: <ludovic.desroches@atmel.com>
Subject: [PATCH 7/8] ARM: dts: add twi nodes for atmel SOCs
Date: Fri, 31 Aug 2012 11:24:37 +0200
Message-ID: <1346405077-18620-1-git-send-email-ludovic.desroches@atmel.com>
References: <1346404884-18451-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1346404884-18451-1-git-send-email-ludovic.desroches@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: plagnioj@jcrosoft.com, n.voss@weinmann.de, nicolas.ferre@atmel.com, Ludovic Desroches <ludovic.desroches@atmel.com>
List-Id: linux-i2c@vger.kernel.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Add twi nodes for atmel SOCs and remove i2c-gpio ones.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi | 23 ++++++-------
 arch/arm/boot/dts/at91sam9263.dtsi | 23 ++++++-------
 arch/arm/boot/dts/at91sam9g20.dtsi |  4 +++
 arch/arm/boot/dts/at91sam9g45.dtsi | 33 +++++++++++-------
 arch/arm/boot/dts/at91sam9n12.dtsi | 33 +++++++++++-------
 arch/arm/boot/dts/at91sam9x5.dtsi  | 69 +++++++++++++++++---------------------
 6 files changed, 94 insertions(+), 91 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 66389c1..8128963 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -28,6 +28,7 @@
 		gpio2 = &pioC;
 		tcb0 = &tcb0;
 		tcb1 = &tcb1;
+		i2c0 = &i2c0;
 	};
 	cpus {
 		cpu@0 {
@@ -199,6 +200,15 @@
 				status = "disabled";
 			};
 
+			i2c0: i2c@fffac000 {
+				compatible = "atmel,at91sam9260-i2c";
+				reg = <0xfffac000 0x100>;
+				interrupts = <11 4 6>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			adc0: adc@fffe0000 {
 				compatible = "atmel,at91sam9260-adc";
 				reg = <0xfffe0000 0x100>;
@@ -258,17 +268,4 @@
 			status = "disabled";
 		};
 	};
-
-	i2c@0 {
-		compatible = "i2c-gpio";
-		gpios = <&pioA 23 0 /* sda */
-			 &pioA 24 0 /* scl */
-			>;
-		i2c-gpio,sda-open-drain;
-		i2c-gpio,scl-open-drain;
-		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "disabled";
-	};
 };
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index b460d6c..34dd4f5 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -24,6 +24,7 @@
 		gpio3 = &pioD;
 		gpio4 = &pioE;
 		tcb0 = &tcb0;
+		i2c0 = &i2c0;
 	};
 	cpus {
 		cpu@0 {
@@ -180,6 +181,15 @@
 				interrupts = <24 4 2>;
 				status = "disabled";
 			};
+
+			i2c0: i2c@fff88000 {
+				compatible = "atmel,at91sam9263-i2c";
+				reg = <0xfff88000 0x100>;
+				interrupts = <13 4 6>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand@40000000 {
@@ -205,17 +215,4 @@
 			status = "disabled";
 		};
 	};
-
-	i2c@0 {
-		compatible = "i2c-gpio";
-		gpios = <&pioB 4 0 /* sda */
-			 &pioB 5 0 /* scl */
-			>;
-		i2c-gpio,sda-open-drain;
-		i2c-gpio,scl-open-drain;
-		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "disabled";
-	};
 };
diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index 2a1d1ca..75ce6e7 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -18,6 +18,10 @@
 
 	ahb {
 		apb {
+			i2c0: i2c@fffac000 {
+				compatible = "atmel,at91sam9g20-i2c";
+			};
+
 			adc0: adc@fffe0000 {
 				atmel,adc-startup-time = <40>;
 			};
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index bafa880..e06cb8a 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -29,6 +29,8 @@
 		gpio4 = &pioE;
 		tcb0 = &tcb0;
 		tcb1 = &tcb1;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
 	};
 	cpus {
 		cpu@0 {
@@ -201,6 +203,24 @@
 				status = "disabled";
 			};
 
+			i2c0: i2c@fff84000 {
+				compatible = "atmel,at91sam9g10-i2c";
+				reg = <0xfff84000 0x100>;
+				interrupts = <12 4 6>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c1: i2c@fff88000 {
+				compatible = "atmel,at91sam9g10-i2c";
+				reg = <0xfff88000 0x100>;
+				interrupts = <13 4 6>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			adc0: adc@fffb0000 {
 				compatible = "atmel,at91sam9260-adc";
 				reg = <0xfffb0000 0x100>;
@@ -269,17 +289,4 @@
 			status = "disabled";
 		};
 	};
-
-	i2c@0 {
-		compatible = "i2c-gpio";
-		gpios = <&pioA 20 0 /* sda */
-			 &pioA 21 0 /* scl */
-			>;
-		i2c-gpio,sda-open-drain;
-		i2c-gpio,scl-open-drain;
-		i2c-gpio,delay-us = <5>;	/* ~100 kHz */
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "disabled";
-	};
 };
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index bfac0df..0c05bb9 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -26,6 +26,8 @@
 		gpio3 = &pioD;
 		tcb0 = &tcb0;
 		tcb1 = &tcb1;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
 	};
 	cpus {
 		cpu@0 {
@@ -178,6 +180,24 @@
 				atmel,use-dma-tx;
 				status = "disabled";
 			};
+
+			i2c0: i2c@f8010000 {
+				compatible = "atmel,at91sam9x5-i2c";
+				reg = <0xf8010000 0x100>;
+				interrupts = <9 4 6>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c1: i2c@f8014000 {
+				compatible = "atmel,at91sam9x5-i2c";
+				reg = <0xf8014000 0x100>;
+				interrupts = <10 4 6>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand@40000000 {
@@ -205,17 +225,4 @@
 			status = "disabled";
 		};
 	};
-
-	i2c@0 {
-		compatible = "i2c-gpio";
-		gpios = <&pioA 30 0 /* sda */
-			 &pioA 31 0 /* scl */
-			>;
-		i2c-gpio,sda-open-drain;
-		i2c-gpio,scl-open-drain;
-		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "disabled";
-	};
 };
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 4a18c39..907b89e 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -27,6 +27,9 @@
 		gpio3 = &pioD;
 		tcb0 = &tcb0;
 		tcb1 = &tcb1;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
 	};
 	cpus {
 		cpu@0 {
@@ -192,6 +195,33 @@
 				status = "disabled";
 			};
 
+			i2c0: i2c@f8010000 {
+				compatible = "atmel,at91sam9x5-i2c";
+				reg = <0xf8010000 0x100>;
+				interrupts = <9 4 6>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c1: i2c@f8014000 {
+				compatible = "atmel,at91sam9x5-i2c";
+				reg = <0xf8014000 0x100>;
+				interrupts = <10 4 6>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c2: i2c@f8018000 {
+				compatible = "atmel,at91sam9x5-i2c";
+				reg = <0xf8018000 0x100>;
+				interrupts = <11 4 6>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			adc0: adc@f804c000 {
 				compatible = "atmel,at91sam9260-adc";
 				reg = <0xf804c000 0x100>;
@@ -260,43 +290,4 @@
 			status = "disabled";
 		};
 	};
-
-	i2c@0 {
-		compatible = "i2c-gpio";
-		gpios = <&pioA 30 0 /* sda */
-			 &pioA 31 0 /* scl */
-			>;
-		i2c-gpio,sda-open-drain;
-		i2c-gpio,scl-open-drain;
-		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "disabled";
-	};
-
-	i2c@1 {
-		compatible = "i2c-gpio";
-		gpios = <&pioC 0 0 /* sda */
-			 &pioC 1 0 /* scl */
-			>;
-		i2c-gpio,sda-open-drain;
-		i2c-gpio,scl-open-drain;
-		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "disabled";
-	};
-
-	i2c@2 {
-		compatible = "i2c-gpio";
-		gpios = <&pioB 4 0 /* sda */
-			 &pioB 5 0 /* scl */
-			>;
-		i2c-gpio,sda-open-drain;
-		i2c-gpio,scl-open-drain;
-		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "disabled";
-	};
 };
-- 
1.7.11.3
