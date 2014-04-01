From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] fixup! i2c: efm32: new bus driver
Date: Tue,  1 Apr 2014 09:42:20 +0200
Message-ID: <1396338140-22332-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1395744526-3706-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1395744526-3706-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

=46ix dt compatible string in the binding document which was changed
during review in the driver, but it seem I messed up to adapt the
documentation accordingly.

Also change status from "disabled" to "ok" which makes more sense for a=
n
example.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 Documentation/devicetree/bindings/i2c/i2c-efm32.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-efm32.txt b/Docu=
mentation/devicetree/bindings/i2c/i2c-efm32.txt
index ead4dd33ab66..fc15ac519437 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-efm32.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-efm32.txt
@@ -3,7 +3,7 @@
 Required properties :
=20
  - reg : Offset and length of the register set for the device
- - compatible : should be "efm32,i2c"
+ - compatible : should be "energymicro,efm32-i2c"
  - interrupts : the interrupt number
  - clocks : reference to the module clock
=20
@@ -17,12 +17,12 @@ Example:
 	i2c0: i2c@4000a000 {
 		#address-cells =3D <1>;
 		#size-cells =3D <0>;
-		compatible =3D "efm32,i2c";
+		compatible =3D "energymicro,efm32-i2c";
 		reg =3D <0x4000a000 0x400>;
 		interrupts =3D <9>;
 		clocks =3D <&cmu clk_HFPERCLKI2C0>;
 		clock-frequency =3D <100000>;
-		status =3D "disabled";
+		status =3D "ok";
 		efm32,location =3D <3>;
=20
 		eeprom@50 {
--=20
1.9.1
