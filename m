From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V4 Resend 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Mon, 27 Aug 2012 10:41:26 +0530
Message-ID: <fce6ddd7e8061ed0f428d48973d73b75c9ae585c.1346044190.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>

Add i2c bus recovery infrastructure to i2c adapters as specified in the i2c
protocol Rev. 03 section 3.16 titled "Bus clear".

http://www.nxp.com/documents/user_manual/UM10204.pdf

Sometimes during operation i2c bus hangs and we need to give dummy clocks t=
o
slave device to start the transfer again. Now we may have capability in the=
 bus
controller to generate these clocks or platform may have gpio pins which ca=
n be
toggled to generate dummy clocks. This patch supports both.

This patch also adds in generic bus recovery routines gpio or scl line base=
d
which can be used by bus controller. In addition controller driver may prov=
ide
its own version of the bus recovery routine.

Signed-off-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
---
 drivers/i2c/i2c-core.c | 125 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 include/linux/i2c.h    |  52 ++++++++++++++++++++
 2 files changed, 177 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 96ef3d8..7ede75d 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -27,7 +27,9 @@
=20
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/delay.h>
 #include <linux/errno.h>
+#include <linux/gpio.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
@@ -104,6 +106,88 @@ static int i2c_device_uevent(struct device *dev, struc=
t kobj_uevent_env *env)
 #define i2c_device_uevent=09NULL
 #endif=09/* CONFIG_HOTPLUG */
=20
+/* i2c bus recovery routines */
+static int i2c_gpio_recover_bus(struct i2c_adapter *adap)
+{
+=09struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
+=09unsigned long delay =3D 1000000;
+=09int i, ret, val =3D 1;
+
+=09if (bri->get_gpio)
+=09=09bri->get_gpio(bri->scl_gpio);
+
+=09ret =3D gpio_request_one(bri->scl_gpio, bri->scl_gpio_flags, "i2c-scl")=
;
+=09if (ret < 0) {
+=09=09dev_warn(&adap->dev, "gpio request fail: %d\n", bri->scl_gpio);
+=09=09return ret;
+=09}
+
+=09if (!bri->skip_sda_polling) {
+=09=09if (bri->get_gpio)
+=09=09=09bri->get_gpio(bri->sda_gpio);
+
+=09=09ret =3D gpio_request_one(bri->sda_gpio, bri->sda_gpio_flags,
+=09=09=09=09"i2c-sda");
+=09=09if (ret < 0) {
+=09=09=09/* work without sda polling */
+=09=09=09dev_warn(&adap->dev,
+=09=09=09=09"sda_gpio request fail: %d. Skip sda polling\n",
+=09=09=09=09bri->scl_gpio);
+=09=09=09bri->skip_sda_polling =3D true;
+=09=09=09if (bri->put_gpio)
+=09=09=09=09bri->put_gpio(bri->sda_gpio);
+=09=09}
+=09}
+
+=09delay /=3D bri->clock_rate_khz * 2;
+
+=09for (i =3D 0; i < bri->clock_cnt * 2; i++, val =3D !val) {
+=09=09ndelay(delay);
+=09=09gpio_set_value(bri->scl_gpio, val);
+
+=09=09/* break if sda got high, check only when scl line is high */
+=09=09if (!bri->skip_sda_polling && val)
+=09=09=09if (gpio_get_value(bri->sda_gpio))
+=09=09=09=09break;
+=09}
+
+=09gpio_free(bri->scl_gpio);
+
+=09if (bri->put_gpio)
+=09=09bri->put_gpio(bri->scl_gpio);
+
+=09if (!bri->skip_sda_polling) {
+=09=09gpio_free(bri->sda_gpio);
+
+=09=09if (bri->put_gpio)
+=09=09=09bri->put_gpio(bri->sda_gpio);
+=09}
+
+=09return 0;
+}
+
+static int i2c_scl_recover_bus(struct i2c_adapter *adap)
+{
+=09struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
+=09int i, val =3D 0;
+=09unsigned long delay =3D 1000000;
+
+=09delay /=3D bri->clock_rate_khz * 2;
+
+=09for (i =3D 0; i < bri->clock_cnt * 2; i++,
+=09=09=09val =3D !val) {
+=09=09bri->set_scl(adap, val);
+=09=09ndelay(delay);
+
+=09=09/* break if sda got high, check only when scl line is high */
+=09=09if (!bri->skip_sda_polling && val)
+=09=09=09if (bri->get_sda(adap))
+=09=09=09=09break;
+=09}
+
+=09return 0;
+}
+
 static int i2c_device_probe(struct device *dev)
 {
 =09struct i2c_client=09*client =3D i2c_verify_client(dev);
@@ -879,6 +963,47 @@ static int i2c_register_adapter(struct i2c_adapter *ad=
ap)
 =09=09=09 "Failed to create compatibility class link\n");
 #endif
=20
+=09/* bus recovery specific initialization */
+=09if (adap->bus_recovery_info) {
+=09=09struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
+
+=09=09if (bri->recover_bus) {
+=09=09=09dev_info(&adap->dev,
+=09=09=09=09"registered for non-generic bus recovery\n");
+=09=09} else {
+=09=09=09/* Use generic recovery routines */
+=09=09=09if (!bri->clock_rate_khz) {
+=09=09=09=09dev_warn(&adap->dev,
+=09=09=09=09=09"doesn't have valid recovery clock rate\n");
+=09=09=09=09goto exit_recovery;
+=09=09=09}
+
+=09=09=09/* Most controller need 9 clocks at max */
+=09=09=09if (!bri->clock_cnt)
+=09=09=09=09bri->clock_cnt =3D 9;
+
+=09=09=09if (bri->is_gpio_recovery) {
+=09=09=09=09bri->recover_bus =3D i2c_gpio_recover_bus;
+=09=09=09=09dev_info(&adap->dev,
+=09=09=09=09=09"registered for gpio bus recovery\n");
+=09=09=09} else if (bri->set_scl) {
+=09=09=09=09if (!bri->skip_sda_polling && !bri->get_sda) {
+=09=09=09=09=09dev_warn(&adap->dev,
+=09=09=09=09=09=09"!get_sda. skip sda polling\n");
+=09=09=09=09=09bri->skip_sda_polling =3D true;
+=09=09=09=09}
+
+=09=09=09=09bri->recover_bus =3D i2c_scl_recover_bus;
+=09=09=09=09dev_info(&adap->dev,
+=09=09=09=09=09"registered for scl bus recovery\n");
+=09=09=09} else {
+=09=09=09=09dev_warn(&adap->dev,
+=09=09=09=09=09"doesn't have valid recovery type\n");
+=09=09=09}
+=09=09}
+=09}
+
+exit_recovery:
 =09/* create pre-declared device nodes */
 =09if (adap->nr < __i2c_first_dynamic_bus_num)
 =09=09i2c_scan_static_board_info(adap);
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 5970266..9e0a14a 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -370,6 +370,55 @@ struct i2c_algorithm {
 =09u32 (*functionality) (struct i2c_adapter *);
 };
=20
+/**
+ * struct i2c_bus_recovery_info - I2c bus recovery information
+ * @recover_bus: Recover routine. Either pass driver's recover_bus() routi=
ne, or
+ *=09pass it NULL to use generic ones, i.e. gpio or scl based.
+ * @skip_sda_polling: if true, bus recovery will not poll sda line to chec=
k if
+ *=09it became high or not. Only required if recover_bus =3D=3D NULL.
+ * @is_gpio_recovery: true, select gpio type else scl type. Only required =
if
+ *=09recover_bus =3D=3D NULL.
+ * @clock_rate_khz: clock rate of dummy clock in khz. Required for both gp=
io and
+ *=09scl type recovery.
+ * @clock_cnt: count of max clocks to be generated. Required for both gpio=
 and
+ *=09scl type recovery.
+ * @set_scl: controller specific scl configuration routine. Only required =
if
+ *=09is_gpio_recovery =3D=3D false
+ * @get_sda: controller specific sda read routine. Only required if
+ *=09is_gpio_recovery =3D=3D false and skip_sda_polling =3D=3D false.
+ * @get_gpio: called before recover_bus() to get padmux configured for scl=
 line.
+ *=09as gpio. Only required if is_gpio_recovery =3D=3D true.
+ * @put_gpio: called after recover_bus() to get padmux configured for scl =
line
+ *=09as scl. Only required if is_gpio_recovery =3D=3D true.
+ * @scl_gpio: gpio number of the scl line. Only required if is_gpio_recove=
ry =3D=3D
+ *=09true.
+ * @sda_gpio: gpio number of the sda line. Only required if is_gpio_recove=
ry =3D=3D
+ *=09true and skip_sda_polling =3D=3D false.
+ * @scl_gpio_flags: flag for gpio_request_one of scl_gpio. 0 implies
+ *=09GPIOF_OUT_INIT_LOW.
+ * @sda_gpio_flags: flag for gpio_request_one of sda_gpio. 0 implies
+ *=09GPIOF_OUT_INIT_LOW.
+ */
+struct i2c_bus_recovery_info {
+=09int (*recover_bus)(struct i2c_adapter *);
+=09bool skip_sda_polling;
+=09bool is_gpio_recovery;
+=09u32 clock_rate_khz;
+=09u8 clock_cnt;
+
+=09/* scl/sda recovery */
+=09void (*set_scl)(struct i2c_adapter *, int val);
+=09int (*get_sda)(struct i2c_adapter *);
+
+=09/* gpio recovery */
+=09int (*get_gpio)(unsigned gpio);
+=09int (*put_gpio)(unsigned gpio);
+=09u32 scl_gpio;
+=09u32 sda_gpio;
+=09u32 scl_gpio_flags;
+=09u32 sda_gpio_flags;
+};
+
 /*
  * i2c_adapter is the structure used to identify a physical i2c bus along
  * with the access algorithms necessary to access it.
@@ -393,6 +442,9 @@ struct i2c_adapter {
=20
 =09struct mutex userspace_clients_lock;
 =09struct list_head userspace_clients;
+
+=09/* Pass valid pointer if recovery infrastructure is required */
+=09struct i2c_bus_recovery_info *bus_recovery_info;
 };
 #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
=20
--=20
1.7.12.rc2.18.g61b472e
