From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 7/7] drm/i915: Take punit lock when modifying punit settings
Date: Sun,  8 Jan 2017 14:44:27 +0100
Message-ID: <20170108134427.8392-8-hdegoede@redhat.com>
References: <20170108134427.8392-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932078AbdAHNov (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 8 Jan 2017 08:44:51 -0500
In-Reply-To: <20170108134427.8392-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org

Make sure the punit i2c bus is not in use when we send a request to
the punit by calling iosf_mbi_punit_lock() / iosf_mbi_punit_unlock()
around punit write accesses.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=155241
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: tagorereddy <tagore.chandan@gmail.com>
---
 drivers/gpu/drm/i915/intel_display.c    | 6 ++++++
 drivers/gpu/drm/i915/intel_pm.c         | 9 +++++++++
 drivers/gpu/drm/i915/intel_runtime_pm.c | 9 +++++++++
 3 files changed, 24 insertions(+)

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
index 4b12637..0d55b61 100644
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
 
@@ -4981,7 +4988,9 @@ static void valleyview_set_rps(struct drm_i915_private *dev_priv, u8 val)
 	I915_WRITE(GEN6_PMINTRMSK, gen6_rps_pm_mask(dev_priv, val));
 
 	if (val != dev_priv->rps.cur_freq) {
+		iosf_mbi_punit_lock();
 		vlv_punit_write(dev_priv, PUNIT_REG_GPU_FREQ_REQ, val);
+		iosf_mbi_punit_unlock();
 		if (!IS_CHERRYVIEW(dev_priv))
 			gen6_set_rps_thresholds(dev_priv, val);
 	}
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
