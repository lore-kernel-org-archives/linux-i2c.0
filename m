From: Peter Rosin <peda@axentia.se>
Subject: [PATCH] dt-bindings: i2c: add bindings for nxp,pca9541
Date: Mon, 27 Jun 2016 12:11:22 +0200
Message-ID: <1467022282-21062-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kalle Valo <kvalo@codeaurora.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Jiri Slaby <jslaby@suse.cz>, Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Fill the gap for this pre-existing driver.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../devicetree/bindings/i2c/i2c-arb-pca9541.txt    | 33 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-arb-pca9541.txt

Hi!

I'm wondering about this driver. It is not a trivial device, and yet it
has historically relied on the i2c core matching the chip w/o vendor
prefix. This is not ideal. But what to do about the driver implementing
this in terms of an i2c-mux, somthing which the chip is not; It is an
i2c arbitrator. It just happens to rely on the i2c mux core also handling
i2c gates and i2c arbitrators. But that seems like a Linux detail. So I
don't know what to do here?

That is, the patch - as is - describes something that would be trivial to
support today, but at the same time it seems to be too tied to Linux.

The problem is that the i2c@0 intermediate node is not really needed, but
at the same time removing it would cause a disruption for the driver since
it can't really use the i2c mux core if that node isn't there. I don't
see a simple way to fix that in the i2c mux core either (but admittedly
haven't given it too much thought).

Any suggestions?

Cheers,
Peter

PS. The driver source is in drivers/i2c/muxes/i2c-mux-pca9541.c

diff --git a/Documentation/devicetree/bindings/i2c/i2c-arb-pca9541.txt b/Documentation/devicetree/bindings/i2c/i2c-arb-pca9541.txt
new file mode 100644
index 000000000000..edbe84935906
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-arb-pca9541.txt
@@ -0,0 +1,33 @@
+* NXP PCA9541 I2C bus master selector
+
+Required Properties:
+
+  - compatible: Must be "nxp,pca9541"
+
+  - reg: The I2C address of the device.
+
+  The following required properties are defined externally:
+
+  - Standard I2C mux properties. See i2c-mux.txt in this directory.
+  - I2C child bus nodes. See i2c-mux.txt in this directory.
+
+
+Example:
+
+	i2c-arbitrator@74 {
+		compatible = "nxp,pca9541";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x74>;
+
+		i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			eeprom@54 {
+				compatible = "at,24c08";
+				reg = <0x54>;
+			};
+		};
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index e1b090f86e0d..3dd44d0d166c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5521,6 +5521,7 @@ S:	Maintained
 F:	Documentation/i2c/i2c-topology
 F:	Documentation/i2c/muxes/
 F:	Documentation/devicetree/bindings/i2c/i2c-mux*
+F:	Documentation/devicetree/bindings/i2c/i2c-arb*
 F:	drivers/i2c/i2c-mux.c
 F:	drivers/i2c/muxes/
 F:	include/linux/i2c-mux.h
-- 
2.1.4
