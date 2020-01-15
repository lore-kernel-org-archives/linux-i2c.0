From: Codrin Ciubotariu <codrin.ciubotariu-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: [PATCH v3 6/6] ARM: at91/dt: sama5d2: add i2c gpio pinctrl
Date: Wed, 15 Jan 2020 13:54:22 +0200
Message-ID: <20200115115422.17097-7-codrin.ciubotariu@microchip.com>
References: <20200115115422.17097-1-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200115115422.17097-1-codrin.ciubotariu-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kamel.bouhara-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Nicolas.Ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, Ludovic.Desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, Codrin Ciubotariu <codrin.ciubotariu-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Kamel Bouhara <kamel.bouhara-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>

Add the i2c gpio pinctrls to support the i2c bus recovery

Signed-off-by: Kamel Bouhara <kamel.bouhara-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
[codrin.ciubotariu-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org: removed gpio pull-ups]
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
---

Changes in v3:
 - removed gpio pull-ups;

Changes in v2:
 - new patch;

 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts   | 33 +++++++++++++++++++--
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 33 +++++++++++++++++++--
 2 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
index ba7f3e646c26..1c24ac8019ba 100644
--- a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
@@ -180,8 +180,11 @@
 
 			i2c0: i2c@f8028000 {
 				dmas = <0>, <0>;
-				pinctrl-names = "default";
+				pinctrl-names = "default", "gpio";
 				pinctrl-0 = <&pinctrl_i2c0_default>;
+				pinctrl-1 = <&pinctrl_i2c0_gpio>;
+				sda-gpios = <&pioA PIN_PD21 GPIO_ACTIVE_HIGH>;
+				scl-gpios = <&pioA PIN_PD22 GPIO_ACTIVE_HIGH>;
 				status = "okay";
 			};
 
@@ -198,8 +201,11 @@
 					#address-cells = <1>;
 					#size-cells = <0>;
 					clocks = <&pmc PMC_TYPE_PERIPHERAL 19>;
-					pinctrl-names = "default";
+					pinctrl-names = "default", "gpio";
 					pinctrl-0 = <&pinctrl_flx0_default>;
+					pinctrl-1 = <&pinctrl_flx0_gpio>;
+					sda-gpios = <&pioA PIN_PB28 GPIO_ACTIVE_HIGH>;
+					scl-gpios = <&pioA PIN_PB29 GPIO_ACTIVE_HIGH>;
 					atmel,fifo-size = <16>;
 					status = "okay";
 				};
@@ -226,8 +232,11 @@
 
 			i2c1: i2c@fc028000 {
 				dmas = <0>, <0>;
-				pinctrl-names = "default";
+				pinctrl-names = "default", "gpio";
 				pinctrl-0 = <&pinctrl_i2c1_default>;
+				pinctrl-1 = <&pinctrl_i2c1_gpio>;
+				sda-gpios = <&pioA PIN_PC6 GPIO_ACTIVE_HIGH>;
+				scl-gpios = <&pioA PIN_PC7 GPIO_ACTIVE_HIGH>;
 				status = "okay";
 
 				at24@50 {
@@ -244,18 +253,36 @@
 					bias-disable;
 				};
 
+				pinctrl_flx0_gpio: flx0_gpio {
+					pinmux = <PIN_PB28__GPIO>,
+						 <PIN_PB29__GPIO>;
+					bias-disable;
+				};
+
 				pinctrl_i2c0_default: i2c0_default {
 					pinmux = <PIN_PD21__TWD0>,
 						 <PIN_PD22__TWCK0>;
 					bias-disable;
 				};
 
+				pinctrl_i2c0_gpio: i2c0_gpio {
+					pinmux = <PIN_PD21__GPIO>,
+						 <PIN_PD22__GPIO>;
+					bias-disable;
+				};
+
 				pinctrl_i2c1_default: i2c1_default {
 					pinmux = <PIN_PC6__TWD1>,
 						 <PIN_PC7__TWCK1>;
 					bias-disable;
 				};
 
+				pinctrl_i2c1_gpio: i2c1_gpio {
+					pinmux = <PIN_PC6__GPIO>,
+						 <PIN_PC7__GPIO>;
+					bias-disable;
+				};
+
 				pinctrl_key_gpio_default: key_gpio_default {
 					pinmux = <PIN_PA10__GPIO>;
 					bias-pull-up;
diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 9d0a7fbea725..055ee53e4773 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -129,8 +129,11 @@
 
 			i2c0: i2c@f8028000 {
 				dmas = <0>, <0>;
-				pinctrl-names = "default";
+				pinctrl-names = "default", "gpio";
 				pinctrl-0 = <&pinctrl_i2c0_default>;
+				pinctrl-1 = <&pinctrl_i2c0_gpio>;
+				sda-gpios = <&pioA PIN_PD21 GPIO_ACTIVE_HIGH>;
+				scl-gpios = <&pioA PIN_PD22 GPIO_ACTIVE_HIGH>;
 				i2c-sda-hold-time-ns = <350>;
 				status = "okay";
 
@@ -331,8 +334,11 @@
 					#address-cells = <1>;
 					#size-cells = <0>;
 					clocks = <&pmc PMC_TYPE_PERIPHERAL 23>;
-					pinctrl-names = "default";
+					pinctrl-names = "default", "gpio";
 					pinctrl-0 = <&pinctrl_flx4_default>;
+					pinctrl-1 = <&pinctrl_flx4_gpio>;
+					sda-gpios = <&pioA PIN_PD12 GPIO_ACTIVE_HIGH>;
+					scl-gpios = <&pioA PIN_PD13 GPIO_ACTIVE_HIGH>;
 					atmel,fifo-size = <16>;
 					i2c-analog-filter;
 					i2c-digital-filter;
@@ -343,11 +349,14 @@
 
 			i2c1: i2c@fc028000 {
 				dmas = <0>, <0>;
-				pinctrl-names = "default";
+				pinctrl-names = "default", "gpio";
 				pinctrl-0 = <&pinctrl_i2c1_default>;
 				i2c-analog-filter;
 				i2c-digital-filter;
 				i2c-digital-filter-width-ns = <35>;
+				pinctrl-1 = <&pinctrl_i2c1_gpio>;
+				sda-gpios = <&pioA PIN_PD4 GPIO_ACTIVE_HIGH>;
+				scl-gpios = <&pioA PIN_PD5 GPIO_ACTIVE_HIGH>;
 				status = "okay";
 
 				at24@54 {
@@ -441,18 +450,36 @@
 					bias-disable;
 				};
 
+				pinctrl_flx4_gpio: flx4_gpio {
+					pinmux = <PIN_PD12__GPIO>,
+						 <PIN_PD13__GPIO>;
+					bias-disable;
+				};
+
 				pinctrl_i2c0_default: i2c0_default {
 					pinmux = <PIN_PD21__TWD0>,
 						 <PIN_PD22__TWCK0>;
 					bias-disable;
 				};
 
+				pinctrl_i2c0_gpio: i2c0_gpio {
+					pinmux = <PIN_PD21__GPIO>,
+						 <PIN_PD22__GPIO>;
+					bias-disable;
+				};
+
 				pinctrl_i2c1_default: i2c1_default {
 					pinmux = <PIN_PD4__TWD1>,
 						 <PIN_PD5__TWCK1>;
 					bias-disable;
 				};
 
+				pinctrl_i2c1_gpio: i2c1_gpio {
+					pinmux = <PIN_PD4__GPIO>,
+						 <PIN_PD5__GPIO>;
+					bias-disable;
+				};
+
 				pinctrl_i2s0_default: i2s0_default {
 					pinmux = <PIN_PC1__I2SC0_CK>,
 						 <PIN_PC2__I2SC0_MCK>,
-- 
2.20.1
