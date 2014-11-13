From: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v6 2/2] DT: i2c: Add binding document for IMG I2C SCB
Date: Thu, 13 Nov 2014 10:25:11 -0300
Message-ID: <1415885111-4138-3-git-send-email-ezequiel.garcia@imgtec.com>
References: <1415885111-4138-1-git-send-email-ezequiel.garcia@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1415885111-4138-1-git-send-email-ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>

Introduce a devicetree binding for Imagination Technologies
I2C SCB controller.

Reviewed-by: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
---
 .../devicetree/bindings/i2c/i2c-img-scb.txt        | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-img-scb.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-img-scb.txt b/Documentation/devicetree/bindings/i2c/i2c-img-scb.txt
new file mode 100644
index 0000000..b646160
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-img-scb.txt
@@ -0,0 +1,26 @@
+IMG Serial Control Bus (SCB) I2C Controller
+
+Required Properties:
+- compatible: "img,scb-i2c"
+- reg: Physical base address and length of controller registers
+- interrupts: Interrupt number used by the controller
+- clocks : Should contain a clock specifier for each entry in clock-names
+- clock-names : Should contain the following entries:
+                "scb", for the SCB core clock.
+                "sys", for the system clock.
+- clock-frequency: The I2C bus frequency in Hz
+- #address-cells: Should be <1>
+- #size-cells: Should be <0>
+
+Example:
+
+i2c@18100000 {
+	compatible = "img,scb-i2c";
+	reg = <0x18100000 0x200>;
+	interrupts = <GIC_SHARED 2 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&i2c0_clk>, <&system_clk>;
+	clock-names = "scb", "sys";
+	clock-frequency = <400000>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+};
-- 
2.1.0
