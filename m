From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 8/13] i2c: mv64xxx: use clk_prepare_enable and clk_disable_unprepare
Date: Sun, 26 Aug 2012 18:01:00 +0200
Message-ID: <1345996865-32082-9-git-send-email-Julia.Lawall@lip6.fr>
References: <1345996865-32082-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1345996865-32082-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: "Jean Delvare (PC drivers core)" <khali@linux-fr.org>
Cc: kernel-janitors@vger.kernel.org, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, "Wolfram Sang (embedded platforms)" <w.sang@pengutronix.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Clk_prepare_enable and clk_disable_unprepare combine clk_prepare and
clk_enable, and clk_disable and clk_unprepare.  They make the code more
concise, and ensure that clk_unprepare is called when clk_enable fails.

A simplified version of the semantic patch that introduces calls to these
functions is as follows: (http://coccinelle.lip6.fr/)

// <smpl>
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
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/i2c/busses/i2c-mv64xxx.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 2e9d567..046c4b5 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -633,10 +633,8 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 #if defined(CONFIG_HAVE_CLK)
 	/* Not all platforms have a clk */
 	drv_data->clk = clk_get(&pd->dev, NULL);
-	if (!IS_ERR(drv_data->clk)) {
-		clk_prepare(drv_data->clk);
-		clk_enable(drv_data->clk);
-	}
+	if (!IS_ERR(drv_data->clk))
+		clk_prepare_enable(drv_data->clk);
 #endif
 	if (pdata) {
 		drv_data->freq_m = pdata->freq_m;
@@ -686,10 +684,8 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 	exit_unmap_regs:
 #if defined(CONFIG_HAVE_CLK)
 	/* Not all platforms have a clk */
-	if (!IS_ERR(drv_data->clk)) {
-		clk_disable(drv_data->clk);
-		clk_unprepare(drv_data->clk);
-	}
+	if (!IS_ERR(drv_data->clk))
+		clk_disable_unprepare(drv_data->clk);
 #endif
 		mv64xxx_i2c_unmap_regs(drv_data);
 	exit_kfree:
@@ -708,10 +704,8 @@ mv64xxx_i2c_remove(struct platform_device *dev)
 	mv64xxx_i2c_unmap_regs(drv_data);
 #if defined(CONFIG_HAVE_CLK)
 	/* Not all platforms have a clk */
-	if (!IS_ERR(drv_data->clk)) {
-		clk_disable(drv_data->clk);
-		clk_unprepare(drv_data->clk);
-	}
+	if (!IS_ERR(drv_data->clk))
+		clk_disable_unprepare(drv_data->clk);
 #endif
 	kfree(drv_data);
 
