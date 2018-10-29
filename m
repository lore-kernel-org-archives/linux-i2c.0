From: Vitor soares <vitor.soares@synopsys.com>
Subject: [PATCH 2/3] dt-bindings: i3c: Document Synopsys DesignWare I3C master bindings
Date: Mon, 29 Oct 2018 10:06:57 +0000
Message-ID: <1540807618-13246-3-git-send-email-soares@synopsys.com>
References: <1540807618-13246-1-git-send-email-soares@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540807618-13246-1-git-send-email-soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: boris.brezillon@bootlin.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de
Cc: psroka@cadence.com, agolec@cadence.com, adouglas@cadence.com, bfolta@cadence.com, dkos@cadence.com, alicja@cadence.com, cwronka@cadence.com, sureshp@cadence.com, rafalc@cadence.com, thomas.petazzoni@bootlin.com, nm@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vitor.soares@synopsys.com, geert@linux-m68k.org, linus.walleij@linaro.org, Xiang.Lin@synaptics.com, linux-gpio@vger.kernel.org, nsekhar@ti.com, pgaj@cadence.com, peda@axentia.se, mshettel@codeaurora.org, swboyd@chromium.org, joao.pinto@synopsys.com, luis.oliveira@synopsys.com, manuel.abreu@synopsys.com, gustavo.pimentel@synopsys.com
List-Id: linux-i2c@vger.kernel.org

Document Synopsys DesignWare I3C master module

Signed-off-by: Vitor soares <soares@synopsys.com>
---
Changes in v2:
-Address the changes in Documentation/devicetree/bindings/i3c/i3c.txt
-Add controller version on compatible string

 .../devicetree/bindings/i3c/snps,dw-i3c-master.txt | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100755 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt

diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
new file mode 100755
index 0000000..b930c09
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
@@ -0,0 +1,42 @@
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
+			reg = < 0x57 0x0 0x10>;
+			pagesize = <0x8>;
+		};
+	};
+
-- 
2.7.4
