From: <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 5/5] ARM: dts: add twi nodes for atmel boards
Date: Tue, 21 Aug 2012 16:32:00 +0200
Message-ID: <1345559520-14074-1-git-send-email-ludovic.desroches@atmel.com>
References: <1345559345-13988-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1345559345-13988-1-git-send-email-ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Use the atmel twi instead of gpio for i2c stuff.

Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 arch/arm/boot/dts/at91sam9263ek.dts         | 20 ++++++++++----------
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi | 28 ++++++++++++++--------------
 arch/arm/boot/dts/at91sam9g25ek.dts         | 12 ++++++++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts      | 14 ++++++++++++++
 arch/arm/boot/dts/at91sam9n12ek.dts         |  8 ++++++++
 5 files changed, 58 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
index f86ac4b..772ab75 100644
--- a/arch/arm/boot/dts/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/at91sam9263ek.dts
@@ -50,6 +50,16 @@
 				atmel,vbus-gpio = <&pioA 25 0>;
 				status = "okay";
 			};
+
+			i2c0: i2c@fff88000 {
+				status = "okay";
+
+				24c512@50 {
+					compatible = "24c512";
+					reg = <0x50>;
+					pagesize = <128>;
+				};
+			};
 		};
 
 		nand0: nand@40000000 {
@@ -143,14 +153,4 @@
 			gpio-key,wakeup;
 		};
 	};
-
-	i2c@0 {
-		status = "okay";
-
-		24c512@50 {
-			compatible = "24c512";
-			reg = <0x50>;
-			pagesize = <128>;
-		};
-	};
 };
diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index b06c0db..712106b 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -51,6 +51,20 @@
 				atmel,vbus-gpio = <&pioC 5 0>;
 				status = "okay";
 			};
+
+			i2c0: i2c@fffac000 {
+				status = "okay";
+
+				24c512@50 {
+					compatible = "24c512";
+					reg = <0x50>;
+				};
+
+				wm8731@1b {
+					compatible = "wm8731";
+					reg = <0x1b>;
+				};
+			};
 		};
 
 		nand0: nand@40000000 {
@@ -106,20 +120,6 @@
 		};
 	};
 
-	i2c@0 {
-		status = "okay";
-
-		24c512@50 {
-			compatible = "24c512";
-			reg = <0x50>;
-		};
-
-		wm8731@1b {
-			compatible = "wm8731";
-			reg = <0x1b>;
-		};
-	};
-
 	gpio_keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/at91sam9g25ek.dts b/arch/arm/boot/dts/at91sam9g25ek.dts
index 7829a4d..3b0adbc 100644
--- a/arch/arm/boot/dts/at91sam9g25ek.dts
+++ b/arch/arm/boot/dts/at91sam9g25ek.dts
@@ -32,6 +32,18 @@
 				phy-mode = "rmii";
 				status = "okay";
 			};
+
+			i2c0: i2c@f8010000 {
+				status = "okay";
+			};
+
+			i2c1: i2c@f8014000 {
+				status = "okay";
+			};
+
+			i2c2: i2c@f8018000 {
+				status = "okay";
+			};
 		};
 
 		usb0: ohci@00600000 {
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index a3633bd..4f94f23 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -46,6 +46,20 @@
 				phy-mode = "rmii";
 				status = "okay";
 			};
+
+			i2c0: i2c@fff84000 {
+				status = "okay";
+
+				24c512@50 {
+					compatible = "24c512";
+					reg = <0x50>;
+					pagesize = <128>;
+				};
+			};
+			
+			i2c1: i2c@fff88000 {
+				status = "okay";
+			};
 		};
 
 		nand0: nand@40000000 {
diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index f4e43e3..912b2c2 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -37,6 +37,14 @@
 			dbgu: serial@fffff200 {
 				status = "okay";
 			};
+
+			i2c0: i2c@f8010000 {
+				status = "okay";
+			};
+
+			i2c1: i2c@f8014000 {
+				status = "okay";
+			};
 		};
 
 		nand0: nand@40000000 {
-- 
1.7.11.3
