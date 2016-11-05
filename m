From: Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH v4 2/2] i2c: aspeed: added documentation for Aspeed I2C driver
Date: Fri,  4 Nov 2016 18:58:19 -0700
Message-ID: <1478311099-6771-3-git-send-email-brendanhiggins@google.com>
References: <1478311099-6771-1-git-send-email-brendanhiggins@google.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35440 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750833AbcKEB7B (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 4 Nov 2016 21:59:01 -0400
Received: by mail-pf0-f178.google.com with SMTP id i88so60371182pfk.2
        for <linux-i2c@vger.kernel.org>; Fri, 04 Nov 2016 18:59:00 -0700 (PDT)
In-Reply-To: <1478311099-6771-1-git-send-email-brendanhiggins@google.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, joel@jms.id.au, openbmc@lists.ozlabs.org, Brendan Higgins <brendanhiggins@google.com>

Added device tree binding documentation for Aspeed I2C controller and
busses.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
Changes for v2:
  - None
Changes for v3:
  - Removed reference to "bus" device tree param
Changes for v4:
  - None
---
 .../devicetree/bindings/i2c/i2c-aspeed.txt         | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-aspeed.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
new file mode 100644
index 0000000..dd11a97
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
@@ -0,0 +1,61 @@
+Device tree configuration for the I2C controller and busses on the AST24XX
+and AST25XX SoCs.
+
+Controller:
+
+	Required Properties:
+	- #address-cells	: should be 1
+	- #size-cells 		: should be 1
+	- #interrupt-cells 	: should be 1
+	- compatible 		: should be "aspeed,ast2400-i2c-controller"
+				  or "aspeed,ast2500-i2c-controller"
+	- reg			: address start and range of controller
+	- ranges		: defines address offset and range for busses
+	- interrupts		: interrupt number
+	- clocks		: root clock of bus, should reference the APB
+				  clock
+	- clock-ranges		: specifies that child busses can inherit clocks
+	- interrupt-controller	: denotes that the controller receives and fires
+				  new interrupts for child busses
+
+Bus:
+
+	Required Properties:
+	- #address-cells	: should be 1
+	- #size-cells		: should be 0
+	- reg			: address offset and range of bus
+	- compatible		: should be "aspeed,ast2400-i2c-bus"
+				  or "aspeed,ast2500-i2c-bus"
+	- interrupts		: interrupt number
+
+	Optional Properties:
+	- clock-frequency	: frequency of the bus clock in Hz
+				  defaults to 100 kHz when not specified
+
+Example:
+
+i2c: i2c@1e78a000 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	#interrupt-cells = <1>;
+
+	compatible = "aspeed,ast2400-i2c-controller";
+	reg = <0x1e78a000 0x40>;
+	ranges = <0 0x1e78a000 0x1000>;
+	interrupts = <12>;
+	clocks = <&clk_apb>;
+	clock-ranges;
+	interrupt-controller;
+
+	i2c0: i2c-bus@40 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x40 0x40>;
+		compatible = "aspeed,ast2400-i2c-bus";
+		clock-frequency = <100000>;
+		status = "disabled";
+		interrupts = <0>;
+		interrupt-parent = <&i2c>;
+	};
+};
+
-- 
2.8.0.rc3.226.g39d4020
