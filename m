From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: [PATCH v9 02/10] dt-bindings: document devicetree bindings for mux-controllers and gpio-mux
Date: Wed, 8 Feb 2017 16:41:49 +0100
Message-ID: <1486568517-6997-3-git-send-email-peda@axentia.se>
References: <1486568517-6997-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1486568517-6997-1-git-send-email-peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Allow specifying that a single multiplexer controller can be used to
control several parallel multiplexers, thus enabling sharing of the
multiplexer controller by different consumers.

Add a binding for a first mux controller in the form of a GPIO based mux
controller.

Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
---
 Documentation/devicetree/bindings/mux/gpio-mux.txt |  69 +++++++++
 .../devicetree/bindings/mux/mux-controller.txt     | 157 +++++++++++++++++++++
 MAINTAINERS                                        |   6 +
 include/dt-bindings/mux/mux.h                      |  16 +++
 4 files changed, 248 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mux/gpio-mux.txt
 create mode 100644 Documentation/devicetree/bindings/mux/mux-controller.txt
 create mode 100644 include/dt-bindings/mux/mux.h

diff --git a/Documentation/devicetree/bindings/mux/gpio-mux.txt b/Documentation/devicetree/bindings/mux/gpio-mux.txt
new file mode 100644
index 000000000000..b8f746344d80
--- /dev/null
+++ b/Documentation/devicetree/bindings/mux/gpio-mux.txt
@@ -0,0 +1,69 @@
+GPIO-based multiplexer controller bindings
+
+Define what GPIO pins are used to control a multiplexer. Or several
+multiplexers, if the same pins control more than one multiplexer.
+
+Required properties:
+- compatible : "gpio-mux"
+- mux-gpios : list of gpios used to control the multiplexer, least
+	      significant bit first.
+- #mux-control-cells : <0>
+* Standard mux-controller bindings as decribed in mux-controller.txt
+
+Optional properties:
+- idle-state : if present, the state the mux will have when idle. The
+	       special state MUX_IDLE_AS_IS is the default.
+
+The multiplexer state is defined as the number represented by the
+multiplexer GPIO pins, where the first pin is the least significant
+bit. An active pin is a binary 1, an inactive pin is a binary 0.
+
+Example:
+
+	mux: mux-controller {
+		compatible = "gpio-mux";
+		#mux-control-cells = <0>;
+
+		mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>,
+			    <&pioA 1 GPIO_ACTIVE_HIGH>;
+	};
+
+	adc-mux {
+		compatible = "io-channel-mux";
+		io-channels = <&adc 0>;
+		io-channel-names = "parent";
+
+		mux-controls = <&mux>;
+
+		channels = "sync-1", "in", "out", "sync-2";
+	};
+
+	i2c-mux {
+		compatible = "i2c-mux";
+		i2c-parent = <&i2c1>;
+
+		mux-controls = <&mux>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ssd1307: oled@3c {
+				/* ... */
+			};
+		};
+
+		i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			pca9555: pca9555@20 {
+				/* ... */
+			};
+		};
+	};
diff --git a/Documentation/devicetree/bindings/mux/mux-controller.txt b/Documentation/devicetree/bindings/mux/mux-controller.txt
new file mode 100644
index 000000000000..4f47e4bd2fa0
--- /dev/null
+++ b/Documentation/devicetree/bindings/mux/mux-controller.txt
@@ -0,0 +1,157 @@
+Common multiplexer controller bindings
+======================================
+
+A multiplexer (or mux) controller will have one, or several, consumer devices
+that uses the mux controller. Thus, a mux controller can possibly control
+several parallel multiplexers. Presumably there will be at least one
+multiplexer needed by each consumer, but a single mux controller can of course
+control several multiplexers for a single consumer.
+
+A mux controller provides a number of states to its consumers, and the state
+space is a simple zero-based enumeration. I.e. 0-1 for a 2-way multiplexer,
+0-7 for an 8-way multiplexer, etc.
+
+
+Consumers
+---------
+
+Mux controller consumers should specify a list of mux controllers that they
+want to use with a property containing a 'mux-ctrl-list':
+
+	mux-ctrl-list ::= <single-mux-ctrl> [mux-ctrl-list]
+	single-mux-ctrl ::= <mux-ctrl-phandle> [mux-ctrl-specifier]
+	mux-ctrl-phandle : phandle to mux controller node
+	mux-ctrl-specifier : array of #mux-control-cells specifying the
+			     given mux controller (controller specific)
+
+Mux controller properties should be named "mux-controls". The exact meaning of
+each mux controller property must be documented in the device tree binding for
+each consumer. An optional property "mux-control-names" may contain a list of
+strings to label each of the mux controllers listed in the "mux-controls"
+property.
+
+Drivers for devices that use more than a single mux controller can use the
+"mux-control-names" property to map the name of the requested mux controller
+to an index into the list given by the "mux-controls" property.
+
+mux-ctrl-specifier typically encodes the chip-relative mux controller number.
+If the mux controller chip only provides a single mux controller, the
+mux-ctrl-specifier can typically be left out.
+
+Example:
+
+	/* One consumer of a 2-way mux controller (one GPIO-line) */
+	mux: mux-controller {
+		compatible = "gpio-mux";
+		#mux-control-cells = <0>;
+
+		mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>;
+	};
+
+	adc-mux {
+		compatible = "io-channel-mux";
+		io-channels = <&adc 0>;
+		io-channel-names = "parent";
+
+		mux-controls = <&mux>;
+		mux-control-names = "adc";
+
+		channels = "sync", "in";
+	};
+
+Note that in the example above, specifying the "mux-control-names" is redundant
+because there is only one mux controller in the list. However, if the driver
+for the consumer node in fact asks for a named mux controller, that name is of
+course still required.
+
+	/*
+	 * Two consumers (one for an ADC line and one for an i2c bus) of
+	 * parallel 4-way multiplexers controlled by the same two GPIO-lines.
+	 */
+	mux: mux-controller {
+		compatible = "gpio-mux";
+		#mux-control-cells = <0>;
+
+		mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>,
+			    <&pioA 1 GPIO_ACTIVE_HIGH>;
+	};
+
+	adc-mux {
+		compatible = "io-channel-mux";
+		io-channels = <&adc 0>;
+		io-channel-names = "parent";
+
+		mux-controls = <&mux>;
+
+		channels = "sync-1", "in", "out", "sync-2";
+	};
+
+	i2c-mux {
+		compatible = "i2c-mux";
+		i2c-parent = <&i2c1>;
+
+		mux-controls = <&mux>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ssd1307: oled@3c {
+				/* ... */
+			};
+		};
+
+		i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			pca9555: pca9555@20 {
+				/* ... */
+			};
+		};
+	};
+
+
+Mux controller nodes
+--------------------
+
+Mux controller nodes must specify the number of cells used for the
+specifier using the '#mux-control-cells' property.
+
+Optionally, mux controller nodes can also specify the state the mux should
+have when it is idle. The idle-state property is used for this. If the
+idle-state is not present, the mux controller is typically left as is when
+it is idle. For multiplexer chips that expose several mux controllers, the
+idle-state property is an array with one idle state for each mux controller.
+
+The special value (-1) may be used to indicate that the mux should be left
+as is when it is idle. This is the default, but can still be useful for
+mux controller chips with more than one mux controller, particularly when
+there is a need to "step past" a mux controller and set some other idle
+state for a mux controller with a higher index.
+
+Some mux controllers have the ability to disconnect the input/output of the
+multiplexer. Using this disconnected high-impedance state as the idle state
+is indicated with idle state (-2).
+
+These constants are available in
+
+      #include <dt-bindings/mux/mux.h>
+
+as MUX_IDLE_AS_IS (-1) and MUX_IDLE_DISCONNECT (-2).
+
+An example mux controller node look like this (the adg972a chip is a triple
+4-way multiplexer):
+
+	mux: mux-controller@50 {
+		compatible = "adi,adg792a";
+		reg = <0x50>;
+		#mux-control-cells = <1>;
+
+		idle-state = <MUX_IDLE_DISCONNECT MUX_IDLE_AS_IS 2>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 01b1719bb1ae..8a0adb1e6194 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8495,6 +8495,12 @@ S:	Orphan
 F:	drivers/mmc/host/mmc_spi.c
 F:	include/linux/spi/mmc_spi.h
 
+MULTIPLEXER SUBSYSTEM
+M:	Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
+S:	Maintained
+F:	Documentation/devicetree/bindings/mux/
+F:	include/linux/dt-bindings/mux/
+
 MULTISOUND SOUND DRIVER
 M:	Andrew Veliath <andrewtv-Jdbf3xiKgS8@public.gmane.org>
 S:	Maintained
diff --git a/include/dt-bindings/mux/mux.h b/include/dt-bindings/mux/mux.h
new file mode 100644
index 000000000000..c8e855c4a609
--- /dev/null
+++ b/include/dt-bindings/mux/mux.h
@@ -0,0 +1,16 @@
+/*
+ * This header provides constants for most Multiplexer bindings.
+ *
+ * Most Multiplexer bindings specify an idle state. In most cases, the
+ * the multiplexer can be left as is when idle, and in some cases it can
+ * disconnect the input/output and leave the multiplexer in a high
+ * impedance state.
+ */
+
+#ifndef _DT_BINDINGS_MUX_MUX_H
+#define _DT_BINDINGS_MUX_MUX_H
+
+#define MUX_IDLE_AS_IS      (-1)
+#define MUX_IDLE_DISCONNECT (-2)
+
+#endif
-- 
2.1.4
