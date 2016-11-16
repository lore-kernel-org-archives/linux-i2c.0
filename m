From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: [RFC PATCH 6/7] dt-bindings: i2c: i2c-mux-simple: document i2c-mux-simple bindings
Date: Thu, 17 Nov 2016 00:48:30 +0100
Message-ID: <1479340111-1259-7-git-send-email-peda@axentia.se>
References: <1479340111-1259-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1479340111-1259-1-git-send-email-peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

---
 .../devicetree/bindings/i2c/i2c-mux-simple.txt     | 91 ++++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-simple.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-simple.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-simple.txt
new file mode 100644
index 000000000000..fec1ab39ad64
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-simple.txt
@@ -0,0 +1,91 @@
+Simple I2C Bus Mux
+
+This binding describes an I2C bus multiplexer that uses GPIOs to
+route the I2C signals.
+
+                                  .-----.  .-----.
+                                  | dev |  | dev |
+    .------------.                '-----'  '-----'
+    | SoC        |                   |        |
+    |            |          .--------+--------'
+    |   .------. |  .------+    child bus A, on MUX value set to 0
+    |   | I2C  |-|--| Mux  |
+    |   '------' |  '--+---+    child bus B, on MUX value set to 1
+    |   .------. |     |    '----------+--------+--------.
+    |   | MUX- | |     |               |        |        |
+    |   | Ctrl |-|-----+            .-----.  .-----.  .-----.
+    |   '------' |                  | dev |  | dev |  | dev |
+    '------------'                  '-----'  '-----'  '-----'
+
+Required properties:
+- compatible: i2c-mux-simple,mux-locked or i2c-mux-simple,parent-locked
+- i2c-parent: The phandle of the I2C bus that this multiplexer's master-side
+  port is connected to.
+- control-muxes : Node of the multiplexer that controls "Mux".
+- control-mux-names : Should be "mux".
+* Standard I2C mux properties. See i2c-mux.txt in this directory.
+* I2C child bus nodes. See i2c-mux.txt in this directory.
+
+Optional properties:
+- idle-state: value to set the muxer to when idle. When no value is
+  given, it defaults to the last value used.
+
+For each i2c child node, an I2C child bus will be created. They will
+be numbered based on their order in the device tree.
+
+Whenever an access is made to a device on a child bus, the value set
+in the relevant node's reg property will be fed to the mux controller.
+
+If an idle state is defined, using the idle-state (optional) property,
+whenever an access is not being made to a device on a child bus, the
+mux controller will be set according to the idle value.
+
+If an idle state is not defined, the most recently used value will be
+left programmed into hardware whenever no access is being made to a
+device on a child bus.
+
+Example:
+	control_i2c_mux: control-i2c-mux {
+		compatible = "mux-gpio";
+
+		mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>,
+			    <&pioA 1 GPIO_ACTIVE_HIGH>;
+	};
+
+	i2c-mux {
+		compatible = "i2c-mux-simple,mux-locked";
+		i2c-parent = <&i2c1>;
+
+		control-muxes = <&control_i2c_mux>;
+		control-mux-names = "mux";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ssd1307: oled@3c {
+				compatible = "solomon,ssd1307fb-i2c";
+				reg = <0x3c>;
+				pwms = <&pwm 4 3000>;
+				reset-gpios = <&gpio2 7 1>;
+				reset-active-low;
+			};
+		};
+
+		i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			pca9555: pca9555@20 {
+				compatible = "nxp,pca9555";
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x20>;
+			};
+		};
+	};
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
