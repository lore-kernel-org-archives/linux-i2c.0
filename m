From: Eddie James <eajames-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v5 6/6] dt-bindings: i2c: Add FSI-attached I2C master dt binding documentation
Date: Wed, 26 Jul 2017 12:13:18 -0500
Message-ID: <1501089198-10356-7-git-send-email-eajames@linux.vnet.ibm.com>
References: <1501089198-10356-1-git-send-email-eajames@linux.vnet.ibm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1501089198-10356-1-git-send-email-eajames-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jk-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org, andrew-zrmu5oMJ5Fs@public.gmane.org, cbostic-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, eajames-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, "Edward A. James" <eajames-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: "Edward A. James" <eajames-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

Document the bindings.

Signed-off-by: Edward A. James <eajames-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/i2c/i2c-fsi.txt | 40 +++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-fsi.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-fsi.txt b/Documentation/devicetree/bindings/i2c/i2c-fsi.txt
new file mode 100644
index 0000000..b1be2ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-fsi.txt
@@ -0,0 +1,40 @@
+Device-tree bindings for FSI-attached I2C master and busses
+-----------------------------------------------------------
+
+Required properties:
+ - compatible = "ibm,i2c-fsi";
+ - reg = < address size >;		: The FSI CFAM address and address
+					  space size.
+ - #address-cells = <1>;		: Number of address cells in child
+					  nodes.
+ - #size-cells = <0>;			: Number of size cells in child nodes.
+ - child nodes				: Nodes to describe busses off the I2C
+					  master.
+
+Child node required properties:
+ - reg = < port number >		: The port number on the I2C master.
+
+Child node optional properties:
+ - child nodes				: Nodes to describe devices on the I2C
+					  bus.
+
+Examples:
+
+    i2c@1800 {
+        compatible = "ibm,i2c-fsi";
+        reg = < 0x1800 0x400 >;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        i2c-bus@0 {
+            reg = <0>;
+        };
+
+        i2c-bus@1 {
+            reg = <1>;
+
+            eeprom@50 {
+                compatible = "vendor,dev-name";
+            };
+        };
+    };
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
