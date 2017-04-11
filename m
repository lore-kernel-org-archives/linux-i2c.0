From: thor.thayer@linux.intel.com
Subject: [PATCH 2/3] Documentation: dt: i2c: Add Altera I2C Controller
Date: Tue, 11 Apr 2017 11:02:26 -0500
Message-ID: <1491926547-29510-3-git-send-email-thor.thayer@linux.intel.com>
References: <1491926547-29510-1-git-send-email-thor.thayer@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:44060 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752433AbdDKP7W (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 11 Apr 2017 11:59:22 -0400
In-Reply-To: <1491926547-29510-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, robh@kernel.org
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Thor Thayer <thor.thayer@linux.intel.com>

From: Thor Thayer <thor.thayer@linux.intel.com>

Add the documentation to support the Altera I2C Controller.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 .../devicetree/bindings/i2c/i2c-altera.txt         | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-altera.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-altera.txt b/Documentation/devicetree/bindings/i2c/i2c-altera.txt
new file mode 100644
index 0000000..a67241c
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-altera.txt
@@ -0,0 +1,37 @@
+* Altera I2C Controller
+
+Required properties :
+ - compatible : should be "altr,sip-i2c"
+ - reg        : Offset and length of the register set for the device
+ - interrupts : <IRQ> where IRQ is the interrupt number.
+ - clocks     : phandles to input clocks.
+ - #address-cells = <1>;
+ - #size-cells = <0>;
+
+Recommended properties :
+ - clock-frequency : desired I2C bus clock frequency in Hz.
+
+Optional properties :
+ - altr,fifo-size : Size of the RX and TX FIFOs.
+ - Child nodes conforming to i2c bus binding
+
+Example :
+
+	i2c@100080000 {
+		compatible = "altr,sip-i2c";
+		reg = <0x00000001 0x00080000 0x00000040>;
+		interrupt-parent = <&intc>;
+		interrupts = <0 43 4>;
+		clocks = <&clk_0>;
+		clock-frequency = <100000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		altr,fifo-size = <4>;
+
+		eeprom@51 {
+			compatible = "atmel,24c32";
+			reg = <0x51>;
+			pagesize = <32>;
+		};
+	};
+
-- 
1.9.1
