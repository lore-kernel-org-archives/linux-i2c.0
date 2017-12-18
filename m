From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 7/7] i2c: sh_mobile: let r8a7790 (R-Car H2) use the new formula
Date: Mon, 18 Dec 2017 22:58:02 +0100
Message-ID: <20171218215802.28591-8-wsa+renesas@sang-engineering.com>
References: <20171218215802.28591-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171218215802.28591-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

Make use of the new formula for more precise bus frequencies.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index a0fddfe3c4497d..d856bc211715e5 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -810,7 +810,7 @@ static const struct sh_mobile_dt_config r8a7740_dt_config = {
 static const struct of_device_id sh_mobile_i2c_dt_ids[] = {
 	{ .compatible = "renesas,iic-r8a73a4", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,iic-r8a7740", .data = &r8a7740_dt_config },
-	{ .compatible = "renesas,iic-r8a7790", .data = &fast_clock_dt_config },
+	{ .compatible = "renesas,iic-r8a7790", .data = &v2_freq_calc_dt_config },
 	{ .compatible = "renesas,iic-r8a7791", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,iic-r8a7792", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,iic-r8a7793", .data = &fast_clock_dt_config },
-- 
2.11.0
