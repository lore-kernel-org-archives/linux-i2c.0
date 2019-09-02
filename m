From: <Eugen.Hristev@microchip.com>
Subject: [PATCH v4 8/9] ARM: dts: at91: sama5d2_xplained: add analog and
 digital filter for i2c
Date: Mon, 2 Sep 2019 10:12:17 +0000
Message-ID: <1567418773-2427-9-git-send-email-eugen.hristev@microchip.com>
References: <1567418773-2427-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1567418773-2427-1-git-send-email-eugen.hristev@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, peda@axentia.se, mark.rutland@arm.com, Ludovic.Desroches@microchip.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, pierre-yves.mordret@st.com, alexandre.belloni@bootlin.com, robh+dt@kernel.org
Cc: Nicolas.Ferre@microchip.com, Eugen.Hristev@microchip.com
List-Id: linux-i2c@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

Add property for analog and digital filter for i2c1 and i2c2 nodes
for sama5d2_xplained

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dt=
s/at91-sama5d2_xplained.dts
index 808e399..2083585 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -334,6 +334,9 @@
 					pinctrl-names =3D "default";
 					pinctrl-0 =3D <&pinctrl_flx4_default>;
 					atmel,fifo-size =3D <16>;
+					i2c-analog-filter;
+					i2c-digital-filter;
+					i2c-filter-width-ns =3D <35>;
 					status =3D "okay";
 				};
 			};
@@ -342,6 +345,9 @@
 				dmas =3D <0>, <0>;
 				pinctrl-names =3D "default";
 				pinctrl-0 =3D <&pinctrl_i2c1_default>;
+				i2c-analog-filter;
+				i2c-digital-filter;
+				i2c-filter-width-ns =3D <35>;
 				status =3D "okay";
=20
 				at24@54 {
--=20
2.7.4
