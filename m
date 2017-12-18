From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 2/7] i2c: sh_mobile: allow setup callback to return errno
Date: Mon, 18 Dec 2017 22:57:57 +0100
Message-ID: <20171218215802.28591-3-wsa+renesas@sang-engineering.com>
References: <20171218215802.28591-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:40896 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965312AbdLRV6J (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 18 Dec 2017 16:58:09 -0500
In-Reply-To: <20171218215802.28591-1-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

The setup callback will be more generic and, thus, need to be able to
return error codes. Change the return type to 'int' for that.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 1ac896e46b390c..a3a377a10fa789 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -149,7 +149,7 @@ struct sh_mobile_i2c_data {
 
 struct sh_mobile_dt_config {
 	int clks_per_count;
-	void (*setup)(struct sh_mobile_i2c_data *pd);
+	int (*setup)(struct sh_mobile_i2c_data *pd);
 };
 
 #define IIC_FLAG_HAS_ICIC67	(1 << 0)
@@ -749,7 +749,7 @@ static const struct i2c_algorithm sh_mobile_i2c_algorithm = {
  * r8a7740 chip has lasting errata on I2C I/O pad reset.
  * this is work-around for it.
  */
-static void sh_mobile_i2c_r8a7740_workaround(struct sh_mobile_i2c_data *pd)
+static int sh_mobile_i2c_r8a7740_workaround(struct sh_mobile_i2c_data *pd)
 {
 	iic_set_clr(pd, ICCR, ICCR_ICE, 0);
 	iic_rd(pd, ICCR); /* dummy read */
@@ -770,6 +770,8 @@ static void sh_mobile_i2c_r8a7740_workaround(struct sh_mobile_i2c_data *pd)
 	udelay(10);
 	iic_wr(pd, ICCR, ICCR_TRS);
 	udelay(10);
+
+	return 0;
 }
 
 static const struct sh_mobile_dt_config default_dt_config = {
@@ -881,8 +883,11 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 	if (config) {
 		pd->clks_per_count = config->clks_per_count;
 
-		if (config->setup)
-			config->setup(pd);
+		if (config->setup) {
+			ret = config->setup(pd);
+			if (ret)
+				return ret;
+		}
 	}
 
 	ret = sh_mobile_i2c_init(pd);
-- 
2.11.0
