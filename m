From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: [PATCH v13 05/10] dt-bindings: iio: io-channel-mux: document io-channel-mux bindings
Date: Thu, 13 Apr 2017 18:43:09 +0200
Message-ID: <1492101794-13444-6-git-send-email-peda@axentia.se>
References: <1492101794-13444-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1492101794-13444-1-git-send-email-peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Describe how a multiplexer can be used to select which signal is fed to
an io-channel.

Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
---
 .../bindings/iio/multiplexer/io-channel-mux.txt    | 39 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++++
 2 files changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt

diff --git a/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt b/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt
new file mode 100644
index 000000000000..c82794002595
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt
@@ -0,0 +1,39 @@
+I/O channel multiplexer bindings
+
+If a multiplexer is used to select which hardware signal is fed to
+e.g. an ADC channel, these bindings describe that situation.
+
+Required properties:
+- compatible : "io-channel-mux"
+- io-channels : Channel node of the parent channel that has multiplexed
+		input.
+- io-channel-names : Should be "parent".
+- #address-cells = <1>;
+- #size-cells = <0>;
+- mux-controls : Mux controller node to use for operating the mux
+- channels : List of strings, labeling the mux controller states.
+
+For each non-empty string in the channels property, an io-channel will
+be created. The number of this io-channel is the same as the index into
+the list of strings in the channels property, and also matches the mux
+controller state. The mux controller state is described in
+../mux/mux-controller.txt
+
+Example:
+	mux: mux-controller {
+		compatible = "mux-gpio";
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
+		channels = "sync", "in", "system-regulator";
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 591eba737678..4af912305d2c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6360,6 +6360,12 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-adc-envelope-detector
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
