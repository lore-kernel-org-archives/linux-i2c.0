From: <Codrin.Ciubotariu@microchip.com>
Subject: [PATCH v2 1/6] dt-bindings: i2c: at91: document optional bus recovery
 properties
Date: Fri, 3 Jan 2020 09:49:06 +0000
Message-ID: <20200103094821.13185-2-codrin.ciubotariu@microchip.com>
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

The at91 I2C controller can support bus recovery by re-assigning SCL
and SDA to gpios. Add the optional pinctrl and gpio properties to do
so.

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
---

Changes in v2:
 - none

 Documentation/devicetree/bindings/i2c/i2c-at91.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-at91.txt b/Documenta=
tion/devicetree/bindings/i2c/i2c-at91.txt
index 2210f4359c45..551ddabb566b 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-at91.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
@@ -20,8 +20,13 @@ Optional properties:
   capable I2C controllers.
 - i2c-sda-hold-time-ns: TWD hold time, only available for "atmel,sama5d4-i=
2c"
   and "atmel,sama5d2-i2c".
+- scl-gpios: specify the gpio related to SCL pin
+- sda-gpios: specify the gpio related to SDA pin
+- pinctrl: add extra pinctrl to configure i2c pins to gpio function for i2=
c
+  bus recovery, call it "gpio" state
 - Child nodes conforming to i2c bus binding
=20
+
 Examples :
=20
 i2c0: i2c@fff84000 {
@@ -56,6 +61,11 @@ i2c0: i2c@f8034600 {
 	clocks =3D <&flx0>;
 	atmel,fifo-size =3D <16>;
 	i2c-sda-hold-time-ns =3D <336>;
+	pinctrl-names =3D "default", "gpio";
+	pinctrl-0 =3D <&pinctrl_i2c0>;
+	pinctrl-1 =3D <&pinctrl_i2c0_gpio>;
+	sda-gpios =3D <&pioA 30 GPIO_ACTIVE_HIGH>;
+	scl-gpios =3D <&pioA 31 GPIO_ACTIVE_HIGH>;
=20
 	wm8731: wm8731@1a {
 		compatible =3D "wm8731";
--=20
2.20.1
