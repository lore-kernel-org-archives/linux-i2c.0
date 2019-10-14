From: Biwen Li <biwen.li@nxp.com>
Subject: [PATCH 1/2] dt-bindings: i2c: replace property i2c-mux-idle-disconnect
Date: Mon, 14 Oct 2019 19:25:57 +0800
Message-ID: <20191014112558.3881-1-biwen.li@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: peda@axentia.se, leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Biwen Li <biwen.li@nxp.com>
List-Id: linux-i2c@vger.kernel.org

This replaces property i2c-mux-idle-disconnect with idle-state

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
 Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
index 30ac6a60f041..f2db517b1635 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
@@ -25,9 +25,7 @@ Required Properties:
 Optional Properties:
 
   - reset-gpios: Reference to the GPIO connected to the reset input.
-  - i2c-mux-idle-disconnect: Boolean; if defined, forces mux to disconnect all
-    children in idle state. This is necessary for example, if there are several
-    multiplexers on the bus and the devices behind them use same I2C addresses.
+  - idle-state: Please refer to Documentation/devicetree/bindings/mux/mux-controller.txt
   - interrupts: Interrupt mapping for IRQ.
   - interrupt-controller: Marks the device node as an interrupt controller.
   - #interrupt-cells : Should be two.
-- 
2.17.1
