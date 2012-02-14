From: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>
Subject: [PATCH 6/7] drm/i915: i2c: unconditionally set up gpio fallback
Date: Tue, 14 Feb 2012 22:37:24 +0100
Message-ID: <1329255445-6312-6-git-send-email-daniel.vetter@ffwll.ch>
References: <1329255445-6312-1-git-send-email-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1329255445-6312-1-git-send-email-daniel.vetter-/w4YWyX8dFk@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Intel Graphics Development <intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: DRI Development <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This way we can simplify the setup and teardown a bit.

Because we don't actually allocate anything anymore for the force_bit
case, we can now convert that into a boolean.

Also and the functionality supported by the bit-banging together with
what gmbus can do, so that this doesn't randomly change any more.

Signed-Off-by: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>
---
 drivers/gpu/drm/i915/i915_drv.h  |    3 +-
 drivers/gpu/drm/i915/intel_i2c.c |   50 ++++++++++++++-----------------------
 2 files changed, 21 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 14b6e94..31affc0 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -293,7 +293,8 @@ struct intel_fbc_work;
 
 struct intel_gmbus {
 	struct i2c_adapter adapter;
-	struct i2c_adapter *force_bit;
+	bool force_bit;
+	bool has_gpio;
 	u32 reg0;
 	u32 gpio_reg;
 	struct i2c_algo_bit_data bit_algo;
diff --git a/drivers/gpu/drm/i915/intel_i2c.c b/drivers/gpu/drm/i915/intel_i2c.c
index 6eb68b7..9791546 100644
--- a/drivers/gpu/drm/i915/intel_i2c.c
+++ b/drivers/gpu/drm/i915/intel_i2c.c
@@ -140,8 +140,8 @@ static void set_data(void *data, int state_high)
 	POSTING_READ(bus->gpio_reg);
 }
 
-static struct i2c_adapter *
-intel_gpio_create(struct intel_gmbus *bus, u32 pin)
+static bool
+intel_gpio_setup(struct intel_gmbus *bus, u32 pin)
 {
 	struct drm_i915_private *dev_priv = bus->dev_priv;
 	static const int map_pin_to_reg[] = {
@@ -157,7 +157,7 @@ intel_gpio_create(struct intel_gmbus *bus, u32 pin)
 	struct i2c_algo_bit_data *algo;
 
 	if (pin >= ARRAY_SIZE(map_pin_to_reg) || !map_pin_to_reg[pin])
-		return NULL;
+		return false;
 
 	algo = &bus->bit_algo;
 
@@ -174,12 +174,11 @@ intel_gpio_create(struct intel_gmbus *bus, u32 pin)
 	algo->timeout = usecs_to_jiffies(2200);
 	algo->data = bus;
 
-	return &bus->adapter;
+	return true;
 }
 
 static int
 intel_i2c_quirk_xfer(struct intel_gmbus *bus,
-		     struct i2c_adapter *adapter,
 		     struct i2c_msg *msgs,
 		     int num)
 {
@@ -193,7 +192,7 @@ intel_i2c_quirk_xfer(struct intel_gmbus *bus,
 	set_clock(bus, 1);
 	udelay(I2C_RISEFALL_TIME);
 
-	ret = i2c_bit_xfer(adapter, msgs, num);
+	ret = i2c_bit_xfer(&bus->adapter, msgs, num);
 
 	set_data(bus, 1);
 	set_clock(bus, 1);
@@ -216,7 +215,7 @@ gmbus_xfer(struct i2c_adapter *adapter,
 	mutex_lock(&dev_priv->gmbus_mutex);
 
 	if (bus->force_bit) {
-		ret = intel_i2c_quirk_xfer(bus, bus->force_bit, msgs, num);
+		ret = intel_i2c_quirk_xfer(bus, msgs, num);
 		goto out;
 	}
 
@@ -311,11 +310,11 @@ timeout:
 	I915_WRITE(GMBUS0 + reg_offset, 0);
 
 	/* Hardware may not support GMBUS over these pins? Try GPIO bitbanging instead. */
-	bus->force_bit = intel_gpio_create(bus, bus->reg0 & 0xff);
-	if (!bus->force_bit)
-		ret = -ENOMEM;
-	else
-		ret = intel_i2c_quirk_xfer(bus, bus->force_bit, msgs, num);
+	ret = -EIO;
+	if (bus->has_gpio) {
+		bus->force_bit = true;
+		ret = intel_i2c_quirk_xfer(bus, msgs, num);
+	}
 out:
 	mutex_unlock(&dev_priv->gmbus_mutex);
 	return ret;
@@ -323,14 +322,8 @@ out:
 
 static u32 gmbus_func(struct i2c_adapter *adapter)
 {
-	struct intel_gmbus *bus = container_of(adapter,
-					       struct intel_gmbus,
-					       adapter);
-
-	if (bus->force_bit)
-		i2c_bit_func(bus->force_bit);
-
-	return (I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL |
+	return i2c_bit_func(adapter) &&
+		(I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL |
 		/* I2C_FUNC_10BIT_ADDR | */
 		I2C_FUNC_SMBUS_READ_BLOCK_DATA |
 		I2C_FUNC_SMBUS_BLOCK_PROC_CALL);
@@ -388,8 +381,11 @@ int intel_setup_gmbus(struct drm_device *dev)
 		/* By default use a conservative clock rate */
 		bus->reg0 = i | GMBUS_RATE_100KHZ;
 
+		bus->has_gpio = intel_gpio_setup(bus, i);
+
 		/* XXX force bit banging until GMBUS is fully debugged */
-		bus->force_bit = intel_gpio_create(bus, i);
+		if (bus->has_gpio)
+			bus->force_bit = true;
 	}
 
 	intel_i2c_reset(dev_priv->dev);
@@ -417,16 +413,8 @@ void intel_gmbus_force_bit(struct i2c_adapter *adapter, bool force_bit)
 {
 	struct intel_gmbus *bus = to_intel_gmbus(adapter);
 
-	if (force_bit) {
-		if (bus->force_bit == NULL) {
-			bus->force_bit = intel_gpio_create(bus,
-							   bus->reg0 & 0xff);
-		}
-	} else {
-		if (bus->force_bit) {
-			bus->force_bit = NULL;
-		}
-	}
+	if (bus->has_gpio)
+		bus->force_bit = force_bit;
 }
 
 void intel_teardown_gmbus(struct drm_device *dev)
-- 
1.7.7.5
