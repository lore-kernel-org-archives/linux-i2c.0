From: Gao Pan <b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [Patch v2] i2c: imx: implement bus recovery
Date: Fri, 17 Jul 2015 10:36:45 +0800
Message-ID: <1437100605-28047-1-git-send-email-b54642@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, B20596-KZfg59tc24xl57MIdRCFDg@public.gmane.org, b38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org, b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Implement bus recovery methods for i2c-imx so we can recover from
situations where SCL/SDA are stuck low.

Once i2c bus SCL/SDA are stuck low during transfer, config the i2c
pinctrl to gpio mode by calling pinctrl sleep set function, and then
use GPIO to emulate the i2c protocol to send nine dummy clock to recove=
r
i2c device. After recovery, set i2c pinctrl to default group setting.

V2:
As Uwe Kleine-K=C3=B6nig's suggestion, the version do below changes:
 -replace of_get_named_gpio() with devm_gpiod_get_optional()
 -move gpio_direction_input() and gpio_direction_output() call to the
  prepare callback
 -use 0 and 1 as return value for the get_scl and get_sda callbacks

Signed-off-by: Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Signed-off-by: Gao Pan <b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 Documentation/devicetree/bindings/i2c/i2c-imx.txt |   4 +
 drivers/i2c/busses/i2c-imx.c                      | 104 ++++++++++++++=
++++++--
 2 files changed, 100 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-imx.txt b/Docume=
ntation/devicetree/bindings/i2c/i2c-imx.txt
index ce4311d..a9fe525 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-imx.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-imx.txt
@@ -14,6 +14,8 @@ Optional properties:
   The absence of the propoerty indicates the default frequency 100 kHz=
=2E
 - dmas: A list of two dma specifiers, one for each entry in dma-names.
 - dma-names: should contain "tx" and "rx".
+- scl-gpio: specify the gpio related to SCL pin
+- sda-gpio: specify the gpio related to SDA pin
=20
 Examples:
=20
@@ -37,4 +39,6 @@ i2c0: i2c@40066000 { /* i2c0 on vf610 */
 	dmas =3D <&edma0 0 50>,
 		<&edma0 0 51>;
 	dma-names =3D "rx","tx";
+	scl-gpio =3D <&gpio5 26 0>;
+	sda-gpio =3D <&gpio5 27 0>;
 };
diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.=
c
index 785aa67..4f75370 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -40,6 +40,7 @@
 #include <linux/dmapool.h>
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -48,6 +49,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_gpio.h>
 #include <linux/of_dma.h>
 #include <linux/platform_data/i2c-imx.h>
 #include <linux/platform_device.h>
@@ -175,6 +177,11 @@ enum imx_i2c_type {
 	VF610_I2C,
 };
=20
+struct imx_i2c_pinctrl {
+	struct gpio_desc *sda;
+	struct gpio_desc *scl;
+};
+
 struct imx_i2c_hwdata {
 	enum imx_i2c_type	devtype;
 	unsigned		regshift;
@@ -206,6 +213,7 @@ struct imx_i2c_struct {
 	unsigned int		ifdr; /* IMX_I2C_IFDR */
 	unsigned int		cur_clk;
 	unsigned int		bitrate;
+	struct imx_i2c_pinctrl	pins;
 	const struct imx_i2c_hwdata	*hwdata;
=20
 	struct imx_i2c_dma	*dma;
@@ -436,7 +444,7 @@ static int i2c_imx_bus_busy(struct imx_i2c_struct *=
i2c_imx, int for_busy)
 		if (time_after(jiffies, orig_jiffies + msecs_to_jiffies(500))) {
 			dev_dbg(&i2c_imx->adapter.dev,
 				"<%s> I2C bus is busy\n", __func__);
-			return -ETIMEDOUT;
+			return i2c_recover_bus(&i2c_imx->adapter);
 		}
 		schedule();
 	}
@@ -450,7 +458,7 @@ static int i2c_imx_trx_complete(struct imx_i2c_stru=
ct *i2c_imx)
=20
 	if (unlikely(!(i2c_imx->i2csr & I2SR_IIF))) {
 		dev_dbg(&i2c_imx->adapter.dev, "<%s> Timeout\n", __func__);
-		return -ETIMEDOUT;
+		return i2c_recover_bus(&i2c_imx->adapter);
 	}
 	dev_dbg(&i2c_imx->adapter.dev, "<%s> TRX complete\n", __func__);
 	i2c_imx->i2csr =3D 0;
@@ -956,6 +964,67 @@ fail0:
 	return (result < 0) ? result : num;
 }
=20
+static int i2c_imx_get_scl(struct i2c_adapter *adap)
+{
+	struct imx_i2c_struct *i2c_imx;
+
+	i2c_imx =3D container_of(adap, struct imx_i2c_struct, adapter);
+	if (i2c_imx->pins.scl)
+		return gpiod_get_value(i2c_imx->pins.scl);
+
+	return 1;
+}
+
+static int i2c_imx_get_sda(struct i2c_adapter *adap)
+{
+	struct imx_i2c_struct *i2c_imx;
+
+	i2c_imx =3D container_of(adap, struct imx_i2c_struct, adapter);
+	if (i2c_imx->pins.sda)
+		return gpiod_get_value(i2c_imx->pins.sda);
+
+	return 1;
+}
+
+static void i2c_imx_set_scl(struct i2c_adapter *adap, int val)
+{
+	struct imx_i2c_struct *i2c_imx;
+
+	i2c_imx =3D container_of(adap, struct imx_i2c_struct, adapter);
+	if (i2c_imx->pins.scl)
+		gpiod_set_value(i2c_imx->pins.scl, val);
+}
+
+static void i2c_imx_prepare_recovery(struct i2c_adapter *adap)
+{
+	struct imx_i2c_struct *i2c_imx;
+
+	i2c_imx =3D container_of(adap, struct imx_i2c_struct, adapter);
+	if (i2c_imx->pins.sda && i2c_imx->pins.scl) {
+		pinctrl_pm_select_sleep_state(&adap->dev);
+		gpiod_direction_input(i2c_imx->pins.sda);
+		gpiod_direction_output(i2c_imx->pins.scl, 1);
+	}
+}
+
+static void i2c_imx_unprepare_recovery(struct i2c_adapter *adap)
+{
+	struct imx_i2c_struct *i2c_imx;
+
+	i2c_imx =3D container_of(adap, struct imx_i2c_struct, adapter);
+	if (i2c_imx->pins.sda && i2c_imx->pins.scl)
+		pinctrl_pm_select_default_state(&adap->dev);
+}
+
+static struct i2c_bus_recovery_info i2c_imx_bus_recovery_info =3D {
+	.get_scl =3D i2c_imx_get_scl,
+	.get_sda =3D i2c_imx_get_sda,
+	.set_scl =3D i2c_imx_set_scl,
+	.prepare_recovery =3D i2c_imx_prepare_recovery,
+	.unprepare_recovery =3D i2c_imx_unprepare_recovery,
+	.recover_bus =3D i2c_generic_scl_recovery,
+};
+
 static u32 i2c_imx_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL
@@ -1004,12 +1073,13 @@ static int i2c_imx_probe(struct platform_device=
 *pdev)
=20
 	/* Setup i2c_imx driver structure */
 	strlcpy(i2c_imx->adapter.name, pdev->name, sizeof(i2c_imx->adapter.na=
me));
-	i2c_imx->adapter.owner		=3D THIS_MODULE;
-	i2c_imx->adapter.algo		=3D &i2c_imx_algo;
-	i2c_imx->adapter.dev.parent	=3D &pdev->dev;
-	i2c_imx->adapter.nr		=3D pdev->id;
-	i2c_imx->adapter.dev.of_node	=3D pdev->dev.of_node;
-	i2c_imx->base			=3D base;
+	i2c_imx->adapter.owner =3D THIS_MODULE;
+	i2c_imx->adapter.algo =3D &i2c_imx_algo;
+	i2c_imx->adapter.dev.parent =3D &pdev->dev;
+	i2c_imx->adapter.nr =3D pdev->id;
+	i2c_imx->adapter.dev.of_node =3D pdev->dev.of_node;
+	i2c_imx->adapter.bus_recovery_info =3D &i2c_imx_bus_recovery_info;
+	i2c_imx->base =3D base;
=20
 	/* Get I2C clock */
 	i2c_imx->clk =3D devm_clk_get(&pdev->dev, NULL);
@@ -1037,6 +1107,24 @@ static int i2c_imx_probe(struct platform_device =
*pdev)
 	/* Set up adapter data */
 	i2c_set_adapdata(&i2c_imx->adapter, i2c_imx);
=20
+	/* Init recover pins */
+	i2c_imx->pins.sda =3D
+		devm_gpiod_get_optional(&pdev->dev, "sda-gpio", 0);
+	i2c_imx->pins.scl =3D
+		devm_gpiod_get_optional(&pdev->dev, "scl-gpio", 0);
+
+	if (IS_ERR(i2c_imx->pins.sda)) {
+		ret =3D PTR_ERR(i2c_imx->pins.sda);
+		dev_err(&pdev->dev, "Failed to get sda gpio: %d\n", ret);
+		i2c_imx->pins.sda =3D NULL;
+	}
+
+	if (IS_ERR(i2c_imx->pins.scl)) {
+		ret =3D PTR_ERR(i2c_imx->pins.scl);
+		dev_err(&pdev->dev, "Failed to get scl gpio: %d\n", ret);
+		i2c_imx->pins.scl =3D NULL;
+	}
+
 	/* Set up clock divider */
 	i2c_imx->bitrate =3D IMX_I2C_BIT_RATE;
 	ret =3D of_property_read_u32(pdev->dev.of_node,
--=20
1.9.1
