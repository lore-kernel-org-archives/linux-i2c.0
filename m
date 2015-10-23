From: Gao Pan <b54642@freescale.com>
Subject: [Patch V8] i2c: imx: implement bus recovery
Date: Fri, 23 Oct 2015 20:28:54 +0800
Message-ID: <1445603334-7661-1-git-send-email-b54642@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bn1on0146.outbound.protection.outlook.com ([157.56.110.146]:49312
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752564AbbJWM3m (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 23 Oct 2015 08:29:42 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, u.kleine-koenig@pengutronix.de
Cc: linux-i2c@vger.kernel.org, B20596@freescale.com, b38611@freescale.com, b54642@freescale.com, kernel@pengutronix.de, hkallweit1@gmail.com

Implement bus recovery methods for i2c-imx so we can recover from
situations where SCL/SDA are stuck low.

Once i2c bus SCL/SDA are stuck low during transfer, config the i2c
pinctrl to gpio mode by calling pinctrl sleep set function, and then
use GPIO to emulate the i2c protocol to send nine dummy clock to recove=
r
i2c device. After recovery, set i2c pinctrl to default group setting.

Signed-off-by: Fugang Duan <B38611@freescale.com>
Signed-off-by: Gao Pan <b54642@freescale.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
V2:
As Uwe Kleine-K=C3=B6nig's suggestion, the version do below changes:
 -replace of_get_named_gpio() with devm_gpiod_get_optional()
 -move gpio_direction_input() and gpio_direction_output() call to the
  prepare callback
 -use 0 and 1 as return value for the get_scl and get_sda callbacks

V3:
 -replace "...-gpio" with "...-gpios" in i2c binding doc
 -document the requirement of using sleep state to configure
  the pins as gpio in i2c binding doc
 -remove i2c_recover_bus() in i2c_imx_trx_complete()
 -use GPIOD_OUT_HIGH as the parameter of devm_gpiod_get_optional to
  config the gpios as output high
 -add error disposal as devm_gpiod_get_optional meets error

V4:
 -remove include <linux/of_gpio.h>
 -call i2c_recover_bus under the condition of the existing of
  both sda and scl. Drop the sda and scl check in i2c_imx_get_scl,
  i2c_imx_get_sda, i2c_imx_set_scl, i2c_imx_prepare_recovery and
  i2c_imx_prepare_recovery
 -use GPIOD_OUT_IN as the parameter of devm_gpiod_get_optional
 -remove documenting the requirement of using sleep state to configure
  the pins as gpio in i2c binding doc

V5:
 -introduce a dedicated gpio state for bus recovery.
 -assign adapter.bus_recovery_info after the two gpios were aquired suc=
cessfully

V6:
 -assign adapter.bus_recovery_info under the condition that gpios are a=
cquired successfully
 -not try the recovery when pinctrl_lookup_state returns an error

V7:
 -execute the bus recovery once in a transfer, when the controller fail=
s to start
 -use i2c_generic_gpio_recovery() to handle the bus recovery with gpios

V8:
 -remove unused symbol and unrelated whitespace changes

 Documentation/devicetree/bindings/i2c/i2c-imx.txt |  9 +++
 drivers/i2c/busses/i2c-imx.c                      | 71 +++++++++++++++=
++++++++
 2 files changed, 80 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-imx.txt b/Docume=
ntation/devicetree/bindings/i2c/i2c-imx.txt
index ce4311d..eab5836 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-imx.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-imx.txt
@@ -14,6 +14,10 @@ Optional properties:
   The absence of the propoerty indicates the default frequency 100 kHz=
=2E
 - dmas: A list of two dma specifiers, one for each entry in dma-names.
 - dma-names: should contain "tx" and "rx".
+- scl-gpios: specify the gpio related to SCL pin
+- sda-gpios: specify the gpio related to SDA pin
+- pinctrl: add extra pinctrl to configure i2c pins to gpio function fo=
r i2c
+  bus recovery, call it "gpio" state
=20
 Examples:
=20
@@ -37,4 +41,9 @@ i2c0: i2c@40066000 { /* i2c0 on vf610 */
 	dmas =3D <&edma0 0 50>,
 		<&edma0 0 51>;
 	dma-names =3D "rx","tx";
+	pinctrl-names =3D "default", "gpio";
+	pinctrl-0 =3D <&pinctrl_i2c1>;
+	pinctrl-1 =3D <&pinctrl_i2c1_gpio>;
+	scl-gpios =3D <&gpio5 26 GPIO_ACTIVE_HIGH>;
+	sda-gpios =3D <&gpio5 27 GPIO_ACTIVE_HIGH>;
 };
diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.=
c
index 785aa67..8d46e74 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -49,6 +49,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
+#include <linux/of_gpio.h>
 #include <linux/platform_data/i2c-imx.h>
 #include <linux/platform_device.h>
 #include <linux/sched.h>
@@ -207,6 +208,11 @@ struct imx_i2c_struct {
 	unsigned int		cur_clk;
 	unsigned int		bitrate;
 	const struct imx_i2c_hwdata	*hwdata;
+	struct i2c_bus_recovery_info rinfo;
+
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pinctrl_pins_default;
+	struct pinctrl_state *pinctrl_pins_gpio;
=20
 	struct imx_i2c_dma	*dma;
 };
@@ -896,6 +902,13 @@ static int i2c_imx_xfer(struct i2c_adapter *adapte=
r,
=20
 	/* Start I2C transfer */
 	result =3D i2c_imx_start(i2c_imx);
+	if (result) {
+		if (i2c_imx->adapter.bus_recovery_info) {
+			i2c_recover_bus(&i2c_imx->adapter);
+			result =3D i2c_imx_start(i2c_imx);
+		}
+	}
+
 	if (result)
 		goto fail0;
=20
@@ -956,6 +969,55 @@ fail0:
 	return (result < 0) ? result : num;
 }
=20
+static void i2c_imx_prepare_recovery(struct i2c_adapter *adap)
+{
+	struct imx_i2c_struct *i2c_imx;
+
+	i2c_imx =3D container_of(adap, struct imx_i2c_struct, adapter);
+
+	pinctrl_select_state(i2c_imx->pinctrl, i2c_imx->pinctrl_pins_gpio);
+}
+
+static void i2c_imx_unprepare_recovery(struct i2c_adapter *adap)
+{
+	struct imx_i2c_struct *i2c_imx;
+
+	i2c_imx =3D container_of(adap, struct imx_i2c_struct, adapter);
+
+	pinctrl_select_state(i2c_imx->pinctrl, i2c_imx->pinctrl_pins_default)=
;
+}
+
+static void i2c_imx_init_recovery_info(struct imx_i2c_struct *i2c_imx,
+		struct platform_device *pdev)
+{
+	struct i2c_bus_recovery_info *rinfo =3D &i2c_imx->rinfo;
+
+	i2c_imx->pinctrl_pins_default =3D pinctrl_lookup_state(i2c_imx->pinct=
rl,
+			PINCTRL_STATE_DEFAULT);
+	i2c_imx->pinctrl_pins_gpio =3D pinctrl_lookup_state(i2c_imx->pinctrl,
+			"gpio");
+	rinfo->sda_gpio =3D of_get_named_gpio_flags(pdev->dev.of_node,
+			"sda-gpios", 0, NULL);
+	rinfo->scl_gpio =3D of_get_named_gpio_flags(pdev->dev.of_node,
+			"scl-gpios", 0, NULL);
+
+	if (!gpio_is_valid(rinfo->sda_gpio) ||
+	    !gpio_is_valid(rinfo->scl_gpio) ||
+	    IS_ERR(i2c_imx->pinctrl_pins_default) ||
+	    IS_ERR(i2c_imx->pinctrl_pins_gpio)) {
+		dev_dbg(&pdev->dev, "recovery information incomplete\n");
+		return;
+	}
+
+	dev_dbg(&pdev->dev, "using scl-gpio %d and sda-gpio %d for recovery\n=
",
+			rinfo->sda_gpio, rinfo->scl_gpio);
+
+	rinfo->prepare_recovery =3D i2c_imx_prepare_recovery;
+	rinfo->unprepare_recovery =3D i2c_imx_unprepare_recovery;
+	rinfo->recover_bus =3D i2c_generic_gpio_recovery;
+	i2c_imx->adapter.bus_recovery_info =3D rinfo;
+}
+
 static u32 i2c_imx_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL
@@ -1023,6 +1085,13 @@ static int i2c_imx_probe(struct platform_device =
*pdev)
 		dev_err(&pdev->dev, "can't enable I2C clock\n");
 		return ret;
 	}
+
+	i2c_imx->pinctrl =3D devm_pinctrl_get(&pdev->dev);
+	if (IS_ERR(i2c_imx->pinctrl)) {
+		ret =3D PTR_ERR(i2c_imx->pinctrl);
+		goto clk_disable;
+	}
+
 	/* Request IRQ */
 	ret =3D devm_request_irq(&pdev->dev, irq, i2c_imx_isr, 0,
 				pdev->name, i2c_imx);
@@ -1056,6 +1125,8 @@ static int i2c_imx_probe(struct platform_device *=
pdev)
 		goto clk_disable;
 	}
=20
+	i2c_imx_init_recovery_info(i2c_imx, pdev);
+
 	/* Set up platform driver data */
 	platform_set_drvdata(pdev, i2c_imx);
 	clk_disable_unprepare(i2c_imx->clk);
--=20
1.9.1
