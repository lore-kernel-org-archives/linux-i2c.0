From: Biwen Li <biwen.li@nxp.com>
Subject: [v4,1/2] dt-bindings: i2c: support property idle-state
Date: Mon, 21 Oct 2019 16:00:47 +0800
Message-ID: <20191021080048.47189-1-biwen.li@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: peda@axentia.se, leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Biwen Li <biwen.li@nxp.com>
List-Id: linux-i2c@vger.kernel.org

This supports property idle-state

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
Change in v4:
	- none

Change in v3:
	- update subject and description
	- add some information for property idle-state

Change in v2:
	- update subject and description
	- add property idle-state

 Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
index 30ac6a60f041..7abda506b828 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
@@ -25,6 +25,8 @@ Required Properties:
 Optional Properties:
 
   - reset-gpios: Reference to the GPIO connected to the reset input.
+  - idle-state: if present, overrides i2c-mux-idle-disconnect,
+    Please refer to Documentation/devicetree/bindings/mux/mux-controller.txt
   - i2c-mux-idle-disconnect: Boolean; if defined, forces mux to disconnect all
     children in idle state. This is necessary for example, if there are several
     multiplexers on the bus and the devices behind them use same I2C addresses.
-- 
2.17.1
