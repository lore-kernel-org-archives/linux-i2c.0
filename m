From: Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH v1 1/1] i2c: aspeed: add proper support for 24xx clock params
Date: Thu, 13 Jul 2017 15:30:52 -0700
Message-ID: <20170713223052.8387-2-brendanhiggins@google.com>
References: <20170713223052.8387-1-brendanhiggins@google.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170713223052.8387-1-brendanhiggins@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, benh@kernel.crashing.org, joel@jms.id.au
Cc: linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org, Brendan Higgins <brendanhiggins@google.com>
List-Id: linux-i2c@vger.kernel.org

24xx BMCs have larger clock divider granularity which can cause problems
when trying to set them as 25xx clock dividers; this adds clock setting
code specific to 24xx.

This also fixes a potential issue where clock dividers were rounded down
instead of up.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 69 +++++++++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index f19348328a71..247270ff2031 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -132,6 +132,7 @@ struct aspeed_i2c_bus {
 	/* Synchronizes I/O mem access to base. */
 	spinlock_t			lock;
 	struct completion		cmd_complete;
+	u32				(*get_clk_reg_val)(u32 divisor);
 	unsigned long			parent_clk_frequency;
 	u32				bus_frequency;
 	/* Transaction state. */
@@ -674,7 +675,7 @@ static const struct i2c_algorithm aspeed_i2c_algo = {
 #endif /* CONFIG_I2C_SLAVE */
 };
 
-static u32 aspeed_i2c_get_clk_reg_val(u32 divisor)
+static u32 aspeed_i2c_get_clk_reg_val(u32 clk_high_low_max, u32 divisor)
 {
 	u32 base_clk, clk_high, clk_low, tmp;
 
@@ -694,11 +695,22 @@ static u32 aspeed_i2c_get_clk_reg_val(u32 divisor)
 	 * Thus,
 	 *	SCL_freq = APB_freq /
 	 *		((1 << base_clk) * (clk_high + 1 + clk_low + 1))
-	 * The documentation recommends clk_high >= 8 and clk_low >= 7 when
-	 * possible; this last constraint gives us the following solution:
+	 * The documentation recommends clk_high >= clk_high_max / 2 and
+	 * clk_low >= clk_low_max / 2 - 1 when possible; this last constraint
+	 * gives us the following solution:
 	 */
-	base_clk = divisor > 33 ? ilog2((divisor - 1) / 32) + 1 : 0;
+	base_clk = divisor > clk_high_low_max + 1 ?
+			ilog2((divisor - 1) / clk_high_low_max) + 1 : 0;
 	tmp = divisor / (1 << base_clk);
+
+	/* Round up to next largest divisor. */
+	if (tmp * (1 << base_clk) < divisor)
+		tmp += 1;
+	if (tmp > clk_high_low_max) {
+		base_clk += 1;
+		tmp = divisor / (1 << base_clk);
+	}
+
 	clk_high = tmp / 2 + tmp % 2;
 	clk_low = tmp - clk_high;
 
@@ -712,13 +724,31 @@ static u32 aspeed_i2c_get_clk_reg_val(u32 divisor)
 			| (base_clk & ASPEED_I2CD_TIME_BASE_DIVISOR_MASK);
 }
 
+static u32 aspeed_i2c_24xx_get_clk_reg_val(u32 divisor)
+{
+	/*
+	 * clk_high and clk_low are each 3 bits wide, so each can hold a max
+	 * value of 8 giving a clk_high_low_max of 16.
+	 */
+	return aspeed_i2c_get_clk_reg_val(16, divisor);
+}
+
+static u32 aspeed_i2c_25xx_get_clk_reg_val(u32 divisor)
+{
+	/*
+	 * clk_high and clk_low are each 4 bits wide, so each can hold a max
+	 * value of 16 giving a clk_high_low_max of 32.
+	 */
+	return aspeed_i2c_get_clk_reg_val(32, divisor);
+}
+
 /* precondition: bus.lock has been acquired. */
 static int aspeed_i2c_init_clk(struct aspeed_i2c_bus *bus)
 {
 	u32 divisor, clk_reg_val;
 
-	divisor = bus->parent_clk_frequency / bus->bus_frequency;
-	clk_reg_val = aspeed_i2c_get_clk_reg_val(divisor);
+	divisor = DIV_ROUND_UP(bus->parent_clk_frequency, bus->bus_frequency);
+	clk_reg_val = bus->get_clk_reg_val(divisor);
 	writel(clk_reg_val, bus->base + ASPEED_I2C_AC_TIMING_REG1);
 	writel(ASPEED_NO_TIMEOUT_CTRL, bus->base + ASPEED_I2C_AC_TIMING_REG2);
 
@@ -777,8 +807,22 @@ static int aspeed_i2c_reset(struct aspeed_i2c_bus *bus)
 	return ret;
 }
 
+static const struct of_device_id aspeed_i2c_bus_of_table[] = {
+	{
+		.compatible = "aspeed,ast2400-i2c-bus",
+		.data = aspeed_i2c_24xx_get_clk_reg_val,
+	},
+	{
+		.compatible = "aspeed,ast2500-i2c-bus",
+		.data = aspeed_i2c_25xx_get_clk_reg_val,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, aspeed_i2c_bus_of_table);
+
 static int aspeed_i2c_probe_bus(struct platform_device *pdev)
 {
+	const struct of_device_id *match;
 	struct aspeed_i2c_bus *bus;
 	struct clk *parent_clk;
 	struct resource *res;
@@ -808,6 +852,12 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
 		bus->bus_frequency = 100000;
 	}
 
+	match = of_match_node(aspeed_i2c_bus_of_table, pdev->dev.of_node);
+	if (!match)
+		bus->get_clk_reg_val = aspeed_i2c_24xx_get_clk_reg_val;
+	else
+		bus->get_clk_reg_val = match->data;
+
 	/* Initialize the I2C adapter */
 	spin_lock_init(&bus->lock);
 	init_completion(&bus->cmd_complete);
@@ -869,13 +919,6 @@ static int aspeed_i2c_remove_bus(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id aspeed_i2c_bus_of_table[] = {
-	{ .compatible = "aspeed,ast2400-i2c-bus", },
-	{ .compatible = "aspeed,ast2500-i2c-bus", },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, aspeed_i2c_bus_of_table);
-
 static struct platform_driver aspeed_i2c_bus_driver = {
 	.probe		= aspeed_i2c_probe_bus,
 	.remove		= aspeed_i2c_remove_bus,
-- 
2.13.2.932.g7449e964c-goog
