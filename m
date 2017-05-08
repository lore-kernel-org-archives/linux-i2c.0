From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: [PATCH v9 6/6] i2c: designware: enable SLAVE in platform module
Date: Mon,  8 May 2017 11:37:21 +0100
Message-ID: <dc32ce6a3988a28e6bd08d4ec2797f0a544ae4ad.1493893241.git.lolivei@synopsys.com>
References: <cover.1493893241.git.lolivei@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1493893241.git.lolivei@synopsys.com>
In-Reply-To: <cover.1493893241.git.lolivei@synopsys.com>
References: <cover.1493893241.git.lolivei@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Luis.Oliveira@synopsys.com, Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

- Slave mode selected in platform module if the support is detected in
  the DT.

Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
---
v8-v9
- fixed kbuild error regarding I2C_DESIGNWARE_SLAVE auto selection to
  correctly compile the module

 drivers/i2c/busses/Kconfig                  |  2 ++
 drivers/i2c/busses/i2c-designware-core.h    |  2 ++
 drivers/i2c/busses/i2c-designware-platdrv.c | 41 +++++++++++++++++++++++++----
 3 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 88e5062015f8..9d4d9901be01 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -471,6 +471,7 @@ config I2C_DESIGNWARE_CORE
 config I2C_DESIGNWARE_PLATFORM
 	tristate "Synopsys DesignWare Platform"
 	select I2C_DESIGNWARE_CORE
+	select I2C_DESIGNWARE_SLAVE
 	depends on (ACPI && COMMON_CLK) || !ACPI
 	help
 	  If you say yes to this option, support will be included for the
@@ -483,6 +484,7 @@ config I2C_DESIGNWARE_SLAVE
 	bool "Synopsys DesignWare Slave"
 	select I2C_SLAVE
 	depends on I2C_DESIGNWARE_PLATFORM
+	default y
 	help
 	  If you say yes to this option, support will be included for the
 	  Synopsys DesignWare I2C slave adapter.
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 8c6fc8384b1e..944af016eac0 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -228,6 +228,7 @@
  * @disable: function to disable the controller
  * @disable_int: function to disable all interrupts
  * @init: function to initialize the I2C hardware
+ * @mode: operation mode - DW_IC_MASTER or DW_IC_SLAVE
  * 
  * HCNT and LCNT parameters can be used if the platform knows more accurate
  * values than the one computed based only on the input clock frequency.
@@ -282,6 +283,7 @@ struct dw_i2c_dev {
 	void			(*disable)(struct dw_i2c_dev *dev);
 	void			(*disable_int)(struct dw_i2c_dev *dev);
 	int			(*init)(struct dw_i2c_dev *dev);
+	int			mode;
 };
 
 #define ACCESS_SWAP		0x00000001
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index ab7a4314a91a..a2b2c8084692 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -1,5 +1,5 @@
 /*
- * Synopsys DesignWare I2C adapter driver (master only).
+ * Synopsys DesignWare I2C adapter driver.
  *
  * Based on the TI DAVINCI I2C adapter driver.
  *
@@ -170,9 +170,13 @@ static inline int dw_i2c_acpi_configure(struct platform_device *pdev)
 
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
@@ -185,6 +189,28 @@ static void i2c_dw_configure_master(struct dw_i2c_dev *dev)
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
@@ -298,9 +324,10 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
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
@@ -329,7 +356,11 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
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
