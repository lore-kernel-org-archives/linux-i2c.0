From: <Eugen.Hristev@microchip.com>
Subject: [PATCH v3 9/9] ARM: dts: at91: sama5d4_xplained: add digital filter
 for i2c
Date: Tue, 9 Jul 2019 13:19:54 +0000
Message-ID: <1562678049-17581-10-git-send-email-eugen.hristev@microchip.com>
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

Add property for digital filter for i2c0 node sama5d4_xplained

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d4_xplained.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dt=
s/at91-sama5d4_xplained.dts
index fdfc37d..298113c 100644
--- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
@@ -49,6 +49,7 @@
 			};
=20
 			i2c0: i2c@f8014000 {
+				i2c-dig-filter;
 				status =3D "okay";
 			};
=20
--=20
2.7.4
