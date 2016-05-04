From: David Wu <david.wu@rock-chips.com>
Subject: [PATCH v7 5/9] i2c: rk3x: Change SoC data to not use array
Date: Wed,  4 May 2016 22:33:38 +0800
Message-ID: <1462372418-6349-1-git-send-email-david.wu@rock-chips.com>
References: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, wsa@the-dreams.de
Cc: robh+dt@kernel.org, dianders@chromium.org, andy.shevchenko@gmail.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, briannorris@google.com, davidriley@google.com, huangtao@rock-chips.com, hl@rock-chips.com, xjq@rock-chips.com, zyw@rock-chips.com, cf@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Wu <david.wu@rock-chips.com>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 drivers/i2c/busses/i2c-rk3x.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 0838fcf..9686c81 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -867,17 +867,39 @@ static const struct i2c_algorithm rk3x_i2c_algorithm = {
 	.functionality		= rk3x_i2c_func,
 };
 
-static struct rk3x_i2c_soc_data soc_data[3] = {
-	{ .grf_offset = 0x154 }, /* rk3066 */
-	{ .grf_offset = 0x0a4 }, /* rk3188 */
-	{ .grf_offset = -1 },    /* no I2C switching needed */
+static const struct rk3x_i2c_soc_data rk3066_soc_data = {
+	.grf_offset = 0x154,
+};
+
+static const struct rk3x_i2c_soc_data rk3188_soc_data = {
+	.grf_offset = 0x0a4,
+};
+
+static const struct rk3x_i2c_soc_data rk3228_soc_data = {
+	.grf_offset = -1,
+};
+
+static const struct rk3x_i2c_soc_data rk3288_soc_data = {
+	.grf_offset = -1,
 };
 
 static const struct of_device_id rk3x_i2c_match[] = {
-	{ .compatible = "rockchip,rk3066-i2c", .data = (void *)&soc_data[0] },
-	{ .compatible = "rockchip,rk3188-i2c", .data = (void *)&soc_data[1] },
-	{ .compatible = "rockchip,rk3228-i2c", .data = (void *)&soc_data[2] },
-	{ .compatible = "rockchip,rk3288-i2c", .data = (void *)&soc_data[2] },
+	{
+		.compatible = "rockchip,rk3066-i2c",
+		.data = (void *)&rk3066_soc_data
+	},
+	{
+		.compatible = "rockchip,rk3188-i2c",
+		.data = (void *)&rk3188_soc_data
+	},
+	{
+		.compatible = "rockchip,rk3228-i2c",
+		.data = (void *)&rk3228_soc_data
+	},
+	{
+		.compatible = "rockchip,rk3288-i2c",
+		.data = (void *)&rk3288_soc_data
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, rk3x_i2c_match);
-- 
1.9.1
