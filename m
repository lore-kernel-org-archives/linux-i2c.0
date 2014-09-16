From: Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] i2c: meson: add device tree bindings documentation
Date: Wed, 17 Sep 2014 00:07:57 +0200
Message-ID: <1410905277-22172-3-git-send-email-b.galvani@gmail.com>
References: <1410905277-22172-1-git-send-email-b.galvani@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1410905277-22172-1-git-send-email-b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add device tree bindings documentation for the I2C controller
found in Amlogic Meson SoCs.

Signed-off-by: Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 .../devicetree/bindings/i2c/i2c-meson.txt          | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-meson.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-meson.txt b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
new file mode 100644
index 0000000..54a6c2c
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
@@ -0,0 +1,24 @@
+* Amlogic Meson I2C controller
+
+Required properties:
+ - compatible: must be "amlogic,meson6-i2c"
+ - reg: physical address and length of the device register set
+ - interrupts: a single interrupt specifier
+ - clocks: clock for the device
+ - #address-cells: should be <1>
+ - #size-cells: should be <0>
+
+Optional properties:
+- clock-frequency: the desired I2C bus clock frequency in Hz; in
+  absence of this property the default value is used (100 kHz).
+
+Example:
+
+	i2c@c1108500 {
+		compatible = "amlogic,meson6-i2c";
+		reg = <0xc1108500 0x20>;
+		interrupts = <0 21 1>;
+		clocks = <&clk81>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
