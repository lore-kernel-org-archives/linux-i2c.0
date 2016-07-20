From: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Subject: [PATCH v2] 2c: mv64xxx: Use clk_enable_prepare and
 clk_disable_unprepare
Date: Wed, 20 Jul 2016 10:44:18 +0530
Message-ID: <20160720051417.GA21765@amitoj-Inspiron-3542>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:32886 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbcGTFOX (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 20 Jul 2016 01:14:23 -0400
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
Changes in v2:
        -Rebased patch

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
