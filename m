From: Biwen Li <biwen.li@nxp.com>
Subject: [v2,1/2] dt-bindings: i2c: add property idle-state
Date: Tue, 15 Oct 2019 12:48:38 +0800
Message-ID: <20191015044839.23746-1-biwen.li@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: peda@axentia.se, leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Biwen Li <biwen.li@nxp.com>
List-Id: linux-i2c@vger.kernel.org

This adds property idle-state

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
Change in v2:
	- update subject and description
	- add property idle-state

 Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
index 30ac6a60f041..2c7875d338fb 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
@@ -34,6 +34,7 @@ Optional Properties:
     - first cell is the pin number
     - second cell is used to specify flags.
     See also Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+  - idle-state: Please refer to Documentation/devicetree/bindings/mux/mux-controller.txt
 
 Example:
 
-- 
2.17.1
