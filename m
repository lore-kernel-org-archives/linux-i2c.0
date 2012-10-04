From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V5 Resend 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Thu, 4 Oct 2012 16:07:42 +0530
Message-ID: <CAKohpokJuCKPXm9YpnOt1SRAMfXL7TX2P5Xe_fDe3WRhv11Bgg@mail.gmail.com>
References: <viresh.kumar@linaro.org>
	<d5eaf5302de6a2ba01d1c11abeeed8850be879be.1348831273.git.viresh.kumar@linaro.org>
	<20121004080051.GG598@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121004080051.GG598-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 4 October 2012 13:30, Uwe Kleine-K=F6nig
<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:

Hi Uwe,

Please see if following fixup looks fine to you:


    fixup! i2c/adapter: Add bus recovery infrastructure
---
 drivers/i2c/i2c-core.c | 33 ++++++++++++++-------------------
 include/linux/i2c.h    | 22 ++++++++++++----------
 2 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index bdc249a..393d5f7 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -107,24 +107,14 @@ static int i2c_device_uevent(struct device *dev,
struct kobj_uevent_env *env)
 #endif /* CONFIG_HOTPLUG */

 /* i2c bus recovery routines */
-static inline void set_scl_value(struct i2c_adapter *adap, int val)
+static void set_scl_gpio_value(struct i2c_adapter *adap, int val)
 {
-       struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
-
-       if (bri->is_gpio_recovery)
-               gpio_set_value(bri->scl_gpio, val);
-       else
-               bri->set_scl(adap, val);
+       gpio_set_value(adap->bus_recovery_info->scl_gpio, val);
 }

-static inline int get_sda_value(struct i2c_adapter *adap)
+static int get_sda_gpio_value(struct i2c_adapter *adap)
 {
-       struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
-
-       if (bri->is_gpio_recovery)
-               return gpio_get_value(bri->sda_gpio);
-       else
-               return bri->get_sda(adap);
+       return gpio_get_value(adap->bus_recovery_info->sda_gpio);
 }

 static int i2c_get_gpios_for_recovery(struct i2c_adapter *adap)
@@ -152,8 +142,7 @@ static int i2c_get_gpios_for_recovery(struct
i2c_adapter *adap)
                        ret =3D bri->get_gpio(bri->sda_gpio);

                if (unlikely(ret ||
-                       gpio_request_one(bri->sda_gpio, bri->sda_gpio_f=
lags,
-                               "i2c-sda"))) {
+                       gpio_request_one(bri->sda_gpio, GPIOF_IN, "i2c-=
sda"))) {
                        /* work without sda polling */
                        dev_warn(dev, "can't get sda: %d. Skip sda poll=
ing\n",
                                        bri->sda_gpio);
@@ -190,7 +179,7 @@ static int i2c_recover_bus(struct i2c_adapter *adap=
)
 {
        struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
        unsigned long delay =3D 1000000;
-       int i, ret, val =3D 1;
+       int i, ret, val =3D 0;

        if (bri->is_gpio_recovery) {
                ret =3D i2c_get_gpios_for_recovery(adap);
@@ -201,12 +190,12 @@ static int i2c_recover_bus(struct i2c_adapter *ad=
ap)
        delay =3D DIV_ROUND_UP(delay, bri->clock_rate_khz * 2);

        for (i =3D 0; i < bri->clock_cnt * 2; i++, val =3D !val) {
-               set_scl_value(adap, val);
+               bri->set_scl(adap, val);
                ndelay(delay);

                /* break if sda got high, check only when scl line is h=
igh */
                if (!bri->skip_sda_polling && val)
-                       if (unlikely(get_sda_value(adap)))
+                       if (unlikely(bri->get_sda(adap)))
                                break;
        }

@@ -1030,6 +1019,12 @@ static int i2c_register_adapter(struct i2c_adapt=
er *adap)
                        bri->recover_bus =3D i2c_recover_bus;

                         if (bri->is_gpio_recovery) {
+                               if (!bri->scl_gpio_flags)
+                                       bri->scl_gpio_flags =3D GPIOF_O=
PEN_DRAIN |
+                                               GPIOF_OUT_INIT_HIGH;
+
+                               bri->set_scl =3D set_scl_gpio_value;
+                               bri->get_sda =3D get_sda_gpio_value;
                                dev_info(&adap->dev,
                                        "registered for gpio bus recove=
ry\n");
                        } else if (bri->set_scl) {
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index c43e5c4..dd470a1 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -382,10 +382,10 @@ struct i2c_algorithm {
  *     scl type recovery.
  * @clock_cnt: count of max clocks to be generated. Required for both =
gpio and
  *     scl type recovery.
- * @set_scl: controller specific scl configuration routine. Only requi=
red if
- *     is_gpio_recovery =3D=3D false
- * @get_sda: controller specific sda read routine. Only required if
- *     is_gpio_recovery =3D=3D false and skip_sda_polling =3D=3D false=
=2E
+ * @set_scl: controller specific routine, if is_gpio_recovery =3D=3D f=
alse.
+ *       set_scl_gpio_value otherwise
+ * @get_sda: controller specific routine, if is_gpio_recovery =3D=3D f=
alse.
+ *       get_sda_gpio_value otherwise
  * @get_gpio: called before recover_bus() to get padmux configured
for scl line.
  *     as gpio. Only required if is_gpio_recovery =3D=3D true. Return =
0 on success.
  * @put_gpio: called after recover_bus() to get padmux configured for =
scl line
@@ -394,10 +394,9 @@ struct i2c_algorithm {
  *     true.
  * @sda_gpio: gpio number of the sda line. Only required if is_gpio_re=
covery =3D=3D
  *     true and skip_sda_polling =3D=3D false.
- * @scl_gpio_flags: flag for gpio_request_one of scl_gpio. 0 implies
- *     GPIOF_OUT_INIT_LOW.
- * @sda_gpio_flags: flag for gpio_request_one of sda_gpio. 0 implies
- *     GPIOF_OUT_INIT_LOW.
+ * @scl_gpio_flags: flag for gpio_request_one of scl_gpio. If passed a=
s 0,
+ *      (GPIOF_OPEN_DRAIN | GPIOF_OUT_INIT_HIGH) is used instead.
+ *      These is no need of sda_gpio_flags, as we always read it in in=
put mode.
  */
 struct i2c_bus_recovery_info {
        int (*recover_bus)(struct i2c_adapter *);
@@ -406,7 +405,11 @@ struct i2c_bus_recovery_info {
        u32 clock_rate_khz;
        u8 clock_cnt;

-       /* scl/sda recovery */
+       /*
+        * Fn pointers for recovery, will point either to:
+        * - set_scl_gpio_value and get_sda_gpio_value for gpio recover=
y
+        * - Controller specific routines, otherwise
+        */
        void (*set_scl)(struct i2c_adapter *, int val);
        int (*get_sda)(struct i2c_adapter *);

@@ -416,7 +419,6 @@ struct i2c_bus_recovery_info {
        unsigned scl_gpio;
        unsigned sda_gpio;
        unsigned long scl_gpio_flags;
-       unsigned long sda_gpio_flags;
 };

 /*
