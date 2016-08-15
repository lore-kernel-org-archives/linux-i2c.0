From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 3/8] dt-bindings: i2c: add support for 'i2c-gate' subnode
Date: Mon, 15 Aug 2016 15:40:26 +0200
Message-ID: <1471268431-5148-4-git-send-email-peda@axentia.se>
References: <1471268431-5148-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471268431-5148-1-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Guenter Roeck <linux@roeck-us.net>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Crestez Dan Leonard <leonard.crestez@intel.com>
List-Id: linux-i2c@vger.kernel.org

Handle i2c gates similarly to how i2c arbitrators are handled.
This gets rid of a pointless 'reg' property for i2c gates.

I.e. this new and more compact style

        some-gate {
                i2c-gate {
                        #address-cells = <1>;
                        #size-cells = <0>;

                        some-i2c-device@50 {
                                reg = <0x50>;
                        };
                };
        };

instead of the old

        some-gate {
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
 Documentation/devicetree/bindings/i2c/i2c-gate.txt | 41 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-gate.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-gate.txt b/Documentation/devicetree/bindings/i2c/i2c-gate.txt
new file mode 100644
index 000000000000..0b057fb2a15a
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-gate.txt
@@ -0,0 +1,41 @@
+An i2c gate is useful to e.g. reduce the digital noise for RF tuners connected
+to the i2c bus. Gates are similar to arbitrators in that you need to perform
+some kind of operation to access the i2c bus past the arbitrator/gate, but
+there are no competing masters to consider for gates and therefore there is
+no arbitration happening for gates.
+
+Common i2c gate properties.
+
+- i2c-gate child node
+
+Required properties for the i2c-gate child node:
+- #address-cells = <1>;
+- #size-cells = <0>;
+
+Optional properties for i2c-gate child node:
+- Child nodes conforming to i2c bus binding
+
+
+Example :
+
+	/*
+	   An Invensense mpu9150 at address 0x68 featuring an on-chip Asahi
+	   Kasei ak8975 compass behind a gate.
+	 */
+
+	mpu9150@68 {
+		compatible = "invensense,mpu9150";
+		reg = <0x68>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <18 1>;
+
+		i2c-gate {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ax8975@0c {
+				compatible = "ak,ak8975";
+				reg = <0x0c>;
+			};
+		};
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 1a61e2f5a0a9..7444b03a4c28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5661,6 +5661,7 @@ F:	Documentation/i2c/i2c-topology
 F:	Documentation/i2c/muxes/
 F:	Documentation/devicetree/bindings/i2c/i2c-mux*
 F:	Documentation/devicetree/bindings/i2c/i2c-arb*
+F:	Documentation/devicetree/bindings/i2c/i2c-gate*
 F:	drivers/i2c/i2c-mux.c
 F:	drivers/i2c/muxes/
 F:	include/linux/i2c-mux.h
-- 
2.1.4
