From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 06/13] i2c: designware-baytrail: Disallow the CPU to enter C6 or C7 while holding the punit semaphore
Date: Mon, 23 Jan 2017 22:09:51 +0100
Message-ID: <20170123210958.18410-7-hdegoede@redhat.com>
References: <20170123210958.18410-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39998 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751338AbdAWVKe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 23 Jan 2017 16:10:34 -0500
In-Reply-To: <20170123210958.18410-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>
Cc: Hans de Goede <hdegoede@redhat.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org

On my cherrytrail tablet with axp288 pmic, just doing a bunch of repeated
reads from the pmic, e.g. "i2cdump -y 14 0x34" would lookup the tablet in
1 - 3 runs guaranteed.

This seems to be causes by the cpu trying to enter C6 or C7 while we hold
the punit bus semaphore, at which point everything just hangs.

Avoid this by disallowing the CPU to enter C6 or C7 before acquiring the
punit bus semaphore.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=109051
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Takashi Iwai <tiwai@suse.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Acked-by: Wolfram Sang <wsa@the-dreams.de>
---
Changes in v2:
-New patch in v2 of this set
Changes in v3:
-Change commit message and comment in the code from "force the CPU to C1"
 to "Disallow the CPU to enter C6 or C7", as the CPU may still be in either
 C0 or C1 with the request pm_qos
Changes in v4:
-Rename i2c_dw_eval_lock_support to i2c_dw_probe_lock_support so that we can
 add a matching i2c_dw_remove_lock_support cleanup function
-Move qm_pos removal to new i2c_dw_remove_lock_support function
-Move pm_qos_add_request to the end of i2c_dw_probe_lock_support
Changes in v5:
-Update the pm_qos for a latency of 0 *before* requesting the semaphore,
 instead of doing it while waiting for the request to be acked
---
 drivers/i2c/busses/i2c-designware-baytrail.c | 24 ++++++++++++++++++++++--
 drivers/i2c/busses/i2c-designware-core.h     |  9 +++++++--
 drivers/i2c/busses/i2c-designware-platdrv.c  |  4 +++-
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-baytrail.c b/drivers/i2c/busses/i2c-designware-baytrail.c
index cf02222..650a700 100644
--- a/drivers/i2c/busses/i2c-designware-baytrail.c
+++ b/drivers/i2c/busses/i2c-designware-baytrail.c
@@ -16,6 +16,7 @@
 #include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/pm_qos.h>
 
 #include <asm/iosf_mbi.h>
 
@@ -56,6 +57,8 @@ static void reset_semaphore(struct dw_i2c_dev *dev)
 	data &= ~PUNIT_SEMAPHORE_BIT;
 	if (iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE, PUNIT_SEMAPHORE, data))
 		dev_err(dev->dev, "iosf failed to reset punit semaphore during write\n");
+
+	pm_qos_update_request(&dev->pm_qos, PM_QOS_DEFAULT_VALUE);
 }
 
 static int baytrail_i2c_acquire(struct dw_i2c_dev *dev)
@@ -72,11 +75,18 @@ static int baytrail_i2c_acquire(struct dw_i2c_dev *dev)
 	if (!dev->release_lock)
 		return 0;
 
+	/*
+	 * Disallow the CPU to enter C6 or C7 state, entering these states
+	 * requires the punit to talk to the pmic and if this happens while
+	 * we're holding the semaphore, the SoC hangs.
+	 */
+	pm_qos_update_request(&dev->pm_qos, 0);
+
 	/* host driver writes to side band semaphore register */
 	ret = iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE, PUNIT_SEMAPHORE, sem);
 	if (ret) {
 		dev_err(dev->dev, "iosf punit semaphore request failed\n");
-		return ret;
+		goto out;
 	}
 
 	/* host driver waits for bit 0 to be set in semaphore register */
@@ -95,6 +105,7 @@ static int baytrail_i2c_acquire(struct dw_i2c_dev *dev)
 	} while (time_before(jiffies, end));
 
 	dev_err(dev->dev, "punit semaphore timed out, resetting\n");
+out:
 	reset_semaphore(dev);
 
 	ret = iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ, PUNIT_SEMAPHORE, &sem);
@@ -121,7 +132,7 @@ static void baytrail_i2c_release(struct dw_i2c_dev *dev)
 		jiffies_to_msecs(jiffies - acquired));
 }
 
-int i2c_dw_eval_lock_support(struct dw_i2c_dev *dev)
+int i2c_dw_probe_lock_support(struct dw_i2c_dev *dev)
 {
 	acpi_status status;
 	unsigned long long shared_host = 0;
@@ -149,5 +160,14 @@ int i2c_dw_eval_lock_support(struct dw_i2c_dev *dev)
 	dev->release_lock = baytrail_i2c_release;
 	dev->pm_runtime_disabled = true;
 
+	pm_qos_add_request(&dev->pm_qos, PM_QOS_CPU_DMA_LATENCY,
+			   PM_QOS_DEFAULT_VALUE);
+
 	return 0;
 }
+
+void i2c_dw_remove_lock_support(struct dw_i2c_dev *dev)
+{
+	if (dev->acquire_lock)
+		pm_qos_remove_request(&dev->pm_qos);
+}
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 2c50571..94a5fd1 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -23,6 +23,7 @@
  */
 
 #include <linux/i2c.h>
+#include <linux/pm_qos.h>
 
 #define DW_IC_DEFAULT_FUNCTIONALITY (I2C_FUNC_I2C |			\
 					I2C_FUNC_SMBUS_BYTE |		\
@@ -75,6 +76,7 @@
  * @fp_lcnt: fast plus LCNT value
  * @hs_hcnt: high speed HCNT value
  * @hs_lcnt: high speed LCNT value
+ * @pm_qos: pm_qos_request used while holding a hardware lock on the bus
  * @acquire_lock: function to acquire a hardware lock on the bus
  * @release_lock: function to release a hardware lock on the bus
  * @pm_runtime_disabled: true if pm runtime is disabled
@@ -122,6 +124,7 @@ struct dw_i2c_dev {
 	u16			fp_lcnt;
 	u16			hs_hcnt;
 	u16			hs_lcnt;
+	struct pm_qos_request	pm_qos;
 	int			(*acquire_lock)(struct dw_i2c_dev *dev);
 	void			(*release_lock)(struct dw_i2c_dev *dev);
 	bool			pm_runtime_disabled;
@@ -139,7 +142,9 @@ extern u32 i2c_dw_read_comp_param(struct dw_i2c_dev *dev);
 extern int i2c_dw_probe(struct dw_i2c_dev *dev);
 
 #if IS_ENABLED(CONFIG_I2C_DESIGNWARE_BAYTRAIL)
-extern int i2c_dw_eval_lock_support(struct dw_i2c_dev *dev);
+extern int i2c_dw_probe_lock_support(struct dw_i2c_dev *dev);
+extern void i2c_dw_remove_lock_support(struct dw_i2c_dev *dev);
 #else
-static inline int i2c_dw_eval_lock_support(struct dw_i2c_dev *dev) { return 0; }
+static inline int i2c_dw_probe_lock_support(struct dw_i2c_dev *dev) { return 0; }
+static inline void i2c_dw_remove_lock_support(struct dw_i2c_dev *dev) {}
 #endif
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 3eede7b..d474db0 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -238,7 +238,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	r = i2c_dw_eval_lock_support(dev);
+	r = i2c_dw_probe_lock_support(dev);
 	if (r)
 		return r;
 
@@ -307,6 +307,8 @@ static int dw_i2c_plat_remove(struct platform_device *pdev)
 	if (!dev->pm_runtime_disabled)
 		pm_runtime_disable(&pdev->dev);
 
+	i2c_dw_remove_lock_support(dev);
+
 	return 0;
 }
 
-- 
2.9.3
