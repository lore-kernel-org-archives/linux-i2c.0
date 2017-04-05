From: <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v4 1/2] dt-bindings: i2c: mux: ltc4306: Add dt-bindings for I2C multiplexer/switch
Date: Wed, 5 Apr 2017 15:07:50 +0200
Message-ID: <1491397671-14675-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

This patch adds support for the Analog Devices / Linear Technology
LTC4306 and LTC4305 4/2 Channel I2C Bus Multiplexer/Switches.
The LTC4306 optionally provides two general purpose input/output pins
(GPIOs) that can be configured as logic inputs, opendrain outputs or
push-pull outputs via the generic GPIOLIB framework.

Signed-off-by: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
