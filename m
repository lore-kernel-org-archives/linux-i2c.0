From: Hans de Goede <hdegoede@redhat.com>
Subject: [RFC 4/4] drm/i915: valleyview: Take punit lock when modifying punit settings
Date: Sun,  1 Jan 2017 21:14:03 +0100
Message-ID: <20170101201403.12132-5-hdegoede@redhat.com>
References: <20170101201403.12132-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932229AbdAAUOO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 1 Jan 2017 15:14:14 -0500
In-Reply-To: <20170101201403.12132-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, Hans de Goede <hdegoede@redhat.com>

Make sure the punit i2c bus is not in use when we send a request to
the punit by calling iosf_mbi_punit_lock() / iosf_mbi_punit_unlock()
around punit write accesses.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/i915/Kconfig            |  1 +
 drivers/gpu/drm/i915/intel_display.c    |  6 ++++++
 drivers/gpu/drm/i915/intel_pm.c         | 21 +++++++++++++++++++++
 drivers/gpu/drm/i915/intel_runtime_pm.c |  9 +++++++++
 4 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index 5ddde73..0fe7443 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -4,6 +4,7 @@ config DRM_I915
 	depends on X86 && PCI
 	select INTEL_GTT
 	select INTERVAL_TREE
+	select IOSF_MBI
 	# we need shmfs for the swappable backing store, and in particular
 	# the shmem_readpage() which depends upon tmpfs
 	select SHMEM
diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index fec8eb3..b8be6ea 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -47,6 +47,7 @@
 #include <drm/drm_rect.h>
 #include <linux/dma_remapping.h>
 #include <linux/reservation.h>
+#include <asm/iosf_mbi.h>
 
 static bool is_mmio_work(struct intel_flip_work *work)
 {
@@ -6423,6 +6424,8 @@ static void valleyview_set_cdclk(struct drm_device *dev, int cdclk)
 		cmd = 0;
 
 	mutex_lock(&dev_priv->rps.hw_lock);
+	iosf_mbi_punit_lock();
+
 	val = vlv_punit_read(dev_priv, PUNIT_REG_DSPFREQ);
 	val &= ~DSPFREQGUAR_MASK;
 	val |= (cmd << DSPFREQGUAR_SHIFT);
@@ -6432,6 +6435,7 @@ static void valleyview_set_cdclk(struct drm_device *dev, int cdclk)
 		     50)) {
 		DRM_ERROR("timed out waiting for CDclk change\n");
 	}
+	iosf_mbi_punit_unlock();
 	mutex_unlock(&dev_priv->rps.hw_lock);
 
 	mutex_lock(&dev_priv->sb_lock);
@@ -6499,6 +6503,7 @@ static void cherryview_set_cdclk(struct drm_device *dev, int cdclk)
 	cmd = DIV_ROUND_CLOSEST(dev_priv->hpll_freq << 1, cdclk) - 1;
 
 	mutex_lock(&dev_priv->rps.hw_lock);
+	iosf_mbi_punit_lock();
 	val = vlv_punit_read(dev_priv, PUNIT_REG_DSPFREQ);
 	val &= ~DSPFREQGUAR_MASK_CHV;
 	val |= (cmd << DSPFREQGUAR_SHIFT_CHV);
@@ -6508,6 +6513,7 @@ static void cherryview_set_cdclk(struct drm_device *dev, int cdclk)
 		     50)) {
 		DRM_ERROR("timed out waiting for CDclk change\n");
 	}
+	iosf_mbi_punit_unlock();
 	mutex_unlock(&dev_priv->rps.hw_lock);
 
 	intel_update_cdclk(dev_priv);
diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
index cc4fbd7..31f88f1 100644
--- a/drivers/gpu/drm/i915/intel_pm.c
+++ b/drivers/gpu/drm/i915/intel_pm.c
@@ -32,6 +32,7 @@
 #include "../../../platform/x86/intel_ips.h"
 #include <linux/module.h>
 #include <drm/drm_atomic_helper.h>
+#include <asm/iosf_mbi.h>
 
 /**
  * DOC: RC6
@@ -276,6 +277,7 @@ static void chv_set_memory_dvfs(struct drm_i915_private *dev_priv, bool enable)
 	u32 val;
 
 	mutex_lock(&dev_priv->rps.hw_lock);
+	iosf_mbi_punit_lock();
 
 	val = vlv_punit_read(dev_priv, PUNIT_REG_DDR_SETUP2);
 	if (enable)
@@ -290,6 +292,7 @@ static void chv_set_memory_dvfs(struct drm_i915_private *dev_priv, bool enable)
 		      FORCE_DDR_FREQ_REQ_ACK) == 0, 3))
 		DRM_ERROR("timed out waiting for Punit DDR DVFS request\n");
 
+	iosf_mbi_punit_unlock();
 	mutex_unlock(&dev_priv->rps.hw_lock);
 }
 
@@ -298,6 +301,7 @@ static void chv_set_memory_pm5(struct drm_i915_private *dev_priv, bool enable)
 	u32 val;
 
 	mutex_lock(&dev_priv->rps.hw_lock);
+	iosf_mbi_punit_lock();
 
 	val = vlv_punit_read(dev_priv, PUNIT_REG_DSPFREQ);
 	if (enable)
@@ -306,6 +310,7 @@ static void chv_set_memory_pm5(struct drm_i915_private *dev_priv, bool enable)
 		val &= ~DSP_MAXFIFO_PM5_ENABLE;
 	vlv_punit_write(dev_priv, PUNIT_REG_DSPFREQ, val);
 
+	iosf_mbi_punit_unlock();
 	mutex_unlock(&dev_priv->rps.hw_lock);
 }
 
@@ -4546,6 +4551,7 @@ void vlv_wm_get_hw_state(struct drm_device *dev)
 
 	if (IS_CHERRYVIEW(dev_priv)) {
 		mutex_lock(&dev_priv->rps.hw_lock);
+		iosf_mbi_punit_lock();
 
 		val = vlv_punit_read(dev_priv, PUNIT_REG_DSPFREQ);
 		if (val & DSP_MAXFIFO_PM5_ENABLE)
@@ -4575,6 +4581,7 @@ void vlv_wm_get_hw_state(struct drm_device *dev)
 				wm->level = VLV_WM_LEVEL_DDR_DVFS;
 		}
 
+		iosf_mbi_punit_unlock();
 		mutex_unlock(&dev_priv->rps.hw_lock);
 	}
 
@@ -5004,11 +5011,15 @@ static void vlv_set_rps_idle(struct drm_i915_private *dev_priv)
 	if (dev_priv->rps.cur_freq <= val)
 		return;
 
+	iosf_mbi_punit_lock();
+
 	/* Wake up the media well, as that takes a lot less
 	 * power than the Render well. */
 	intel_uncore_forcewake_get(dev_priv, FORCEWAKE_MEDIA);
 	valleyview_set_rps(dev_priv, val);
 	intel_uncore_forcewake_put(dev_priv, FORCEWAKE_MEDIA);
+
+	iosf_mbi_punit_unlock();
 }
 
 void gen6_rps_busy(struct drm_i915_private *dev_priv)
@@ -5097,12 +5108,14 @@ void gen6_rps_boost(struct drm_i915_private *dev_priv,
 void intel_set_rps(struct drm_i915_private *dev_priv, u8 val)
 {
 	if (IS_VALLEYVIEW(dev_priv) || IS_CHERRYVIEW(dev_priv)) {
+		iosf_mbi_punit_lock();
 		/* Wake up the media well, as that takes a lot less
 		 * power than the Render well.
 		 */
 		intel_uncore_forcewake_get(dev_priv, FORCEWAKE_MEDIA);
 		valleyview_set_rps(dev_priv, val);
 		intel_uncore_forcewake_put(dev_priv, FORCEWAKE_MEDIA);
+		iosf_mbi_punit_unlock();
 	} else
 		gen6_set_rps(dev_priv, val);
 }
@@ -5999,6 +6012,8 @@ static void cherryview_enable_rps(struct drm_i915_private *dev_priv)
 
 	cherryview_check_pctx(dev_priv);
 
+	iosf_mbi_punit_lock();
+
 	/* 1a & 1b: Get forcewake during program sequence. Although the driver
 	 * hasn't enabled a state yet where we need forcewake, BIOS may have.*/
 	intel_uncore_forcewake_get(dev_priv, FORCEWAKE_ALL);
@@ -6068,6 +6083,8 @@ static void cherryview_enable_rps(struct drm_i915_private *dev_priv)
 	reset_rps(dev_priv, valleyview_set_rps);
 
 	intel_uncore_forcewake_put(dev_priv, FORCEWAKE_ALL);
+
+	iosf_mbi_punit_unlock();
 }
 
 static void valleyview_enable_rps(struct drm_i915_private *dev_priv)
@@ -6087,6 +6104,8 @@ static void valleyview_enable_rps(struct drm_i915_private *dev_priv)
 		I915_WRITE(GTFIFODBG, gtfifodbg);
 	}
 
+	iosf_mbi_punit_lock();
+
 	/* If VLV, Forcewake all wells, else re-direct to regular path */
 	intel_uncore_forcewake_get(dev_priv, FORCEWAKE_ALL);
 
@@ -6149,6 +6168,8 @@ static void valleyview_enable_rps(struct drm_i915_private *dev_priv)
 	reset_rps(dev_priv, valleyview_set_rps);
 
 	intel_uncore_forcewake_put(dev_priv, FORCEWAKE_ALL);
+
+	iosf_mbi_punit_unlock();
 }
 
 static unsigned long intel_pxfreq(u32 vidfreq)
diff --git a/drivers/gpu/drm/i915/intel_runtime_pm.c b/drivers/gpu/drm/i915/intel_runtime_pm.c
index c0b7e95..17922ae 100644
--- a/drivers/gpu/drm/i915/intel_runtime_pm.c
+++ b/drivers/gpu/drm/i915/intel_runtime_pm.c
@@ -28,6 +28,7 @@
 
 #include <linux/pm_runtime.h>
 #include <linux/vgaarb.h>
+#include <asm/iosf_mbi.h>
 
 #include "i915_drv.h"
 #include "intel_drv.h"
@@ -1027,6 +1028,8 @@ static void vlv_set_power_well(struct drm_i915_private *dev_priv,
 	if (COND)
 		goto out;
 
+	iosf_mbi_punit_lock();
+
 	ctrl = vlv_punit_read(dev_priv, PUNIT_REG_PWRGT_CTRL);
 	ctrl &= ~mask;
 	ctrl |= state;
@@ -1037,6 +1040,8 @@ static void vlv_set_power_well(struct drm_i915_private *dev_priv,
 			  state,
 			  vlv_punit_read(dev_priv, PUNIT_REG_PWRGT_CTRL));
 
+	iosf_mbi_punit_unlock();
+
 #undef COND
 
 out:
@@ -1643,6 +1648,8 @@ static void chv_set_pipe_power_well(struct drm_i915_private *dev_priv,
 	if (COND)
 		goto out;
 
+	iosf_mbi_punit_lock();
+
 	ctrl = vlv_punit_read(dev_priv, PUNIT_REG_DSPFREQ);
 	ctrl &= ~DP_SSC_MASK(pipe);
 	ctrl |= enable ? DP_SSC_PWR_ON(pipe) : DP_SSC_PWR_GATE(pipe);
@@ -1653,6 +1660,8 @@ static void chv_set_pipe_power_well(struct drm_i915_private *dev_priv,
 			  state,
 			  vlv_punit_read(dev_priv, PUNIT_REG_DSPFREQ));
 
+	iosf_mbi_punit_unlock();
+
 #undef COND
 
 out:
-- 
2.9.3
