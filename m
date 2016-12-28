From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: [PATCH v5 7/7] i2c: designware: style changes in existing code
Date: Wed, 28 Dec 2016 14:43:26 +0000
Message-ID: <4ff96e7320ebaef28c0ccb47c29bd9a2fe16027c.1482934380.git.lolivei@synopsys.com>
References: <cover.1482934380.git.lolivei@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1482934380.git.lolivei@synopsys.com>
In-Reply-To: <cover.1482934380.git.lolivei@synopsys.com>
References: <cover.1482934380.git.lolivei@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Luis.Oliveira@synopsys.com, Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

Replaced all the return variables 'r' in the existing
code by 'ret' to make the code easier to read (and
more standard).

Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
---
Changes V4->V5: (Andy Shevchenko)
- Replaced all the old code using "r" as return to "ret". For consistency 
purposes.

 drivers/i2c/busses/i2c-designware-master.c  | 30 ++++++++++++++---------------
 drivers/i2c/busses/i2c-designware-platdrv.c | 16 +++++++--------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index b55a7f4c5149..0d5aca6edb48 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -644,18 +644,18 @@ EXPORT_SYMBOL_GPL(i2c_dw_read_comp_param);
 int i2c_dw_probe(struct dw_i2c_dev *dev)
 {
 	struct i2c_adapter *adap = &dev->adapter;
-	int r;
+	int ret;
 	u32 reg;
 
 	init_completion(&dev->cmd_complete);
 
-	r = i2c_dw_init(dev);
-	if (r)
-		return r;
+	ret = i2c_dw_init(dev);
+	if (ret)
+		return ret;
 
-	r = i2c_dw_acquire_lock(dev);
-	if (r)
-		return r;
+	ret = i2c_dw_acquire_lock(dev);
+	if (ret)
+		return ret;
 
 	/*
 	 * Test if dynamic TAR update is enabled in this controller by writing
@@ -681,13 +681,13 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 	i2c_set_adapdata(adap, dev);
 
 	i2c_dw_disable_int(dev);
-	r = devm_request_irq(dev->dev, dev->irq, i2c_dw_isr,
+	ret = devm_request_irq(dev->dev, dev->irq, i2c_dw_isr,
 			     IRQF_SHARED | IRQF_COND_SUSPEND,
 			     dev_name(dev->dev), dev);
-	if (r) {
+	if (ret) {
 		dev_err(dev->dev, "failure requesting irq %i: %d\n",
-			dev->irq, r);
-		return r;
+			dev->irq, ret);
+		return ret;
 	}
 
 	/*
@@ -697,12 +697,12 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 	 * registered I2C slaves that do I2C transfers in their probe.
 	 */
 	pm_runtime_get_noresume(dev->dev);
-	r = i2c_add_numbered_adapter(adap);
-	if (r)
-		dev_err(dev->dev, "failure adding adapter: %d\n", r);
+	ret = i2c_add_numbered_adapter(adap);
+	if (ret)
+		dev_err(dev->dev, "failure adding adapter: %d\n", ret);
 	pm_runtime_put_noidle(dev->dev);
 
-	return r;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(i2c_dw_probe);
 
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index ef75031f8a62..785f4380c9a9 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -234,7 +234,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	struct fwnode_handle *child;
 	u32 acpi_speed, ht = 0;
 	struct resource *mem;
-	int irq, r;
+	int irq, ret;
 	u32 reg;
 
 	irq = platform_get_irq(pdev, 0);
@@ -293,9 +293,9 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	r = i2c_dw_eval_lock_support(dev);
-	if (r)
-		return r;
+	ret = i2c_dw_eval_lock_support(dev);
+	if (ret)
+		return ret;
 
 	if (ACPI_HANDLE(&pdev->dev) == NULL) {
 		device_for_each_child_node(&pdev->dev, child) {
@@ -336,14 +336,14 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	}
 
 	if (dev->mode == DW_IC_SLAVE)
-		r = i2c_dw_probe_slave(dev);
+		ret = i2c_dw_probe_slave(dev);
 	else
-		r = i2c_dw_probe(dev);
+		ret = i2c_dw_probe(dev);
 
-	if (r && !dev->pm_runtime_disabled)
+	if (ret && !dev->pm_runtime_disabled)
 		pm_runtime_disable(&pdev->dev);
 
-	return r;
+	return ret;
 }
 
 static int dw_i2c_plat_remove(struct platform_device *pdev)
-- 
2.11.0
