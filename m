From: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH V4 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Fri, 4 May 2012 15:10:59 +0530
Message-ID: <3484bf49a423bd55daa6a45e68c2c31dce46eb32.1336124143.git.viresh.kumar@st.com>
References: <cover.1336124143.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1336124143.git.viresh.kumar-qxv4g6HH51o@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ml.lawnick-Mmb7MZpHnFY@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add i2c bus recovery infrastructure to i2c adapters as specified in the i2c
protocol Rev. 03 section 3.16 titled "Bus clear".

http://www.nxp.com/documents/user_manual/UM10204.pdf

Sometimes during operation i2c bus hangs and we need to give dummy clocks to
slave device to start the transfer again. Now we may have capability in the bus
controller to generate these clocks or platform may have gpio pins which can be
toggled to generate dummy clocks. This patch supports both.

This patch also adds in generic bus recovery routines gpio or scl line based
which can be used by bus controller. In addition controller driver may provide
its own version of the bus recovery routine.

Signed-off-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
---
 Documentation/i2c/bus-recovery |   87 ++++++++++++++++++++++
 drivers/i2c/i2c-core.c         |  160 ++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-mux.c          |    9 ++-
 include/linux/i2c.h            |   58 ++++++++++++++
 4 files changed, 313 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/i2c/bus-recovery

diff --git a/Documentation/i2c/bus-recovery b/Documentation/i2c/bus-recovery
new file mode 100644
index 0000000..518dff6
--- /dev/null
+++ b/Documentation/i2c/bus-recovery
@@ -0,0 +1,87 @@
+			I2C Bus Recovery
+			================
+
+Problem:
+========
+There is a generic issue with I2C transfers, where the SDA line is pulled down
+by the slave device and the controller isn't able to control SDA line anymore.
+
+Solution:
+=========
+Following is specified in the i2c protocol Rev. 03 section 3.16 titled "Bus
+clear".
+
+http://www.nxp.com/documents/user_manual/UM10204.pdf
+
+If the data line (SDA) is stuck LOW, the master should send nine clock pulses.
+The device that held the bus LOW should release it sometime within those nine
+clocks. If not, then use the HW reset or cycle power to clear the bus.
+
+Implementation:
+==============
+In order to fix this issue in Linux, bus recovery mechanism is added in
+i2c-core. The controller driver needs to do following to get recovery support
+from i2c-core:
+- Return -ETIMEDOUT from their master_xfer() callback if they are stuck, so that
+  core can try recovery. (Which can only be done if below is passed from
+  controller driver.)
+- Must fill Adapters bus_recovery_info field with valid recovery structure.
+
+/**
+ * struct i2c_bus_recovery_info - I2c bus recovery information
+ * @recover_bus: Recover routine. Either pass driver's recover_bus() routine, or
+ *	pass it NULL to use generic ones, i.e. gpio or scl based.
+ * @skip_sda_polling: if true, bus recovery will not poll sda line to check if
+ *	it became high or not. Only required if recover_bus == NULL.
+ * @is_gpio_recovery: true, select gpio type else scl type. Only required if
+ *	recover_bus == NULL.
+ * @clock_rate_khz: clock rate of dummy clock in khz. Required for both gpio and
+ *	scl type recovery.
+ * @clock_cnt: count of max clocks to be generated. Required for both gpio and
+ *	scl type recovery.
+ * @set_scl: controller specific scl configuration routine. Only required if
+ *	is_gpio_recovery == false
+ * @get_sda: controller specific sda read routine. Only required if
+ *	is_gpio_recovery == false and skip_sda_polling == false.
+ * @gpio_recov: gpio recovery info, only if (is_gpio_recovery == true)
+ */
+struct i2c_bus_recovery_info {
+	int (*recover_bus)(struct i2c_adapter *);
+	bool skip_sda_polling;
+	bool is_gpio_recovery;
+	u32 clock_rate_khz;
+	u8 clock_cnt;
+
+	/* gpio recovery */
+	struct i2c_bus_gpio_recovery_info *gpio_recov;
+	/* scl/sda recovery */
+	void (*set_scl)(struct i2c_adapter *, int val);
+	int (*get_sda)(struct i2c_adapter *);
+};
+
+/**
+ * struct i2c_bus_gpio_recovery_info - I2c bus recovery information if recovery
+ *	type is gpio.
+ * @get_gpio: called before recover_bus() to get padmux configured for scl line.
+ *	as gpio.
+ * @put_gpio: called after recover_bus() to get padmux configured for scl line
+ *	as scl.
+ * @scl_gpio: gpio number of the scl line.
+ * @sda_gpio: gpio number of the sda line.
+ * @scl_gpio_flags: flag for gpio_request_one of scl_gpio. 0 implies
+ *	GPIOF_OUT_INIT_LOW.
+ * @sda_gpio_flags: flag for gpio_request_one of sda_gpio. 0 implies
+ *	GPIOF_OUT_INIT_LOW.
+ */
+struct i2c_bus_gpio_recovery_info {
+	int (*get_gpio)(unsigned gpio);
+	int (*put_gpio)(unsigned gpio);
+	u32 scl_gpio;
+	u32 sda_gpio;
+	u32 scl_gpio_flags;
+	u32 sda_gpio_flags;
+};
+
+Author:
+=======
+Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index a6ad32b..dc0e93d8 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -27,7 +27,9 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/delay.h>
 #include <linux/errno.h>
+#include <linux/gpio.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
@@ -104,6 +106,112 @@ static int i2c_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 #define i2c_device_uevent	NULL
 #endif	/* CONFIG_HOTPLUG */
 
+/* i2c bus recovery routines */
+static int i2c_gpio_pre_recovery(struct i2c_adapter *adap)
+{
+	struct i2c_bus_recovery_info *bus_recov = adap->bus_recovery_info;
+	struct i2c_bus_gpio_recovery_info *gpio_recov = bus_recov->gpio_recov;
+	int ret;
+
+	if (gpio_recov->get_gpio)
+		gpio_recov->get_gpio(gpio_recov->scl_gpio);
+
+	ret = gpio_request_one(gpio_recov->scl_gpio, gpio_recov->scl_gpio_flags,
+			"i2c-scl");
+	if (ret < 0) {
+		if (gpio_recov->put_gpio)
+			gpio_recov->put_gpio(gpio_recov->scl_gpio);
+		dev_warn(&adap->dev, "scl gpio request fail: %d\n",
+				gpio_recov->scl_gpio);
+		return ret;
+	}
+
+	if (!bus_recov->skip_sda_polling) {
+		if (gpio_recov->get_gpio)
+			gpio_recov->get_gpio(gpio_recov->sda_gpio);
+
+		ret = gpio_request_one(gpio_recov->sda_gpio,
+				gpio_recov->sda_gpio_flags, "i2c-sda");
+		if (ret < 0) {
+			/* work without sda polling */
+			dev_warn(&adap->dev,
+				"sda_gpio request fail: %d. Skip sda polling\n",
+				gpio_recov->scl_gpio);
+			bus_recov->skip_sda_polling = true;
+
+			if (gpio_recov->put_gpio)
+				gpio_recov->put_gpio(gpio_recov->sda_gpio);
+		}
+	}
+
+	return 0;
+}
+
+static void i2c_gpio_post_recovery(struct i2c_adapter *adap)
+{
+	struct i2c_bus_recovery_info *bus_recov = adap->bus_recovery_info;
+	struct i2c_bus_gpio_recovery_info *gpio_recov = bus_recov->gpio_recov;
+
+	if (!bus_recov->skip_sda_polling) {
+		gpio_free(gpio_recov->sda_gpio);
+
+		if (gpio_recov->put_gpio)
+			gpio_recov->put_gpio(gpio_recov->sda_gpio);
+	}
+
+	gpio_free(gpio_recov->scl_gpio);
+
+	if (gpio_recov->put_gpio)
+		gpio_recov->put_gpio(gpio_recov->scl_gpio);
+}
+
+static void set_scl_via_gpio(struct i2c_adapter *adap, int val)
+{
+	struct i2c_bus_gpio_recovery_info *gpio_recov =
+		adap->bus_recovery_info->gpio_recov;
+
+	gpio_set_value(gpio_recov->scl_gpio, val);
+}
+
+static int get_sda_via_gpio(struct i2c_adapter *adap)
+{
+	struct i2c_bus_gpio_recovery_info *gpio_recov =
+		adap->bus_recovery_info->gpio_recov;
+
+	return gpio_get_value(gpio_recov->sda_gpio);
+}
+
+/* i2c bus recovery routines */
+static int i2c_recover_bus(struct i2c_adapter *adap)
+{
+	struct i2c_bus_recovery_info *bus_recov = adap->bus_recovery_info;
+	unsigned long delay_nsec = 1000000;
+	int i, ret, val = 0;
+
+	if (bus_recov->is_gpio_recovery) {
+		ret = i2c_gpio_pre_recovery(adap);
+		if (ret)
+			return ret;
+	}
+
+	delay_nsec /= bus_recov->clock_rate_khz * 2;
+
+	for (i = 0; i < bus_recov->clock_cnt * 2; i++, val = !val) {
+		bus_recov->set_scl(adap, val);
+		ndelay(delay_nsec);
+
+		/* break if sda got high, check only when scl line is high */
+		if (!bus_recov->skip_sda_polling && val)
+			if (bus_recov->get_sda(adap))
+				break;
+	}
+
+	if (bus_recov->is_gpio_recovery)
+		i2c_gpio_post_recovery(adap);
+
+	return 0;
+}
+
 static int i2c_device_probe(struct device *dev)
 {
 	struct i2c_client	*client = i2c_verify_client(dev);
@@ -879,6 +987,51 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 			 "Failed to create compatibility class link\n");
 #endif
 
+	/* bus recovery specific initialization */
+	if (adap->bus_recovery_info) {
+		struct i2c_bus_recovery_info *bus_recov =
+			adap->bus_recovery_info;
+
+		if (bus_recov->recover_bus) {
+			dev_dbg(&adap->dev,
+				"registered for non-generic bus recovery\n");
+		} else {
+			bus_recov->recover_bus = i2c_recover_bus;
+
+			/* Use generic recovery routines */
+			if (!bus_recov->clock_rate_khz) {
+				dev_warn(&adap->dev,
+					"doesn't have valid recovery clock rate\n");
+				goto exit_recovery;
+			}
+
+			/* Most controller need 9 clocks at max */
+			if (!bus_recov->clock_cnt)
+				bus_recov->clock_cnt = 9;
+
+			if (bus_recov->is_gpio_recovery) {
+				bus_recov->set_scl = set_scl_via_gpio;
+				bus_recov->get_sda = get_sda_via_gpio;
+
+				dev_dbg(&adap->dev,
+					"registered for gpio bus recovery\n");
+			} else if (bus_recov->set_scl) {
+				if (!bus_recov->skip_sda_polling && !bus_recov->get_sda) {
+					bus_recov->skip_sda_polling = true;
+					dev_warn(&adap->dev,
+						"no get_sda. skip sda polling\n");
+				}
+
+				dev_info(&adap->dev,
+					"registered for scl bus recovery\n");
+			} else {
+				dev_warn(&adap->dev,
+					"doesn't have valid recovery type\n");
+			}
+		}
+	}
+
+exit_recovery:
 	/* create pre-declared device nodes */
 	if (adap->nr < __i2c_first_dynamic_bus_num)
 		i2c_scan_static_board_info(adap);
@@ -1368,6 +1521,13 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 		orig_jiffies = jiffies;
 		for (ret = 0, try = 0; try <= adap->retries; try++) {
 			ret = adap->algo->master_xfer(adap, msgs, num);
+			if ((ret == -ETIMEDOUT) && adap->bus_recovery_info) {
+				/* Attempt bus recovery */
+				dev_dbg(&adap->dev, "try bus recovery\n");
+				adap->bus_recovery_info->recover_bus(adap);
+				ret = -EAGAIN;
+				break;
+			}
 			if (ret != -EAGAIN)
 				break;
 			if (time_after(jiffies, orig_jiffies + adap->timeout))
diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 1038c38..c710319 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -50,8 +50,15 @@ static int i2c_mux_master_xfer(struct i2c_adapter *adap,
 	/* Switch to the right mux port and perform the transfer. */
 
 	ret = priv->select(parent, priv->mux_priv, priv->chan_id);
-	if (ret >= 0)
+	if (ret >= 0) {
 		ret = parent->algo->master_xfer(parent, msgs, num);
+		if ((ret == -ETIMEDOUT) && parent->bus_recovery_info) {
+			/* Attempt bus recovery */
+			dev_dbg(&parent->dev, "try bus recovery\n");
+			parent->bus_recovery_info->recover_bus(parent);
+			ret = -EAGAIN;
+		}
+	}
 	if (priv->deselect)
 		priv->deselect(parent, priv->mux_priv, priv->chan_id);
 
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index b66cb60..d7abf0d 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -367,6 +367,61 @@ struct i2c_algorithm {
 	u32 (*functionality) (struct i2c_adapter *);
 };
 
+/**
+ * struct i2c_bus_gpio_recovery_info - I2c bus recovery information if recovery
+ *	type is gpio.
+ * @get_gpio: called before recover_bus() to get padmux configured for scl line.
+ *	as gpio.
+ * @put_gpio: called after recover_bus() to get padmux configured for scl line
+ *	as scl.
+ * @scl_gpio: gpio number of the scl line.
+ * @sda_gpio: gpio number of the sda line.
+ * @scl_gpio_flags: flag for gpio_request_one of scl_gpio. 0 implies
+ *	GPIOF_OUT_INIT_LOW.
+ * @sda_gpio_flags: flag for gpio_request_one of sda_gpio. 0 implies
+ *	GPIOF_OUT_INIT_LOW.
+ */
+struct i2c_bus_gpio_recovery_info {
+	int (*get_gpio)(unsigned gpio);
+	int (*put_gpio)(unsigned gpio);
+	u32 scl_gpio;
+	u32 sda_gpio;
+	u32 scl_gpio_flags;
+	u32 sda_gpio_flags;
+};
+
+/**
+ * struct i2c_bus_recovery_info - I2c bus recovery information
+ * @recover_bus: Recover routine. Either pass driver's recover_bus() routine, or
+ *	pass it NULL to use generic ones, i.e. gpio or scl based.
+ * @skip_sda_polling: if true, bus recovery will not poll sda line to check if
+ *	it became high or not. Only required if recover_bus == NULL.
+ * @is_gpio_recovery: true, select gpio type else scl type. Only required if
+ *	recover_bus == NULL.
+ * @clock_rate_khz: clock rate of dummy clock in khz. Required for both gpio and
+ *	scl type recovery.
+ * @clock_cnt: count of max clocks to be generated. Required for both gpio and
+ *	scl type recovery.
+ * @set_scl: controller specific scl configuration routine. Only required if
+ *	is_gpio_recovery == false
+ * @get_sda: controller specific sda read routine. Only required if
+ *	is_gpio_recovery == false and skip_sda_polling == false.
+ * @gpio_recov: gpio recovery info, only if (is_gpio_recovery == true)
+ */
+struct i2c_bus_recovery_info {
+	int (*recover_bus)(struct i2c_adapter *);
+	bool skip_sda_polling;
+	bool is_gpio_recovery;
+	u32 clock_rate_khz;
+	u8 clock_cnt;
+
+	/* gpio recovery */
+	struct i2c_bus_gpio_recovery_info *gpio_recov;
+	/* scl/sda recovery */
+	void (*set_scl)(struct i2c_adapter *, int val);
+	int (*get_sda)(struct i2c_adapter *);
+};
+
 /*
  * i2c_adapter is the structure used to identify a physical i2c bus along
  * with the access algorithms necessary to access it.
@@ -390,6 +445,9 @@ struct i2c_adapter {
 
 	struct mutex userspace_clients_lock;
 	struct list_head userspace_clients;
+
+	/* Pass valid pointer if recovery infrastructure is required */
+	struct i2c_bus_recovery_info *bus_recovery_info;
 };
 #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
 
-- 
1.7.9
