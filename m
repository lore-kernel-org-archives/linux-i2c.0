From: Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] devicetree: i2c: add binding for Sigma Designs SMP8642 I2C master
Date: Sat, 31 Oct 2015 17:35:56 +0000
Message-ID: <1446312957-18744-1-git-send-email-mans@mansr.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This adds a binding for the Sigma Designs SMP8642 built-in I2C master
controller.

Signed-off-by: Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
---
 .../devicetree/bindings/i2c/sigma,smp8642-i2c.txt  | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/sigma,smp8642-i2c.txt

diff --git a/Documentation/devicetree/bindings/i2c/sigma,smp8642-i2c.txt b/Documentation/devicetree/bindings/i2c/sigma,smp8642-i2c.txt
new file mode 100644
index 0000000..117fc8b
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/sigma,smp8642-i2c.txt
@@ -0,0 +1,24 @@
+Sigma Designs SMP8642 I2C master
+
+Required properties:
+- compatible: should be "sigma,smp8642-i2c"
+- reg: physical address space of the device
+- interrupts: the interrupt of the device
+- clocks: phandle of the clock for the device
+- #address-cells: should be <1>
+- #size-cells: should be <0>
+
+Optional properties:
+- clock-frequency: frequency of bus clock in Hz, default 100kHz
+
+Example:
+
+i2c@10480 {
+	compatible = "sigma,smp8642-i2c";
+	reg = <0x10480 0x2c>;
+	interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&sys_clk>;
+	clock-frequency = <100000>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+};
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
