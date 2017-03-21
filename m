From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: entering the error case of i2c-designware with a timeout at probe
Date: Tue, 21 Mar 2017 14:00:07 +0100
Message-ID: <93d60dc3-f55c-3367-df6c-0ac24180106b@redhat.com>
References: <1490100731.8154.13.camel@suse.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------B2BFB873A766277436AB9B2B"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757092AbdCUNAv (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 21 Mar 2017 09:00:51 -0400
In-Reply-To: <1490100731.8154.13.camel@suse.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: linux-i2c@vger.kernel.org, mstaudt@suse.com

This is a multi-part message in MIME format.
--------------B2BFB873A766277436AB9B2B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 21-03-17 13:52, Oliver Neukum wrote:
> Hi Hans,
>
> we found on our test systems with a bit of experimentation,
> that actually running into the timeout is bound to hang the whole
> system within only a few seconds.

AFAICT running into the timeout may be caused by the bus being
stuck, which seems to happen when the designware controller and
the punit try to access the bus simultaneously, which is exactly
what my patches try to avoid.

But yeah once that happens the system usually needs a hard reset /
powercycle to recover.

I assume this is on Cherry Trail with my full patch-set including
the forcewake fixes ?

One thing you could do is try the attach patches which got
dropped from the set as it did not seem necessary.

> I was wondering whether the error handling needs to be changed.

Are we talking the error case in i2c-designware-baytrail.c here ?

I believe that the error handling there is correct (bail do not
allow an i2c transfer to even be attempted) the problem is more
likely that the punit sometimes does do accesses even when we
hold the semaphore. The trick is to find those accesses (assuming
they are triggered from the kernel) and add mutex protection to
them, as the attached patch tries to do for i915.

Regards,

Hans



--------------B2BFB873A766277436AB9B2B
Content-Type: text/x-patch;
 name="0001-drm-i915-Acquire-P-Unit-access-when-modifying-P-Unit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-drm-i915-Acquire-P-Unit-access-when-modifying-P-Unit.pa";
 filename*1="tch"

>From ad779e820fadb7c42ea1c609e177b07f98c22a21 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 1 Jan 2017 13:56:11 +0100
Subject: [PATCH v8] drm/i915: Acquire P-Unit access when modifying P-Unit
 settings

Make sure the P-Unit or the PMIC i2c bus is not in use when we send a
request to the P-Unit by calling iosf_mbi_punit_acquire() / _release()
around P-Unit write accesses.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=155241
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: tagorereddy <tagore.chandan@gmail.com>
---
Changes in v2:
-Spelling: P-Unit, PMIC
-Adjust for iosf_mbi_punit_lock/_unlock to _acquire/_release rename
Changes in v3:
-Make sure IOSF_MBI is builtin if the i915 driver is builtin
-Add comments explaining why calling iosf_mbi_punit_acquire is necessary
---
 drivers/gpu/drm/i915/intel_display.c    |  8 ++++++++
 drivers/gpu/drm/i915/intel_pm.c         | 13 +++++++++++++
 drivers/gpu/drm/i915/intel_runtime_pm.c | 11 +++++++++++
 3 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index 88689a0..cc54378 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -47,6 +47,7 @@
 #include <drm/drm_rect.h>
 #include <linux/dma_remapping.h>
 #include <linux/reservation.h>
+#include <asm/iosf_mbi.h>
 
 static bool is_mmio_work(struct intel_flip_work *work)
 {
@@ -6422,6 +6423,9 @@ static void valleyview_set_cdclk(struct drm_device *dev, int cdclk)
 		cmd = 0;
 
 	mutex_lock(&dev_priv->rps.hw_lock);
+	/* Claim the pmic bus on systems where the punit shares the pmic bus */
+	iosf_mbi_punit_acquire();
+
 	val = vlv_punit_read(dev_priv, PUNIT_REG_DSPFREQ);
 	val &= ~DSPFREQGUAR_MASK;
 	val |= (cmd << DSPFREQGUAR_SHIFT);
@@ -6431,6 +6435,7 @@ static void valleyview_set_cdclk(struct drm_device *dev, int cdclk)
 		     50)) {
 		DRM_ERROR("timed out waiting for CDclk change\n");
 	}
+	iosf_mbi_punit_release();
 	mutex_unlock(&dev_priv->rps.hw_lock);
 
 	mutex_lock(&dev_priv->sb_lock);
@@ -6498,6 +6503,8 @@ static void cherryview_set_cdclk(struct drm_device *dev, int cdclk)
 	cmd = DIV_ROUND_CLOSEST(dev_priv->hpll_freq << 1, cdclk) - 1;
 
 	mutex_lock(&dev_priv->rps.hw_lock);
+	/* Claim the pmic bus on systems where the punit shares the pmic bus */
+	iosf_mbi_punit_acquire();
 	val = vlv_punit_read(dev_priv, PUNIT_REG_DSPFREQ);
 	val &= ~DSPFREQGUAR_MASK_CHV;
 	val |= (cmd << DSPFREQGUAR_SHIFT_CHV);
@@ -6507,6 +6514,7 @@ static void cherryview_set_cdclk(struct drm_device *dev, int cdclk)
 		     50)) {
 		DRM_ERROR("timed out waiting for CDclk change\n");
 	}
+	iosf_mbi_punit_release();
 	mutex_unlock(&dev_priv->rps.hw_lock);
 
 	intel_update_cdclk(dev_priv);
diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
index ec16f3d6..d2498b8 100644
--- a/drivers/gpu/drm/i915/intel_pm.c
+++ b/drivers/gpu/drm/i915/intel_pm.c
@@ -32,6 +32,7 @@
 #include "../../../platform/x86/intel_ips.h"
 #include <linux/module.h>
 #include <drm/drm_atomic_helper.h>
+#include <asm/iosf_mbi.h>
 
 /**
  * DOC: RC6
@@ -289,6 +290,8 @@ static void chv_set_memory_dvfs(struct drm_i915_private *dev_priv, bool enable)
 	u32 val;
 
 	mutex_lock(&dev_priv->rps.hw_lock);
+	/* Claim the pmic bus on systems where the punit shares the pmic bus */
+	iosf_mbi_punit_acquire();
 
 	val = vlv_punit_read(dev_priv, PUNIT_REG_DDR_SETUP2);
 	if (enable)
@@ -303,6 +306,7 @@ static void chv_set_memory_dvfs(struct drm_i915_private *dev_priv, bool enable)
 		      FORCE_DDR_FREQ_REQ_ACK) == 0, 3))
 		DRM_ERROR("timed out waiting for Punit DDR DVFS request\n");
 
+	iosf_mbi_punit_release();
 	mutex_unlock(&dev_priv->rps.hw_lock);
 }
 
@@ -311,6 +315,8 @@ static void chv_set_memory_pm5(struct drm_i915_private *dev_priv, bool enable)
 	u32 val;
 
 	mutex_lock(&dev_priv->rps.hw_lock);
+	/* Claim the pmic bus on systems where the punit shares the pmic bus */
+	iosf_mbi_punit_acquire();
 
 	val = vlv_punit_read(dev_priv, PUNIT_REG_DSPFREQ);
 	if (enable)
@@ -319,6 +325,7 @@ static void chv_set_memory_pm5(struct drm_i915_private *dev_priv, bool enable)
 		val &= ~DSP_MAXFIFO_PM5_ENABLE;
 	vlv_punit_write(dev_priv, PUNIT_REG_DSPFREQ, val);
 
+	iosf_mbi_punit_release();
 	mutex_unlock(&dev_priv->rps.hw_lock);
 }
 
@@ -4565,6 +4572,8 @@ void vlv_wm_get_hw_state(struct drm_device *dev)
 
 	if (IS_CHERRYVIEW(dev_priv)) {
 		mutex_lock(&dev_priv->rps.hw_lock);
+		/* Claim the pmic on systems where the punit shares its bus */
+		iosf_mbi_punit_acquire();
 
 		val = vlv_punit_read(dev_priv, PUNIT_REG_DSPFREQ);
 		if (val & DSP_MAXFIFO_PM5_ENABLE)
@@ -4594,6 +4603,7 @@ void vlv_wm_get_hw_state(struct drm_device *dev)
 				wm->level = VLV_WM_LEVEL_DDR_DVFS;
 		}
 
+		iosf_mbi_punit_release();
 		mutex_unlock(&dev_priv->rps.hw_lock);
 	}
 
@@ -5000,7 +5010,10 @@ static int valleyview_set_rps(struct drm_i915_private *dev_priv, u8 val)
 	I915_WRITE(GEN6_PMINTRMSK, gen6_rps_pm_mask(dev_priv, val));
 
 	if (val != dev_priv->rps.cur_freq) {
+		/* Claim the pmic on systems where the punit shares its bus */
+		iosf_mbi_punit_acquire();
 		err = vlv_punit_write(dev_priv, PUNIT_REG_GPU_FREQ_REQ, val);
+		iosf_mbi_punit_release();
 		if (err)
 			return err;
 
diff --git a/drivers/gpu/drm/i915/intel_runtime_pm.c b/drivers/gpu/drm/i915/intel_runtime_pm.c
index 66aa1bb..4704b40 100644
--- a/drivers/gpu/drm/i915/intel_runtime_pm.c
+++ b/drivers/gpu/drm/i915/intel_runtime_pm.c
@@ -28,6 +28,7 @@
 
 #include <linux/pm_runtime.h>
 #include <linux/vgaarb.h>
+#include <asm/iosf_mbi.h>
 
 #include "i915_drv.h"
 #include "intel_drv.h"
@@ -1027,6 +1028,9 @@ static void vlv_set_power_well(struct drm_i915_private *dev_priv,
 	if (COND)
 		goto out;
 
+	/* Claim the pmic bus on systems where the punit shares the pmic bus */
+	iosf_mbi_punit_acquire();
+
 	ctrl = vlv_punit_read(dev_priv, PUNIT_REG_PWRGT_CTRL);
 	ctrl &= ~mask;
 	ctrl |= state;
@@ -1037,6 +1041,8 @@ static void vlv_set_power_well(struct drm_i915_private *dev_priv,
 			  state,
 			  vlv_punit_read(dev_priv, PUNIT_REG_PWRGT_CTRL));
 
+	iosf_mbi_punit_release();
+
 #undef COND
 
 out:
@@ -1643,6 +1649,9 @@ static void chv_set_pipe_power_well(struct drm_i915_private *dev_priv,
 	if (COND)
 		goto out;
 
+	/* Claim the pmic bus on systems where the punit shares the pmic bus */
+	iosf_mbi_punit_acquire();
+
 	ctrl = vlv_punit_read(dev_priv, PUNIT_REG_DSPFREQ);
 	ctrl &= ~DP_SSC_MASK(pipe);
 	ctrl |= enable ? DP_SSC_PWR_ON(pipe) : DP_SSC_PWR_GATE(pipe);
@@ -1653,6 +1662,8 @@ static void chv_set_pipe_power_well(struct drm_i915_private *dev_priv,
 			  state,
 			  vlv_punit_read(dev_priv, PUNIT_REG_DSPFREQ));
 
+	iosf_mbi_punit_release();
+
 #undef COND
 
 out:
-- 
2.9.3


--------------B2BFB873A766277436AB9B2B--
