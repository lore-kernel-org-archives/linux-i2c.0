From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] i2c: designware: Make master module optional
Date: Mon, 23 Mar 2020 12:04:50 +0200
Message-ID: <20200323100451.28808-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:5149 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727788AbgCWKE4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 23 Mar 2020 06:04:56 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

In some cases we know that the controller will be always used in slave mode and
master is just a bulk. In order to drop that, introduce a separate configuration
parameter for master mode. Default it to core to avoid regressions.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/Kconfig                  | 10 ++++++++++
 drivers/i2c/busses/Makefile                 |  5 ++++-
 drivers/i2c/busses/i2c-designware-core.h    | 19 ++++++++++++++++++-
 drivers/i2c/busses/i2c-designware-master.c  |  4 ++--
 drivers/i2c/busses/i2c-designware-pcidrv.c  |  2 +-
 drivers/i2c/busses/i2c-designware-platdrv.c |  6 +-----
 6 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 2ddca08f8a76..1df238ff8dd0 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -527,6 +527,16 @@ config I2C_DAVINCI
 config I2C_DESIGNWARE_CORE
 	tristate
 
+config I2C_DESIGNWARE_MASTER
+	bool "Synopsys DesignWare Master"
+	default I2C_DESIGNWARE_CORE
+	help
+	  If you say yes to this option, support will be included for the
+	  Synopsys DesignWare I2C master adapter.
+
+	  This is not a standalone module, this module compiles together with
+	  i2c-designware-core.
+
 config I2C_DESIGNWARE_PLATFORM
 	tristate "Synopsys DesignWare Platform"
 	select I2C_DESIGNWARE_CORE
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 25d60889713c..829731d4a1f9 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -49,7 +49,10 @@ obj-$(CONFIG_I2C_CBUS_GPIO)	+= i2c-cbus-gpio.o
 obj-$(CONFIG_I2C_CPM)		+= i2c-cpm.o
 obj-$(CONFIG_I2C_DAVINCI)	+= i2c-davinci.o
 obj-$(CONFIG_I2C_DESIGNWARE_CORE)	+= i2c-designware-core.o
-i2c-designware-core-objs := i2c-designware-common.o i2c-designware-master.o
+i2c-designware-core-objs := i2c-designware-common.o
+ifeq ($(CONFIG_I2C_DESIGNWARE_MASTER),y)
+i2c-designware-core-objs += i2c-designware-master.o
+endif
 ifeq ($(CONFIG_I2C_DESIGNWARE_SLAVE),y)
 i2c-designware-core-objs += i2c-designware-slave.o
 endif
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index b220ad64c38d..2d34c15dca75 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -314,13 +314,30 @@ static inline void __i2c_dw_disable_nowait(struct dw_i2c_dev *dev)
 
 void __i2c_dw_disable(struct dw_i2c_dev *dev);
 
-extern int i2c_dw_probe(struct dw_i2c_dev *dev);
+#if IS_ENABLED(CONFIG_I2C_DESIGNWARE_MASTER)
+extern int i2c_dw_probe_master(struct dw_i2c_dev *dev);
+#else
+static inline int i2c_dw_probe_master(struct dw_i2c_dev *dev) { return -EINVAL; }
+#endif
 #if IS_ENABLED(CONFIG_I2C_DESIGNWARE_SLAVE)
 extern int i2c_dw_probe_slave(struct dw_i2c_dev *dev);
 #else
 static inline int i2c_dw_probe_slave(struct dw_i2c_dev *dev) { return -EINVAL; }
 #endif
 
+static inline int i2c_dw_probe(struct dw_i2c_dev *dev)
+{
+	switch (dev->mode) {
+	case DW_IC_SLAVE:
+		return i2c_dw_probe_slave(dev);
+	case DW_IC_MASTER:
+		return i2c_dw_probe_master(dev);
+	default:
+		dev_err(dev->dev, "Wrong operation mode: %d\n", dev->mode);
+		return -EINVAL;
+	}
+}
+
 #if IS_ENABLED(CONFIG_I2C_DESIGNWARE_BAYTRAIL)
 extern int i2c_dw_probe_lock_support(struct dw_i2c_dev *dev);
 #else
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index 3a58eef20936..9d2af87f45f1 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -678,7 +678,7 @@ static int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev)
 	return 0;
 }
 
-int i2c_dw_probe(struct dw_i2c_dev *dev)
+int i2c_dw_probe_master(struct dw_i2c_dev *dev)
 {
 	struct i2c_adapter *adap = &dev->adapter;
 	unsigned long irq_flags;
@@ -745,7 +745,7 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(i2c_dw_probe);
+EXPORT_SYMBOL_GPL(i2c_dw_probe_master);
 
 MODULE_DESCRIPTION("Synopsys DesignWare I2C bus master adapter");
 MODULE_LICENSE("GPL");
diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 7a0b65b5b5b5..cbab5346e311 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -290,7 +290,7 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 	ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&pdev->dev));
 	adap->nr = controller->bus_num;
 
-	r = i2c_dw_probe(dev);
+	r = i2c_dw_probe_master(dev);
 	if (r) {
 		pci_free_irq_vectors(pdev);
 		return r;
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index c98befe2a92e..0edcebe2168f 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -371,11 +371,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(&pdev->dev);
 
-	if (dev->mode == DW_IC_SLAVE)
-		ret = i2c_dw_probe_slave(dev);
-	else
-		ret = i2c_dw_probe(dev);
-
+	ret = i2c_dw_probe(dev);
 	if (ret)
 		goto exit_probe;
 
-- 
2.25.1
