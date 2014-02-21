From: Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
Subject: [PATCH v3 1/2] i2c: qup: Add device tree bindings information
Date: Thu, 20 Feb 2014 16:38:09 -0800
Message-ID: <1392943090-30556-2-git-send-email-bjorn.andersson@sonymobile.com>
References: <1392943090-30556-1-git-send-email-bjorn.andersson@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392943090-30556-1-git-send-email-bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>

The Qualcomm Universal Peripherial (QUP) wraps I2C mini-core and
provide input and output FIFO's for it. I2C controller can operate
as master with supported bus speeds of 100Kbps and 400Kbps.

Signed-off-by: Ivan T. Ivanov <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
[bjorn: reformulated part of binding description
        added version to compatible
        cleaned up example]
Signed-off-by: Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
---
 .../devicetree/bindings/i2c/qcom,i2c-qup.txt       |   44 ++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/qcom,i2c-qup.txt

diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-qup.txt b/Documentation/devicetree/bindings/i2c/qcom,i2c-qup.txt
new file mode 100644
index 0000000..38d505f
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-qup.txt
@@ -0,0 +1,44 @@
+Qualcomm Universal Peripheral (QUP) I2C controller
+
+Required properties:
+ - compatible: Should be
+		"qcom,i2c-qup-v1.1.1" for 8660, 8960 and 8064.
+		"qcom,i2c-qup-v2.1.1" for 8974 v1.
+		"qcom,i2c-qup-v2.2.1" for 8974 v2 and later.
+ - reg: Should contain QUP register address and length.
+ - interrupts: Should contain I2C interrupt.
+
+ - clocks: Should contain the core clock and the AHB clock.
+ - clock-names: Should be "core" for the core clock and "iface" for the
+                AHB clock.
+
+ - #address-cells: Should be <1> Address cells for i2c device address
+ - #size-cells: Should be <0> as i2c addresses have no size component
+
+Optional properties:
+ - clock-frequency: Should specify the desired i2c bus clock frequency in Hz,
+                    defaults to 100kHz if omitted.
+
+Child nodes should conform to i2c bus binding.
+
+Example:
+
+ i2c@f9924000 {
+ 	compatible = "qcom,i2c-qup-v2.2.1";
+ 	reg = <0xf9924000 0x1000>;
+ 	interrupts = <0 96 0>;
+
+ 	clocks = <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
+ 	clock-names = "core", "iface";
+
+ 	clock-frequency = <355000>;
+
+ 	#address-cells = <1>;
+ 	#size-cells = <0>;
+
+ 	dummy@60 {
+ 		compatible = "dummy";
+ 		reg = <0x60>;
+ 	};
+ };
+
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
