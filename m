From: Gao Pan <b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [Patch v1] i2c: imx: add runtime pm support to improve the performance
Date: Thu, 11 Jun 2015 09:50:04 +0800
Message-ID: <1433987404-28957-1-git-send-email-b54642@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, B20596-KZfg59tc24xl57MIdRCFDg@public.gmane.org, b38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

In our former i2c driver, i2c clk is enabled and disabled in
xfer function, which contributes to power saving. However,
the clk enable process brings a busy wait delay until the core
is stable. As a result, the performance is sacrificed.

To weigh the power consuption and i2c bus performance, runtime
pm is the good solution for it. The clk is enabled when a i2c
transfer starts, and disabled afer a specifically defined delay.

Without the patch the test case (many eeprom reads) executes with approx:
real 1m7.735s
user 0m0.488s
sys 0m20.040s

With the patch the same test case (many eeprom reads) executes with approx:
real 0m54.241s
user 0m0.440s
sys 0m5.920s

>From the test result, the patch get better performance.

Signed-off-by: Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Signed-off-by: Gao Pan <b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/i2c/busses/i2c-imx.c | 78 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 66 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 785aa67..cc4b5d6 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -53,6 +53,7 @@
 #include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 
 /** Defines ********************************************************************
 *******************************************************************************/
@@ -118,6 +119,8 @@
 #define I2CR_IEN_OPCODE_0	0x0
 #define I2CR_IEN_OPCODE_1	I2CR_IEN
 
+#define I2C_PM_TIMEOUT		10 /* ms */
+
 /** Variables ******************************************************************
 *******************************************************************************/
 
@@ -520,9 +523,6 @@ static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
 
 	i2c_imx_set_clk(i2c_imx);
 
-	result = clk_prepare_enable(i2c_imx->clk);
-	if (result)
-		return result;
 	imx_i2c_write_reg(i2c_imx->ifdr, i2c_imx, IMX_I2C_IFDR);
 	/* Enable I2C controller */
 	imx_i2c_write_reg(i2c_imx->hwdata->i2sr_clr_opcode, i2c_imx, IMX_I2C_I2SR);
@@ -575,7 +575,6 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
 	/* Disable I2C controller */
 	temp = i2c_imx->hwdata->i2cr_ien_opcode ^ I2CR_IEN,
 	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
-	clk_disable_unprepare(i2c_imx->clk);
 }
 
 static irqreturn_t i2c_imx_isr(int irq, void *dev_id)
@@ -583,6 +582,9 @@ static irqreturn_t i2c_imx_isr(int irq, void *dev_id)
 	struct imx_i2c_struct *i2c_imx = dev_id;
 	unsigned int temp;
 
+	if (pm_runtime_suspended(i2c_imx->adapter.dev.parent))
+		return IRQ_NONE;
+
 	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
 	if (temp & I2SR_IIF) {
 		/* save status register */
@@ -894,6 +896,10 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
 
 	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
 
+	result = pm_runtime_get_sync(i2c_imx->adapter.dev.parent);
+	if (IS_ERR_VALUE(result))
+		goto out;
+
 	/* Start I2C transfer */
 	result = i2c_imx_start(i2c_imx);
 	if (result)
@@ -950,6 +956,10 @@ fail0:
 	/* Stop I2C transfer */
 	i2c_imx_stop(i2c_imx);
 
+out:
+	pm_runtime_mark_last_busy(i2c_imx->adapter.dev.parent);
+	pm_runtime_put_autosuspend(i2c_imx->adapter.dev.parent);
+
 	dev_dbg(&i2c_imx->adapter.dev, "<%s> exit with: %s: %d\n", __func__,
 		(result < 0) ? "error" : "success msg",
 			(result < 0) ? result : num);
@@ -1018,11 +1028,6 @@ static int i2c_imx_probe(struct platform_device *pdev)
 		return PTR_ERR(i2c_imx->clk);
 	}
 
-	ret = clk_prepare_enable(i2c_imx->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "can't enable I2C clock\n");
-		return ret;
-	}
 	/* Request IRQ */
 	ret = devm_request_irq(&pdev->dev, irq, i2c_imx_isr, 0,
 				pdev->name, i2c_imx);
@@ -1037,6 +1042,14 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	/* Set up adapter data */
 	i2c_set_adapdata(&i2c_imx->adapter, i2c_imx);
 
+	/* Set up platform driver data */
+	platform_set_drvdata(pdev, i2c_imx);
+
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, I2C_PM_TIMEOUT);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
+
 	/* Set up clock divider */
 	i2c_imx->bitrate = IMX_I2C_BIT_RATE;
 	ret = of_property_read_u32(pdev->dev.of_node,
@@ -1056,9 +1069,8 @@ static int i2c_imx_probe(struct platform_device *pdev)
 		goto clk_disable;
 	}
 
-	/* Set up platform driver data */
-	platform_set_drvdata(pdev, i2c_imx);
-	clk_disable_unprepare(i2c_imx->clk);
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
 
 	dev_dbg(&i2c_imx->adapter.dev, "claimed irq %d\n", irq);
 	dev_dbg(&i2c_imx->adapter.dev, "device resources: %pR\n", res);
@@ -1079,6 +1091,11 @@ clk_disable:
 static int i2c_imx_remove(struct platform_device *pdev)
 {
 	struct imx_i2c_struct *i2c_imx = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (IS_ERR_VALUE(ret))
+		return ret;
 
 	/* remove adapter */
 	dev_dbg(&i2c_imx->adapter.dev, "adapter removed\n");
@@ -1093,14 +1110,51 @@ static int i2c_imx_remove(struct platform_device *pdev)
 	imx_i2c_write_reg(0, i2c_imx, IMX_I2C_I2CR);
 	imx_i2c_write_reg(0, i2c_imx, IMX_I2C_I2SR);
 
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int i2c_imx_runtime_suspend(struct device *dev)
+{
+	struct imx_i2c_struct *i2c_imx  = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(i2c_imx->clk);
+
+	return 0;
+}
+
+static int i2c_imx_runtime_resume(struct device *dev)
+{
+	struct imx_i2c_struct *i2c_imx  = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(i2c_imx->clk);
+	if (ret) {
+		dev_err(dev, "can't enable I2C clock\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops i2c_imx_pm_ops = {
+	SET_RUNTIME_PM_OPS(i2c_imx_runtime_suspend,
+			   i2c_imx_runtime_resume, NULL)
+};
+#define I2C_IMX_PM_OPS (&i2c_imx_pm_ops)
+#else
+#define I2C_IMX_PM_OPS NULL
+#endif /* CONFIG_PM */
+
 static struct platform_driver i2c_imx_driver = {
 	.probe = i2c_imx_probe,
 	.remove = i2c_imx_remove,
 	.driver	= {
 		.name	= DRIVER_NAME,
+		.pm     = I2C_IMX_PM_OPS,
 		.of_match_table = i2c_imx_dt_ids,
 	},
 	.id_table	= imx_i2c_devtype,
-- 
1.9.1
