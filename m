From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [PATCH 3/4] i2c: pca954x: Add device tree bindings documentation
Date: Fri, 29 Nov 2013 01:51:24 +0100
Message-ID: <1385686285-23780-4-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1385686285-23780-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385686285-23780-1-git-send-email-laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 .../devicetree/bindings/i2c/i2c-mux-pca954x.txt    | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
new file mode 100644
index 0000000..cc7e7fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
@@ -0,0 +1,46 @@
+* NXP PCA954x I2C bus switch
+
+Required Properties:
+
+  - compatible: Must contain one of the following.
+    "nxp,pca9540", "nxp,pca9542", "nxp,pca9543", "nxp,pca9544",
+    "nxp,pca9545", "nxp,pca9546", "nxp,pca9547", "nxp,pca9548"
+
+  - reg: The I2C address of the device.
+
+  The following required properties are defined externally:
+
+  - Standard I2C mux properties. See i2c-mux.txt in this directory.
+  - I2C child bus nodes. See i2c-mux.txt in this directory.
+
+
+Example:
+
+	i2c-switch@74 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x74>;
+
+		i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+
+			eeprom@54 {
+				compatible = "at,24c08";
+				reg = <0x54>;
+			};
+		};
+
+		i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+
+			rtc@51 {
+				compatible = "nxp,pcf8563";
+				reg = <0x51>;
+			};
+		};
+	};
-- 
1.8.3.2
