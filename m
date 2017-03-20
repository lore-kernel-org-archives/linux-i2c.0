From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: [PATCH v7 6/6] i2c: designware: enable SLAVE in platform module
Date: Mon, 20 Mar 2017 11:10:45 +0000
Message-ID: <8972a23babcca02f6d8139caaaf43000111d15b1.1490007620.git.lolivei@synopsys.com>
References: <cover.1490007620.git.lolivei@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1490007620.git.lolivei@synopsys.com>
In-Reply-To: <cover.1490007620.git.lolivei@synopsys.com>
References: <cover.1490007620.git.lolivei@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Luis.Oliveira@synopsys.com, Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

- Slave mode selected in platform module if the support is detected in
  the DT.

Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
---
v6-v7
- no changes

 drivers/i2c/busses/Kconfig                  |  1 +
 drivers/i2c/busses/i2c-designware-platdrv.c | 41 +++++++++++++++++++++++++----
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index f23575da67fd..d55b0fbff5fb 100644
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
index 7f689df9aa7a..939039b4c41b 100644
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
@@ -270,9 +296,10 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	if (ret)
 		goto exit_reset;
 
-	dev->functionality = I2C_FUNC_10BIT_ADDR | DW_IC_DEFAULT_FUNCTIONALITY;
-
-	i2c_dw_configure_master(dev);
+	if (i2c_detect_slave_mode(&pdev->dev))
+		i2c_dw_configure_slave(dev);
+	else
+		i2c_dw_configure_master(dev);
 
 	dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (!i2c_dw_plat_prepare_clk(dev, true)) {
@@ -301,7 +328,11 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 		pm_runtime_enable(&pdev->dev);
 	}
 
-	ret = i2c_dw_probe(dev);
+	if (dev->mode == DW_IC_SLAVE)
+		ret = i2c_dw_probe_slave(dev);
+	else
+		ret = i2c_dw_probe(dev);
+
 	if (ret)
 		goto exit_probe;
 
-- 
2.11.0
