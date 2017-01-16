From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Subject: [PATCH v4 2/5] dt: bindings: i2c-mux-pca954x: Add documentation for interrupt controller
Date: Mon, 16 Jan 2017 11:11:12 +0800
Message-ID: <1484536275-75995-3-git-send-email-preid@electromag.com.au>
References: <1484536275-75995-1-git-send-email-preid@electromag.com.au>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1484536275-75995-1-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Various muxes can aggregate multiple irq lines and provide a control
register to determine the active line. Add bindings for interrupt
controller support.

Acked-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
---
 Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
index cf53d5f..aa09704 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
@@ -19,7 +19,14 @@ Optional Properties:
   - i2c-mux-idle-disconnect: Boolean; if defined, forces mux to disconnect all
     children in idle state. This is necessary for example, if there are several
     multiplexers on the bus and the devices behind them use same I2C addresses.
-
+  - interrupt-parent: Phandle for the interrupt controller that services
+    interrupts for this device.
+  - interrupts: Interrupt mapping for IRQ.
+  - interrupt-controller: Marks the device node as an interrupt controller.
+  - #interrupt-cells : Should be two.
+    - first cell is the pin number
+    - second cell is used to specify flags.
+    See also Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
 
 Example:
 
@@ -29,6 +36,11 @@ Example:
 		#size-cells = <0>;
 		reg = <0x74>;
 
+		interrupt-parent = <&ipic>;
+		interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
 		i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
