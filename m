From: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>
Subject: [PATCH 1/7] drm/i915: add dev_priv to intel_gmbus
Date: Tue, 14 Feb 2012 22:37:19 +0100
Message-ID: <1329255445-6312-1-git-send-email-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Intel Graphics Development <intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: DRI Development <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This way we can free up the bus->adaptor.algo_data pointer and make it
available for use with the bitbanging fallback algo.

Signed-Off-by: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>
---
 drivers/gpu/drm/i915/i915_drv.h  |   13 ++++++++-----
 drivers/gpu/drm/i915/intel_i2c.c |    6 +++---
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 8e3eb5e..ed40743 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -290,6 +290,13 @@ enum intel_pch {
 struct intel_fbdev;
 struct intel_fbc_work;
 
+struct intel_gmbus {
+	struct i2c_adapter adapter;
+	struct i2c_adapter *force_bit;
+	u32 reg0;
+	struct drm_i915_private *dev_priv;
+};
+
 typedef struct drm_i915_private {
 	struct drm_device *dev;
 
@@ -307,11 +314,7 @@ typedef struct drm_i915_private {
 	/** gt_lock is also taken in irq contexts. */
 	struct spinlock gt_lock;
 
-	struct intel_gmbus {
-		struct i2c_adapter adapter;
-		struct i2c_adapter *force_bit;
-		u32 reg0;
-	} *gmbus;
+	struct intel_gmbus *gmbus;
 
 	/** gmbus_mutex protects against concurrent usage of the single hw gmbus
 	 * controller on different i2c buses. */
diff --git a/drivers/gpu/drm/i915/intel_i2c.c b/drivers/gpu/drm/i915/intel_i2c.c
index fc75d71..f496510 100644
--- a/drivers/gpu/drm/i915/intel_i2c.c
+++ b/drivers/gpu/drm/i915/intel_i2c.c
@@ -232,7 +232,7 @@ gmbus_xfer(struct i2c_adapter *adapter,
 	struct intel_gmbus *bus = container_of(adapter,
 					       struct intel_gmbus,
 					       adapter);
-	struct drm_i915_private *dev_priv = adapter->algo_data;
+	struct drm_i915_private *dev_priv = bus->dev_priv;
 	int i, reg_offset, ret;
 
 	mutex_lock(&dev_priv->gmbus_mutex);
@@ -401,7 +401,7 @@ int intel_setup_gmbus(struct drm_device *dev)
 			 names[i]);
 
 		bus->adapter.dev.parent = &dev->pdev->dev;
-		bus->adapter.algo_data	= dev_priv;
+		bus->dev_priv = dev_priv;
 
 		bus->adapter.algo = &gmbus_algorithm;
 		ret = i2c_add_adapter(&bus->adapter);
@@ -442,7 +442,7 @@ void intel_gmbus_force_bit(struct i2c_adapter *adapter, bool force_bit)
 
 	if (force_bit) {
 		if (bus->force_bit == NULL) {
-			struct drm_i915_private *dev_priv = adapter->algo_data;
+			struct drm_i915_private *dev_priv = bus->dev_priv;
 			bus->force_bit = intel_gpio_create(dev_priv,
 							   bus->reg0 & 0xff);
 		}
-- 
1.7.7.5
