From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 4/8] dt-bindings: i2c: add bindings for nxp,pca9541
Date: Mon, 15 Aug 2016 15:40:27 +0200
Message-ID: <1471268431-5148-5-git-send-email-peda@axentia.se>
References: <1471268431-5148-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471268431-5148-1-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Guenter Roeck <linux@roeck-us.net>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Crestez Dan Leonard <leonard.crestez@intel.com>
List-Id: linux-i2c@vger.kernel.org

Fill the gap for this pre-existing driver.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../devicetree/bindings/i2c/nxp,pca9541.txt        | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/nxp,pca9541.txt

diff --git a/Documentation/devicetree/bindings/i2c/nxp,pca9541.txt b/Documentation/devicetree/bindings/i2c/nxp,pca9541.txt
new file mode 100644
index 000000000000..0fbbc6970ec5
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/nxp,pca9541.txt
@@ -0,0 +1,29 @@
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
+  - I2C arbitration bus node. See i2c-arb.txt in this directory.
+
+
+Example:
+
+	i2c-arbitrator@74 {
+		compatible = "nxp,pca9541";
+		reg = <0x74>;
+
+		i2c-arb {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			eeprom@54 {
+				compatible = "at,24c08";
+				reg = <0x54>;
+			};
+		};
+	};
-- 
2.1.4
