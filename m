From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: [PATCH v2 2/8] dt-bindings: i2c: add support for 'i2c-arb' subnode
Date: Mon, 15 Aug 2016 15:40:25 +0200
Message-ID: <1471268431-5148-3-git-send-email-peda@axentia.se>
References: <1471268431-5148-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471268431-5148-1-git-send-email-peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This gets rid of the need for a pointless 'reg' property for i2c
arbitrators.

I.e. this new and more compact style

	some-arbitrator {
		i2c-arb {
			#address-cells = <1>;
			#size-cells = <0>;

			some-i2c-device@50 {
				reg = <0x50>;
			};
		};
	};

instead of the old

	some-arbitrator {
		#address-cells = <1>;
		#size-cells = <0>;

		i2c@0 {
			reg = <0>;

			#address-cells = <1>;
			#size-cells = <0>;

			some-i2c-device@50 {
				reg = <0x50>;
			};
		};
	};

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
---
 .../bindings/i2c/i2c-arb-gpio-challenge.txt        |  8 ++---
 Documentation/devicetree/bindings/i2c/i2c-arb.txt  | 35 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 3 files changed, 38 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-arb.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-arb-gpio-challenge.txt b/Documentation/devicetree/bindings/i2c/i2c-arb-gpio-challenge.txt
index 71191ff0e781..248a155414c2 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-arb-gpio-challenge.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-arb-gpio-challenge.txt
@@ -44,8 +44,7 @@ Required properties:
 - our-claim-gpio: The GPIO that we use to claim the bus.
 - their-claim-gpios: The GPIOs that the other sides use to claim the bus.
   Note that some implementations may only support a single other master.
-- Standard I2C mux properties. See i2c-mux.txt in this directory.
-- Single I2C child bus node at reg 0. See i2c-mux.txt in this directory.
+- I2C arbitration bus node. See i2c-arb.txt in this directory.
 
 Optional properties:
 - slew-delay-us: microseconds to wait for a GPIO to go high. Default is 10 us.
@@ -63,8 +62,6 @@ Example:
 
 	i2c-arbitrator {
 		compatible = "i2c-arb-gpio-challenge";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		i2c-parent = <&{/i2c@12CA0000}>;
 
@@ -74,8 +71,7 @@ Example:
 		wait-retry-us = <3000>;
 		wait-free-us = <50000>;
 
-		i2c@0 {
-			reg = <0>;
+		i2c-arb {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
diff --git a/Documentation/devicetree/bindings/i2c/i2c-arb.txt b/Documentation/devicetree/bindings/i2c/i2c-arb.txt
new file mode 100644
index 000000000000..59abf9277bdc
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-arb.txt
@@ -0,0 +1,35 @@
+Common i2c arbitration bus properties.
+
+- i2c-arb child node
+
+Required properties for the i2c-arb child node:
+- #address-cells = <1>;
+- #size-cells = <0>;
+
+Optional properties for i2c-arb child node:
+- Child nodes conforming to i2c bus binding
+
+
+Example :
+
+	/*
+	   An NXP pca9541 I2C bus master selector at address 0x74
+	   with a NXP pca8574 GPIO expander attached.
+	 */
+
+	arb@74 {
+		compatible = "nxp,pca9541";
+		reg = <0x74>;
+
+		i2c-arb {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			gpio@38 {
+				compatible = "nxp,pca8574";
+				reg = <0x38>;
+				#gpio-cells = <2>;
+				gpio-controller;
+			};
+		};
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 20bb1d00098c..1a61e2f5a0a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5660,6 +5660,7 @@ S:	Maintained
 F:	Documentation/i2c/i2c-topology
 F:	Documentation/i2c/muxes/
 F:	Documentation/devicetree/bindings/i2c/i2c-mux*
+F:	Documentation/devicetree/bindings/i2c/i2c-arb*
 F:	drivers/i2c/i2c-mux.c
 F:	drivers/i2c/muxes/
 F:	include/linux/i2c-mux.h
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
