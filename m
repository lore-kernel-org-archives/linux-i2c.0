From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] i2c: sh_mobile: Use of_device_get_match_data() helper
Date: Wed,  4 Oct 2017 14:17:05 +0200
Message-ID: <1507119425-12566-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from albert.telenet-ops.be ([195.130.137.90]:33390 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbdJDMRK (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 4 Oct 2017 08:17:10 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Use the of_device_get_match_data() helper instead of open coding.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 6f2aaeb7c4fa156d..c03acdf713972677 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -881,7 +881,7 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 	struct sh_mobile_i2c_data *pd;
 	struct i2c_adapter *adap;
 	struct resource *res;
-	const struct of_device_id *match;
+	const struct sh_mobile_dt_config *config;
 	int ret;
 	u32 bus_speed;
 
@@ -913,10 +913,8 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 	pd->bus_speed = ret ? STANDARD_MODE : bus_speed;
 	pd->clks_per_count = 1;
 
-	match = of_match_device(sh_mobile_i2c_dt_ids, &dev->dev);
-	if (match) {
-		const struct sh_mobile_dt_config *config = match->data;
-
+	config = of_device_get_match_data(&dev->dev);
+	if (config) {
 		pd->clks_per_count = config->clks_per_count;
 
 		if (config->setup)
-- 
2.7.4
