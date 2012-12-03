From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V6 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Mon, 3 Dec 2012 08:17:46 +0530
Message-ID: <CAKohponVHENLBQ3u844ufSN8F0zco=nqs1GpNLteo8whK29Nfg@mail.gmail.com>
References: <9adb13c1a2e35dce401b0a50e455fe1be76285a7.1349348405.git.viresh.kumar@linaro.org>
	<20121124205931.GB3210@pengutronix.de>
	<CAKohpokLD60N087_ae8-JY-4b4Opn+OrTErt0MwFsTgnSwFb0w@mail.gmail.com>
	<20121130141129.GG23231@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121130141129.GG23231-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Paul Carpenter <paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org>
Cc: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram/Paul,

I have tried to fix my patches as per review comments from you.
Following is diff of the new changes i have made, I am sending a
new complete version separately:

commit 62cf40359c63ac028b3e8a6395f9440f6a3b0162
Author: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Date:   Mon Dec 3 08:12:55 2012 +0530

    fixup! i2c/adapter: Add bus recovery infrastructure
---
 drivers/i2c/i2c-core.c | 42 +++++++++++++++++++++++++++---------------
 include/linux/i2c.h    | 19 +++++++++++--------
 2 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index d100276..9b6a1a6 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -109,15 +109,22 @@ static int i2c_device_uevent(struct device *dev,
struct kobj_uevent_env *env)
 /* i2c bus recovery routines */
 #define RECOVERY_CLK_CNT       9
 #define DEFAULT_CLK_RATE       100     /* KHz */
+/* 10^6/KHz for delay in ns */
+unsigned long clk_delay = DIV_ROUND_UP(1000000, DEFAULT_CLK_RATE * 2);

-static void set_scl_gpio_value(struct i2c_adapter *adap, int val)
+static int get_sda_gpio_value(struct i2c_adapter *adap)
 {
-       gpio_set_value(adap->bus_recovery_info->scl_gpio, val);
+       return gpio_get_value(adap->bus_recovery_info->sda_gpio);
 }

-static int get_sda_gpio_value(struct i2c_adapter *adap)
+static int get_scl_gpio_value(struct i2c_adapter *adap)
 {
-       return gpio_get_value(adap->bus_recovery_info->sda_gpio);
+       return gpio_get_value(adap->bus_recovery_info->scl_gpio);
+}
+
+static void set_scl_gpio_value(struct i2c_adapter *adap, int val)
+{
+       gpio_set_value(adap->bus_recovery_info->scl_gpio, val);
 }

 static int i2c_get_gpios_for_recovery(struct i2c_adapter *adap)
@@ -158,28 +165,37 @@ static void i2c_put_gpios_for_recovery(struct
i2c_adapter *adap)
 static int i2c_generic_recovery(struct i2c_adapter *adap)
 {
        struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
-       unsigned long delay = 1000000; /* 10^6/KHz for delay in ns */
        int i, val = 0;

        if (bri->prepare_recovery)
                bri->prepare_recovery(bri);

+       /* SCL shouldn't be low here */
+       if (!bri->get_scl(adap)) {
+               dev_err(&adap->dev, "SCL is stuck Low, exiting recovery.\n");
+               goto unprepare;
+       }
+
        /*
         * By this time SCL is high, as we need to give 9 falling-rising edges
         */
-
-       delay = DIV_ROUND_UP(delay, bri->clock_rate_khz * 2);
-
        for (i = 0; i < RECOVERY_CLK_CNT * 2; i++, val = !val) {
                bri->set_scl(adap, val);
-               ndelay(delay);
+               ndelay(clk_delay);

                /* break if sda got high, check only when scl line is high */
                if (!bri->skip_sda_polling && val)
-                       if (unlikely(bri->get_sda(adap)))
+                       /* Check SCL again to see fault condition */
+                       if (!bri->get_scl(adap)) {
+                               dev_err(&adap->dev, "SCL is stuck Low
during recovery, exiting recovery.\n");
+                               goto unprepare;
+                       }
+
+                       if (bri->get_sda(adap))
                                break;
        }

+unprepare:
        if (bri->unprepare_recovery)
                bri->unprepare_recovery(bri);

@@ -1008,13 +1024,9 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
                        goto exit_recovery;
                }

-               if (!bri->clock_rate_khz) {
-                       dev_warn(&adap->dev, "default clk rate used: 100KHz\n");
-                       bri->clock_rate_khz = DEFAULT_CLK_RATE;
-               }
-
                /* GPIO recovery */
                if (bri->recover_bus == i2c_generic_gpio_recovery) {
+                       bri->get_scl = get_scl_gpio_value;
                        bri->set_scl = set_scl_gpio_value;

                        if (!bri->skip_sda_polling)
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 63acd9d..165282f 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -373,14 +373,17 @@ struct i2c_algorithm {
  * @recover_bus: Recover routine. Either pass driver's recover_bus()
routine, or
  *     i2c_generic_scl_recovery() or i2c_generic_gpio_recovery().
  * @skip_sda_polling: if true, bus recovery will not poll sda line to check if
- *     it became high or not. Only required if recover_bus == NULL.
- * @clock_rate_khz: clock rate of dummy clock in khz. Required for
both gpio and
- *     scl type recovery.
- * @set_scl: This sets/clears scl line. For GPIO recovery set_scl_gpio_value()
- *     is used here otherwise controller specific routine must be passed.
+ *     it became high or not. Platforms/controllers which don't have
+ *     configuration registers to control sda line must set this. Only required
+ *     if recover_bus == NULL.
  * @get_sda: This gets current value of sda line. For GPIO recovery
  *     get_sda_gpio_value() is used here otherwise controller specific routine
  *     must be passed.
+ * @get_scl: This gets current value of scl line. For GPIO recovery
+ *     get_scl_gpio_value() is used here otherwise controller specific routine
+ *     must be passed.
+ * @set_scl: This sets/clears scl line. For GPIO recovery set_scl_gpio_value()
+ *     is used here otherwise controller specific routine must be passed.
  * @prepare_recovery: This will be called before starting recovery.
Platform may
  *     configure padmux here for sda/scl line or something else they want.
  * @unprepare_recovery: This will be called after completing recovery. Platform
@@ -391,15 +394,15 @@ struct i2c_algorithm {
 struct i2c_bus_recovery_info {
        int (*recover_bus)(struct i2c_adapter *);
        bool skip_sda_polling;
-       u32 clock_rate_khz;

        /*
         * Fn pointers for recovery, will point either to:
-        * - set_scl_gpio_value and get_sda_gpio_value for gpio recovery
+        * - set_scl_gpio_value and get_[scl]sda_gpio_value for gpio recovery
         * - Controller specific routines, otherwise
         */
-       void (*set_scl)(struct i2c_adapter *, int val);
        int (*get_sda)(struct i2c_adapter *);
+       int (*get_scl)(struct i2c_adapter *);
+       void (*set_scl)(struct i2c_adapter *, int val);

        void (*prepare_recovery)(struct i2c_bus_recovery_info *bri);
        void (*unprepare_recovery)(struct i2c_bus_recovery_info *bri);
