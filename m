From: <Codrin.Ciubotariu@microchip.com>
Subject: [PATCH v2 5/6] ARM: at91/dt: sama5d4: add i2c gpio pinctrl
Date: Fri, 3 Jan 2020 09:49:08 +0000
Message-ID: <20200103094821.13185-6-codrin.ciubotariu@microchip.com>
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

Add the i2c gpio pinctrls so the i2c bus recovery option can be enabled

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
---

Changes in v2:
 - none;

 arch/arm/boot/dts/sama5d4.dtsi | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dts=
i
index 6ab27a7b388d..34351baab985 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -458,8 +458,11 @@
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
 					| AT91_XDMAC_DT_PERID(3))>;
 				dma-names =3D "tx", "rx";
-				pinctrl-names =3D "default";
+				pinctrl-names =3D "default", "gpio";
 				pinctrl-0 =3D <&pinctrl_i2c0>;
+				pinctrl-1 =3D <&pinctrl_i2c0_gpio>;
+				sda-gpios =3D <&pioA 30 GPIO_ACTIVE_HIGH>;
+				scl-gpios =3D <&pioA 31 GPIO_ACTIVE_HIGH>;
 				#address-cells =3D <1>;
 				#size-cells =3D <0>;
 				clocks =3D <&pmc PMC_TYPE_PERIPHERAL 32>;
@@ -477,8 +480,11 @@
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
 					| AT91_XDMAC_DT_PERID(5))>;
 				dma-names =3D "tx", "rx";
-				pinctrl-names =3D "default";
+				pinctrl-names =3D "default", "gpio";
 				pinctrl-0 =3D <&pinctrl_i2c1>;
+				pinctrl-1 =3D <&pinctrl_i2c1_gpio>;
+				sda-gpios =3D <&pioE 29 GPIO_ACTIVE_HIGH>;
+				scl-gpios =3D <&pioE 30 GPIO_ACTIVE_HIGH>;
 				#address-cells =3D <1>;
 				#size-cells =3D <0>;
 				clocks =3D <&pmc PMC_TYPE_PERIPHERAL 33>;
@@ -519,8 +525,11 @@
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
 					| AT91_XDMAC_DT_PERID(7))>;
 				dma-names =3D "tx", "rx";
-				pinctrl-names =3D "default";
+				pinctrl-names =3D "default", "gpio";
 				pinctrl-0 =3D <&pinctrl_i2c2>;
+				pinctrl-1 =3D <&pinctrl_i2c2_gpio>;
+				sda-gpios =3D <&pioB 29 GPIO_ACTIVE_HIGH>;
+				scl-gpios =3D <&pioB 30 GPIO_ACTIVE_HIGH>;
 				#address-cells =3D <1>;
 				#size-cells =3D <0>;
 				clocks =3D <&pmc PMC_TYPE_PERIPHERAL 34>;
@@ -1122,6 +1131,12 @@
 							<AT91_PIOA 30 AT91_PERIPH_A AT91_PINCTRL_NONE
 							 AT91_PIOA 31 AT91_PERIPH_A AT91_PINCTRL_NONE>;
 					};
+
+					pinctrl_i2c0_gpio: i2c0-gpio {
+						atmel,pins =3D
+							<AT91_PIOA 30 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP
+							 AT91_PIOA 31 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
+					};
 				};
=20
 				i2c1 {
@@ -1130,6 +1145,12 @@
 							<AT91_PIOE 29 AT91_PERIPH_C AT91_PINCTRL_NONE	/* TWD1, conflicts wi=
th UART0 RX and DIBP */
 							 AT91_PIOE 30 AT91_PERIPH_C AT91_PINCTRL_NONE>;	/* TWCK1, conflicts=
 with UART0 TX and DIBN */
 					};
+
+					pinctrl_i2c1_gpio: i2c1-gpio {
+						atmel,pins =3D
+							<AT91_PIOE 29 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP
+							 AT91_PIOE 30 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
+					};
 				};
=20
 				i2c2 {
@@ -1138,6 +1159,12 @@
 							<AT91_PIOB 29 AT91_PERIPH_A AT91_PINCTRL_NONE	/* TWD2, conflicts wi=
th RD0 and PWML1 */
 							 AT91_PIOB 30 AT91_PERIPH_A AT91_PINCTRL_NONE>; /* TWCK2, conflicts=
 with RF0 */
 					};
+
+					pinctrl_i2c2_gpio: i2c2-gpio {
+						atmel,pins =3D
+							<AT91_PIOB 29 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP
+							 AT91_PIOB 30 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
+					};
 				};
=20
 				isi {
--=20
2.20.1
