From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 1/2] i2c: designware: Never suspend i2c-busses used for accessing the system PMIC
Date: Mon, 13 Mar 2017 23:25:09 +0100
Message-ID: <20170313222510.466-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42170 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751687AbdCMWZO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 13 Mar 2017 18:25:14 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org

Currently we are already setting a pm_runtime_disabled flag and disabling
runtime-pm for i2c-busses used for accessing the system PMIC on x86.
But this is not enough, there are ACPI opregions which may want to access
the PMIC during late-suspend and early-resume, so we need to completely
disable pm to be safe.

This commit renames the flag from pm_runtime_disabled to pm_disabled and
adds the following new behavior if the flag is set:

1) Call dev_pm_syscore_device(dev, true) which disables normal suspend /
   resume and remove the pm_runtime_disabled check from dw_i2c_plat_resume
   since that will now never get called. This fixes suspend_late handlers
   which use ACPI PMIC opregions causing errors like these:

  PM: Suspending system (freeze)
  PM: suspend of devices complete after 1127.751 msecs
  i2c_designware 808622C1:06: timeout waiting for bus ready
  ACPI Exception: AE_ERROR, Returned by Handler for [UserDefinedRegion]
  acpi 80860F14:02: Failed to change power state to D3hot
  PM: late suspend of devices failed

2) Set IRQF_NO_SUSPEND irq flag. This fixes resume_early handlers which
   handlers which use ACPI PMIC opregions causing errors like these:

  PM: resume from suspend-to-idle
  i2c_designware 808622C1:06: controller timed out
  ACPI Exception: AE_ERROR, Returned by Handler for [UserDefinedRegion]

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
Changes in v2:
-Rebase on v4.11-rc1 to fix conflicts
Changes in v3:
-Rebase on v4.11-rc2 to fix yet more conflicts
---
 drivers/i2c/busses/i2c-designware-baytrail.c |  2 +-
 drivers/i2c/busses/i2c-designware-core.c     | 11 +++++++++--
 drivers/i2c/busses/i2c-designware-core.h     |  4 ++--
 drivers/i2c/busses/i2c-designware-platdrv.c  | 10 ++++------
 4 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-baytrail.c b/drivers/i2c/busses/i2c-designware-baytrail.c
index 1749a0f..b8cc226 100644
--- a/drivers/i2c/busses/i2c-designware-baytrail.c
+++ b/drivers/i2c/busses/i2c-designware-baytrail.c
@@ -170,7 +170,7 @@ int i2c_dw_probe_lock_support(struct dw_i2c_dev *dev)
 	dev_info(dev->dev, "I2C bus managed by PUNIT\n");
 	dev->acquire_lock = baytrail_i2c_acquire;
 	dev->release_lock = baytrail_i2c_release;
-	dev->pm_runtime_disabled = true;
+	dev->pm_disabled = true;
 
 	pm_qos_add_request(&dev->pm_qos, PM_QOS_CPU_DMA_LATENCY,
 			   PM_QOS_DEFAULT_VALUE);
diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 15a5348..c453717 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -960,6 +960,7 @@ EXPORT_SYMBOL_GPL(i2c_dw_read_comp_param);
 int i2c_dw_probe(struct dw_i2c_dev *dev)
 {
 	struct i2c_adapter *adap = &dev->adapter;
+	unsigned long irq_flags;
 	int r;
 
 	init_completion(&dev->cmd_complete);
@@ -975,9 +976,15 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 	adap->dev.parent = dev->dev;
 	i2c_set_adapdata(adap, dev);
 
+	if (dev->pm_disabled) {
+		dev_pm_syscore_device(dev->dev, true);
+		irq_flags = IRQF_NO_SUSPEND;
+	} else {
+		irq_flags = IRQF_SHARED | IRQF_COND_SUSPEND;
+	}
+
 	i2c_dw_disable_int(dev);
-	r = devm_request_irq(dev->dev, dev->irq, i2c_dw_isr,
-			     IRQF_SHARED | IRQF_COND_SUSPEND,
+	r = devm_request_irq(dev->dev, dev->irq, i2c_dw_isr, irq_flags,
 			     dev_name(dev->dev), dev);
 	if (r) {
 		dev_err(dev->dev, "failure requesting irq %i: %d\n",
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 846ea57..a7cf429 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -79,7 +79,7 @@
  * @pm_qos: pm_qos_request used while holding a hardware lock on the bus
  * @acquire_lock: function to acquire a hardware lock on the bus
  * @release_lock: function to release a hardware lock on the bus
- * @pm_runtime_disabled: true if pm runtime is disabled
+ * @pm_disabled: true if power-management should be disabled for this i2c-bus
  *
  * HCNT and LCNT parameters can be used if the platform knows more accurate
  * values than the one computed based only on the input clock frequency.
@@ -128,7 +128,7 @@ struct dw_i2c_dev {
 	struct pm_qos_request	pm_qos;
 	int			(*acquire_lock)(struct dw_i2c_dev *dev);
 	void			(*release_lock)(struct dw_i2c_dev *dev);
-	bool			pm_runtime_disabled;
+	bool			pm_disabled;
 };
 
 #define ACCESS_SWAP		0x00000001
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index d866509..0b6f6dc 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -286,7 +286,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&pdev->dev));
 	adap->dev.of_node = pdev->dev.of_node;
 
-	if (dev->pm_runtime_disabled) {
+	if (dev->pm_disabled) {
 		pm_runtime_forbid(&pdev->dev);
 	} else {
 		pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
@@ -302,7 +302,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	return r;
 
 exit_probe:
-	if (!dev->pm_runtime_disabled)
+	if (!dev->pm_disabled)
 		pm_runtime_disable(&pdev->dev);
 exit_reset:
 	if (!IS_ERR_OR_NULL(dev->rst))
@@ -322,7 +322,7 @@ static int dw_i2c_plat_remove(struct platform_device *pdev)
 
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
-	if (!dev->pm_runtime_disabled)
+	if (!dev->pm_disabled)
 		pm_runtime_disable(&pdev->dev);
 	if (!IS_ERR_OR_NULL(dev->rst))
 		reset_control_assert(dev->rst);
@@ -374,9 +374,7 @@ static int dw_i2c_plat_resume(struct device *dev)
 	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
 
 	i2c_dw_plat_prepare_clk(i_dev, true);
-
-	if (!i_dev->pm_runtime_disabled)
-		i2c_dw_init(i_dev);
+	i2c_dw_init(i_dev);
 
 	return 0;
 }
-- 
2.9.3
