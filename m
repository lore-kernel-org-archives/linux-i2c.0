From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Subject: [RFC 3/3] dts: beaglebone: Portable connector BB_RELAY_4PORT definition
Date: Fri,  3 Jun 2016 23:37:53 +0300
Message-ID: <1464986273-12039-4-git-send-email-pantelis.antoniou@konsulko.com>
References: <1464986273-12039-1-git-send-email-pantelis.antoniou@konsulko.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464986273-12039-1-git-send-email-pantelis.antoniou@konsulko.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Frank Rowand <frowand.list@gmail.com>, Matt Porter <mporter@konsulko.com>, Koen Kooi <koen@dominion.thruhere.net>, Guenter Roeck <linux@roeck-us.net>, Marek Vasut <marex@denx.de>, Wolfram Sang <wsa@the-dreams.de>, Stephen Boyd <stephen.boyd@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Pantelis Antoniou <panto@antoniou-consulting.com>
List-Id: linux-i2c@vger.kernel.org

Example of a portable connector port for the BB_RELAY_4PORT cape

Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 48 +++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index 0e73ab6..06f2191 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -2045,6 +2045,54 @@
 			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			BB_RELAY_4PORT {
+				compatible = "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio_relay_4port: gpio_relay_4port@0 {
+					compatible = "dtcon-gpio";
+					status = "okay";
+
+					gpio-controller;
+					#gpio-cells = <2>;
+
+					pin-list = <9 15>,	/* #0 P9.15 */
+						   <9 23>,	/* #1 P9.23 */
+						   <9 12>,	/* #2 P9.12 */
+						   <9 27>;	/* #3 P9.27 */
+				};
+
+				leds@0 {
+					compatible = "gpio-leds";
+					status = "okay";
+
+					jp@1 {
+						label = "relay-jp1";
+						gpios = <&gpio_relay_4port 0 GPIO_ACTIVE_HIGH>;
+						default-state = "keep";
+					};
+
+					jp@2 {
+						label = "relay-jp2";
+						gpios = <&gpio_relay_4port 1 GPIO_ACTIVE_HIGH>;
+						default-state = "keep";
+					};
+
+					jp@3 {
+						label = "relay-jp3";
+						gpios = <&gpio_relay_4port 2 GPIO_ACTIVE_HIGH>;
+						default-state = "keep";
+					};
+
+					jp@4 {
+						label = "relay-jp4";
+						gpios = <&gpio_relay_4port 3 GPIO_ACTIVE_HIGH>;
+						default-state = "keep";
+					};
+				};
+			};
 		};
 	};
 };
-- 
1.7.12
