From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 3/4] i2c: i2c-mv64xxx: use clk_{prepare_enable,disable_unprepare}
Date: Fri, 22 Apr 2016 15:19:53 +0200
Message-ID: <1461331194-27637-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1461331194-27637-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:39027 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752524AbcDVNUC (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 22 Apr 2016 09:20:02 -0400
In-Reply-To: <1461331194-27637-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Hanna Hawa <hannah@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Instead of separately calling clk_prepare()/clk_enable(), use
clk_prepare_enable(), and instead of calling
clk_disable()/clk_unprepare(), use clk_disable_unprepare(). Those
handy shortcuts have been introduced specifically to simplify the
numerous call sites were both functions were called in sequence.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 4c6282a..e87db03 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -912,10 +912,8 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 	drv_data->clk = devm_clk_get(&pd->dev, NULL);
 	if (IS_ERR(drv_data->clk) && PTR_ERR(drv_data->clk) == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
-	if (!IS_ERR(drv_data->clk)) {
-		clk_prepare(drv_data->clk);
-		clk_enable(drv_data->clk);
-	}
+	if (!IS_ERR(drv_data->clk))
+		clk_prepare_enable(drv_data->clk);
 #endif
 	if (pdata) {
 		drv_data->freq_m = pdata->freq_m;
@@ -968,10 +966,8 @@ exit_reset:
 exit_clk:
 #if defined(CONFIG_HAVE_CLK)
 	/* Not all platforms have a clk */
-	if (!IS_ERR(drv_data->clk)) {
-		clk_disable(drv_data->clk);
-		clk_unprepare(drv_data->clk);
-	}
+	if (!IS_ERR(drv_data->clk))
+		clk_disable_unprepare(drv_data->clk);
 #endif
 	return rc;
 }
@@ -987,10 +983,8 @@ mv64xxx_i2c_remove(struct platform_device *dev)
 		reset_control_assert(drv_data->rstc);
 #if defined(CONFIG_HAVE_CLK)
 	/* Not all platforms have a clk */
-	if (!IS_ERR(drv_data->clk)) {
-		clk_disable(drv_data->clk);
-		clk_unprepare(drv_data->clk);
-	}
+	if (!IS_ERR(drv_data->clk))
+		clk_disable_unprepare(drv_data->clk);
 #endif
 
 	return 0;
-- 
2.6.4
