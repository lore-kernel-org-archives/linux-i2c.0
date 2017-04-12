From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: [PATCH v8 6/6] i2c: designware: enable SLAVE in platform module
Date: Wed, 12 Apr 2017 17:47:56 +0100
Message-ID: <225a4bd16cb02a59c775a4fe471441844e48732d.1492014220.git.lolivei@synopsys.com>
References: <cover.1492014220.git.lolivei@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1492014220.git.lolivei@synopsys.com>
In-Reply-To: <cover.1492014220.git.lolivei@synopsys.com>
References: <cover.1492014220.git.lolivei@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Luis.Oliveira@synopsys.com, Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

- Slave mode selected in platform module if the support is detected in
  the DT.

Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
---
v7-v8
- moved "bool mode;" comment/description to this patch

 drivers/i2c/busses/Kconfig                  |  1 +
 drivers/i2c/busses/i2c-designware-core.h    |  2 ++
 drivers/i2c/busses/i2c-designware-platdrv.c | 41 +++++++++++++++++++++++++----
 3 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 84efa57f90b3..ada037186ff8 100644
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
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index fc3227782082..e96b75869959 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -226,6 +226,7 @@
  * @disable: function to disable the controller
  * @disable_int: function to disable all interrupts
  * @init: function to initialize the I2C hardware
+ * @mode: operation mode - DW_IC_MASTER or DW_IC_SLAVE
  * 
  * HCNT and LCNT parameters can be used if the platform knows more accurate
  * values than the one computed based only on the input clock frequency.
@@ -280,6 +281,7 @@ struct dw_i2c_dev {
 	void			(*disable)(struct dw_i2c_dev *dev);
 	void			(*disable_int)(struct dw_i2c_dev *dev);
 	int			(*init)(struct dw_i2c_dev *dev);
+	int			mode;
 };
 
 #define ACCESS_SWAP		0x00000001
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 96c04a4475d2..ff31281554ad 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -1,5 +1,5 @@
 /*
- * Synopsys DesignWare I2C adapter driver (master only).
+ * Synopsys DesignWare I2C adapter driver.
  *
  * Based on the TI DAVINCI I2C adapter driver.
  *
@@ -157,9 +157,13 @@ static inline int dw_i2c_acpi_configure(struct platform_device *pdev)
 
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
@@ -172,6 +176,28 @@ static void i2c_dw_configure_master(struct dw_i2c_dev *dev)
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
@@ -285,9 +311,10 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
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
@@ -316,7 +343,11 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
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
