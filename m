From: Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH v6 1/5] irqchip/aspeed-i2c-ic: binding docs for Aspeed I2C Interrupt Controller
Date: Mon, 27 Mar 2017 22:12:22 -0700
Message-ID: <20170328051226.21677-2-brendanhiggins@google.com>
References: <20170328051226.21677-1-brendanhiggins@google.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35799 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753882AbdC1FNE (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 28 Mar 2017 01:13:04 -0400
Received: by mail-pg0-f43.google.com with SMTP id 81so46899430pgh.2
        for <linux-i2c@vger.kernel.org>; Mon, 27 Mar 2017 22:13:03 -0700 (PDT)
In-Reply-To: <20170328051226.21677-1-brendanhiggins@google.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, joel@jms.id.au, vz@mleia.com, mouse@mayc.ru, clg@kaod.org
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, benh@kernel.crashing.org, Brendan Higgins <brendanhiggins@google.com>

Added device tree binding documentation for Aspeed I2C Interrupt
Controller.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
Added in v6:
  - Pulled "aspeed_i2c_controller" out into a interrupt controller since that is
    what it actually does.
---
 .../interrupt-controller/aspeed,ast2400-i2c-ic.txt | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-i2c-ic.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-i2c-ic.txt b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-i2c-ic.txt
new file mode 100644
index 000000000000..033cc82e5684
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-i2c-ic.txt
@@ -0,0 +1,25 @@
+Device tree configuration for the I2C Interrupt Controller on the AST24XX and
+AST25XX SoCs.
+
+Required Properties:
+- #address-cells	: should be 1
+- #size-cells 		: should be 1
+- #interrupt-cells 	: should be 1
+- compatible 		: should be "aspeed,ast2400-i2c-ic"
+			  or "aspeed,ast2500-i2c-ic"
+- reg			: address start and range of controller
+- interrupts		: interrupt number
+- interrupt-controller	: denotes that the controller receives and fires
+			  new interrupts for child busses
+
+Example:
+
+i2c_ic: interrupt-controller@0 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	#interrupt-cells = <1>;
+	compatible = "aspeed,ast2400-i2c-ic";
+	reg = <0x0 0x40>;
+	interrupts = <12>;
+	interrupt-controller;
+};
-- 
2.12.2.564.g063fe858b8-goog
