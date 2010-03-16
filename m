From: wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 3/3] i2c-pnx: Disable/enable clocks only when needed to reduce power
Date: Tue, 16 Mar 2010 15:55:38 -0700
Message-ID: <1268780138-10019-5-git-send-email-wellsk40@gmail.com>
References: <1268780138-10019-1-git-send-email-wellsk40@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1268780138-10019-1-git-send-email-wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: vitaly.wool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Kevin Wells <wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Kevin Wells <wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Enable I2C peripheral clocking at the start of a transfer and
disable on transfer completion to reduce peripheral power use
when bus is not in use.

Signed-off-by: Kevin Wells <wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-pnx.c |   33 +++++++--------------------------
 1 files changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index 6bb6ff7..23bd556 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -448,6 +448,8 @@ i2c_pnx_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 		"%s(): entering: %d messages, stat = %04x.\n",
 		__func__, num, ioread32(I2C_REG_STS(alg_data)));
 
+	clk_enable(alg_data->clk);
+
 	bus_reset_if_active(alg_data);
 
 	/* Process transactions in a loop. */
@@ -516,6 +518,8 @@ i2c_pnx_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 
 	bus_reset_if_active(alg_data);
 
+	clk_disable(alg_data->clk);
+
 	/* Cleanup to be sure... */
 	alg_data->mif.buf = NULL;
 	alg_data->mif.len = 0;
@@ -539,29 +543,6 @@ static struct i2c_algorithm pnx_algorithm = {
 	.functionality = i2c_pnx_func,
 };
 
-#ifdef CONFIG_PM
-static int i2c_pnx_controller_suspend(struct platform_device *pdev,
-				      pm_message_t state)
-{
-	struct i2c_pnx_algo_data *alg_data = platform_get_drvdata(pdev);
-
-	/* FIXME: shouldn't this be clk_disable? */
-	clk_enable(alg_data->clk);
-
-	return 0;
-}
-
-static int i2c_pnx_controller_resume(struct platform_device *pdev)
-{
-	struct i2c_pnx_algo_data *alg_data = platform_get_drvdata(pdev);
-
-	return clk_enable(alg_data->clk);
-}
-#else
-#define i2c_pnx_controller_suspend	NULL
-#define i2c_pnx_controller_resume	NULL
-#endif
-
 static int __devinit i2c_pnx_probe(struct platform_device *pdev)
 {
 	unsigned long tmp;
@@ -665,6 +646,9 @@ static int __devinit i2c_pnx_probe(struct platform_device *pdev)
 	dev_dbg(&pdev->dev, "%s: Master at %#8x, irq %d.\n",
 	       alg_data->adapter.name, i2c_pnx->base, i2c_pnx->irq);
 
+	/* Disable clock until needed */
+	clk_disable(alg_data->clk);
+
 	return 0;
 
 out_irq:
@@ -692,7 +676,6 @@ static int __devexit i2c_pnx_remove(struct platform_device *pdev)
 
 	free_irq(i2c_pnx->irq, alg_data);
 	i2c_del_adapter(&alg_data->adapter);
-	clk_disable(alg_data->clk);
 	iounmap(alg_data->ioaddr);
 	release_mem_region(i2c_pnx->base, I2C_PNX_REGION_SIZE);
 	clk_put(alg_data->clk);
@@ -709,8 +692,6 @@ static struct platform_driver i2c_pnx_driver = {
 	},
 	.probe = i2c_pnx_probe,
 	.remove = __devexit_p(i2c_pnx_remove),
-	.suspend = i2c_pnx_controller_suspend,
-	.resume = i2c_pnx_controller_resume,
 };
 
 static int __init i2c_adap_pnx_init(void)
-- 
1.6.6
