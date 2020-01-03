From: <Codrin.Ciubotariu@microchip.com>
Subject: [PATCH v2 6/6] ARM: at91/dt: sama5d2: add i2c gpio pinctrl
Date: Fri, 3 Jan 2020 09:49:09 +0000
Message-ID: <20200103094821.13185-7-codrin.ciubotariu@microchip.com>
References: <20200103094821.13185-1-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200103094821.13185-1-codrin.ciubotariu@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kamel.bouhara@bootlin.com, wsa@the-dreams.de, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, robh@kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Kamel Bouhara <kamel.bouhara@bootlin.com>

Add the i2c gpio pinctrls to support the i2c bus recovery

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
---

Changes in v2:
 - new changes;

 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts   | 33 +++++++++++++++++++--
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 33 +++++++++++++++++++--
 2 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts b/arch/arm/boot/dts/=
at91-sama5d2_ptc_ek.dts
index ba7f3e646c26..b3cd651ecda0 100644
--- a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
@@ -180,8 +180,11 @@
=20
 			i2c0: i2c@f8028000 {
 				dmas =3D <0>, <0>;
-				pinctrl-names =3D "default";
+				pinctrl-names =3D "default", "gpio";
 				pinctrl-0 =3D <&pinctrl_i2c0_default>;
+				pinctrl-1 =3D <&pinctrl_i2c0_gpio>;
+				sda-gpios =3D <&pioA PIN_PD21 GPIO_ACTIVE_HIGH>;
+				scl-gpios =3D <&pioA PIN_PD22 GPIO_ACTIVE_HIGH>;
 				status =3D "okay";
 			};
=20
@@ -198,8 +201,11 @@
 					#address-cells =3D <1>;
 					#size-cells =3D <0>;
 					clocks =3D <&pmc PMC_TYPE_PERIPHERAL 19>;
-					pinctrl-names =3D "default";
+					pinctrl-names =3D "default", "gpio";
 					pinctrl-0 =3D <&pinctrl_flx0_default>;
+					pinctrl-1 =3D <&pinctrl_flx0_gpio>;
+					sda-gpios =3D <&pioA PIN_PB28 GPIO_ACTIVE_HIGH>;
+					scl-gpios =3D <&pioA PIN_PB29 GPIO_ACTIVE_HIGH>;
 					atmel,fifo-size =3D <16>;
 					status =3D "okay";
 				};
@@ -226,8 +232,11 @@
=20
 			i2c1: i2c@fc028000 {
 				dmas =3D <0>, <0>;
-				pinctrl-names =3D "default";
+				pinctrl-names =3D "default", "gpio";
 				pinctrl-0 =3D <&pinctrl_i2c1_default>;
+				pinctrl-1 =3D <&pinctrl_i2c1_gpio>;
+				sda-gpios =3D <&pioA PIN_PC6 GPIO_ACTIVE_HIGH>;
+				scl-gpios =3D <&pioA PIN_PC7 GPIO_ACTIVE_HIGH>;
 				status =3D "okay";
=20
 				at24@50 {
@@ -244,18 +253,36 @@
 					bias-disable;
 				};
=20
+				pinctrl_flx0_gpio: flx0_gpio {
+					pinmux =3D <PIN_PB28__GPIO>,
+						 <PIN_PB29__GPIO>;
+					bias-pull-up;
+				};
+
 				pinctrl_i2c0_default: i2c0_default {
 					pinmux =3D <PIN_PD21__TWD0>,
 						 <PIN_PD22__TWCK0>;
 					bias-disable;
 				};
=20
+				pinctrl_i2c0_gpio: i2c0_gpio {
+					pinmux =3D <PIN_PD21__GPIO>,
+						 <PIN_PD22__GPIO>;
+					bias-pull-up;
+				};
+
 				pinctrl_i2c1_default: i2c1_default {
 					pinmux =3D <PIN_PC6__TWD1>,
 						 <PIN_PC7__TWCK1>;
 					bias-disable;
 				};
=20
+				pinctrl_i2c1_gpio: i2c1_gpio {
+					pinmux =3D <PIN_PC6__GPIO>,
+						 <PIN_PC7__GPIO>;
+					bias-pull-up;
+				};
+
 				pinctrl_key_gpio_default: key_gpio_default {
 					pinmux =3D <PIN_PA10__GPIO>;
 					bias-pull-up;
diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dt=
s/at91-sama5d2_xplained.dts
index 9d0a7fbea725..500e49eeb8cc 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -129,8 +129,11 @@
=20
 			i2c0: i2c@f8028000 {
 				dmas =3D <0>, <0>;
-				pinctrl-names =3D "default";
+				pinctrl-names =3D "default", "gpio";
 				pinctrl-0 =3D <&pinctrl_i2c0_default>;
+				pinctrl-1 =3D <&pinctrl_i2c0_gpio>;
+				sda-gpios =3D <&pioA PIN_PD21 GPIO_ACTIVE_HIGH>;
+				scl-gpios =3D <&pioA PIN_PD22 GPIO_ACTIVE_HIGH>;
 				i2c-sda-hold-time-ns =3D <350>;
 				status =3D "okay";
=20
@@ -331,8 +334,11 @@
 					#address-cells =3D <1>;
 					#size-cells =3D <0>;
 					clocks =3D <&pmc PMC_TYPE_PERIPHERAL 23>;
-					pinctrl-names =3D "default";
+					pinctrl-names =3D "default", "gpio";
 					pinctrl-0 =3D <&pinctrl_flx4_default>;
+					pinctrl-1 =3D <&pinctrl_flx4_gpio>;
+					sda-gpios =3D <&pioA PIN_PD12 GPIO_ACTIVE_HIGH>;
+					scl-gpios =3D <&pioA PIN_PD13 GPIO_ACTIVE_HIGH>;
 					atmel,fifo-size =3D <16>;
 					i2c-analog-filter;
 					i2c-digital-filter;
@@ -343,11 +349,14 @@
=20
 			i2c1: i2c@fc028000 {
 				dmas =3D <0>, <0>;
-				pinctrl-names =3D "default";
+				pinctrl-names =3D "default", "gpio";
 				pinctrl-0 =3D <&pinctrl_i2c1_default>;
 				i2c-analog-filter;
 				i2c-digital-filter;
 				i2c-digital-filter-width-ns =3D <35>;
+				pinctrl-1 =3D <&pinctrl_i2c1_gpio>;
+				sda-gpios =3D <&pioA PIN_PD4 GPIO_ACTIVE_HIGH>;
+				scl-gpios =3D <&pioA PIN_PD5 GPIO_ACTIVE_HIGH>;
 				status =3D "okay";
=20
 				at24@54 {
@@ -441,18 +450,36 @@
 					bias-disable;
 				};
=20
+				pinctrl_flx4_gpio: flx4_gpio {
+					pinmux =3D <PIN_PD12__GPIO>,
+						 <PIN_PD13__GPIO>;
+					bias-pull-up;
+				};
+
 				pinctrl_i2c0_default: i2c0_default {
 					pinmux =3D <PIN_PD21__TWD0>,
 						 <PIN_PD22__TWCK0>;
 					bias-disable;
 				};
=20
+				pinctrl_i2c0_gpio: i2c0_gpio {
+					pinmux =3D <PIN_PD21__GPIO>,
+						 <PIN_PD22__GPIO>;
+					bias-pull-up;
+				};
+
 				pinctrl_i2c1_default: i2c1_default {
 					pinmux =3D <PIN_PD4__TWD1>,
 						 <PIN_PD5__TWCK1>;
 					bias-disable;
 				};
=20
+				pinctrl_i2c1_gpio: i2c1_gpio {
+					pinmux =3D <PIN_PD4__GPIO>,
+						 <PIN_PD5__GPIO>;
+					bias-pull-up;
+				};
+
 				pinctrl_i2s0_default: i2s0_default {
 					pinmux =3D <PIN_PC1__I2SC0_CK>,
 						 <PIN_PC2__I2SC0_MCK>,
--=20
2.20.1
