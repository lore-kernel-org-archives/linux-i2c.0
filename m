From: <Eugen.Hristev@microchip.com>
Subject: [PATCH v3 8/9] ARM: dts: at91: sama5d2_xplained: add analog and
 digital filter for i2c
Date: Tue, 9 Jul 2019 13:19:51 +0000
Message-ID: <1562678049-17581-9-git-send-email-eugen.hristev@microchip.com>
References: <1562678049-17581-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1562678049-17581-1-git-send-email-eugen.hristev@microchip.com>
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
index 808e399..965326c 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -334,6 +334,9 @@
 					pinctrl-names =3D "default";
 					pinctrl-0 =3D <&pinctrl_flx4_default>;
 					atmel,fifo-size =3D <16>;
+					i2c-ana-filter;
+					i2c-dig-filter;
+					i2c-filter-width-ns =3D <35>;
 					status =3D "okay";
 				};
 			};
@@ -342,6 +345,9 @@
 				dmas =3D <0>, <0>;
 				pinctrl-names =3D "default";
 				pinctrl-0 =3D <&pinctrl_i2c1_default>;
+				i2c-ana-filter;
+				i2c-dig-filter;
+				i2c-filter-width-ns =3D <35>;
 				status =3D "okay";
=20
 				at24@54 {
--=20
2.7.4
