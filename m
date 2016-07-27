From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 2/7] dt-bindings: i2c: add support for 'i2c-arb' subnode
Date: Wed, 27 Jul 2016 10:43:25 +0200
Message-ID: <1469609010-23049-3-git-send-email-peda@axentia.se>
References: <1469609010-23049-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0135.outbound.protection.outlook.com ([104.47.2.135]:56251
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753979AbcG0IoI (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 27 Jul 2016 04:44:08 -0400
In-Reply-To: <1469609010-23049-1-git-send-email-peda@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Guenter Roeck <linux@roeck-us.net>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Kalle Valo <kvalo@codeaurora.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Emil Velikov <emil.l.velikov@gmail.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Crestez Dan Leonard <leonard.crestez@intel.com>

This gets rid of the need for a pointless 'reg' property for i2c
arbitrators.

I.e. this new and more compact style

	some-arbitrator {
		i2c-mux {
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

Signed-off-by: Peter Rosin <peda@axentia.se>
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
index 8c20323d1277..543052305a09 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5524,6 +5524,7 @@ S:	Maintained
 F:	Documentation/i2c/i2c-topology
 F:	Documentation/i2c/muxes/
 F:	Documentation/devicetree/bindings/i2c/i2c-mux*
+F:	Documentation/devicetree/bindings/i2c/i2c-arb*
 F:	drivers/i2c/i2c-mux.c
 F:	drivers/i2c/muxes/
 F:	include/linux/i2c-mux.h
-- 
2.1.4
