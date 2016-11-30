From: Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v5 2/2] i2c: aspeed: added documentation for Aspeed I2C driver
Date: Tue, 29 Nov 2016 17:00:18 -0800
Message-ID: <1480467618-7497-3-git-send-email-brendanhiggins@google.com>
References: <1480467618-7497-1-git-send-email-brendanhiggins@google.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1480467618-7497-1-git-send-email-brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org, clg-Bxea+6Xhats@public.gmane.org, mouse-Pma6HLj0uuo@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org, openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Added device tree binding documentation for Aspeed I2C controller and
busses.

Signed-off-by: Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
---
Changes for v2:
  - None
Changes for v3:
  - Removed reference to "bus" device tree param
Changes for v4:
  - None
Changes for v5:
  - None
---
 .../devicetree/bindings/i2c/i2c-aspeed.txt         | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-aspeed.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
new file mode 100644
index 0000000..dd11a97
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
@@ -0,0 +1,61 @@
+Device tree configuration for the I2C controller and busses on the AST24XX
+and AST25XX SoCs.
+
+Controller:
+
+	Required Properties:
+	- #address-cells	: should be 1
+	- #size-cells 		: should be 1
+	- #interrupt-cells 	: should be 1
+	- compatible 		: should be "aspeed,ast2400-i2c-controller"
+				  or "aspeed,ast2500-i2c-controller"
+	- reg			: address start and range of controller
+	- ranges		: defines address offset and range for busses
+	- interrupts		: interrupt number
+	- clocks		: root clock of bus, should reference the APB
+				  clock
+	- clock-ranges		: specifies that child busses can inherit clocks
+	- interrupt-controller	: denotes that the controller receives and fires
+				  new interrupts for child busses
+
+Bus:
+
+	Required Properties:
+	- #address-cells	: should be 1
+	- #size-cells		: should be 0
+	- reg			: address offset and range of bus
+	- compatible		: should be "aspeed,ast2400-i2c-bus"
+				  or "aspeed,ast2500-i2c-bus"
+	- interrupts		: interrupt number
+
+	Optional Properties:
+	- clock-frequency	: frequency of the bus clock in Hz
+				  defaults to 100 kHz when not specified
+
+Example:
+
+i2c: i2c@1e78a000 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	#interrupt-cells = <1>;
+
+	compatible = "aspeed,ast2400-i2c-controller";
+	reg = <0x1e78a000 0x40>;
+	ranges = <0 0x1e78a000 0x1000>;
+	interrupts = <12>;
+	clocks = <&clk_apb>;
+	clock-ranges;
+	interrupt-controller;
+
+	i2c0: i2c-bus@40 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x40 0x40>;
+		compatible = "aspeed,ast2400-i2c-bus";
+		clock-frequency = <100000>;
+		status = "disabled";
+		interrupts = <0>;
+		interrupt-parent = <&i2c>;
+	};
+};
+
-- 
2.8.0.rc3.226.g39d4020

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
