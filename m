From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH 1/2] i2c: dt binding documentation for the Digicolor I2C controller
Date: Mon, 16 Feb 2015 15:20:03 +0200
Message-ID: <7da767503ac6085c10fbd1953ffd36621b8bf0c5.1424092804.git.baruch@tkos.co.il>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The CX92755 is an SoC in the Conexant Digicolor series. This devicetree binding
document describes the I2C controller on the CX92755 SoC, that is also shared
by some other SoCs in the Digicolor series.

Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
 .../devicetree/bindings/i2c/i2c-digicolor.txt      | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-digicolor.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-digicolor.txt b/Documentation/devicetree/bindings/i2c/i2c-digicolor.txt
new file mode 100644
index 000000000000..457a098d4f7e
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-digicolor.txt
@@ -0,0 +1,25 @@
+Conexant Digicolor I2C controller
+
+Required properties:
+ - compatible: must be "cnxt,cx92755-i2c"
+ - reg: physical address and length of the device registers
+ - interrupts: a single interrupt specifier
+ - clocks: clock for the device
+ - #address-cells: should be <1>
+ - #size-cells: should be <0>
+
+Optional properties:
+- clock-frequency: the desired I2C bus clock frequency in Hz; in
+  absence of this property the default value is used (100 kHz).
+
+Example:
+
+	i2c: i2c@f0000120 {
+		compatible = "cnxt,cx92755-i2c";
+		reg = <0xf0000120 0x10>;
+		interrupts = <28>;
+		clocks = <&main_clk>;
+		clock-frequency = <100000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
-- 
2.1.4
