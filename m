From: <michael.hennerich@analog.com>
Subject: [PATCH v3 2/2] dt-bindings:i2c:mux:ltc4306: Add dt-bindings for I2C multiplexer/switch
Date: Mon, 3 Apr 2017 15:31:37 +0200
Message-ID: <1491226297-4970-2-git-send-email-michael.hennerich@analog.com>
References: <1491226297-4970-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1491226297-4970-1-git-send-email-michael.hennerich@analog.com>
Sender: linux-gpio-owner@vger.kernel.org
To: wsa@the-dreams.de, peda@axentia.se, robh+dt@kernel.org, mark.rutland@arm.com, linus.walleij@linaro.org
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>
List-Id: linux-i2c@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/i2c/i2c-mux-ltc4306.txt    | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
new file mode 100644
index 0000000..1e98c6b
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
@@ -0,0 +1,61 @@
+* Linear Technology / Analog Devices I2C bus switch
+
+Required Properties:
+
+  - compatible: Must contain one of the following.
+    "lltc,ltc4305", "lltc,ltc4306"
+  - reg: The I2C address of the device.
+
+  The following required properties are defined externally:
+
+  - Standard I2C mux properties. See i2c-mux.txt in this directory.
+  - I2C child bus nodes. See i2c-mux.txt in this directory.
+
+Optional Properties:
+
+  - enable-gpios: Reference to the GPIO connected to the enable input.
+  - i2c-mux-idle-disconnect: Boolean; if defined, forces mux to disconnect all
+    children in idle state. This is necessary for example, if there are several
+    multiplexers on the bus and the devices behind them use same I2C addresses.
+  - gpio-controller: Marks the device node as a GPIO Controller.
+  - #gpio-cells: Should be two.  The first cell is the pin number and
+	the second cell is used to specify flags.
+	See ../gpio/gpio.txt for more information.
+  - ltc,downstream-accelerators-enable: Enables the rise time accelerators
+	on the downstream port.
+  - ltc,upstream-accelerators-enable: Enables the rise time accelerators
+	on the upstream port.
+
+Example:
+
+	ltc4306: i2c-mux@4a {
+		compatible = "lltc,ltc4306";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x4a>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			eeprom@50 {
+				compatible = "at,24c02";
+				reg = <0x50>;
+			};
+		};
+
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			eeprom@50 {
+				compatible = "at,24c02";
+				reg = <0x50>;
+			};
+		};
+	};
-- 
2.7.4

