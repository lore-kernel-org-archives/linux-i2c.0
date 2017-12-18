From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 6/7] i2c: sh_mobile: add new frequency calculation for later SoC
Date: Mon, 18 Dec 2017 22:58:01 +0100
Message-ID: <20171218215802.28591-7-wsa+renesas@sang-engineering.com>
References: <20171218215802.28591-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171218215802.28591-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

The formula to generate the desired bus speeds has changed a little over
time. Implement the new formula and allow drivers to opt-in by changing
to this new config set. Ensure in probe that we don't divide by zero.
The returned values on a R-Car H2 (r8a7790/Lager board) match the
suggested values in the datasheet.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index b111191a449a69..a0fddfe3c4497d 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -299,6 +299,18 @@ static int sh_mobile_i2c_init(struct sh_mobile_i2c_data *pd)
 	return sh_mobile_i2c_check_timing(pd);
 }
 
+static int sh_mobile_i2c_v2_init(struct sh_mobile_i2c_data *pd)
+{
+	unsigned long clks_per_cycle;
+
+	/* L = 5, H = 4, L + H = 9 */
+	clks_per_cycle = clk_get_rate(pd->clk) / pd->bus_speed;
+	pd->iccl = DIV_ROUND_UP(clks_per_cycle * 5 / 9 - 1, pd->clks_per_count);
+	pd->icch = DIV_ROUND_UP(clks_per_cycle * 4 / 9 - 5, pd->clks_per_count);
+
+	return sh_mobile_i2c_check_timing(pd);
+}
+
 static unsigned char i2c_op(struct sh_mobile_i2c_data *pd,
 			    enum sh_mobile_i2c_op op, unsigned char data)
 {
@@ -785,6 +797,11 @@ static const struct sh_mobile_dt_config fast_clock_dt_config = {
 	.setup = sh_mobile_i2c_init,
 };
 
+static const struct sh_mobile_dt_config v2_freq_calc_dt_config = {
+	.clks_per_count = 2,
+	.setup = sh_mobile_i2c_v2_init,
+};
+
 static const struct sh_mobile_dt_config r8a7740_dt_config = {
 	.clks_per_count = 1,
 	.setup = sh_mobile_i2c_r8a7740_workaround,
@@ -875,7 +892,7 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 		return PTR_ERR(pd->reg);
 
 	ret = of_property_read_u32(dev->dev.of_node, "clock-frequency", &bus_speed);
-	pd->bus_speed = ret ? STANDARD_MODE : bus_speed;
+	pd->bus_speed = (ret || !bus_speed) ? STANDARD_MODE : bus_speed;
 	pd->clks_per_count = 1;
 
 	/* Newer variants come with two new bits in ICIC */
-- 
2.11.0
