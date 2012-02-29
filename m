From: viresh kumar <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c/designware: Provide optional i2c bus recovery function
Date: Wed, 29 Feb 2012 23:28:21 +0530
Message-ID: <CAOh2x=nS39yhfUcQtCUF5Hz1axCjdPdueWok4jMHq_rTFpRq9Q@mail.gmail.com>
References: <0ca1d8990c23a45193a32d0e7e889620b995af59.1330082915.git.viresh.kumar@st.com>
	<351031347b845920a0ea78e7491d955137e3d7aa.1330082915.git.viresh.kumar@st.com>
	<CAM=Q2cudYcSqAKk4qNg7MQxRBCkJ-XXXSL-Bg=sZ2+hvS_Qcxw@mail.gmail.com>
	<4F4B3072.6050903@nvidia.com>
	<CAM=Q2cs-nCuSmkBFtv4odbqoRJcPkXk4Rz-H=9S6RDG3Z8kcEQ@mail.gmail.com>
	<4F4B569F.3080607@st.com>
	<4F4B5A9A.4050303@st.com>
	<CAOh2x=nfNGpBmHVd1bPT9+AezDMEjaC4ktj4hX9=yWg2_k7r3Q@mail.gmail.com>
	<4F4E118B.2030403@nvidia.com>
	<4F4E12D9.90909@st.com>
	<4F4E1797.7010503@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F4E1797.7010503-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>, Rajeev KUMAR <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Armando VISCONTI <armando.visconti-qxv4g6HH51o@public.gmane.org>, Shiraz HASHIM <shiraz.hashim-qxv4g6HH51o@public.gmane.org>, Vipin KUMAR <vipin.kumar-qxv4g6HH51o@public.gmane.org>, Deepak SIKRI <deepak.sikri-qxv4g6HH51o@public.gmane.org>, Vipul Kumar SAMAR <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>, Amit VIRDI <Amit.VIRDI-qxv4g6HH51o@public.gmane.org>, Pratyush ANAND <pratyush.anand-qxv4g6HH51o@public.gmane.org>, Bhupesh SHARMA <bhupesh.sharma-qxv4g6HH51o@public.gmane.org>, Bhavna YADAV <bhavna.yadav-qxv4g6HH51o@public.gmane.org>, Vincenzo FRASCINO <Vincenzo.FRASCINO-qxv4g6HH51o@public.gmane.org>, Mirko GARDI <mirko.gardi-qxv4g6HH51o@public.gmane.org>, Salvatore DE DOMINICIS <salvatore.dedominicis-qxv4g6HH51o@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 2/29/12, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:

Here is V2:

From: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Date: Tue, 28 Feb 2012 18:26:31 +0530
Subject: [PATCH] i2c/adapter: Add bus recovery infrastructure

Add i2c bus recovery infrastructure to i2c adapters as specified in the i2c
protocol Rev. 03 section 3.16 titled "Bus clear".

Sometimes during operation i2c bus hangs and we need to give dummy clocks to
slave device to start the transfer again. Now we may have capability in the bus
controller to generate these clocks or platform may have gpio pins which can be
toggled to generate dummy clocks.

This patch also adds in generic bus recovery routines gpio or scl line based
which can be used by bus controller. In addition controller driver may provide
its own version of the bus recovery routine.

Signed-off-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
---
 drivers/i2c/i2c-core.c |   85 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c.h    |   32 ++++++++++++++++++
 2 files changed, 117 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index e9c1893..1d2c8a0 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -26,7 +26,9 @@

 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/delay.h>
 #include <linux/errno.h>
+#include <linux/gpio.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
@@ -103,6 +105,54 @@ static int i2c_device_uevent(struct device *dev,
struct kobj_uevent_env *env)
 #define i2c_device_uevent	NULL
 #endif	/* CONFIG_HOTPLUG */

+/* i2c bus recovery routines */
+static int i2c_gpio_recover_bus(struct i2c_adapter *adap)
+{
+	int i, ret, val = 1, gpio = adap->bus_recovery_info->gpio;
+	unsigned long delay = 1000000;
+
+	if (adap->bus_recovery_info->get_gpio)
+		adap->bus_recovery_info->get_gpio(gpio);
+
+	ret = gpio_request_one(gpio, GPIOF_DIR_OUT |
+			GPIOF_INIT_LOW, "i2c-bus-recover");
+	if (ret < 0) {
+		dev_warn(&adap->dev, "gpio request one fail: %d\n", gpio);
+		return ret;
+	}
+
+	delay /= adap->bus_recovery_info->clock_rate_khz * 2;
+
+	for (i = 0; i < adap->bus_recovery_info->clock_cnt * 2;
+			i++, val = !val) {
+		ndelay(delay);
+		gpio_set_value(gpio, val);
+	}
+
+	gpio_free(adap->bus_recovery_info->clock_cnt);
+
+	if (adap->bus_recovery_info->put_gpio)
+		adap->bus_recovery_info->put_gpio(gpio);
+
+	return 0;
+}
+
+static int i2c_scl_recover_bus(struct i2c_adapter *adap)
+{
+	int i, val = 0;
+	unsigned long delay = 1000000;
+
+	delay /= adap->bus_recovery_info->clock_rate_khz * 2;
+
+	for (i = 0; i < adap->bus_recovery_info->clock_cnt * 2; i++,
+			val = !val) {
+		adap->bus_recovery_info->set_scl(adap, val);
+		ndelay(delay);
+	}
+
+	return 0;
+}
+
 static int i2c_device_probe(struct device *dev)
 {
 	struct i2c_client	*client = i2c_verify_client(dev);
@@ -861,6 +911,41 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 			 "Failed to create compatibility class link\n");
 #endif

+	/* bus recovery specific initialization */
+	if (adap->bus_recovery_info) {
+		if (adap->bus_recovery_info->recover_bus) {
+			dev_info(&adap->dev,
+				"registered for non-generic bus recovery\n");
+		} else {
+			/* Use generic recovery routines */
+			if (!adap->bus_recovery_info->clock_rate_khz) {
+				dev_warn(&adap->dev,
+					"doesn't have valid recovery clock rate\n");
+				goto exit_recovery;
+			}
+
+			/* Most controller need 9 clocks at max */
+			if (!adap->bus_recovery_info->clock_cnt)
+				adap->bus_recovery_info->clock_cnt = 9;
+
+			if (adap->bus_recovery_info->is_gpio_recovery) {
+				adap->bus_recovery_info->recover_bus =
+					i2c_gpio_recover_bus;
+				dev_info(&adap->dev,
+					"registered for gpio bus recovery\n");
+			} else if (adap->bus_recovery_info->set_scl) {
+				adap->bus_recovery_info->recover_bus =
+					i2c_scl_recover_bus;
+				dev_info(&adap->dev,
+					"registered for scl bus recovery\n");
+			} else {
+				dev_warn(&adap->dev,
+					"doesn't have valid recovery routine\n");
+			}
+		}
+	}
+
+exit_recovery:
 	/* create pre-declared device nodes */
 	if (adap->nr < __i2c_first_dynamic_bus_num)
 		i2c_scan_static_board_info(adap);
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 8e25a91..ee2d954 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -365,6 +365,35 @@ struct i2c_algorithm {
 	u32 (*functionality) (struct i2c_adapter *);
 };

+/**
+ * struct i2c_bus_recovery_info - I2c bus recovery information
+ * @recover_bus: Recover routine. Either pass driver's recover_bus()
routine, or
+ *	pass it NULL to use generic ones, i.e. gpio or scl based.
+ * @is_gpio_recovery: true, select gpio type else scl type. Only required if
+ *	recover_bus == NULL
+ * @set_scl: controller specific scl configuration routine. Only required if
+ *	is_gpio_recovery == false
+ * @get_gpio: called before recover_bus() to get padmux configured for scl line
+ *	as gpio. Only required if is_gpio_recovery == true
+ * @put_gpio: called after recover_bus() to get padmux configured for scl line
+ *	as scl. Only required if is_gpio_recovery == true
+ * @gpio: gpio number of the scl line. Only required if
is_gpio_recovery == true
+ * @clock_rate_khz: clock rate of dummy clock in khz. Required for
both gpio and
+ *	scl type recovery.
+ * @clock_cnt: count of max clocks to be generated. Required for both gpio and
+ *	scl type recovery.
+ */
+struct i2c_bus_recovery_info {
+	int (*recover_bus)(struct i2c_adapter *);
+	bool is_gpio_recovery;
+	void (*set_scl)(struct i2c_adapter *, int val);
+	int (*get_gpio)(unsigned gpio);
+	int (*put_gpio)(unsigned gpio);
+	u32 gpio;
+	u32 clock_rate_khz;
+	u8 clock_cnt;
+};
+
 /*
  * i2c_adapter is the structure used to identify a physical i2c bus along
  * with the access algorithms necessary to access it.
@@ -388,6 +417,9 @@ struct i2c_adapter {

 	struct mutex userspace_clients_lock;
 	struct list_head userspace_clients;
+
+	/* Pass valid pointer if recovery infrastructure is required */
+	struct i2c_bus_recovery_info *bus_recovery_info;
 };
 #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)


--
viresh
