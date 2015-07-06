From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 2/5] i2c: emev2: add binding documentation
Date: Mon,  6 Jul 2015 23:46:06 +0200
Message-ID: <1436219188-4325-3-git-send-email-wsa@the-dreams.de>
References: <1436219188-4325-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1436219188-4325-1-git-send-email-wsa@the-dreams.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 .../devicetree/bindings/i2c/i2c-emev2.txt          | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-emev2.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-emev2.txt b/Documentation/devicetree/bindings/i2c/i2c-emev2.txt
new file mode 100644
index 00000000000000..a6740066835056
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-emev2.txt
@@ -0,0 +1,22 @@
+Device tree configuration for Renesas EMEV2 IIC driver
+
+Required properties:
+- compatible      : "renesas,iic-<soctype>". "renesas,iic-emev2" as fallback
+- reg             : address start and address range size of device
+- interrupts      : 1 interrupt
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

