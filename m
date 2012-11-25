From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V7 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Sun, 25 Nov 2012 12:01:55 +0530
Message-ID: <71e27515a050a2c7d18272b84ff7ec3ec8b11cae.1353824555.git.viresh.kumar@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add i2c bus recovery infrastructure to i2c adapters as specified in the i2c
protocol Rev. 03 section 3.1.16 titled "Bus clear".

http://www.nxp.com/documents/user_manual/UM10204.pdf

Sometimes during operation i2c bus hangs and we need to give dummy clocks to
slave device to start the transfer again. Now we may have capability in the bus
controller to generate these clocks or platform may have gpio pins which can be
toggled to generate dummy clocks. This patch supports both.

This patch also adds in generic bus recovery routines gpio or scl line based
which can be used by bus controller. In addition controller driver may provide
its own version of the bus recovery routine.

This doesn't support multi-master recovery for now.

Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---

Hi Wolfram,

I am sending V7 before closing our comments completely on V6 (Very few are left
now :) ), so that you can get an idea of what i am implementing now. It
incorporates all your comments leaving:
- removing skip_sda_polling
- removing clock_rate_khz
- calling recover_bus from core instead of controller driver

V6->V7:
- Lots of review comments from Wolfram incorporated
- get[put]_gpio updated to more generic [un]prepare_recovery with return type as
  void.
- prototypes of generic recovery routines are exposed to controller driver and
  they are now required to pass recover_bus()
- gpio flags removed from recovery info
- default clock rate is 100 KHz if not passed by controller driver
- clk count is 9, fixed.

V5->V6:
- Removed sda_gpio_flags
- Make scl_gpio_flags as GPIOF_OPEN_DRAIN | GPIOF_OUT_INIT_HIGH by default
- update bri->set_scl and bri->get_sda for gpio recovery case in i2c core
- Guaranteed to generate 9 falling-rising edges for bus recovery

V4->V5:
- section name corrected to 3.1.16
- merged gpio and non-gpio recovery routines to remove code redundancy
- Changed types of gpio and gpio-flags to unsigned and unsigned long
- Checking return value of get_gpio() now
- using DIV_ROUND_UP for calculating delay, to get more correct value

 drivers/i2c/i2c-core.c | 136 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c.h    |  47 +++++++++++++++++
 2 files changed, 183 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index a7edf98..d100276 100644
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
@@ -104,6 +106,106 @@ static int i2c_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 #define i2c_device_uevent	NULL
 #endif	/* CONFIG_HOTPLUG */
 
+/* i2c bus recovery routines */
+#define RECOVERY_CLK_CNT	9
+#define DEFAULT_CLK_RATE	100	/* KHz */
+
+static void set_scl_gpio_value(struct i2c_adapter *adap, int val)
+{
+	gpio_set_value(adap->bus_recovery_info->scl_gpio, val);
+}
+
+static int get_sda_gpio_value(struct i2c_adapter *adap)
+{
+	return gpio_get_value(adap->bus_recovery_info->sda_gpio);
+}
+
+static int i2c_get_gpios_for_recovery(struct i2c_adapter *adap)
+{
+	struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
+	struct device *dev = &adap->dev;
+	int ret = 0;
+
+	ret = gpio_request_one(bri->scl_gpio, GPIOF_OPEN_DRAIN |
+			GPIOF_OUT_INIT_HIGH, "i2c-scl");
+	if (ret) {
+		dev_warn(dev, "gpio request fail: %d\n", bri->scl_gpio);
+		return ret;
+	}
+
+	if (!bri->skip_sda_polling) {
+		if (gpio_request_one(bri->sda_gpio, GPIOF_IN, "i2c-sda")) {
+			/* work without sda polling */
+			dev_warn(dev, "can't get sda: %d. Skip sda polling\n",
+					bri->sda_gpio);
+			bri->skip_sda_polling = true;
+		}
+	}
+
+	return ret;
+}
+
+static void i2c_put_gpios_for_recovery(struct i2c_adapter *adap)
+{
+	struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
+
+	if (!bri->skip_sda_polling)
+		gpio_free(bri->sda_gpio);
+
+	gpio_free(bri->scl_gpio);
+}
+
+static int i2c_generic_recovery(struct i2c_adapter *adap)
+{
+	struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
+	unsigned long delay = 1000000; /* 10^6/KHz for delay in ns */
+	int i, val = 0;
+
+	if (bri->prepare_recovery)
+		bri->prepare_recovery(bri);
+
+	/*
+	 * By this time SCL is high, as we need to give 9 falling-rising edges
+	 */
+
+	delay = DIV_ROUND_UP(delay, bri->clock_rate_khz * 2);
+
+	for (i = 0; i < RECOVERY_CLK_CNT * 2; i++, val = !val) {
+		bri->set_scl(adap, val);
+		ndelay(delay);
+
+		/* break if sda got high, check only when scl line is high */
+		if (!bri->skip_sda_polling && val)
+			if (unlikely(bri->get_sda(adap)))
+				break;
+	}
+
+	if (bri->unprepare_recovery)
+		bri->unprepare_recovery(bri);
+
+	return 0;
+}
+
+int i2c_generic_scl_recovery(struct i2c_adapter *adap)
+{
+	adap->bus_recovery_info->set_scl(adap, 1);
+	return i2c_generic_recovery(adap);
+}
+
+int i2c_generic_gpio_recovery(struct i2c_adapter *adap)
+{
+	int ret;
+
+	ret = i2c_get_gpios_for_recovery(adap);
+	if (ret)
+		return ret;
+
+	ret = i2c_generic_recovery(adap);
+	i2c_put_gpios_for_recovery(adap);
+
+	return ret;
+}
+
 static int i2c_device_probe(struct device *dev)
 {
 	struct i2c_client	*client = i2c_verify_client(dev);
@@ -896,6 +998,40 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 			 "Failed to create compatibility class link\n");
 #endif
 
+	/* bus recovery specific initialization */
+	if (adap->bus_recovery_info) {
+		struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
+
+		if (!bri->recover_bus) {
+			dev_err(&adap->dev, "Invalid recover_bus(), skip recovery \n");
+			adap->bus_recovery_info = NULL;
+			goto exit_recovery;
+		}
+
+		if (!bri->clock_rate_khz) {
+			dev_warn(&adap->dev, "default clk rate used: 100KHz\n");
+			bri->clock_rate_khz = DEFAULT_CLK_RATE;
+		}
+
+		/* GPIO recovery */
+		if (bri->recover_bus == i2c_generic_gpio_recovery) {
+			bri->set_scl = set_scl_gpio_value;
+
+			if (!bri->skip_sda_polling)
+				bri->get_sda = get_sda_gpio_value;
+		} else if (bri->set_scl) {
+			if (!bri->skip_sda_polling && !bri->get_sda) {
+				dev_warn(&adap->dev,
+						"!get_sda. skip sda polling\n");
+				bri->skip_sda_polling = true;
+			}
+		} else {
+			dev_warn(&adap->dev,
+					"doesn't have valid recovery type\n");
+		}
+	}
+
+exit_recovery:
 	/* create pre-declared device nodes */
 	if (adap->nr < __i2c_first_dynamic_bus_num)
 		i2c_scan_static_board_info(adap);
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 800de22..63acd9d 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -368,6 +368,51 @@ struct i2c_algorithm {
 	u32 (*functionality) (struct i2c_adapter *);
 };
 
+/**
+ * struct i2c_bus_recovery_info - I2c bus recovery information
+ * @recover_bus: Recover routine. Either pass driver's recover_bus() routine, or
+ *	i2c_generic_scl_recovery() or i2c_generic_gpio_recovery().
+ * @skip_sda_polling: if true, bus recovery will not poll sda line to check if
+ *	it became high or not. Only required if recover_bus == NULL.
+ * @clock_rate_khz: clock rate of dummy clock in khz. Required for both gpio and
+ *	scl type recovery.
+ * @set_scl: This sets/clears scl line. For GPIO recovery set_scl_gpio_value()
+ *	is used here otherwise controller specific routine must be passed.
+ * @get_sda: This gets current value of sda line. For GPIO recovery
+ *	get_sda_gpio_value() is used here otherwise controller specific routine
+ *	must be passed.
+ * @prepare_recovery: This will be called before starting recovery. Platform may
+ *	configure padmux here for sda/scl line or something else they want.
+ * @unprepare_recovery: This will be called after completing recovery. Platform
+ *	may configure padmux here for sda/scl line or something else they want.
+ * @scl_gpio: gpio number of the scl line. Only required for GPIO recovery.
+ * @sda_gpio: gpio number of the sda line. Only required for GPIO recovery.
+ */
+struct i2c_bus_recovery_info {
+	int (*recover_bus)(struct i2c_adapter *);
+	bool skip_sda_polling;
+	u32 clock_rate_khz;
+
+	/*
+	 * Fn pointers for recovery, will point either to:
+	 * - set_scl_gpio_value and get_sda_gpio_value for gpio recovery
+	 * - Controller specific routines, otherwise
+	 */
+	void (*set_scl)(struct i2c_adapter *, int val);
+	int (*get_sda)(struct i2c_adapter *);
+
+	void (*prepare_recovery)(struct i2c_bus_recovery_info *bri);
+	void (*unprepare_recovery)(struct i2c_bus_recovery_info *bri);
+
+	/* gpio recovery */
+	unsigned scl_gpio;
+	unsigned sda_gpio;
+};
+
+/* Generic recovery routines */
+int i2c_generic_gpio_recovery(struct i2c_adapter *adap);
+int i2c_generic_scl_recovery(struct i2c_adapter *adap);
+
 /*
  * i2c_adapter is the structure used to identify a physical i2c bus along
  * with the access algorithms necessary to access it.
@@ -391,6 +436,8 @@ struct i2c_adapter {
 
 	struct mutex userspace_clients_lock;
 	struct list_head userspace_clients;
+
+	struct i2c_bus_recovery_info *bus_recovery_info;
 };
 #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
 
-- 
1.7.12.rc2.18.g61b472e
