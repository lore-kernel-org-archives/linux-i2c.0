From: Gao Pan <b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [Patch v1] i2c: imx: implement bus recovery
Date: Tue, 14 Jul 2015 10:04:46 +0800
Message-ID: <1436839486-11110-1-git-send-email-b54642@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, B20596-KZfg59tc24xl57MIdRCFDg@public.gmane.org, b38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org, b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Implement bus recovery methods for i2c-imx so we can recover from
situations where SCL/SDA are stuck low.

Once i2c bus SCL/SDA are stuck low during transfer, config the i2c
pinctrl to gpio mode by calling pinctrl sleep set function, and then
use GPIO to emulate the i2c protocol to send nine dummy clock to recover
i2c device. After recovery, set i2c pinctrl to default group setting.

Signed-off-by: Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Signed-off-by: Gao Pan <b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 Documentation/devicetree/bindings/i2c/i2c-imx.txt |   4 +
 drivers/i2c/busses/i2c-imx.c                      | 102 +++++++++++++++++++++-
 2 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-imx.txt b/Documentation/devicetree/bindings/i2c/i2c-imx.txt
index ce4311d..0a0848f5 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-imx.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-imx.txt
@@ -14,6 +14,8 @@ Optional properties:
   The absence of the propoerty indicates the default frequency 100 kHz.
 - dmas: A list of two dma specifiers, one for each entry in dma-names.
 - dma-names: should contain "tx" and "rx".
+- recover-scl: specify the gpio related to SCL pin
+- recover-sda: specify the gpio related to SDA pin
 
 Examples:
 
@@ -37,4 +39,6 @@ i2c0: i2c@40066000 { /* i2c0 on vf610 */
 	dmas = <&edma0 0 50>,
 		<&edma0 0 51>;
 	dma-names = "rx","tx";
+	recover-scl = <&gpio5 26 0>;
+	recover-sda = <&gpio5 27 0>;
 };
diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 785aa67..eb4f95c 100644
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
@@ -175,6 +177,16 @@ enum imx_i2c_type {
 	VF610_I2C,
 };
 
+enum imx_i2c_vol_level {
+	I2C_IMX_LOW_VOL_LEVEL,
+	I2C_IMX_HIGH_VOL_LEVEL,
+};
+
+struct imx_i2c_pinctrl {
+	unsigned int	sda_pin;
+	unsigned int	scl_pin;
+};
+
 struct imx_i2c_hwdata {
 	enum imx_i2c_type	devtype;
 	unsigned		regshift;
@@ -206,6 +218,7 @@ struct imx_i2c_struct {
 	unsigned int		ifdr; /* IMX_I2C_IFDR */
 	unsigned int		cur_clk;
 	unsigned int		bitrate;
+	struct imx_i2c_pinctrl	pins;
 	const struct imx_i2c_hwdata	*hwdata;
 
 	struct imx_i2c_dma	*dma;
@@ -436,7 +449,7 @@ static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int for_busy)
 		if (time_after(jiffies, orig_jiffies + msecs_to_jiffies(500))) {
 			dev_dbg(&i2c_imx->adapter.dev,
 				"<%s> I2C bus is busy\n", __func__);
-			return -ETIMEDOUT;
+			return i2c_recover_bus(&i2c_imx->adapter);
 		}
 		schedule();
 	}
@@ -450,6 +463,7 @@ static int i2c_imx_trx_complete(struct imx_i2c_struct *i2c_imx)
 
 	if (unlikely(!(i2c_imx->i2csr & I2SR_IIF))) {
 		dev_dbg(&i2c_imx->adapter.dev, "<%s> Timeout\n", __func__);
+		i2c_recover_bus(&i2c_imx->adapter);
 		return -ETIMEDOUT;
 	}
 	dev_dbg(&i2c_imx->adapter.dev, "<%s> TRX complete\n", __func__);
@@ -956,6 +970,67 @@ fail0:
 	return (result < 0) ? result : num;
 }
 
+static int i2c_imx_get_scl(struct i2c_adapter *adap)
+{
+	struct imx_i2c_struct *i2c_imx;
+
+	i2c_imx = container_of(adap, struct imx_i2c_struct, adapter);
+	if (i2c_imx->pins.sda_pin && i2c_imx->pins.scl_pin)
+		return gpio_get_value(i2c_imx->pins.scl_pin);
+
+	return I2C_IMX_HIGH_VOL_LEVEL;
+}
+
+static int i2c_imx_get_sda(struct i2c_adapter *adap)
+{
+	struct imx_i2c_struct *i2c_imx;
+
+	i2c_imx = container_of(adap, struct imx_i2c_struct, adapter);
+	if (i2c_imx->pins.sda_pin && i2c_imx->pins.scl_pin) {
+		gpio_direction_input(i2c_imx->pins.sda_pin);
+		return gpio_get_value(i2c_imx->pins.sda_pin);
+	}
+
+	return I2C_IMX_HIGH_VOL_LEVEL;
+}
+
+static void i2c_imx_set_scl(struct i2c_adapter *adap, int val)
+{
+	struct imx_i2c_struct *i2c_imx;
+
+	i2c_imx = container_of(adap, struct imx_i2c_struct, adapter);
+	if (i2c_imx->pins.sda_pin && i2c_imx->pins.scl_pin)
+		gpio_direction_output(i2c_imx->pins.scl_pin, val);
+}
+
+static void i2c_imx_prepare_recovery(struct i2c_adapter *adap)
+{
+	struct imx_i2c_struct *i2c_imx;
+
+	i2c_imx = container_of(adap, struct imx_i2c_struct, adapter);
+	if (i2c_imx->pins.sda_pin && i2c_imx->pins.scl_pin)
+		pinctrl_pm_select_sleep_state(&adap->dev);
+
+}
+
+static void i2c_imx_unprepare_recovery(struct i2c_adapter *adap)
+{
+	struct imx_i2c_struct *i2c_imx;
+
+	i2c_imx = container_of(adap, struct imx_i2c_struct, adapter);
+	if (i2c_imx->pins.sda_pin && i2c_imx->pins.scl_pin)
+		pinctrl_pm_select_default_state(&adap->dev);
+}
+
+static struct i2c_bus_recovery_info i2c_imx_bus_recovery_info = {
+	.get_scl                = i2c_imx_get_scl,
+	.get_sda                = i2c_imx_get_sda,
+	.set_scl                = i2c_imx_set_scl,
+	.prepare_recovery	= i2c_imx_prepare_recovery,
+	.unprepare_recovery	= i2c_imx_unprepare_recovery,
+	.recover_bus            = i2c_generic_scl_recovery,
+};
+
 static u32 i2c_imx_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL
@@ -1009,6 +1084,7 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	i2c_imx->adapter.dev.parent	= &pdev->dev;
 	i2c_imx->adapter.nr		= pdev->id;
 	i2c_imx->adapter.dev.of_node	= pdev->dev.of_node;
+	i2c_imx->adapter.bus_recovery_info	= &i2c_imx_bus_recovery_info;
 	i2c_imx->base			= base;
 
 	/* Get I2C clock */
@@ -1037,6 +1113,30 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	/* Set up adapter data */
 	i2c_set_adapdata(&i2c_imx->adapter, i2c_imx);
 
+	/* Init recover pins */
+	i2c_imx->pins.sda_pin =
+		of_get_named_gpio(pdev->dev.of_node, "recover-sda", 0);
+	i2c_imx->pins.scl_pin =
+		of_get_named_gpio(pdev->dev.of_node, "recover-scl", 0);
+	if (gpio_is_valid(i2c_imx->pins.sda_pin) &&
+	    gpio_is_valid(i2c_imx->pins.scl_pin)) {
+		ret = devm_gpio_request_one(&pdev->dev, i2c_imx->pins.sda_pin,
+					    GPIOF_OUT_INIT_HIGH, "recover-sda");
+		if (ret) {
+			i2c_imx->pins.sda_pin = 0;
+			dev_err(&pdev->dev, "request sda failed\n");
+		}
+		ret = devm_gpio_request_one(&pdev->dev, i2c_imx->pins.scl_pin,
+					    GPIOF_OUT_INIT_HIGH, "recover-scl");
+		if (ret) {
+			i2c_imx->pins.scl_pin = 0;
+			dev_err(&pdev->dev, "request scl failed\n");
+		}
+	} else {
+		i2c_imx->pins.sda_pin = 0;
+		i2c_imx->pins.scl_pin = 0;
+	}
+
 	/* Set up clock divider */
 	i2c_imx->bitrate = IMX_I2C_BIT_RATE;
 	ret = of_property_read_u32(pdev->dev.of_node,
-- 
1.9.1
