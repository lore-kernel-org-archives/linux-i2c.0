From: <ying.zhang22455@nxp.com>
Subject: [PATCH 2/2] i2c: imx: implement bus recovery with gpio for Layerscape
Date: Fri, 17 Nov 2017 16:21:04 +0800
Message-ID: <20171117082104.18140-2-ying.zhang22455@nxp.com>
References: <20171117082104.18140-1-ying.zhang22455@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bn3nam01on0065.outbound.protection.outlook.com ([104.47.33.65]:2592
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965444AbdKQIjc (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 17 Nov 2017 03:39:32 -0500
In-Reply-To: <20171117082104.18140-1-ying.zhang22455@nxp.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Zhang Ying-22455 <ying.zhang22455@nxp.com>

From: Zhang Ying-22455 <ying.zhang22455@nxp.com>

Based on the I2C specification, if the data line (SDA) is stuck low,
the master should send nine clock pulses. The I2C slave device that
held the bus low should release it sometime within those nine clocks.

Because pinctrl is not support on Layerscape, Current bus recovery
it not avalible for Layerscape. This patch use an open drain GPIO
pin to connect to the IICx_SCL to drive nine clock pulses to unlock
the I2C bus.

Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
---
 drivers/i2c/busses/i2c-imx.c | 175 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 173 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 5df381c5f70d..ff6d0b20e0a2 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -53,6 +53,11 @@
 #include <linux/pm_runtime.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/libata.h>
 
 /* This will be the driver name the kernel reports */
 #define DRIVER_NAME "imx-i2c"
@@ -117,6 +122,39 @@
 
 #define I2C_PM_TIMEOUT		10 /* ms */
 
+enum pinmux_endian_type {
+	BIG_ENDIAN,
+	LITTLE_ENDIAN,
+};
+
+struct pinmux_cfg {
+	enum pinmux_endian_type big_endian; /* endian of RCWPMUXCR0 */
+	u32 pmuxcr_set_bit;		    /* pin mux of RCWPMUXCR0 */
+};
+
+static struct pinmux_cfg ls1012a_pinmux_cfg = {
+	.big_endian = BIG_ENDIAN,
+	.pmuxcr_set_bit = 0x10,
+};
+
+static struct pinmux_cfg ls1043a_pinmux_cfg = {
+	.big_endian = BIG_ENDIAN,
+	.pmuxcr_set_bit = 0x10,
+};
+
+static struct pinmux_cfg ls1046a_pinmux_cfg = {
+	.big_endian = BIG_ENDIAN,
+	.pmuxcr_set_bit = 0x80000000,
+};
+
+static const struct of_device_id pinmux_of_match[] = {
+	{ .compatible = "fsl,ls1012a-vf610-i2c", .data = &ls1012a_pinmux_cfg},
+	{ .compatible = "fsl,ls1043a-vf610-i2c", .data = &ls1043a_pinmux_cfg},
+	{ .compatible = "fsl,ls1046a-vf610-i2c", .data = &ls1046a_pinmux_cfg},
+	{},
+};
+MODULE_DEVICE_TABLE(of, pinmux_of_match);
+
 /*
  * sorted list of clock divider, register value pairs
  * taken from table 26-5, p.26-9, Freescale i.MX
@@ -210,6 +248,12 @@ struct imx_i2c_struct {
 	struct pinctrl_state *pinctrl_pins_gpio;
 
 	struct imx_i2c_dma	*dma;
+	int			bus_recover;
+	int 			gpio;
+	int			need_set_pmuxcr;
+	int			pmuxcr_set;
+	int			pmuxcr_endia;
+	void __iomem		*pmuxcr_addr;
 };
 
 static const struct imx_i2c_hwdata imx1_i2c_hwdata = {
@@ -879,6 +923,78 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs, bo
 	return 0;
 }
 
+/*
+ * Based on the I2C specification, if the data line (SDA) is
+ * stuck low, the master should send nine  * clock pulses.
+ * The I2C slave device that held the bus low should release it
+ * sometime within  * those nine clocks. Due to this erratum,
+ * the I2C controller cannot generate nine clock pulses.
+ */
+static int i2c_imx_recovery_for_layerscape(struct imx_i2c_struct *i2c_imx)
+{
+	u32 ulPMUXCR0 = 0;
+	int ret;
+	unsigned int i, temp;
+
+	/* configure IICx_SCL/GPIO pin as a GPIO */
+	if (i2c_imx->need_set_pmuxcr == 1) {
+		ulPMUXCR0 = ioread32be(i2c_imx->pmuxcr_addr);
+		if (i2c_imx->pmuxcr_endia == BIG_ENDIAN)
+			iowrite32be(i2c_imx->pmuxcr_set|ulPMUXCR0,
+				    i2c_imx->pmuxcr_addr);
+		else
+			iowrite32(i2c_imx->pmuxcr_set|ulPMUXCR0,
+				  i2c_imx->pmuxcr_addr);
+	}
+
+	ret = gpio_request(i2c_imx->gpio, i2c_imx->adapter.name);
+	if (ret != 0) {
+		dev_err(&i2c_imx->adapter.dev,
+			"can't get gpio: %d\n", ret);
+		return ret;
+	}
+
+	/* Configure GPIO pin as an output and open drain. */
+	gpio_direction_output(i2c_imx->gpio, 1);
+	udelay(10);
+
+	/* Write data to generate 9 pulses */
+	for (i = 0; i < 9; i++) {
+		gpio_set_value(i2c_imx->gpio, 1);
+		udelay(10);
+		gpio_set_value(i2c_imx->gpio, 0);
+		udelay(10);
+	}
+	/* ensure that the last level sent is always high */
+	gpio_set_value(i2c_imx->gpio, 1);
+
+	/*
+	 * Set I2Cx_IBCR = 0h00 to generate a STOP and then
+	 * set I2Cx_IBCR = 0h80 to reset
+	 */
+	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
+	temp &= ~(I2CR_MSTA | I2CR_MTX);
+	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
+
+	/* Restore the saved value of the register SCFG_RCWPMUXCR0 */
+	if (i2c_imx->need_set_pmuxcr == 1) {
+		if (i2c_imx->pmuxcr_endia == BIG_ENDIAN)
+			iowrite32be(ulPMUXCR0, i2c_imx->pmuxcr_addr);
+		else
+			iowrite32(ulPMUXCR0, i2c_imx->pmuxcr_addr);
+	}
+	/*
+	 * Set I2C_IBSR[IBAL] to clear the IBAL bit if-
+	 * I2C_IBSR[IBAL] = 1
+	 */
+	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
+	if (temp & I2SR_IAL) {
+		temp &= ~I2SR_IAL;
+		imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2SR);
+	}
+	return 0;
+}
+
 static int i2c_imx_xfer(struct i2c_adapter *adapter,
 						struct i2c_msg *msgs, int num)
 {
@@ -894,8 +1010,13 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
 	 * before switching to master mode and attempting a Start cycle
 	 */
 	result =  i2c_imx_bus_busy(i2c_imx, 0);
-	if (result)
-		goto out;
+	if (result) {
+		/* timeout */
+		if ((result == -ETIMEDOUT) && (i2c_imx->bus_recover == 1))
+			i2c_imx_recovery_for_layerscape(i2c_imx);
+		else
+			goto out;
+	}
 
 	result = pm_runtime_get_sync(i2c_imx->adapter.dev.parent);
 	if (result < 0)
@@ -1039,6 +1160,51 @@ static int i2c_imx_init_recovery_info(struct imx_i2c_struct *i2c_imx,
 	return 0;
 }
 
+/*
+ * switch SCL and SDA to their GPIO function and do some bitbanging
+ * for bus recovery.
+ * There are platforms such as Layerscape that don't support pinctrl, so add
+ * workaround for layerscape, it has no effect for other platforms.
+ */
+static int i2c_imx_init_recovery_for_layerscape(
+		struct imx_i2c_struct *i2c_imx,
+		struct platform_device *pdev)
+{
+	const struct of_device_id *of_id;
+	struct device_node *np		= pdev->dev.of_node;
+	struct resource			*r;
+	struct pinmux_cfg		*pinmux_cfg;
+
+	i2c_imx->gpio = of_get_named_gpio(np, "fsl-scl-gpio", 0);
+	if (!gpio_is_valid(i2c_imx->gpio)) {
+		dev_info(&pdev->dev, "recovery information incomplete\n");
+		return 0;
+	}
+	pinmux_cfg = devm_kzalloc(&pdev->dev, sizeof(*pinmux_cfg), GFP_KERNEL);
+	if (!pinmux_cfg)
+		return -ENOMEM;
+
+	of_id = of_match_node(pinmux_of_match, np);
+	if (of_id) {
+		i2c_imx->need_set_pmuxcr = 1;
+		pinmux_cfg = (struct pinmux_cfg *)of_id->data;
+		i2c_imx->pmuxcr_endia = pinmux_cfg->big_endian;
+		i2c_imx->pmuxcr_set = pinmux_cfg->pmuxcr_set_bit;
+		r = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						 "SCFG_RCWPMUXCR0");
+		if (r) {
+			i2c_imx->pmuxcr_addr = devm_ioremap_resource(&pdev->dev, r);
+			if (IS_ERR(i2c_imx->pmuxcr_addr))
+				return PTR_ERR(i2c_imx->pmuxcr_addr);
+		} else {
+			i2c_imx->need_set_pmuxcr = 0;
+		}
+	}
+
+	i2c_imx->bus_recover = 1;
+	return 0;
+}
+
 static u32 i2c_imx_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL
@@ -1094,6 +1260,11 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	i2c_imx->adapter.dev.of_node	= pdev->dev.of_node;
 	i2c_imx->base			= base;
 
+	/* Init optional bus recovery for layerscape */
+	ret = i2c_imx_init_recovery_for_layerscape(i2c_imx, pdev);
+	if (ret != 0)
+		return ret;
+
 	/* Get I2C clock */
 	i2c_imx->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(i2c_imx->clk)) {
-- 
2.14.1
