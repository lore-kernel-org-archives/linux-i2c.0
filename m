From: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>
Subject: [PATCH 7/7] drm/i915: reenable gmbus on gen3+ again
Date: Tue, 14 Feb 2012 22:37:25 +0100
Message-ID: <1329255445-6312-7-git-send-email-daniel.vetter@ffwll.ch>
References: <1329255445-6312-1-git-send-email-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1329255445-6312-1-git-send-email-daniel.vetter-/w4YWyX8dFk@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Intel Graphics Development <intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: DRI Development <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

With the rework to merge the bit-banging fallback into the gmbus
i2c adapter we've gotten rid of the deadlock possibility that
originally lead to the disabling of this code.

This reverts the revert

commit 826c7e4147f902737b281e8a5a7d7aa33fd63316
Author: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Date:   Sat Jun 4 19:34:56 2011 +0000

    Revert "drm/i915: Enable GMBUS for post-gen2 chipsets"

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=35572
Signed-off-by: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>
---
 drivers/gpu/drm/i915/intel_i2c.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_i2c.c b/drivers/gpu/drm/i915/intel_i2c.c
index 9791546..2ec5f0d 100644
--- a/drivers/gpu/drm/i915/intel_i2c.c
+++ b/drivers/gpu/drm/i915/intel_i2c.c
@@ -384,7 +384,7 @@ int intel_setup_gmbus(struct drm_device *dev)
 		bus->has_gpio = intel_gpio_setup(bus, i);
 
 		/* XXX force bit banging until GMBUS is fully debugged */
-		if (bus->has_gpio)
+		if (bus->has_gpio && IS_GEN2(dev))
 			bus->force_bit = true;
 	}
 
-- 
1.7.7.5
