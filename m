From: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Subject: [PATCH] i2c: mv64xxx: Use clk_enable_prepare and
 clk_disable_unprepare
Date: Mon, 27 Jun 2016 20:17:22 +0530
Message-ID: <20160627144722.GA31362@amitoj-Inspiron-3542>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35938 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbcF0Orb (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 27 Jun 2016 10:47:31 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: julia.lawall@lip6.fr

Replace clk_enable and clk_prepare with clk_enable_prepare and
clk_disable and clk_unprepare with clk_disable_unprepare.

The Coccinelle semantic patch used to make this change is as follows:
@@
expression e;
@@

- clk_prepare(e);
- clk_enable(e);
+ clk_prepare_enable(e);

@@
expression e;
@@

- clk_disable(e);
- clk_unprepare(e);
+ clk_disable_unprepare(e);

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 43207f5..79bae48 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -910,10 +910,8 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 #if defined(CONFIG_HAVE_CLK)
 	/* Not all platforms have a clk */
 	drv_data->clk = devm_clk_get(&pd->dev, NULL);
-	if (!IS_ERR(drv_data->clk)) {
-		clk_prepare(drv_data->clk);
-		clk_enable(drv_data->clk);
-	}
+	if (!IS_ERR(drv_data->clk))
+		clk_prepare_enable(drv_data->clk);
 #endif
 	if (pdata) {
 		drv_data->freq_m = pdata->freq_m;
@@ -966,10 +964,8 @@ exit_reset:
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
@@ -985,10 +981,8 @@ mv64xxx_i2c_remove(struct platform_device *dev)
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
1.9.1
