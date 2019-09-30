From: Biwen Li <biwen.li@nxp.com>
Subject: [v2,2/2] dt-bindings: i2c-mux-pca954x: Add optional property i2c-mux-never-disable
Date: Mon, 30 Sep 2019 11:25:03 +0800
Message-ID: <20190930032503.44425-2-biwen.li@nxp.com>
References: <20190930032503.44425-1-biwen.li@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190930032503.44425-1-biwen.li@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peda@axentia.se, leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Biwen Li <biwen.li@nxp.com>
List-Id: linux-i2c@vger.kernel.org

The patch adds an optional property i2c-mux-never-disable

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
Change in v2:
	- update documentation

 Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
index 30ac6a60f041..71b73d0fdb62 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
@@ -34,6 +34,7 @@ Optional Properties:
     - first cell is the pin number
     - second cell is used to specify flags.
     See also Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+  - i2c-mux-never-disable: always forces mux to be enabled.
 
 Example:
 
-- 
2.17.1
