From: Vitor soares <Vitor.Soares@synopsys.com>
Subject: [PATCH 2/3] dt-bindings: i3c: Document Synopsys DesignWare I3C master bindings
Date: Fri, 20 Jul 2018 21:57:51 +0100
Message-ID: <1532120272-17157-3-git-send-email-soares@synopsys.com>
References: <1532120272-17157-1-git-send-email-soares@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532120272-17157-1-git-send-email-soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: boris.brezillon@bootlin.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de
Cc: psroka@cadence.com, agolec@cadence.com, adouglas@cadence.com, bfolta@cadence.com, dkos@cadence.com, alicja@cadence.com, cwronka@cadence.com, sureshp@cadence.com, rafalc@cadence.com, thomas.petazzoni@bootlin.com, nm@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, geert@linux-m68k.org, linus.walleij@linaro.org, Xiang.Lin@synaptics.com, linux-gpio@vger.kernel.org, nsekhar@ti.com, pgaj@cadence.com, peda@axentia.se, Joao.Pinto@synopsys.com, Vitor.Soares@synopsys.com
List-Id: linux-i2c@vger.kernel.org

This patch document Synopsys DesignWare I3C master DT bindings.

Signed-off-by: Vitor soares <soares@synopsys.com>
---
 .../devicetree/bindings/i3c/snps,dw-i3c-master.txt | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt

diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
new file mode 100644
index 0000000..7f5c8b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
@@ -0,0 +1,43 @@
+Bindings for Synopsys DesignWare I3C master block
+=================================================
+
+Required properties:
+--------------------
+- compatible: shall be "snps,dw-i3c-master"
+- clocks: shall reference the core_clk
+- clock-names: shall contain "core_clk"
+- interrupts: the interrupt line connected to this I3C master
+- reg:  Offset and length of I3C master registers
+
+Mandatory properties defined by the generic binding (see
+Documentation/devicetree/bindings/i3c/i3c.txt for more details):
+
+- #address-cells: shall be set to 3
+- #size-cells: shall be set to 0
+
+Optional properties defined by the generic binding (see
+Documentation/devicetree/bindings/i3c/i3c.txt for more details):
+
+- i2c-scl-hz
+- i3c-scl-hz
+
+I3C device connected on the bus follow the generic description (see
+Documentation/devicetree/bindings/i3c/i3c.txt for more details).
+
+Example:
+
+	i3c-master@0x2000 {
+		compatible = "snps,dw-i3c-master";
+		#address-cells = <3>;
+		#size-cells = <0>;
+		reg = <0x02000 0x1000>;
+		interrupts = <0>;
+		clocks = <&i3cclk>;
+		clock-names = "core_clk";
+
+		eeprom@0x57{
+			compatible = "atmel,24c01";
+			reg = < 0x57 0x80000010 0x0>;
+			pagesize = <0x8>;
+		};
+	};
-- 
2.7.4
