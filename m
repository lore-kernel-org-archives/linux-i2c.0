From: Joel Stanley <joel@jms.id.au>
Subject: [PATCH v4] i2c: aspeed: Deassert reset in probe
Date: Wed,  1 Nov 2017 10:53:30 +1030
Message-ID: <20171101002330.24981-1-joel@jms.id.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:52130 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbdKAAXo (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 31 Oct 2017 20:23:44 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Brendan Higgins <brendanhiggins@google.com>, Philipp Zabel <philipp.zabel@gmail.com>, Rob Herring <robh+dt@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

In order to use i2c from a cold boot, the i2c peripheral must be taken
out of reset. We request a shared reset controller each time a bus
driver is loaded, as the reset is shared between the 14 i2c buses.

On remove the reset is asserted, which only touches the hardware once
the last i2c bus is removed.

The reset is required as the I2C buses will not work without releasing
the reset. Previously the driver only worked with out of tree hacks
that released this reset before the driver was loaded. Update the
device tree bindings to reflect this.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v4:
  - Make reset required and update device tree bindings
  - Remove unnecessary delay.h
  - Exit when reset controller probing fails
  - Fix ordering when removing the driver so that it is the opposite of probing
v3: Check for bad reset controller probe (caused by eg. bad device tree)
    and set ->rst to NULL so assert/desassert does not cause a warning to
    be printed
v2: Sort the headers

 Documentation/devicetree/bindings/i2c/i2c-aspeed.txt |  7 +++++--
 drivers/i2c/busses/i2c-aspeed.c                      | 12 ++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
index bd6480b19535..e7106bfc1f13 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
@@ -7,7 +7,9 @@ Required Properties:
 - compatible		: should be "aspeed,ast2400-i2c-bus"
 			  or "aspeed,ast2500-i2c-bus"
 - clocks		: root clock of bus, should reference the APB
-			  clock
+			  clock in the second cell
+- resets		: phandle to reset controller with the reset number in
+			  the second cell
 - interrupts		: interrupt number
 - interrupt-parent	: interrupt controller for bus, should reference a
 			  aspeed,ast2400-i2c-ic or aspeed,ast2500-i2c-ic
@@ -40,7 +42,8 @@ i2c {
 		#interrupt-cells = <1>;
 		reg = <0x40 0x40>;
 		compatible = "aspeed,ast2400-i2c-bus";
-		clocks = <&clk_apb>;
+		clocks = <&syscon ASPEED_CLK_APB>;
+		resets = <&syscon ASPEED_RESET_I2C>;
 		bus-frequency = <100000>;
 		interrupts = <0>;
 		interrupt-parent = <&i2c_ic>;
diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 284f8670dbeb..7d4aeb4465b3 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -27,6 +27,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 
 /* I2C Register */
@@ -132,6 +133,7 @@ struct aspeed_i2c_bus {
 	struct i2c_adapter		adap;
 	struct device			*dev;
 	void __iomem			*base;
+	struct reset_control		*rst;
 	/* Synchronizes I/O mem access to base. */
 	spinlock_t			lock;
 	struct completion		cmd_complete;
@@ -847,6 +849,14 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
 	/* We just need the clock rate, we don't actually use the clk object. */
 	devm_clk_put(&pdev->dev, parent_clk);
 
+	bus->rst = devm_reset_control_get_shared(&pdev->dev, NULL);
+	if (IS_ERR(bus->rst)) {
+		dev_err(&pdev->dev,
+			"missing or invalid reset controller device tree entry");
+		return PTR_ERR(bus->rst);
+	}
+	reset_control_deassert(bus->rst);
+
 	ret = of_property_read_u32(pdev->dev.of_node,
 				   "bus-frequency", &bus->bus_frequency);
 	if (ret < 0) {
@@ -917,6 +927,8 @@ static int aspeed_i2c_remove_bus(struct platform_device *pdev)
 
 	spin_unlock_irqrestore(&bus->lock, flags);
 
+	reset_control_assert(bus->rst);
+
 	i2c_del_adapter(&bus->adap);
 
 	return 0;
-- 
2.14.1
