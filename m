From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v2 2/5] i2c: emev2: add binding documentation
Date: Sat, 11 Jul 2015 09:46:23 +0200
Message-ID: <1436600786-3068-3-git-send-email-wsa@the-dreams.de>
References: <1436600786-3068-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1436600786-3068-1-git-send-email-wsa@the-dreams.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Ian Molton <ian.molton@codethink.co.uk>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Change since v1:
* removed <soctype> binding, thanks Geert
* reworded interrupt property, thanks Laurent

 .../devicetree/bindings/i2c/i2c-emev2.txt          | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-emev2.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-emev2.txt b/Documentation/devicetree/bindings/i2c/i2c-emev2.txt
new file mode 100644
index 00000000000000..5ed1ea1c7e14a9
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-emev2.txt
@@ -0,0 +1,22 @@
+Device tree configuration for Renesas EMEV2 IIC controller
+
+Required properties:
+- compatible      : "renesas,iic-emev2"
+- reg             : address start and address range size of device
+- interrupts      : specifier for the IIC controller interrupt
+- clocks          : phandle to the IP core SCLK
+- clock-names     : must be "sclk"
+- #address-cells  : should be <1>
+- #size-cells     : should be <0>
+
+Example:
+
+	iic0: i2c@e0070000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,iic-emev2";
+		reg = <0xe0070000 0x28>;
+		interrupts = <0 32 IRQ_TYPE_EDGE_RISING>;
+		clocks = <&iic0_sclk>;
+		clock-names = "sclk";
+	};
-- 
2.1.4

