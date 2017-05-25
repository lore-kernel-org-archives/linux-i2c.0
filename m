From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] i2c: sh_mobile: Handle return value of clk_prepare_enable
Date: Thu, 25 May 2017 17:07:17 +0530
Message-ID: <da1fd66f93db7ca0ec718913bfd2d5e28919a5ff.1495711281.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35535 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764284AbdEYLiz (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 25 May 2017 07:38:55 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 3d75593..a845292 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -252,9 +252,15 @@ static int sh_mobile_i2c_init(struct sh_mobile_i2c_data *pd)
 	unsigned long i2c_clk_khz;
 	u32 tHIGH, tLOW, tf;
 	uint16_t max_val;
+	int ret;
 
 	/* Get clock rate after clock is enabled */
-	clk_prepare_enable(pd->clk);
+	ret = clk_prepare_enable(pd->clk);
+	if (ret) {
+		dev_err(pd->dev, "Failed! to enable clock\n");
+		return ret;
+	}
+
 	i2c_clk_khz = clk_get_rate(pd->clk) / 1000;
 	clk_disable_unprepare(pd->clk);
 	i2c_clk_khz /= pd->clks_per_count;
@@ -299,11 +305,14 @@ static int sh_mobile_i2c_init(struct sh_mobile_i2c_data *pd)
 	return 0;
 }
 
-static void activate_ch(struct sh_mobile_i2c_data *pd)
+static int activate_ch(struct sh_mobile_i2c_data *pd)
 {
+	int ret;
 	/* Wake up device and enable clock */
 	pm_runtime_get_sync(pd->dev);
-	clk_prepare_enable(pd->clk);
+	ret = clk_prepare_enable(pd->clk);
+	if (ret)
+		return ret;
 
 	/* Enable channel and configure rx ack */
 	iic_set_clr(pd, ICCR, ICCR_ICE, 0);
@@ -314,6 +323,7 @@ static void activate_ch(struct sh_mobile_i2c_data *pd)
 	/* Set the clock */
 	iic_wr(pd, ICCL, pd->iccl & 0xff);
 	iic_wr(pd, ICCH, pd->icch & 0xff);
+	return 0;
 }
 
 static void deactivate_ch(struct sh_mobile_i2c_data *pd)
@@ -732,7 +742,11 @@ static int sh_mobile_i2c_xfer(struct i2c_adapter *adapter,
 	int i;
 	long timeout;
 
-	activate_ch(pd);
+	err = activate_ch(pd);
+	if (err) {
+		dev_err(pd->dev, "Failed! to enable clock\n");
+		return err;
+	}
 
 	/* Process all messages */
 	for (i = 0; i < num; i++) {
-- 
1.9.1
