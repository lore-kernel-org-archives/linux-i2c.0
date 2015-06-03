From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 3/6] i2c: at91: update documentation for DT bindings
Date: Wed, 3 Jun 2015 11:04:24 +0200
Message-ID: <aa2a1ec2bd3da46c9a3bbbe0812d82de09d66095.1433321260.git.cyrille.pitchen@atmel.com>
References: <cover.1433321260.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1433321260.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

add a new value "atmel,at91sama5d2-i2c" for the "compatible" property.
add a new optional property "atmel,fifo-size" to enable FIFO support when
available.
add missing optional properties "dmas" and "dma-names".

Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 Documentation/devicetree/bindings/i2c/i2c-at91.txt | 29 ++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-at91.txt b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
index 388f0a2..7c04fd9 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-at91.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
@@ -2,8 +2,8 @@ I2C for Atmel platforms
 
 Required properties :
 - compatible : Must be "atmel,at91rm9200-i2c", "atmel,at91sam9261-i2c",
-     "atmel,at91sam9260-i2c", "atmel,at91sam9g20-i2c", "atmel,at91sam9g10-i2c"
-     or "atmel,at91sam9x5-i2c"
+     "atmel,at91sam9260-i2c", "atmel,at91sam9g20-i2c", "atmel,at91sam9g10-i2c",
+     "atmel,at91sam9x5-i2c" or "atmel,at91sama5d2-i2c"
 - reg: physical base address of the controller and length of memory mapped
      region.
 - interrupts: interrupt number to the cpu.
@@ -13,6 +13,9 @@ Required properties :
 
 Optional properties:
 - clock-frequency: Desired I2C bus frequency in Hz, otherwise defaults to 100000
+- dmas: A list of two dma specifiers, one for each entry in dma-names.
+- dma-names: should contain "tx" and "rx".
+- atmel,fifo-size: size of the RX and TX FIFOs, if available.
 - Child nodes conforming to i2c bus binding
 
 Examples :
@@ -32,3 +35,25 @@ i2c0: i2c@fff84000 {
 		pagesize = <128>;
 	}
 }
+
+i2c0: i2c@f8034600 {
+	compatible = "atmel,at91sama5d2-i2c";
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
+	atmel,fifo-size = <32>;
+
+	wm8731: wm8731@1a {
+		compatible = "wm8731";
+		reg = <0x1a>;
+	};
+};
-- 
1.8.2.2
