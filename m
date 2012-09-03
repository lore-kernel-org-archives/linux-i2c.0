From: <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 8/8] ARM: dts: add twi nodes for atmel boards
Date: Mon, 3 Sep 2012 12:20:02 +0200
Message-ID: <1346667602-8140-1-git-send-email-ludovic.desroches@atmel.com>
References: <1346667367-7969-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1346667367-7969-1-git-send-email-ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Still use i2c-gpio on boards which have a SoC with a TWI IP which
doesn't have clock stretching in transmission mode.

Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 arch/arm/boot/dts/at91sam9g25ek.dts    | 12 ++++++++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts |  8 ++++++++
 arch/arm/boot/dts/at91sam9n12ek.dts    |  8 ++++++++
 3 files changed, 28 insertions(+)

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
index a3633bd..15e1dd4 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -46,6 +46,14 @@
 				phy-mode = "rmii";
 				status = "okay";
 			};
+
+			i2c0: i2c@fff84000 {
+				status = "okay";
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
