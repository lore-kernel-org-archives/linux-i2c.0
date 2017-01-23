From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 11/13] drm/i915: Add intel_uncore_suspend / resume functions
Date: Mon, 23 Jan 2017 22:09:56 +0100
Message-ID: <20170123210958.18410-12-hdegoede@redhat.com>
References: <20170123210958.18410-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750957AbdAWVKf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 23 Jan 2017 16:10:35 -0500
In-Reply-To: <20170123210958.18410-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>
Cc: Hans de Goede <hdegoede@redhat.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org

Rename intel_uncore_early_sanitize to intel_uncore_resume, dropping the
(always true) restore_forcewake argument and add a new intel_uncore_resume
function to replace the intel_uncore_forcewake_reset(dev_priv, false)
calls done from the suspend / runtime_suspend functions and make
intel_uncore_forcewake_reset private.

This is a preparation patch for adding PMIC bus access notifier support.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=155241
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: tagorereddy <tagore.chandan@gmail.com>
---
Changes in v2:
-Spelling: P-Unit, PMIC
---
 drivers/gpu/drm/i915/i915_drv.c     |  6 +++---
 drivers/gpu/drm/i915/i915_drv.h     |  6 ++----
 drivers/gpu/drm/i915/intel_uncore.c | 18 +++++++++++-------
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index aefab9a..5a62d7a 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -1445,7 +1445,7 @@ static int i915_drm_suspend(struct drm_device *dev)
 	opregion_target_state = suspend_to_idle(dev_priv) ? PCI_D1 : PCI_D3cold;
 	intel_opregion_notify_adapter(dev_priv, opregion_target_state);
 
-	intel_uncore_forcewake_reset(dev_priv, false);
+	intel_uncore_suspend(dev_priv);
 	intel_opregion_unregister(dev_priv);
 
 	intel_fbdev_set_suspend(dev, FBINFO_STATE_SUSPENDED, true);
@@ -1690,7 +1690,7 @@ static int i915_drm_resume_early(struct drm_device *dev)
 		DRM_ERROR("Resume prepare failed: %d, continuing anyway\n",
 			  ret);
 
-	intel_uncore_early_sanitize(dev_priv, true);
+	intel_uncore_resume(dev_priv);
 
 	if (IS_GEN9_LP(dev_priv)) {
 		if (!dev_priv->suspended_to_idle)
@@ -2344,7 +2344,7 @@ static int intel_runtime_suspend(struct device *kdev)
 		return ret;
 	}
 
-	intel_uncore_forcewake_reset(dev_priv, false);
+	intel_uncore_suspend(dev_priv);
 
 	enable_rpm_wakeref_asserts(dev_priv);
 	WARN_ON_ONCE(atomic_read(&dev_priv->pm.wakeref_count));
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index e9b4ece..c717329 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -2976,14 +2976,12 @@ int intel_irq_install(struct drm_i915_private *dev_priv);
 void intel_irq_uninstall(struct drm_i915_private *dev_priv);
 
 extern void intel_uncore_sanitize(struct drm_i915_private *dev_priv);
-extern void intel_uncore_early_sanitize(struct drm_i915_private *dev_priv,
-					bool restore_forcewake);
 extern void intel_uncore_init(struct drm_i915_private *dev_priv);
 extern bool intel_uncore_unclaimed_mmio(struct drm_i915_private *dev_priv);
 extern bool intel_uncore_arm_unclaimed_mmio_detection(struct drm_i915_private *dev_priv);
 extern void intel_uncore_fini(struct drm_i915_private *dev_priv);
-extern void intel_uncore_forcewake_reset(struct drm_i915_private *dev_priv,
-					 bool restore);
+extern void intel_uncore_suspend(struct drm_i915_private *dev_priv);
+extern void intel_uncore_resume(struct drm_i915_private *dev_priv);
 const char *intel_uncore_forcewake_domain_to_str(const enum forcewake_domain_id id);
 void intel_uncore_forcewake_get(struct drm_i915_private *dev_priv,
 				enum forcewake_domains domains);
diff --git a/drivers/gpu/drm/i915/intel_uncore.c b/drivers/gpu/drm/i915/intel_uncore.c
index abe0888..3767307 100644
--- a/drivers/gpu/drm/i915/intel_uncore.c
+++ b/drivers/gpu/drm/i915/intel_uncore.c
@@ -250,7 +250,7 @@ intel_uncore_fw_release_timer(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-void intel_uncore_forcewake_reset(struct drm_i915_private *dev_priv,
+static void __intel_uncore_forcewake_reset(struct drm_i915_private *dev_priv,
 				  bool restore)
 {
 	unsigned long irqflags;
@@ -424,13 +424,17 @@ static void __intel_uncore_early_sanitize(struct drm_i915_private *dev_priv,
 	if (IS_BXT_REVID(dev_priv, 0, BXT_REVID_B_LAST))
 		info->has_decoupled_mmio = false;
 
-	intel_uncore_forcewake_reset(dev_priv, restore_forcewake);
+	__intel_uncore_forcewake_reset(dev_priv, restore_forcewake);
 }
 
-void intel_uncore_early_sanitize(struct drm_i915_private *dev_priv,
-				 bool restore_forcewake)
+void intel_uncore_suspend(struct drm_i915_private *dev_priv)
 {
-	__intel_uncore_early_sanitize(dev_priv, restore_forcewake);
+	__intel_uncore_forcewake_reset(dev_priv, false);
+}
+
+void intel_uncore_resume(struct drm_i915_private *dev_priv)
+{
+	__intel_uncore_early_sanitize(dev_priv, true);
 	i915_check_and_clear_faults(dev_priv);
 }
 
@@ -1463,7 +1467,7 @@ void intel_uncore_fini(struct drm_i915_private *dev_priv)
 {
 	/* Paranoia: make sure we have disabled everything before we exit. */
 	intel_uncore_sanitize(dev_priv);
-	intel_uncore_forcewake_reset(dev_priv, false);
+	__intel_uncore_forcewake_reset(dev_priv, false);
 }
 
 #define GEN_RANGE(l, h) GENMASK((h) - 1, (l) - 1)
@@ -1679,7 +1683,7 @@ static int gen6_reset_engines(struct drm_i915_private *dev_priv,
 
 	ret = gen6_hw_domain_reset(dev_priv, hw_mask);
 
-	intel_uncore_forcewake_reset(dev_priv, true);
+	__intel_uncore_forcewake_reset(dev_priv, true);
 
 	return ret;
 }
-- 
2.9.3
