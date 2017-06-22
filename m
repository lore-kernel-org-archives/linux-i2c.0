From: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v2 1/2] dt: bindings: add documentation for zx2967 family i2c controller
Date: Thu, 22 Jun 2017 20:56:54 +0800
Message-ID: <1498136215-8102-2-git-send-email-shawnguo@kernel.org>
References: <1498136215-8102-1-git-send-email-shawnguo@kernel.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbdFVM63 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 22 Jun 2017 08:58:29 -0400
In-Reply-To: <1498136215-8102-1-git-send-email-shawnguo@kernel.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Baoyou Xie <xie.baoyou@sanechips.com.cn>, Xin Zhou <zhou.xin8@sanechips.com.cn>, Jun Nie <jun.nie@linaro.org>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Baoyou Xie <baoyou.xie@linaro.org>, Shawn Guo <shawn.guo@linaro.org>

From: Baoyou Xie <baoyou.xie@linaro.org>

This patch adds dt-binding documentation for zx2967 family
i2c controller.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../devicetree/bindings/i2c/i2c-zx2967.txt         | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-zx2967.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-zx2967.txt b/Documentation/devicetree/bindings/i2c/i2c-zx2967.txt
new file mode 100644
index 000000000000..cb806d1ae4c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-zx2967.txt
@@ -0,0 +1,22 @@
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
+	};
-- 
1.9.1
