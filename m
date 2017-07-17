From: thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Subject: [PATCHv5 2/3] dt-bindings: i2c: Add Altera I2C Controller
Date: Mon, 17 Jul 2017 11:35:13 -0500
Message-ID: <1500309314-18464-3-git-send-email-thor.thayer@linux.intel.com>
References: <1500309314-18464-1-git-send-email-thor.thayer@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1500309314-18464-1-git-send-email-thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Thor Thayer <thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Add the documentation to support the Altera synthesizable
logic I2C Controller in FPGA.

Signed-off-by: Thor Thayer <thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
v2  Change the subject to identify dt-bindings
    Add synthesizable logic to description.
    Change compatible string to "altr,softip-i2c"
    Make description of clock phandle singular since 1 clock.
    Remove altr, from fifo-size
    Specify fifo-size is in bytes.
v3  Add version to compatible string "altr,softip-i2c-v1.0"
    Add for use in FPGA in description.
v4  No Change - Add Acked-by
v5  No Change
---
 .../devicetree/bindings/i2c/i2c-altera.txt         | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-altera.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-altera.txt b/Documentation/devicetree/bindings/i2c/i2c-altera.txt
new file mode 100644
index 0000000..767664f
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-altera.txt
@@ -0,0 +1,39 @@
+* Altera I2C Controller
+* This is Altera's synthesizable logic block I2C Controller for use
+* in Altera's FPGAs.
+
+Required properties :
+ - compatible : should be "altr,softip-i2c-v1.0"
+ - reg        : Offset and length of the register set for the device
+ - interrupts : <IRQ> where IRQ is the interrupt number.
+ - clocks     : phandle to input clock.
+ - #address-cells = <1>;
+ - #size-cells = <0>;
+
+Recommended properties :
+ - clock-frequency : desired I2C bus clock frequency in Hz.
+
+Optional properties :
+ - fifo-size : Size of the RX and TX FIFOs in bytes.
+ - Child nodes conforming to i2c bus binding
+
+Example :
+
+	i2c@100080000 {
+		compatible = "altr,softip-i2c-v1.0";
+		reg = <0x00000001 0x00080000 0x00000040>;
+		interrupt-parent = <&intc>;
+		interrupts = <0 43 4>;
+		clocks = <&clk_0>;
+		clock-frequency = <100000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		fifo-size = <4>;
+
+		eeprom@51 {
+			compatible = "atmel,24c32";
+			reg = <0x51>;
+			pagesize = <32>;
+		};
+	};
+
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
