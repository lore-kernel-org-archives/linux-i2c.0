From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 6/7] drm/i915: Listen for pmic bus access notifications
Date: Sun,  8 Jan 2017 14:44:26 +0100
Message-ID: <20170108134427.8392-7-hdegoede@redhat.com>
References: <20170108134427.8392-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52828 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932078AbdAHNos (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 8 Jan 2017 08:44:48 -0500
In-Reply-To: <20170108134427.8392-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org

Listen for pmic bus access notifications and get FORCEWAKE_ALL while
the bus is accessed to avoid needing to do any forcewakes, which need
pmic bus access, while the pmic bus is busy:

This fixes errors like these showing up in dmesg, usually followed
by a gfx or system freeze:

[drm:fw_domains_get [i915]] *ERROR* render: timed out waiting for forcewake ack request.
[drm:fw_domains_get [i915]] *MEDIA* render: timed out waiting for forcewake ack request.
i2c_designware 808622C1:06: punit semaphore timed out, resetting
i2c_designware 808622C1:06: PUNIT SEM: 2
i2c_designware 808622C1:06: couldn't acquire bus ownership

Downside of this approach is that it causes wakeups whenever the pmic
bus is accessed. Unfortunately we cannot simply wait for the pmic bus
to go idle when we hit a race, as forcewakes may be done from interrupt
handlers where we cannot sleep to wait for the i2c pmic bus access to
finish.

Note that the notifications and thus the wakeups will only happen on
baytrail / cherrytrail devices using pmic-s with a shared i2c bus for
punit and host pmic access (i2c busses with a _SEM method in their
APCI node), e.g. an axp288 pmic.

I plan to write some patches for drivers accessing the pmic bus to
limit their bus accesses to a bare minimum (e.g. cache registers, do not
update battery level more often then 4 times a minute), to limit the
amount of wakeups.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=155241
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: tagorereddy <tagore.chandan@gmail.com>
---
 drivers/gpu/drm/i915/i915_drv.h     |  1 +
 drivers/gpu/drm/i915/intel_uncore.c | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 7cd0363..60297de 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -731,6 +731,7 @@ struct intel_uncore {
 	const struct intel_forcewake_range *fw_domains_table;
 	unsigned int fw_domains_table_entries;
 
+	struct notifier_block pmic_bus_access_nb;
 	struct intel_uncore_funcs funcs;
 
 	unsigned fifo_count;
diff --git a/drivers/gpu/drm/i915/intel_uncore.c b/drivers/gpu/drm/i915/intel_uncore.c
index c7fa222..1668de4 100644
--- a/drivers/gpu/drm/i915/intel_uncore.c
+++ b/drivers/gpu/drm/i915/intel_uncore.c
@@ -25,6 +25,7 @@
 #include "intel_drv.h"
 #include "i915_vgpu.h"
 
+#include <asm/iosf_mbi.h>
 #include <linux/pm_runtime.h>
 
 #define FORCEWAKE_ACK_TIMEOUT_MS 50
@@ -429,12 +430,16 @@ static void __intel_uncore_early_sanitize(struct drm_i915_private *dev_priv,
 
 void intel_uncore_suspend(struct drm_i915_private *dev_priv)
 {
+	iosf_mbi_unregister_pmic_bus_access_notifier(
+		&dev_priv->uncore.pmic_bus_access_nb);
 	__intel_uncore_forcewake_reset(dev_priv, false);
 }
 
 void intel_uncore_resume(struct drm_i915_private *dev_priv)
 {
 	__intel_uncore_early_sanitize(dev_priv, true);
+	iosf_mbi_register_pmic_bus_access_notifier(
+		&dev_priv->uncore.pmic_bus_access_nb);
 	i915_check_and_clear_faults(dev_priv);
 }
 
@@ -1390,6 +1395,28 @@ static void intel_uncore_fw_domains_init(struct drm_i915_private *dev_priv)
 	dev_priv->uncore.fw_domains_table_entries = ARRAY_SIZE((d)); \
 }
 
+static int i915_pmic_bus_access_notifier(struct notifier_block *nb,
+					 unsigned long action, void *data)
+{
+	struct drm_i915_private *dev_priv = container_of(nb,
+			struct drm_i915_private, uncore.pmic_bus_access_nb);
+
+	switch (action) {
+	case MBI_PMIC_BUS_ACCESS_BEGIN:
+		/*
+		 * forcewake all to make sure that we don't need to forcewake
+		 * any power-planes while the pmic bus is busy.
+		 */
+		intel_uncore_forcewake_get(dev_priv, FORCEWAKE_ALL);
+		break;
+	case MBI_PMIC_BUS_ACCESS_END:
+		intel_uncore_forcewake_put(dev_priv, FORCEWAKE_ALL);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
 void intel_uncore_init(struct drm_i915_private *dev_priv)
 {
 	i915_check_vgpu(dev_priv);
@@ -1399,6 +1426,8 @@ void intel_uncore_init(struct drm_i915_private *dev_priv)
 	__intel_uncore_early_sanitize(dev_priv, false);
 
 	dev_priv->uncore.unclaimed_mmio_check = 1;
+	dev_priv->uncore.pmic_bus_access_nb.notifier_call =
+		i915_pmic_bus_access_notifier;
 
 	switch (INTEL_INFO(dev_priv)->gen) {
 	default:
@@ -1458,6 +1487,9 @@ void intel_uncore_init(struct drm_i915_private *dev_priv)
 		ASSIGN_READ_MMIO_VFUNCS(vgpu);
 	}
 
+	iosf_mbi_register_pmic_bus_access_notifier(
+		&dev_priv->uncore.pmic_bus_access_nb);
+
 	i915_check_and_clear_faults(dev_priv);
 }
 #undef ASSIGN_WRITE_MMIO_VFUNCS
@@ -1465,6 +1497,9 @@ void intel_uncore_init(struct drm_i915_private *dev_priv)
 
 void intel_uncore_fini(struct drm_i915_private *dev_priv)
 {
+	iosf_mbi_unregister_pmic_bus_access_notifier(
+		&dev_priv->uncore.pmic_bus_access_nb);
+
 	/* Paranoia: make sure we have disabled everything before we exit. */
 	intel_uncore_sanitize(dev_priv);
 	__intel_uncore_forcewake_reset(dev_priv, false);
-- 
2.9.3
