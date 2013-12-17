From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 05/13] i2c: mv64xxx: Use devm_request_irq()
Date: Tue, 17 Dec 2013 15:53:17 +0900
Message-ID: <002901cefaf4$aa582270$ff086750$%han@samsung.com>
References: <001601cefaf3$940d0040$bc2700c0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <001601cefaf3$940d0040$bc2700c0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Thierry Reding' <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 'Gregory CLEMENT' <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Use devm_request_irq() to make cleanup paths simpler.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-mv64xxx.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 8be7e42..d94ed5a 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -859,8 +859,8 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 
 	mv64xxx_i2c_hw_init(drv_data);
 
-	rc = request_irq(drv_data->irq, mv64xxx_i2c_intr, 0,
-			 MV64XXX_I2C_CTLR_NAME, drv_data);
+	rc = devm_request_irq(&pd->dev, drv_data->irq, mv64xxx_i2c_intr, 0,
+			      MV64XXX_I2C_CTLR_NAME, drv_data);
 	if (rc) {
 		dev_err(&drv_data->adapter.dev,
 			"mv64xxx: Can't register intr handler irq%d: %d\n",
@@ -869,13 +869,11 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 	} else if ((rc = i2c_add_numbered_adapter(&drv_data->adapter)) != 0) {
 		dev_err(&drv_data->adapter.dev,
 			"mv64xxx: Can't add i2c adapter, rc: %d\n", -rc);
-		goto exit_free_irq;
+		goto exit_clk;
 	}
 
 	return 0;
 
-exit_free_irq:
-	free_irq(drv_data->irq, drv_data);
 exit_clk:
 #if defined(CONFIG_HAVE_CLK)
 	/* Not all platforms have a clk */
@@ -893,7 +891,6 @@ mv64xxx_i2c_remove(struct platform_device *dev)
 	struct mv64xxx_i2c_data		*drv_data = platform_get_drvdata(dev);
 
 	i2c_del_adapter(&drv_data->adapter);
-	free_irq(drv_data->irq, drv_data);
 #if defined(CONFIG_HAVE_CLK)
 	/* Not all platforms have a clk */
 	if (!IS_ERR(drv_data->clk)) {
-- 
1.7.10.4
