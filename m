From: Peter Rosin <peda-SamgB31n2u5IcsJQ0EH25Q@public.gmane.org>
Subject: [PATCH 08/10] i2c-mux: relax locking of the top i2c adapter during i2c controlled muxing
Date: Mon,  4 Jan 2016 16:10:13 +0100
Message-ID: <1451920215-29167-9-git-send-email-peda@lysator.liu.se>
References: <1451920215-29167-1-git-send-email-peda@lysator.liu.se>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1451920215-29167-1-git-send-email-peda-SamgB31n2u5IcsJQ0EH25Q@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Rosin <peda-SamgB31n2u5IcsJQ0EH25Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>

With a i2c topology like the following

                       GPIO ---|  ------ BAT1
                        |      v /
   I2C  -----+----------+---- MUX
             |                   \
           EEPROM                 ------ BAT2

there is a locking problem with the GPIO controller since it is a client
on the same i2c bus that it muxes. Transfers to the mux clients (e.g. BAT1)
will lock the whole i2c bus prior to attempting to switch the mux to the
correct i2c segment. In the above case, the GPIO device is an I/O expander
with an i2c interface, and since the GPIO subsystem knows nothing (and
rightfully so) about the lockless needs of the i2c mux code, this results
in a deadlock when the GPIO driver issues i2c transfers to modify the
mux.

So, observing that while it is needed to have the i2c bus locked during the
actual MUX update in order to avoid random garbage on the slave side, it
is not strictly a must to have it locked over the whole sequence of a full
select-transfer-deselect mux client operation. The mux itself needs to be
locked, so transfers to clients behind the mux are serialized, and the mux
needs to be stable during all i2c traffic (otherwise individual mux slave
segments might see garbage, or worse).

Add devive tree properties (bool named i2c-controlled) to i2c-mux-gpio and
i2c-mux-pinctrl that asserts that the the gpio/pinctrl is controlled via
the same i2c bus that it muxes.

Modify the i2c mux locking so that muxes that are "i2c-controlled" locks
the mux instead of the whole i2c bus when there is a transfer to the slave
side of the mux. This lock serializes transfers to the slave side of the
mux.

Modify the select-transfer-deselect code for "i2c-controlled" muxes so
that each of the select-transfer-deselect ops locks the mux parent
adapter individually.

Signed-off-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
---
 .../devicetree/bindings/i2c/i2c-mux-gpio.txt       |   2 +
 .../devicetree/bindings/i2c/i2c-mux-pinctrl.txt    |   4 +
 drivers/i2c/i2c-mux.c                              | 109 +++++++++++++++++++--
 drivers/i2c/muxes/i2c-mux-gpio.c                   |   3 +
 drivers/i2c/muxes/i2c-mux-pinctrl.c                |   3 +
 include/linux/i2c-mux-gpio.h                       |   2 +
 include/linux/i2c-mux-pinctrl.h                    |   2 +
 include/linux/i2c-mux.h                            |   2 +
 8 files changed, 120 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt
index 66709a825541..17670b997d81 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt
@@ -28,6 +28,8 @@ Required properties:
 Optional properties:
 - idle-state: value to set the muxer to when idle. When no value is
   given, it defaults to the last value used.
+- i2c-controlled: The muxed I2C bus is also used to control all the gpios
+  used for muxing.
 
 For each i2c child node, an I2C child bus will be created. They will
 be numbered based on their order in the device tree.
diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.txt
index ae8af1694e95..8374a1f7a709 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.txt
@@ -23,6 +23,10 @@ Required properties:
 - i2c-parent: The phandle of the I2C bus that this multiplexer's master-side
   port is connected to.
 
+Optional properties:
+- i2c-controlled: The muxed I2C bus is also used to control all the pinctrl
+  pins used for muxing.
+
 Also required are:
 
 * Standard pinctrl properties that specify the pin mux state for each child
diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 605333757a5e..91066cfe5a95 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -54,6 +54,25 @@ static int i2c_mux_master_xfer(struct i2c_adapter *adap,
 	return ret;
 }
 
+static int __i2c_mux_master_xfer(struct i2c_adapter *adap,
+				 struct i2c_msg msgs[], int num)
+{
+	struct i2c_mux_priv *priv = adap->algo_data;
+	struct i2c_mux_core *muxc = priv->muxc;
+	struct i2c_adapter *parent = muxc->parent;
+	int ret;
+
+	/* Switch to the right mux port and perform the transfer. */
+
+	ret = muxc->select(muxc, priv->chan_id);
+	if (ret >= 0)
+		ret = i2c_transfer(parent, msgs, num);
+	if (muxc->deselect)
+		muxc->deselect(muxc, priv->chan_id);
+
+	return ret;
+}
+
 static int i2c_mux_smbus_xfer(struct i2c_adapter *adap,
 			      u16 addr, unsigned short flags,
 			      char read_write, u8 command,
@@ -76,6 +95,28 @@ static int i2c_mux_smbus_xfer(struct i2c_adapter *adap,
 	return ret;
 }
 
+static int __i2c_mux_smbus_xfer(struct i2c_adapter *adap,
+				u16 addr, unsigned short flags,
+				char read_write, u8 command,
+				int size, union i2c_smbus_data *data)
+{
+	struct i2c_mux_priv *priv = adap->algo_data;
+	struct i2c_mux_core *muxc = priv->muxc;
+	struct i2c_adapter *parent = muxc->parent;
+	int ret;
+
+	/* Select the right mux port and perform the transfer. */
+
+	ret = muxc->select(muxc, priv->chan_id);
+	if (ret >= 0)
+		ret = i2c_smbus_xfer(parent, addr, flags,
+				     read_write, command, size, data);
+	if (muxc->deselect)
+		muxc->deselect(muxc, priv->chan_id);
+
+	return ret;
+}
+
 /* Return the parent's functionality */
 static u32 i2c_mux_functionality(struct i2c_adapter *adap)
 {
@@ -98,6 +139,45 @@ static unsigned int i2c_mux_parent_classes(struct i2c_adapter *parent)
 	return class;
 }
 
+static void i2c_mux_lock_bus(struct i2c_adapter *adapter, int flags)
+{
+	struct i2c_mux_priv *priv = adapter->algo_data;
+	struct i2c_mux_core *muxc = priv->muxc;
+	struct i2c_adapter *parent = muxc->parent;
+
+	rt_mutex_lock(&muxc->bus_lock);
+	if (!(flags & I2C_LOCK_ADAPTER))
+		return;
+	i2c_lock_bus(parent, flags);
+}
+
+static int i2c_mux_trylock_bus(struct i2c_adapter *adapter, int flags)
+{
+	struct i2c_mux_priv *priv = adapter->algo_data;
+	struct i2c_mux_core *muxc = priv->muxc;
+	struct i2c_adapter *parent = muxc->parent;
+
+	if (!rt_mutex_trylock(&muxc->bus_lock))
+		return 0;
+	if (!(flags & I2C_LOCK_ADAPTER))
+		return 1;
+	if (parent->trylock_bus(parent, flags))
+		return 1;
+	rt_mutex_unlock(&muxc->bus_lock);
+	return 0;
+}
+
+static void i2c_mux_unlock_bus(struct i2c_adapter *adapter, int flags)
+{
+	struct i2c_mux_priv *priv = adapter->algo_data;
+	struct i2c_mux_core *muxc = priv->muxc;
+	struct i2c_adapter *parent = muxc->parent;
+
+	if (flags & I2C_LOCK_ADAPTER)
+		i2c_unlock_bus(parent, flags);
+	rt_mutex_unlock(&muxc->bus_lock);
+}
+
 static void i2c_parent_lock_bus(struct i2c_adapter *adapter, int flags)
 {
 	struct i2c_mux_priv *priv = adapter->algo_data;
@@ -158,6 +238,7 @@ struct i2c_mux_core *i2c_mux_alloc(struct device *dev, int sizeof_priv)
 			goto fail;
 	}
 	muxc->dev = dev;
+	rt_mutex_init(&muxc->bus_lock);
 	return muxc;
 
 fail:
@@ -196,10 +277,18 @@ int i2c_add_mux_adapter(struct i2c_mux_core *muxc,
 	/* Need to do algo dynamically because we don't know ahead
 	 * of time what sort of physical adapter we'll be dealing with.
 	 */
-	if (parent->algo->master_xfer)
-		priv->algo.master_xfer = i2c_mux_master_xfer;
-	if (parent->algo->smbus_xfer)
-		priv->algo.smbus_xfer = i2c_mux_smbus_xfer;
+	if (parent->algo->master_xfer) {
+		if (muxc->i2c_controlled)
+			priv->algo.master_xfer = __i2c_mux_master_xfer;
+		else
+			priv->algo.master_xfer = i2c_mux_master_xfer;
+	}
+	if (parent->algo->smbus_xfer) {
+		if (muxc->i2c_controlled)
+			priv->algo.smbus_xfer = __i2c_mux_smbus_xfer;
+		else
+			priv->algo.smbus_xfer = i2c_mux_smbus_xfer;
+	}
 	priv->algo.functionality = i2c_mux_functionality;
 
 	/* Now fill out new adapter structure */
@@ -212,9 +301,15 @@ int i2c_add_mux_adapter(struct i2c_mux_core *muxc,
 	priv->adap.retries = parent->retries;
 	priv->adap.timeout = parent->timeout;
 	priv->adap.quirks = parent->quirks;
-	priv->adap.lock_bus = i2c_parent_lock_bus;
-	priv->adap.trylock_bus = i2c_parent_trylock_bus;
-	priv->adap.unlock_bus = i2c_parent_unlock_bus;
+	if (muxc->i2c_controlled) {
+		priv->adap.lock_bus = i2c_mux_lock_bus;
+		priv->adap.trylock_bus = i2c_mux_trylock_bus;
+		priv->adap.unlock_bus = i2c_mux_unlock_bus;
+	} else {
+		priv->adap.lock_bus = i2c_parent_lock_bus;
+		priv->adap.trylock_bus = i2c_parent_trylock_bus;
+		priv->adap.unlock_bus = i2c_parent_unlock_bus;
+	}
 
 	/* Sanity check on class */
 	if (i2c_mux_parent_classes(parent) & class)
diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 4641ea0da516..af984d438fe1 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -68,6 +68,8 @@ static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
 	if (!np)
 		return -ENODEV;
 
+	mux->data.i2c_controlled = of_property_read_bool(np,
+							 "i2c-controlled");
 	adapter_np = of_parse_phandle(np, "i2c-parent", 0);
 	if (!adapter_np) {
 		dev_err(&pdev->dev, "Cannot parse i2c-parent\n");
@@ -179,6 +181,7 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 	if (!parent)
 		return -EPROBE_DEFER;
 
+	muxc->i2c_controlled = mux->data.i2c_controlled;
 	muxc->parent = parent;
 	muxc->select = i2c_mux_gpio_select;
 	mux->gpio_base = gpio_base;
diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c
index e27f66bf5341..541c17567dbf 100644
--- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
@@ -101,6 +101,8 @@ static int i2c_mux_pinctrl_parse_dt(struct i2c_mux_pinctrl *mux,
 		}
 	}
 
+	mux->pdata->i2c_controlled = of_property_read_bool(np,
+							   "i2c-controlled");
 	adapter_np = of_parse_phandle(np, "i2c-parent", 0);
 	if (!adapter_np) {
 		dev_err(muxc->dev, "Cannot parse i2c-parent\n");
@@ -201,6 +203,7 @@ static int i2c_mux_pinctrl_probe(struct platform_device *pdev)
 	}
 	muxc->select = i2c_mux_pinctrl_select;
 
+	muxc->i2c_controlled = mux->pdata->i2c_controlled;
 	muxc->parent = i2c_get_adapter(mux->pdata->parent_bus_num);
 	if (!muxc->parent) {
 		dev_err(&pdev->dev, "Parent adapter (%d) not found\n",
diff --git a/include/linux/i2c-mux-gpio.h b/include/linux/i2c-mux-gpio.h
index 4406108201fe..8fb19380bb03 100644
--- a/include/linux/i2c-mux-gpio.h
+++ b/include/linux/i2c-mux-gpio.h
@@ -27,6 +27,7 @@
  * @gpios: Array of GPIO numbers used to control MUX
  * @n_gpios: Number of GPIOs used to control MUX
  * @idle: Bitmask to write to MUX when idle or GPIO_I2CMUX_NO_IDLE if not used
+ * @i2c_controlled: Set if the parent i2c bus is used to control the gpio.
  */
 struct i2c_mux_gpio_platform_data {
 	int parent;
@@ -38,6 +39,7 @@ struct i2c_mux_gpio_platform_data {
 	const unsigned *gpios;
 	int n_gpios;
 	unsigned idle;
+	bool i2c_controlled;
 };
 
 #endif /* _LINUX_I2C_MUX_GPIO_H */
diff --git a/include/linux/i2c-mux-pinctrl.h b/include/linux/i2c-mux-pinctrl.h
index a65c86429e84..fb95cb7c45c5 100644
--- a/include/linux/i2c-mux-pinctrl.h
+++ b/include/linux/i2c-mux-pinctrl.h
@@ -29,6 +29,7 @@
  * @pinctrl_state_idle: The pinctrl state to select when no child bus is being
  *	accessed. If NULL, the most recently used pinctrl state will be left
  *	selected.
+ * @i2c_controlled: Set if the parent i2c bus is used to control the pinctrl.
  */
 struct i2c_mux_pinctrl_platform_data {
 	int parent_bus_num;
@@ -36,6 +37,7 @@ struct i2c_mux_pinctrl_platform_data {
 	int bus_count;
 	const char **pinctrl_states;
 	const char *pinctrl_state_idle;
+	bool i2c_controlled;
 };
 
 #endif
diff --git a/include/linux/i2c-mux.h b/include/linux/i2c-mux.h
index d88e0a3b6768..b73d14c45121 100644
--- a/include/linux/i2c-mux.h
+++ b/include/linux/i2c-mux.h
@@ -33,6 +33,8 @@ struct i2c_mux_core {
 	int adapters;
 	int max_adapters;
 	struct device *dev;
+	struct rt_mutex bus_lock;
+	bool i2c_controlled;
 
 	void *priv;
 
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
