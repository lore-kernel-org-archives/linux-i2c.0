From: Vitor Soares <vitor.soares@synopsys.com>
Subject: [PATCH v4 2/3] dt-binding: i3c: Document Synopsys DesignWare I3C
Date: Tue, 13 Nov 2018 14:09:52 +0000
Message-ID: <1542118193-24925-3-git-send-email-vitor.soares@synopsys.com>
References: <1542118193-24925-1-git-send-email-vitor.soares@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542118193-24925-1-git-send-email-vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: boris.brezillon@bootlin.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de
Cc: psroka@cadence.com, agolec@cadence.com, adouglas@cadence.com, bfolta@cadence.com, dkos@cadence.com, alicja@cadence.com, cwronka@cadence.com, sureshp@cadence.com, rafalc@cadence.com, thomas.petazzoni@bootlin.com, nm@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vitor.soares@synopsys.com, geert@linux-m68k.org, linus.walleij@linaro.org, Xiang.Lin@synaptics.com, linux-gpio@vger.kernel.org, nsekhar@ti.com, pgaj@cadence.com, peda@axentia.se, mshettel@codeaurora.org, swboyd@chromium.org, joao.pinto@synopsys.com
List-Id: linux-i2c@vger.kernel.org

Document Synopsys DesignWare I3C master module

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v4:
- Change email soares@synopsys.com to vitor.soares@synopsys.com
- Add Rob Herring R-b

Changes in v3:
- Remove dummy characters

Changes in v2:
- Address the changes in Documentation/devicetree/bindings/i3c/i3c.txt
- Add controller version on compatible string

 .../devicetree/bindings/i3c/snps,dw-i3c-master.txt | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt

diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
new file mode 100644
index 0000000..5020eb7
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
@@ -0,0 +1,41 @@
+Bindings for Synopsys DesignWare I3C master block
+=================================================
+
+Required properties:
+--------------------
+- compatible: shall be "snps,dw-i3c-master-1.00a"
+- clocks: shall reference the core_clk
+- interrupts: the interrupt line connected to this I3C master
+- reg: Offset and length of I3C master registers
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
+	i3c-master@2000 {
+		compatible = "snps,dw-i3c-master-1.00a";
+		#address-cells = <3>;
+		#size-cells = <0>;
+		reg = <0x02000 0x1000>;
+		interrupts = <0>;
+		clocks = <&i3cclk>;
+
+		eeprom@57{
+			compatible = "atmel,24c01";
+			reg = <0x57 0x0 0x10>;
+			pagesize = <0x8>;
+		};
+	};
-- 
2.7.4
