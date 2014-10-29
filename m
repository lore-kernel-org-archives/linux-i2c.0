From: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] DT: i2c: Add binding document for IMG I2C SCB
Date: Wed, 29 Oct 2014 16:57:21 -0300
Message-ID: <1414612641-4259-3-git-send-email-ezequiel.garcia@imgtec.com>
References: <1414612641-4259-1-git-send-email-ezequiel.garcia@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1414612641-4259-1-git-send-email-ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>

From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>

Introduce a devicetree binding for Imagination Technologies
I2C SCB controller.

Signed-off-by: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
---
 Documentation/devicetree/bindings/i2c/i2c-img-scb.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-img-scb.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-img-scb.txt b/Documentation/devicetree/bindings/i2c/i2c-img-scb.txt
new file mode 100644
index 0000000..39fa9c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-img-scb.txt
@@ -0,0 +1,14 @@
+IMG Serial Control Bus (SCB) I2C Controller
+
+Required Properties:
+- compatible: "img,scb-i2c"
+- reg: Physical base address and length of controller registers
+- interrupts: Interrupt number used by the controller
+- clocks : Clock specifier to the SCB clock node
+- clock-frequency: The I2C bus frequency in Hz
+- bus-delay : Bus delay in ms
+
+Optional properties:
+- linux,i2c-index: Can be used to override the I2C bus number. This is useful
+  when some of the I2C adapters are used by other non-Linux cores so would get
+  numbered incorrectly by default.
-- 
2.1.0
