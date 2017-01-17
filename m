From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v5 2/5] dt: bindings: i2c-mux-pca954x: Add documentation for interrupt controller
Date: Tue, 17 Jan 2017 16:00:26 +0800
Message-ID: <1484640029-22870-3-git-send-email-preid@electromag.com.au>
References: <1484640029-22870-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:34160 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751023AbdAQIAj (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 17 Jan 2017 03:00:39 -0500
In-Reply-To: <1484640029-22870-1-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: peda@axentia.se, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, preid@electromag.com.au, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org

Various muxes can aggregate multiple irq lines and provide a control
register to determine the active line. Add bindings for interrupt
controller support.

Acked-by: Peter Rosin <peda@axentia.se>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Phil Reid <preid@electromag.com.au>
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
