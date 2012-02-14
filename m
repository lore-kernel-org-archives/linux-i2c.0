From: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>
Subject: [PATCH 5/7] drm/i915: merge gmbus and gpio i2c adpater into one
Date: Tue, 14 Feb 2012 22:37:23 +0100
Message-ID: <1329255445-6312-5-git-send-email-daniel.vetter@ffwll.ch>
References: <1329255445-6312-1-git-send-email-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1329255445-6312-1-git-send-email-daniel.vetter-/w4YWyX8dFk@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Intel Graphics Development <intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: DRI Development <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

... and directly call the newly exported i2c bit-banging functions.

The code is still pretty convoluted because we only set up the gpio
i2c stuff when actually falling back, resulting in more complexity
than necessary. This will be fixed up in the next patch.

Signed-Off-by: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>
---
 drivers/gpu/drm/i915/i915_drv.h  |    2 ++
 drivers/gpu/drm/i915/intel_i2c.c |   38 +++++---------------------------------
 2 files changed, 7 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index f137b1d..14b6e94 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -35,6 +35,7 @@
 #include "intel_ringbuffer.h"
 #include <linux/io-mapping.h>
 #include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
 #include <drm/intel-gtt.h>
 #include <linux/backlight.h>
 
@@ -295,6 +296,7 @@ struct intel_gmbus {
 	struct i2c_adapter *force_bit;
 	u32 reg0;
 	u32 gpio_reg;
+	struct i2c_algo_bit_data bit_algo;
 	struct drm_i915_private *dev_priv;
 };
 
diff --git a/drivers/gpu/drm/i915/intel_i2c.c b/drivers/gpu/drm/i915/intel_i2c.c
index b9f17cb..6eb68b7 100644
--- a/drivers/gpu/drm/i915/intel_i2c.c
+++ b/drivers/gpu/drm/i915/intel_i2c.c
@@ -154,29 +154,18 @@ intel_gpio_create(struct intel_gmbus *bus, u32 pin)
 		0,
 		GPIOF,
 	};
-	struct i2c_adapter *adapter;
 	struct i2c_algo_bit_data *algo;
 
 	if (pin >= ARRAY_SIZE(map_pin_to_reg) || !map_pin_to_reg[pin])
 		return NULL;
 
-	adapter = kzalloc(sizeof(struct i2c_adapter), GFP_KERNEL);
-	if (adapter == NULL)
-		return NULL;
-
-	algo = kzalloc(sizeof(struct i2c_algo_bit_data), GFP_KERNEL);
-	if (algo == NULL)
-		goto out_adap;
+	algo = &bus->bit_algo;
 
 	bus->gpio_reg = map_pin_to_reg[pin];
 	if (HAS_PCH_SPLIT(dev_priv->dev))
 		bus->gpio_reg += PCH_GPIOA - GPIOA;
 
-	snprintf(adapter->name, sizeof(adapter->name),
-		 "i915 GPIO%c", "?BACDE?F"[pin]);
-	adapter->owner = THIS_MODULE;
-	adapter->algo_data = algo;
-	adapter->dev.parent = &dev_priv->dev->pdev->dev;
+	bus->adapter.algo_data = algo;
 	algo->setsda = set_data;
 	algo->setscl = set_clock;
 	algo->getsda = get_data;
@@ -185,16 +174,7 @@ intel_gpio_create(struct intel_gmbus *bus, u32 pin)
 	algo->timeout = usecs_to_jiffies(2200);
 	algo->data = bus;
 
-	if (i2c_bit_add_bus(adapter))
-		goto out_algo;
-
-	return adapter;
-
-out_algo:
-	kfree(algo);
-out_adap:
-	kfree(adapter);
-	return NULL;
+	return &bus->adapter;
 }
 
 static int
@@ -213,7 +193,7 @@ intel_i2c_quirk_xfer(struct intel_gmbus *bus,
 	set_clock(bus, 1);
 	udelay(I2C_RISEFALL_TIME);
 
-	ret = adapter->algo->master_xfer(adapter, msgs, num);
+	ret = i2c_bit_xfer(adapter, msgs, num);
 
 	set_data(bus, 1);
 	set_clock(bus, 1);
@@ -348,7 +328,7 @@ static u32 gmbus_func(struct i2c_adapter *adapter)
 					       adapter);
 
 	if (bus->force_bit)
-		bus->force_bit->algo->functionality(bus->force_bit);
+		i2c_bit_func(bus->force_bit);
 
 	return (I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL |
 		/* I2C_FUNC_10BIT_ADDR | */
@@ -444,9 +424,6 @@ void intel_gmbus_force_bit(struct i2c_adapter *adapter, bool force_bit)
 		}
 	} else {
 		if (bus->force_bit) {
-			i2c_del_adapter(bus->force_bit);
-			kfree(bus->force_bit->algo);
-			kfree(bus->force_bit);
 			bus->force_bit = NULL;
 		}
 	}
@@ -462,11 +439,6 @@ void intel_teardown_gmbus(struct drm_device *dev)
 
 	for (i = 0; i < GMBUS_NUM_PORTS; i++) {
 		struct intel_gmbus *bus = &dev_priv->gmbus[i];
-		if (bus->force_bit) {
-			i2c_del_adapter(bus->force_bit);
-			kfree(bus->force_bit->algo);
-			kfree(bus->force_bit);
-		}
 		i2c_del_adapter(&bus->adapter);
 	}
 
-- 
1.7.7.5
