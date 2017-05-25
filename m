From: Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH v8 1/5] irqchip/aspeed-i2c-ic: binding docs for Aspeed I2C Interrupt Controller
Date: Wed, 24 May 2017 23:49:21 -0700
Message-ID: <20170525064925.16867-2-brendanhiggins@google.com>
References: <20170525064925.16867-1-brendanhiggins@google.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170525064925.16867-1-brendanhiggins@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, joel@jms.id.au, vz@mleia.com, mouse@mayc.ru, clg@kaod.org, benh@kernel.crashing.org
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, Brendan Higgins <brendanhiggins@google.com>
List-Id: linux-i2c@vger.kernel.org

Added device tree binding documentation for Aspeed I2C Interrupt
Controller.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
Added in v6:
  - Pulled "aspeed_i2c_controller" out into a interrupt controller since that is
    what it actually does.
Changes for v7:
  - None
Changes for v8:
  - None
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
2.13.0.219.gdb65acc882-goog
