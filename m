From: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Subject: [PATCH 3/3] i2c: uniphier: add bindings for UniPhier I2C controllers
Date: Thu, 30 Jul 2015 17:12:22 +0900
Message-ID: <1438243942-26401-4-git-send-email-yamada.masahiro@socionext.com>
References: <1438243942-26401-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438243942-26401-1-git-send-email-yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Device Tree bindings for two I2C controllers embedded in
UniPhier SoCs.

Signed-off-by: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
---

 .../devicetree/bindings/i2c/i2c-uniphier.txt       | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-uniphier.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-uniphier.txt b/Documentation/devicetree/bindings/i2c/i2c-uniphier.txt
new file mode 100644
index 0000000..e4ddb50
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-uniphier.txt
@@ -0,0 +1,46 @@
+UniPhier I2C controller
+
+Two different types of I2C controller IPs are used on UniPhier SoC platform:
+- FIFO-less I2C controller on PH-LD4, PH1-sLD8 or older SoCs
+- FIFO-builtin I2C controller on PH1-Pro4 or newer SoCs
+
+Required properties:
+- compatible: should be one of the followings:
+	"socionext,uniphier-i2c"  (FIFO-less)
+	"socionext,uniphier-fi2c" (FIFO-builtin)
+- #address-cells: should be 1.
+- #size-cells: should be 0.
+- reg: offset and length of the register set for the device.
+- interrupts: a single interrupt specifier.
+- clocks: phandle to the input clock.
+
+Optional properties:
+- clock-frequency: desired I2C bus frequency in Hz.  The maximum supported
+  value is 400000.  Defaults to 100000 if not specified.
+
+Examples:
+
+- FIFO-less
+
+	i2c0: i2c@58400000 {
+		compatible = "socionext,uniphier-i2c";
+		reg = <0x58400000 0x40>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <0 41 1>;
+		clocks = <&i2c_clk>;
+		clock-frequency = <100000>;
+	};
+
+
+- FIFO-builtin
+
+	i2c0: i2c@58780000 {
+		compatible = "socionext,uniphier-fi2c";
+		reg = <0x58780000 0x80>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <0 41 4>;
+		clocks = <&i2c_clk>;
+		clock-frequency = <100000>;
+	};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
