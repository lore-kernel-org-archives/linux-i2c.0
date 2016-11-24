From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: [PATCH v4 4/7] dt-bindings: iio: iio-mux: document iio-mux bindings
Date: Thu, 24 Nov 2016 16:18:04 +0100
Message-ID: <1480000687-5630-5-git-send-email-peda@axentia.se>
References: <1480000687-5630-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1480000687-5630-1-git-send-email-peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
---
 .../bindings/iio/multiplexer/iio-mux.txt           | 47 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 +++
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt

diff --git a/Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt b/Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt
new file mode 100644
index 000000000000..f5eccdfbed40
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt
@@ -0,0 +1,47 @@
+IIO multiplexer bindings
+
+If a multiplexer is used to select which hardware signal is fed to
+e.g. an ADC channel, these bindings describe that situation.
+
+Required properties:
+- compatible : "iio-mux"
+- io-channels : Channel node of the parent channel that has multiplexed
+		input.
+- io-channel-names : Should be "parent".
+- #address-cells = <1>;
+- #size-cells = <0>;
+
+Required properties for iio-mux child nodes:
+- reg : The multiplexer state as described in ../misc/mux-controller.txt
+
+For each iio-mux child, an iio channel will be created whose number will
+match the mux controller state.
+
+Example:
+	adc-mux {
+		compatible = "iio-mux";
+		io-channels = <&adc 0>;
+		io-channel-names = "parent";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mux-controller {
+			compatible = "mux-gpio";
+
+			mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>,
+				    <&pioA 1 GPIO_ACTIVE_HIGH>;
+		};
+
+		sync@0 {
+			reg = <0>;
+		};
+
+		in@1 {
+			reg = <1>;
+		};
+
+		system-regulator@2 {
+			reg = <2>;
+		};
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 9635c9708a13..7f02f58dfc37 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6233,6 +6233,12 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-adc-envelope-detector
 F:	Documentation/devicetree/bindings/iio/adc/envelope-detector.txt
 F:	drivers/iio/adc/envelope-detector.c
 
+IIO MULTIPLEXER
+M:	Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
+L:	linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt
+
 IIO SUBSYSTEM AND DRIVERS
 M:	Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
 R:	Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
