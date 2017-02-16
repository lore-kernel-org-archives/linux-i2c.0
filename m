From: Baoyou Xie <baoyou.xie@linaro.org>
Subject: [PATCH v7 1/3] dt: bindings: add documentation for zx2967 family i2c controller
Date: Thu, 16 Feb 2017 14:00:42 +0800
Message-ID: <1487224844-10973-1-git-send-email-baoyou.xie@linaro.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34231 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753552AbdBPGBG (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 16 Feb 2017 01:01:06 -0500
Received: by mail-pf0-f170.google.com with SMTP id e4so3018367pfg.1
        for <linux-i2c@vger.kernel.org>; Wed, 15 Feb 2017 22:01:06 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: shawnguo@kernel.org, andy.shevchenko@gmail.com, jun.nie@linaro.org, baoyou.xie@linaro.org, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, xie.baoyou@zte.com.cn, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn

This patch adds dt-binding documentation for zx2967 family
i2c controller.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/i2c/i2c-zx2967.txt         | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-zx2967.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-zx2967.txt b/Documentation/devicetree/bindings/i2c/i2c-zx2967.txt
new file mode 100644
index 0000000..a528374
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-zx2967.txt
@@ -0,0 +1,24 @@
+ZTE zx2967 I2C controller
+
+Required properties:
+ - compatible: must be "zte,zx296718-i2c"
+ - reg: physical address and length of the device registers
+ - interrupts: a single interrupt specifier
+ - clocks: clock for the device
+ - #address-cells: should be <1>
+ - #size-cells: should be <0>
+ - clock-frequency: the desired I2C bus clock frequency.
+
+Examples:
+
+	i2c@112000 {
+		compatible = "zte,zx296718-i2c";
+		reg = <0x00112000 0x1000>;
+		interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&osc24m>;
+		#address-cells = <1>
+		#size-cells = <0>;
+		clock-frequency = <1600000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c_global_pin>;
+	};
-- 
2.7.4
