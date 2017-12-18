From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 3/7] i2c: sh_mobile: require setup callback
Date: Mon, 18 Dec 2017 22:57:58 +0100
Message-ID: <20171218215802.28591-4-wsa+renesas@sang-engineering.com>
References: <20171218215802.28591-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171218215802.28591-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

Require the setup callback and move the frequency calculation into it.
This is in preparation for supporting multiple formulas.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index a3a377a10fa789..88af45225003a5 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -771,15 +771,17 @@ static int sh_mobile_i2c_r8a7740_workaround(struct sh_mobile_i2c_data *pd)
 	iic_wr(pd, ICCR, ICCR_TRS);
 	udelay(10);
 
-	return 0;
+	return sh_mobile_i2c_init(pd);
 }
 
 static const struct sh_mobile_dt_config default_dt_config = {
 	.clks_per_count = 1,
+	.setup = sh_mobile_i2c_init,
 };
 
 static const struct sh_mobile_dt_config fast_clock_dt_config = {
 	.clks_per_count = 2,
+	.setup = sh_mobile_i2c_init,
 };
 
 static const struct sh_mobile_dt_config r8a7740_dt_config = {
@@ -882,15 +884,10 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 	config = of_device_get_match_data(&dev->dev);
 	if (config) {
 		pd->clks_per_count = config->clks_per_count;
-
-		if (config->setup) {
-			ret = config->setup(pd);
-			if (ret)
-				return ret;
-		}
+		ret = config->setup(pd);
+	} else {
+		ret = sh_mobile_i2c_init(pd);
 	}
-
-	ret = sh_mobile_i2c_init(pd);
 	if (ret)
 		return ret;
 
-- 
2.11.0
