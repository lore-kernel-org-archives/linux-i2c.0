From: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v6 6/6] i2c: designware: enable SLAVE in platform module
Date: Wed, 15 Feb 2017 12:22:15 +0000
Message-ID: <b00cf29abbe7b4fee7738881f2ecc3e8ef2436d3.1487009294.git.lolivei@synopsys.com>
References: <cover.1487009294.git.lolivei@synopsys.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1487009294.git.lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
In-Reply-To: <cover.1487009294.git.lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
References: <cover.1487009294.git.lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

- Slave mode selected in platform module if the support is detected in
  the DT.

Signed-off-by: Luis Oliveira <lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
---
V5->V6
- No changes

 drivers/i2c/busses/Kconfig                  |  1 +
 drivers/i2c/busses/i2c-designware-platdrv.c | 41 +++++++++++++++++++++++++----
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index b3d37ac9f5f6..13bd932c81f7 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -484,6 +484,7 @@ config I2C_DESIGNWARE_SLAVE
 	select I2C_SLAVE
 	select I2C_SLAVE_EEPROM
 	depends on I2C_DESIGNWARE_PLATFORM
+	default y
 	help
 	  If you say yes to this option, support will be included for the
 	  Synopsys DesignWare I2C slave adapter.
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 671bdc0fdb24..5fcd9dbfc64c 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -1,5 +1,5 @@
 /*
- * Synopsys DesignWare I2C adapter driver (master only).
+ * Synopsys DesignWare I2C adapter driver.
  *
  * Based on the TI DAVINCI I2C adapter driver.
  *
@@ -142,9 +142,13 @@ static inline int dw_i2c_acpi_configure(struct platform_device *pdev)
 
 static void i2c_dw_configure_master(struct dw_i2c_dev *dev)
 {
+	dev->functionality = I2C_FUNC_10BIT_ADDR | DW_IC_DEFAULT_FUNCTIONALITY;
+
 	dev->master_cfg = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
 			  DW_IC_CON_RESTART_EN;
 
+	dev->mode = DW_IC_MASTER;
+
 	switch (dev->clk_freq) {
 	case 100000:
 		dev->master_cfg |= DW_IC_CON_SPEED_STD;
@@ -157,6 +161,28 @@ static void i2c_dw_configure_master(struct dw_i2c_dev *dev)
 	}
 }
 
+static void i2c_dw_configure_slave(struct dw_i2c_dev *dev)
+{
+	dev->functionality = I2C_FUNC_SLAVE | DW_IC_DEFAULT_FUNCTIONALITY;
+
+	dev->slave_cfg = DW_IC_CON_RX_FIFO_FULL_HLD_CTRL |
+			 DW_IC_CON_RESTART_EN | DW_IC_CON_STOP_DET_IFADDRESSED |
+			 DW_IC_CON_SPEED_FAST;
+
+	dev->mode = DW_IC_SLAVE;
+
+	switch (dev->clk_freq) {
+	case 100000:
+		dev->slave_cfg |= DW_IC_CON_SPEED_STD;
+		break;
+	case 3400000:
+		dev->slave_cfg |= DW_IC_CON_SPEED_HIGH;
+		break;
+	default:
+		dev->slave_cfg |= DW_IC_CON_SPEED_FAST;
+	}
+}
+
 static int i2c_dw_plat_prepare_clk(struct dw_i2c_dev *i_dev, bool prepare)
 {
 	if (IS_ERR(i_dev->clk))
@@ -261,9 +287,10 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	dev->functionality = I2C_FUNC_10BIT_ADDR | DW_IC_DEFAULT_FUNCTIONALITY;
-
-	i2c_dw_configure_master(dev);
+	if (i2c_detect_slave_mode(&pdev->dev))
+		i2c_dw_configure_slave(dev);
+	else
+		i2c_dw_configure_master(dev);
 
 	dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (!i2c_dw_plat_prepare_clk(dev, true)) {
@@ -292,7 +319,11 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 		pm_runtime_enable(&pdev->dev);
 	}
 
-	ret = i2c_dw_probe(dev);
+	if (dev->mode == DW_IC_SLAVE)
+		ret = i2c_dw_probe_slave(dev);
+	else
+		ret = i2c_dw_probe(dev);
+
 	if (ret && !dev->pm_runtime_disabled)
 		pm_runtime_disable(&pdev->dev);
 
-- 
2.11.0


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
