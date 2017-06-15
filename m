From: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Subject: [RESEND PATCH v6 5/8] i2c: i2c-cbus-gpio: Add vendor prefix to retu node in example
Date: Thu, 15 Jun 2017 20:49:25 +0200
Message-ID: <20170615184928.12007-6-javier@dowhile0.org>
References: <20170615184928.12007-1-javier@dowhile0.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170615184928.12007-1-javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The example contains a device node for a retu device, but
its compatible string doesn't have a vendor prefix.

While being there, drop the -mfd suffix since isn't correct.

Signed-off-by: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Acked-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Reviewed-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

---

Changes in v6:
- Add Wolfram Sang's Reviewed-by tag.

Changes in v5:
- Add Rob Herring's Acked-by tag.
- Add Aaro Koskinen's Acked-by tag.
- Add Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>'s Acked-by tag.

Changes in v4:
- Avoid using MFD in Device Tree (Lee Jones).

Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/i2c/i2c-cbus-gpio.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-cbus-gpio.txt b/Documentation/devicetree/bindings/i2c/i2c-cbus-gpio.txt
index 8ce9cd2855b5..c143948b2a37 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-cbus-gpio.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-cbus-gpio.txt
@@ -20,8 +20,8 @@ i2c@0 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 
-	retu-mfd: retu@1 {
-		compatible = "retu-mfd";
+	retu: retu@1 {
+		compatible = "nokia,retu";
 		reg = <0x1>;
 	};
 };
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
