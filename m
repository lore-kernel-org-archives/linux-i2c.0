From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 2/2] i2c: sh_mobile: drop needless check for of_node
Date: Thu, 18 May 2017 23:11:40 +0200
Message-ID: <20170518211140.12023-3-wsa+renesas@sang-engineering.com>
References: <20170518211140.12023-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170518211140.12023-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

After removal of platform_data support, we can simplify OF handling.
of_match_device() evaluates to NULL if !CONFIG_OF or if there is no node
pointer for that device, so we can remove the check for the node ptr.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index d5e39eccae9b97..92c002c5bb0abe 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -881,6 +881,7 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 	struct sh_mobile_i2c_data *pd;
 	struct i2c_adapter *adap;
 	struct resource *res;
+	const struct of_device_id *match;
 	int ret;
 	u32 bus_speed;
 
@@ -910,22 +911,17 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 
 	ret = of_property_read_u32(dev->dev.of_node, "clock-frequency", &bus_speed);
 	pd->bus_speed = ret ? STANDARD_MODE : bus_speed;
-
 	pd->clks_per_count = 1;
 
-	if (dev->dev.of_node) {
-		const struct of_device_id *match;
-
-		match = of_match_device(sh_mobile_i2c_dt_ids, &dev->dev);
-		if (match) {
-			const struct sh_mobile_dt_config *config;
+	match = of_match_device(sh_mobile_i2c_dt_ids, &dev->dev);
+	if (match) {
+		const struct sh_mobile_dt_config *config;
 
-			config = match->data;
-			pd->clks_per_count = config->clks_per_count;
+		config = match->data;
+		pd->clks_per_count = config->clks_per_count;
 
-			if (config->setup)
-				config->setup(pd);
-		}
+		if (config->setup)
+			config->setup(pd);
 	}
 
 	/* The IIC blocks on SH-Mobile ARM processors
-- 
2.11.0
