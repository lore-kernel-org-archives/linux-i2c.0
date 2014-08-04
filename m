From: Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/2] i2c: hix5hd2: add devicetree documentation
Date: Mon,  4 Aug 2014 11:46:46 +0800
Message-ID: <1407124007-27631-2-git-send-email-zhangfei.gao@linaro.org>
References: <1407124007-27631-1-git-send-email-zhangfei.gao@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1407124007-27631-1-git-send-email-zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, haifeng.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jchxue-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>

Signed-off-by: Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/i2c/i2c-hix5hd2.txt        |   31 ++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-hix5hd2.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-hix5hd2.txt b/Documentation/devicetree/bindings/i2c/i2c-hix5hd2.txt
new file mode 100644
index 000000000000..2ecc8a7f4401
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-hix5hd2.txt
@@ -0,0 +1,31 @@
+I2C for Hisilicon hix5hd2 chipset platforms (3716,3719,3798...)
+
+Required properties:
+- compatible: Must be "hisilicon,hix5hd2-i2c"
+  Specifically, the following versions of the chipset are supported:
+	  Hi3716CV200 (support six I2C module)
+	  Hi3719CV100 (support six I2C module)
+	  Hi3718CV100 (support six I2C module)
+	  Hi3719MV100 (support two I2C module)
+	  Hi3718MV100 (support two I2C module)
+- reg: physical base address of the controller and length of memory mapped
+     region.
+- interrupts: interrupt number to the cpu.
+- #address-cells = <1>;
+- #size-cells = <0>;
+- clocks: phandles to input clocks.
+
+Optional properties:
+- clock-frequency: Desired I2C bus frequency in Hz, otherwise defaults to 400000
+- Child nodes conforming to i2c bus binding
+
+Examples:
+I2C0@f8b10000 {
+	compatible = "hisilicon,hix5hd2-i2c";
+	reg = <0xf8b10000 0x1000>;
+	interrupts = <0 38 4>;
+	clocks = <&clock HIX5HD2_I2C0_RST>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "disabled";
+}
-- 
1.7.9.5
