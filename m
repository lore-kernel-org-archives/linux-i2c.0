From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Subject: [PATCH v6 3/6] i2c: at91: update documentation for DT bindings
Date: Tue, 9 Jun 2015 18:22:16 +0200
Message-ID: <9f47a33d22873d75c67574736515bea46747d302.1433866582.git.cyrille.pitchen@atmel.com>
References: <cover.1433866582.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1433866582.git.cyrille.pitchen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ludovic.desroches@atmel.com, nicolas.ferre@atmel.com, linux-i2c@vger.kernel.org, wsa@the-dreams.de
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, robh+dt@kernel.org, Cyrille Pitchen <cyrille.pitchen@atmel.com>
List-Id: linux-i2c@vger.kernel.org

add a new value "atmel,sama5d2-i2c" for the "compatible" property.
add a new optional property "atmel,fifo-size" to enable FIFO support when
available.
add missing optional properties "dmas" and "dma-names".

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 Documentation/devicetree/bindings/i2c/i2c-at91.txt | 30 ++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-at91.txt b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
index 388f0a2..6e81dc1 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-at91.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
@@ -2,8 +2,8 @@ I2C for Atmel platforms
 
 Required properties :
 - compatible : Must be "atmel,at91rm9200-i2c", "atmel,at91sam9261-i2c",
-     "atmel,at91sam9260-i2c", "atmel,at91sam9g20-i2c", "atmel,at91sam9g10-i2c"
-     or "atmel,at91sam9x5-i2c"
+     "atmel,at91sam9260-i2c", "atmel,at91sam9g20-i2c", "atmel,at91sam9g10-i2c",
+     "atmel,at91sam9x5-i2c" or "atmel,sama5d2-i2c"
 - reg: physical base address of the controller and length of memory mapped
      region.
 - interrupts: interrupt number to the cpu.
@@ -13,6 +13,10 @@ Required properties :
 
 Optional properties:
 - clock-frequency: Desired I2C bus frequency in Hz, otherwise defaults to 100000
+- dmas: A list of two dma specifiers, one for each entry in dma-names.
+- dma-names: should contain "tx" and "rx".
+- atmel,fifo-size: maximum number of data the RX and TX FIFOs can store for FIFO
+  capable I2C controllers.
 - Child nodes conforming to i2c bus binding
 
 Examples :
@@ -32,3 +36,25 @@ i2c0: i2c@fff84000 {
 		pagesize = <128>;
 	}
 }
+
+i2c0: i2c@f8034600 {
+	compatible = "atmel,sama5d2-i2c";
+	reg = <0xf8034600 0x100>;
+	interrupts = <19 IRQ_TYPE_LEVEL_HIGH 7>;
+	dmas = <&dma0
+		(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1))
+		AT91_XDMAC_DT_PERID(11)>,
+	       <&dma0
+		(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1))
+		AT91_XDMAC_DT_PERID(12)>;
+	dma-names = "tx", "rx";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clocks = <&flx0>;
+	atmel,fifo-size = <16>;
+
+	wm8731: wm8731@1a {
+		compatible = "wm8731";
+		reg = <0x1a>;
+	};
+};
-- 
1.8.2.2
