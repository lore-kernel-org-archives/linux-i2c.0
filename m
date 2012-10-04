From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V6 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Thu,  4 Oct 2012 16:34:53 +0530
Message-ID: <9adb13c1a2e35dce401b0a50e455fe1be76285a7.1349348405.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add i2c bus recovery infrastructure to i2c adapters as specified in the i2c
protocol Rev. 03 section 3.1.16 titled "Bus clear".

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

This doesn't support multi-master recovery for now.

Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
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

 drivers/i2c/i2c-core.c | 156 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 include/linux/i2c.h    |  55 +++++++++++++++++
 2 files changed, 211 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index a7edf98..e78033b 100644
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
@@ -104,6 +106,111 @@ static int i2c_device_uevent(struct device *dev, stru=
ct kobj_uevent_env *env)
 #define i2c_device_uevent=09NULL
 #endif=09/* CONFIG_HOTPLUG */
=20
+/* i2c bus recovery routines */
+static void set_scl_gpio_value(struct i2c_adapter *adap, int val)
+{
+=09gpio_set_value(adap->bus_recovery_info->scl_gpio, val);
+}
+
+static int get_sda_gpio_value(struct i2c_adapter *adap)
+{
+=09return gpio_get_value(adap->bus_recovery_info->sda_gpio);
+}
+
+static int i2c_get_gpios_for_recovery(struct i2c_adapter *adap)
+{
+=09struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
+=09struct device *dev =3D &adap->dev;
+=09int ret =3D 0;
+
+=09if (bri->get_gpio) {
+=09=09ret =3D bri->get_gpio(bri->scl_gpio);
+=09=09if (ret) {
+=09=09=09dev_warn(dev, "scl get_gpio: %d\n", bri->scl_gpio);
+=09=09=09return ret;
+=09=09}
+=09}
+
+=09ret =3D gpio_request_one(bri->scl_gpio, bri->scl_gpio_flags, "i2c-scl")=
;
+=09if (ret) {
+=09=09dev_warn(dev, "gpio request fail: %d\n", bri->scl_gpio);
+=09=09goto scl_put_gpio;
+=09}
+
+=09if (!bri->skip_sda_polling) {
+=09=09if (bri->get_gpio)
+=09=09=09ret =3D bri->get_gpio(bri->sda_gpio);
+
+=09=09if (unlikely(ret ||
+=09=09=09gpio_request_one(bri->sda_gpio, GPIOF_IN, "i2c-sda"))) {
+=09=09=09/* work without sda polling */
+=09=09=09dev_warn(dev, "can't get sda: %d. Skip sda polling\n",
+=09=09=09=09=09bri->sda_gpio);
+=09=09=09bri->skip_sda_polling =3D true;
+=09=09=09if (!ret && bri->put_gpio)
+=09=09=09=09bri->put_gpio(bri->sda_gpio);
+
+=09=09=09ret =3D 0;
+=09=09}
+=09}
+
+scl_put_gpio:
+=09if (bri->put_gpio)
+=09=09bri->put_gpio(bri->scl_gpio);
+
+=09return ret;
+}
+
+static void i2c_put_gpios_for_recovery(struct i2c_adapter *adap)
+{
+=09struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
+
+=09gpio_free(bri->scl_gpio);
+
+=09if (!bri->skip_sda_polling) {
+=09=09gpio_free(bri->sda_gpio);
+
+=09=09if (bri->put_gpio)
+=09=09=09bri->put_gpio(bri->sda_gpio);
+=09}
+}
+
+static int i2c_recover_bus(struct i2c_adapter *adap)
+{
+=09struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
+=09unsigned long delay =3D 1000000;
+=09int i, ret, val =3D 0;
+
+=09if (bri->is_gpio_recovery) {
+=09=09ret =3D i2c_get_gpios_for_recovery(adap);
+=09=09if (ret)
+=09=09=09return ret;
+=09} else {
+=09=09bri->set_scl(adap, 1);
+=09}
+
+=09/*
+=09 * By this time SCL is high, as we need to give 9 falling-rising edges
+=09 */
+
+=09delay =3D DIV_ROUND_UP(delay, bri->clock_rate_khz * 2);
+
+=09for (i =3D 0; i < bri->clock_cnt * 2; i++, val =3D !val) {
+=09=09bri->set_scl(adap, val);
+=09=09ndelay(delay);
+
+=09=09/* break if sda got high, check only when scl line is high */
+=09=09if (!bri->skip_sda_polling && val)
+=09=09=09if (unlikely(bri->get_sda(adap)))
+=09=09=09=09break;
+=09}
+
+=09if (bri->is_gpio_recovery)
+=09=09i2c_put_gpios_for_recovery(adap);
+
+=09return 0;
+}
+
 static int i2c_device_probe(struct device *dev)
 {
 =09struct i2c_client=09*client =3D i2c_verify_client(dev);
@@ -896,6 +1003,55 @@ static int i2c_register_adapter(struct i2c_adapter *a=
dap)
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
+=09=09=09bri->recover_bus =3D i2c_recover_bus;
+
+=09=09=09if (bri->is_gpio_recovery) {
+=09=09=09=09if (!bri->scl_gpio_flags)
+=09=09=09=09=09bri->scl_gpio_flags =3D GPIOF_OPEN_DRAIN;
+
+=09=09=09=09/* We always start by making GPIO HIGH */
+=09=09=09=09bri->scl_gpio_flags |=3D GPIOF_OUT_INIT_HIGH;
+
+=09=09=09=09bri->set_scl =3D set_scl_gpio_value;
+=09=09=09=09bri->get_sda =3D get_sda_gpio_value;
+=09=09=09=09dev_info(&adap->dev,
+=09=09=09=09=09"registered for gpio bus recovery\n");
+=09=09=09} else if (bri->set_scl) {
+=09=09=09=09if (!bri->skip_sda_polling && !bri->get_sda) {
+=09=09=09=09=09dev_warn(&adap->dev,
+=09=09=09=09=09=09"!get_sda. skip sda polling\n");
+=09=09=09=09=09bri->skip_sda_polling =3D true;
+=09=09=09=09}
+
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
index 5970266..13eeb2e 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -370,6 +370,58 @@ struct i2c_algorithm {
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
+ * @set_scl: controller specific routine, if is_gpio_recovery =3D=3D false=
.
+ *       set_scl_gpio_value otherwise
+ * @get_sda: controller specific routine, if is_gpio_recovery =3D=3D false=
.
+ *       get_sda_gpio_value otherwise
+ * @get_gpio: called before recover_bus() to get padmux configured for scl=
 line.
+ *=09as gpio. Only required if is_gpio_recovery =3D=3D true. Return 0 on s=
uccess.
+ * @put_gpio: called after recover_bus() to get padmux configured for scl =
line
+ *=09as scl. Only required if is_gpio_recovery =3D=3D true.
+ * @scl_gpio: gpio number of the scl line. Only required if is_gpio_recove=
ry =3D=3D
+ *=09true.
+ * @sda_gpio: gpio number of the sda line. Only required if is_gpio_recove=
ry =3D=3D
+ *=09true and skip_sda_polling =3D=3D false.
+ * @scl_gpio_flags: flag for gpio_request_one of scl_gpio. If passed as 0,
+ *      (GPIOF_OPEN_DRAIN | GPIOF_OUT_INIT_HIGH) is used instead. Otherwis=
e, it
+ *      is ORRED with GPIOF_OUT_INIT_HIGH.
+ *      These is no need of sda_gpio_flags, as we always read it in input =
mode.
+ */
+struct i2c_bus_recovery_info {
+=09int (*recover_bus)(struct i2c_adapter *);
+=09bool skip_sda_polling;
+=09bool is_gpio_recovery;
+=09u32 clock_rate_khz;
+=09u8 clock_cnt;
+
+=09/*
+=09 * Fn pointers for recovery, will point either to:
+=09 * - set_scl_gpio_value and get_sda_gpio_value for gpio recovery
+=09 * - Controller specific routines, otherwise
+=09 */
+=09void (*set_scl)(struct i2c_adapter *, int val);
+=09int (*get_sda)(struct i2c_adapter *);
+
+=09/* gpio recovery */
+=09int (*get_gpio)(unsigned gpio);
+=09void (*put_gpio)(unsigned gpio);
+=09unsigned scl_gpio;
+=09unsigned sda_gpio;
+=09unsigned long scl_gpio_flags;
+};
+
 /*
  * i2c_adapter is the structure used to identify a physical i2c bus along
  * with the access algorithms necessary to access it.
@@ -393,6 +445,9 @@ struct i2c_adapter {
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
