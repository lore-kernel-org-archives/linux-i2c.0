From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: [RFC PATCH 4/7] dt-bindings: iio: iio-mux: document iio-mux bindings
Date: Thu, 17 Nov 2016 00:48:28 +0100
Message-ID: <1479340111-1259-5-git-send-email-peda@axentia.se>
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
 .../bindings/iio/multiplexer/iio-mux.txt           | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt

diff --git a/Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt b/Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt
new file mode 100644
index 000000000000..2f5c7fc35a42
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt
@@ -0,0 +1,59 @@
+IIO multiplexer bindings
+
+If a multiplexer is used to select when hardware signal is fed to
+e.g. an ADC channel, these bindings describe that situation.
+
+Required properties:
+- compatible : "iio-mux"
+- io-channels : Channel node of the parent channel that has multiplexed
+		input.
+- io-channel-names : Should be "parent".
+- control-muxes : Node of the multiplexer that controls the input signal.
+- control-mux-names : Should be "mux".
+- #address-cells = <1>;
+- #size-cells = <0>;
+
+Required properties for iio-mux child nodes:
+- reg : The multiplexer number.
+
+Optional properties for iio-mux child nodes:
+- iio-ext-info : Array of string pairs, the first item in each pair is the
+		 iio ext_info attribute name, and the second item in each
+		 pair is the iio ext_info value for that attribute. The
+		 mux will write these ext_info values to the corresponding
+		 ext_info attributes on every multiplexer switch.
+
+Example:
+	control_adc_mux: control-adc-mux {
+		compatible = "mux-gpio";
+
+		mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>,
+			    <&pioA 1 GPIO_ACTIVE_HIGH>;
+	};
+
+	adc-mux {
+		compatible = "iio-mux";
+		io-channels = <&adc 0>;
+		io-channel-names = "parent";
+
+		control-muxes = <&control_adc_mux>;
+		control-mux-names = "mux";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sync@0 {
+			reg = <0>;
+			iio-ext-info = "invert", "1";
+		};
+
+		in@1 {
+			reg = <1>;
+			iio-ext-info = "invert", "1";
+		};
+
+		system-regulator@2 {
+			reg = <2>;
+			iio-ext-info = "invert", "0";
+		};
+	};
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
