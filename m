From: Gao Pan <b54642@freescale.com>
Subject: [Patch V9] i2c: imx: add runtime pm support to improve the performance
Date: Mon, 26 Oct 2015 14:55:21 +0800
Message-ID: <1445842521-26222-1-git-send-email-b54642@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bn1on0111.outbound.protection.outlook.com ([157.56.110.111]:50507
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752636AbbJZG4U (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 26 Oct 2015 02:56:20 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, B20596@freescale.com, b38611@freescale.com, b54642@freescale.com, u.kleine-koenig@pengutronix.de, kernel@pengutronix.de, hkallweit1@gmail.com, s.hauer@pengutronix.de

In our former i2c driver, i2c clk is enabled and disabled in
xfer function, which contributes to power saving. However,
the clk enable process brings a busy wait delay until the core
is stable. As a result, the performance is sacrificed.

To weigh the power consumption and i2c bus performance, runtime
pm is the good solution for it. The clk is enabled when a i2c
transfer starts, and disabled after a specifically defined delay.

If CONFIG_PM is disabled the net result of this patch is that the
clock is never disabled.

Without the patch the test case (many eeprom reads) executes with appro=
x:
real 1m7.735s
user 0m0.488s
sys 0m20.040s

With the patch the same test case (many eeprom reads) executes with app=
rox:
real 0m54.241s
user 0m0.440s
sys 0m5.920s

Signed-off-by: Fugang Duan <B38611@freescale.com>
Signed-off-by: Gao Pan <b54642@freescale.com>
---
V2:
As Uwe Kleine-K=C3=B6nig's suggestion, the version do below changes:
 -call clk_prepare_enable in probe to avoid never enabling clock
  if CONFIG_PM is disabled
 -enable clock before request IRQ in probe
 -remove the pm staff in i2c_imx_isr

V3:
 -pm_runtime_get_sync returns < 0 as error

V4:
 -add pm_runtime_set_active before pm_runtime_enable
 -replace pm_runtime_put_autosuspend with pm_runtime_autosuspend
  in probe
 -add error disposal when i2c_add_numbered_adapter fails

V5:
 -clean up and disable runtime PM when i2c_add_numbered_adapter fails
 -use pm_runtime_get and pm_runtime_put_autosuspend in probe

V6:
 -disable the clock manually and set the state to suspended explicitly =
with
  pm_runtime_set_suspended

V7:
 -manually disabling the clock and use pm_runtime_put_noidle in the rem=
ove callback

V8:
 -move out label after the two runtime pm calls in i2c_imx_xfer

V9:
 -add comment in the log what is the result when CONFIG_PM is disabled
 -do the rpm_disable cleanup in reverse order

 drivers/i2c/busses/i2c-imx.c | 90 ++++++++++++++++++++++++++++++++++++=
++------
 1 file changed, 78 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.=
c
index 8d46e74..d2a379f 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -54,6 +54,7 @@
 #include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
=20
 /** Defines **********************************************************=
**********
 **********************************************************************=
*********/
@@ -119,6 +120,8 @@
 #define I2CR_IEN_OPCODE_0	0x0
 #define I2CR_IEN_OPCODE_1	I2CR_IEN
=20
+#define I2C_PM_TIMEOUT		10 /* ms */
+
 /** Variables ********************************************************=
**********
 **********************************************************************=
*********/
=20
@@ -526,9 +529,6 @@ static int i2c_imx_start(struct imx_i2c_struct *i2c=
_imx)
=20
 	i2c_imx_set_clk(i2c_imx);
=20
-	result =3D clk_prepare_enable(i2c_imx->clk);
-	if (result)
-		return result;
 	imx_i2c_write_reg(i2c_imx->ifdr, i2c_imx, IMX_I2C_IFDR);
 	/* Enable I2C controller */
 	imx_i2c_write_reg(i2c_imx->hwdata->i2sr_clr_opcode, i2c_imx, IMX_I2C_=
I2SR);
@@ -581,7 +581,6 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2c=
_imx)
 	/* Disable I2C controller */
 	temp =3D i2c_imx->hwdata->i2cr_ien_opcode ^ I2CR_IEN,
 	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
-	clk_disable_unprepare(i2c_imx->clk);
 }
=20
 static irqreturn_t i2c_imx_isr(int irq, void *dev_id)
@@ -900,6 +899,10 @@ static int i2c_imx_xfer(struct i2c_adapter *adapte=
r,
=20
 	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
=20
+	result =3D pm_runtime_get_sync(i2c_imx->adapter.dev.parent);
+	if (result < 0)
+		goto out;
+
 	/* Start I2C transfer */
 	result =3D i2c_imx_start(i2c_imx);
 	if (result) {
@@ -963,6 +966,10 @@ fail0:
 	/* Stop I2C transfer */
 	i2c_imx_stop(i2c_imx);
=20
+	pm_runtime_mark_last_busy(i2c_imx->adapter.dev.parent);
+	pm_runtime_put_autosuspend(i2c_imx->adapter.dev.parent);
+
+out:
 	dev_dbg(&i2c_imx->adapter.dev, "<%s> exit with: %s: %d\n", __func__,
 		(result < 0) ? "error" : "success msg",
 			(result < 0) ? result : num);
@@ -1082,7 +1089,7 @@ static int i2c_imx_probe(struct platform_device *=
pdev)
=20
 	ret =3D clk_prepare_enable(i2c_imx->clk);
 	if (ret) {
-		dev_err(&pdev->dev, "can't enable I2C clock\n");
+		dev_err(&pdev->dev, "can't enable I2C clock, ret=3D%d\n", ret);
 		return ret;
 	}
=20
@@ -1106,6 +1113,18 @@ static int i2c_imx_probe(struct platform_device =
*pdev)
 	/* Set up adapter data */
 	i2c_set_adapdata(&i2c_imx->adapter, i2c_imx);
=20
+	/* Set up platform driver data */
+	platform_set_drvdata(pdev, i2c_imx);
+
+	pm_runtime_set_autosuspend_delay(&pdev->dev, I2C_PM_TIMEOUT);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	ret =3D pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0)
+		goto rpm_disable;
+
 	/* Set up clock divider */
 	i2c_imx->bitrate =3D IMX_I2C_BIT_RATE;
 	ret =3D of_property_read_u32(pdev->dev.of_node,
@@ -1122,14 +1141,13 @@ static int i2c_imx_probe(struct platform_device=
 *pdev)
 	ret =3D i2c_add_numbered_adapter(&i2c_imx->adapter);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "registration failed\n");
-		goto clk_disable;
+		goto rpm_disable;
 	}
=20
 	i2c_imx_init_recovery_info(i2c_imx, pdev);
=20
-	/* Set up platform driver data */
-	platform_set_drvdata(pdev, i2c_imx);
-	clk_disable_unprepare(i2c_imx->clk);
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
=20
 	dev_dbg(&i2c_imx->adapter.dev, "claimed irq %d\n", irq);
 	dev_dbg(&i2c_imx->adapter.dev, "device resources: %pR\n", res);
@@ -1142,6 +1160,12 @@ static int i2c_imx_probe(struct platform_device =
*pdev)
=20
 	return 0;   /* Return OK */
=20
+rpm_disable:
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+
 clk_disable:
 	clk_disable_unprepare(i2c_imx->clk);
 	return ret;
@@ -1150,6 +1174,11 @@ clk_disable:
 static int i2c_imx_remove(struct platform_device *pdev)
 {
 	struct imx_i2c_struct *i2c_imx =3D platform_get_drvdata(pdev);
+	int ret;
+
+	ret =3D pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0)
+		return ret;
=20
 	/* remove adapter */
 	dev_dbg(&i2c_imx->adapter.dev, "adapter removed\n");
@@ -1164,17 +1193,54 @@ static int i2c_imx_remove(struct platform_devic=
e *pdev)
 	imx_i2c_write_reg(0, i2c_imx, IMX_I2C_I2CR);
 	imx_i2c_write_reg(0, i2c_imx, IMX_I2C_I2SR);
=20
+	clk_disable_unprepare(i2c_imx->clk);
+
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int i2c_imx_runtime_suspend(struct device *dev)
+{
+	struct imx_i2c_struct *i2c_imx  =3D dev_get_drvdata(dev);
+
+	clk_disable_unprepare(i2c_imx->clk);
+
 	return 0;
 }
=20
+static int i2c_imx_runtime_resume(struct device *dev)
+{
+	struct imx_i2c_struct *i2c_imx  =3D dev_get_drvdata(dev);
+	int ret;
+
+	ret =3D clk_prepare_enable(i2c_imx->clk);
+	if (ret)
+		dev_err(dev, "can't enable I2C clock, ret=3D%d\n", ret);
+
+	return ret;
+}
+
+static const struct dev_pm_ops i2c_imx_pm_ops =3D {
+	SET_RUNTIME_PM_OPS(i2c_imx_runtime_suspend,
+			   i2c_imx_runtime_resume, NULL)
+};
+#define I2C_IMX_PM_OPS (&i2c_imx_pm_ops)
+#else
+#define I2C_IMX_PM_OPS NULL
+#endif /* CONFIG_PM */
+
 static struct platform_driver i2c_imx_driver =3D {
 	.probe =3D i2c_imx_probe,
 	.remove =3D i2c_imx_remove,
-	.driver	=3D {
-		.name	=3D DRIVER_NAME,
+	.driver =3D {
+		.name =3D DRIVER_NAME,
+		.pm =3D I2C_IMX_PM_OPS,
 		.of_match_table =3D i2c_imx_dt_ids,
 	},
-	.id_table	=3D imx_i2c_devtype,
+	.id_table =3D imx_i2c_devtype,
 };
=20
 static int __init i2c_adap_imx_init(void)
--=20
1.9.1
