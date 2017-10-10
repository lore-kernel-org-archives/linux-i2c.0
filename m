From: Joel Stanley <joel@jms.id.au>
Subject: [PATCH] i2c: aspeed: Deassert reset in probe
Date: Tue, 10 Oct 2017 15:18:28 +1030
Message-ID: <20171010044828.20913-1-joel@jms.id.au>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Brendan Higgins <brendanhiggins@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

In order to use i2c from a cold boot, the i2c peripheral must be taken
out of reset. We request a shared reset controller each time a bus
driver is loaded, as the reset is shared between the 14 i2c buses.

On remove the reset is asserted, which only touches the hardware once
the last i2c bus is removed.

The request is optional, so if a device tree does not specify a reset
controller (or the driver is not built in), the driver continues to
probe.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/i2c/busses/i2c-aspeed.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 284f8670dbeb..ad06f902f90f 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -28,6 +28,8 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/reset.h>
 
 /* I2C Register */
 #define ASPEED_I2C_FUN_CTRL_REG				0x00
@@ -132,6 +134,7 @@ struct aspeed_i2c_bus {
 	struct i2c_adapter		adap;
 	struct device			*dev;
 	void __iomem			*base;
+	struct reset_control		*rst;
 	/* Synchronizes I/O mem access to base. */
 	spinlock_t			lock;
 	struct completion		cmd_complete;
@@ -847,6 +850,9 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
 	/* We just need the clock rate, we don't actually use the clk object. */
 	devm_clk_put(&pdev->dev, parent_clk);
 
+	bus->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
+	reset_control_deassert(bus->rst);
+
 	ret = of_property_read_u32(pdev->dev.of_node,
 				   "bus-frequency", &bus->bus_frequency);
 	if (ret < 0) {
@@ -919,6 +925,8 @@ static int aspeed_i2c_remove_bus(struct platform_device *pdev)
 
 	i2c_del_adapter(&bus->adap);
 
+	reset_control_assert(bus->rst);
+
 	return 0;
 }
 
-- 
2.14.1
