From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCHv5 8/8] ARM: sun4i: cubieboard: Enable the i2c controllers
Date: Wed, 12 Jun 2013 18:53:37 +0200
Message-ID: <1371056017-8166-9-git-send-email-maxime.ripard@free-electrons.com>
References: <1371056017-8166-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1371056017-8166-1-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

=46rom: Emilio L=C3=B3pez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>

The Cubieboard makes use of the first two i2c controllers found on the
Allwinner A10; i2c-0 is used internally for the PMIC, while i2c-1
is exposed on the board headers. This patch enables them in the device
tree.

Signed-off-by: Emilio L=C3=B3pez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Reviewed-by: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot=
/dts/sun4i-a10-cubieboard.dts
index e752b57..757c4cd 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -56,6 +56,18 @@
 			pinctrl-0 =3D <&uart0_pins_a>;
 			status =3D "okay";
 		};
+
+		i2c0: i2c@01c2ac00 {
+			pinctrl-names =3D "default";
+			pinctrl-0 =3D <&i2c0_pins_a>;
+			status =3D "okay";
+		};
+
+		i2c1: i2c@01c2b000 {
+			pinctrl-names =3D "default";
+			pinctrl-0 =3D <&i2c1_pins_a>;
+			status =3D "okay";
+		};
 	};
=20
 	leds {
--=20
1.8.3
