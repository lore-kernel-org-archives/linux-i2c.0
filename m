From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: [PATCH v10 09/11] dt-bindings: mux-adg792a: document devicetree bindings for ADG792A/G mux
Date: Fri, 10 Mar 2017 12:10:03 +0100
Message-ID: <1489144205-17427-10-git-send-email-peda@axentia.se>
References: <1489144205-17427-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1489144205-17427-1-git-send-email-peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Analog Devices ADG792A/G is a triple 4:1 mux.

Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
---
 .../devicetree/bindings/mux/adi,adg792a.txt        | 75 ++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mux/adi,adg792a.txt

diff --git a/Documentation/devicetree/bindings/mux/adi,adg792a.txt b/Documentation/devicetree/bindings/mux/adi,adg792a.txt
new file mode 100644
index 000000000000..96b787a69f50
--- /dev/null
+++ b/Documentation/devicetree/bindings/mux/adi,adg792a.txt
@@ -0,0 +1,75 @@
+Bindings for Analog Devices ADG792A/G Triple 4:1 Multiplexers
+
+Required properties:
+- compatible : "adi,adg792a" or "adi,adg792g"
+- #mux-control-cells : <0> if parallel (the three muxes are bound together
+  with a single mux controller controlling all three muxes), or <1> if
+  not (one mux controller for each mux).
+* Standard mux-controller bindings as described in mux-controller.txt
+
+Optional properties for ADG792G:
+- gpio-controller : if present, #gpio-cells below is required.
+- #gpio-cells : should be <2>
+			  - First cell is the GPO line number, i.e. 0 or 1
+			  - Second cell is used to specify active high (0)
+			    or active low (1)
+
+Optional properties:
+- idle-state : if present, array of states that the mux controllers will have
+  when idle. The special state MUX_IDLE_AS_IS is the default and
+  MUX_IDLE_DISCONNECT is also supported.
+
+States 0 through 3 correspond to signals A through D in the datasheet.
+
+Example:
+
+	/*
+	 * Three independent mux controllers (of which one is used).
+	 * Mux 0 is disconnected when idle, mux 1 idles in the previously
+	 * selected state and mux 2 idles with signal B.
+	 */
+	&i2c0 {
+		mux: mux-controller@50 {
+			compatible = "adi,adg792a";
+			reg = <0x50>;
+			#mux-control-cells = <1>;
+
+			idle-state = <MUX_IDLE_DISCONNECT MUX_IDLE_AS_IS 1>;
+		};
+	};
+
+	adc-mux {
+		compatible = "io-channel-mux";
+		io-channels = <&adc 0>;
+		io-channel-names = "parent";
+
+		mux-controls = <&mux 2>;
+
+		channels = "sync-1", "", "out";
+	};
+
+
+	/*
+	 * Three parallel muxes with one mux controller, useful e.g. if
+	 * the adc is differential, thus needing two signals to be muxed
+	 * simultaneously for correct operation.
+	 */
+	&i2c0 {
+		pmux: mux-controller@50 {
+			compatible = "adi,adg792a";
+			reg = <0x50>;
+			#mux-control-cells = <0>;
+
+			idle-state = <1>;
+		};
+	};
+
+	diff-adc-mux {
+		compatible = "io-channel-mux";
+		io-channels = <&adc 0>;
+		io-channel-names = "parent";
+
+		mux-controls = <&pmux>;
+
+		channels = "sync-1", "", "out";
+	};
-- 
2.1.4
