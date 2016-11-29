From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: [PATCH v5 8/9] dt-bindings: mux-adg792a: document devicetree bindings for ADG792A/G mux
Date: Tue, 29 Nov 2016 11:10:44 +0100
Message-ID: <1480414245-14034-9-git-send-email-peda@axentia.se>
References: <1480414245-14034-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1480414245-14034-1-git-send-email-peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Analog Devices ADG792A/G is a triple 4:1 mux.

Signed-off-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
---
 .../devicetree/bindings/misc/mux-adg792a.txt       | 82 ++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/mux-adg792a.txt

diff --git a/Documentation/devicetree/bindings/misc/mux-adg792a.txt b/Documentation/devicetree/bindings/misc/mux-adg792a.txt
new file mode 100644
index 000000000000..8d5c9de09832
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/mux-adg792a.txt
@@ -0,0 +1,82 @@
+Bindings for Analog Devices ADG792A/G Triple 4:1 Multiplexers
+
+Required properties:
+- compatible : "adi,adg792a" or "adi,adg792g"
+- #mux-control-cells : <0> if parallel, or <1> if not.
+* Standard mux-controller bindings as decribed in mux-controller.txt
+
+Optional properties:
+- adi,parallel : if present, the three muxes are bound together with a single
+  mux controller, controlling all three muxes in parallel.
+- adi,idle-state : if present, array of states the three mux controllers will
+  have when idle (or, if parallel, a single idle-state).
+
+Mux controller states 0 through 3 correspond to signals A through D in the
+datasheet. Mux controller states 4 and 5 are only available as possible idle
+states. State 4 represents that nothing is connected, and state 5 represents
+that the mux controller keeps the mux in its previously selected state during
+the idle period. State 5 is the default idle state.
+
+Example:
+
+	/* three independent mux controllers (of which one is used) */
+	&i2c0 {
+		mux: adg792a@50 {
+			compatible = "adi,adg792a";
+			reg = <0x50>;
+			#mux-control-cells = <1>;
+		};
+	};
+
+	adc-mux {
+		compatible = "iio-mux";
+		io-channels = <&adc 0>;
+		io-channel-names = "parent";
+
+		mux-controls = <&mux 1>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sync-1@0 {
+			reg = <0>;
+		};
+
+		in@2 {
+			reg = <2>;
+		};
+	};
+
+
+	/*
+	 * Three parallel muxes with one mux controller, useful e.g. if
+	 * the adc is differential, thus needing two signals to be muxed
+	 * simultaneously for correct operation.
+	 */
+	&i2c0 {
+		pmux: adg792a@50 {
+			compatible = "adi,adg792a";
+			reg = <0x50>;
+			#mux-control-cells = <0>;
+			adi,parallel;
+		};
+	};
+
+	diff-adc-mux {
+		compatible = "iio-mux";
+		io-channels = <&adc 0>;
+		io-channel-names = "parent";
+
+		mux-controls = <&pmux>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sync-1@0 {
+			reg = <0>;
+		};
+
+		in@2 {
+			reg = <2>;
+		};
+	};
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
