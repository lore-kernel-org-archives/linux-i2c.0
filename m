From: Hans de Goede <hdegoede@redhat.com>
Subject: [RFC 3/4] drm/i915: valleyview: Make intel_set_rps get FORCEWAKE_MEDIA
Date: Sun,  1 Jan 2017 21:14:02 +0100
Message-ID: <20170101201403.12132-4-hdegoede@redhat.com>
References: <20170101201403.12132-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32994 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932229AbdAAUON (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 1 Jan 2017 15:14:13 -0500
In-Reply-To: <20170101201403.12132-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, Hans de Goede <hdegoede@redhat.com>

All callers of valleyview_set_rps() get at least FORCEWAKE_MEDIA, except
for intel_set_rps(). Since intel_set_rps can for example be called from
sysfs store functions, there is no guarantee this is already done, so add
an intel_uncore_forcewake_get(FORCEWAKE_MEDIA) call to intel_set_rps.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/i915/intel_pm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
index 4b12637..cc4fbd7 100644
--- a/drivers/gpu/drm/i915/intel_pm.c
+++ b/drivers/gpu/drm/i915/intel_pm.c
@@ -5096,9 +5096,14 @@ void gen6_rps_boost(struct drm_i915_private *dev_priv,
 
 void intel_set_rps(struct drm_i915_private *dev_priv, u8 val)
 {
-	if (IS_VALLEYVIEW(dev_priv) || IS_CHERRYVIEW(dev_priv))
+	if (IS_VALLEYVIEW(dev_priv) || IS_CHERRYVIEW(dev_priv)) {
+		/* Wake up the media well, as that takes a lot less
+		 * power than the Render well.
+		 */
+		intel_uncore_forcewake_get(dev_priv, FORCEWAKE_MEDIA);
 		valleyview_set_rps(dev_priv, val);
-	else
+		intel_uncore_forcewake_put(dev_priv, FORCEWAKE_MEDIA);
+	} else
 		gen6_set_rps(dev_priv, val);
 }
 
-- 
2.9.3
