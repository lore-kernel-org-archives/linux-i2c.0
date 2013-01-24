From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V9 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Thu, 24 Jan 2013 16:06:37 +0530
Message-ID: <fe4fba74b7bac4fe56e26b2a947280390182c66c.1359023434.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
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

Reviewed-by: Paul Carpenter <paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org>
Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
Most number of versions for any patchset i submitted :)

V8->V9:
- removed skip_sda_polling variable
- simplified/fixed i2c_generic_recovery() routine
- added new routine i2c_recover_bus()
- added gpio_is_valid() checks over scl and sda gpios
- code is rearranged at places (based on Wolfram's comments)

 drivers/i2c/i2c-core.c | 155 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 include/linux/i2c.h    |  39 +++++++++++++
 2 files changed, 194 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index e388590..8076e52 100644
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
@@ -109,6 +111,127 @@ static int i2c_device_uevent(struct device *dev, stru=
ct kobj_uevent_env *env)
 #define i2c_device_uevent=09NULL
 #endif=09/* CONFIG_HOTPLUG */
=20
+/* i2c bus recovery routines */
+#define RECOVERY_CLK_CNT=099
+#define DEFAULT_CLK_RATE=09100=09/* KHz */
+/* 10^6/KHz for delay in ns */
+unsigned long clk_delay =3D DIV_ROUND_UP(1000000, DEFAULT_CLK_RATE * 2);
+
+static int get_scl_gpio_value(struct i2c_adapter *adap)
+{
+=09return gpio_get_value(adap->bus_recovery_info->scl_gpio);
+}
+
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
+=09ret =3D gpio_request_one(bri->scl_gpio, GPIOF_OPEN_DRAIN |
+=09=09=09GPIOF_OUT_INIT_HIGH, "i2c-scl");
+=09if (ret) {
+=09=09dev_warn(dev, "gpio request fail: %d\n", bri->scl_gpio);
+=09=09return ret;
+=09}
+
+=09if (bri->get_sda) {
+=09=09if (gpio_request_one(bri->sda_gpio, GPIOF_IN, "i2c-sda")) {
+=09=09=09/* work without sda polling */
+=09=09=09dev_warn(dev, "can't get sda: %d. Skip sda polling\n",
+=09=09=09=09=09bri->sda_gpio);
+=09=09=09bri->get_sda =3D NULL;
+=09=09}
+=09}
+
+=09return ret;
+}
+
+static void i2c_put_gpios_for_recovery(struct i2c_adapter *adap)
+{
+=09struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
+
+=09if (bri->get_sda)
+=09=09gpio_free(bri->sda_gpio);
+
+=09gpio_free(bri->scl_gpio);
+}
+
+static int i2c_generic_recovery(struct i2c_adapter *adap)
+{
+=09struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
+=09int i =3D 0, val =3D 1, ret =3D 0;
+
+=09if (bri->prepare_recovery)
+=09=09bri->prepare_recovery(bri);
+
+=09/*
+=09 * By this time SCL is high, as we need to give 9 falling-rising edges
+=09 */
+=09while (i++ < RECOVERY_CLK_CNT * 2) {
+=09=09/* SCL shouldn't be low here */
+=09=09if (val && !bri->get_scl(adap)) {
+=09=09=09dev_err(&adap->dev, "SCL is stuck Low exit recovery\n");
+=09=09=09ret =3D -EBUSY;
+=09=09=09goto unprepare;
+=09=09}
+
+=09=09val =3D !val;
+=09=09bri->set_scl(adap, val);
+=09=09ndelay(clk_delay);
+
+=09=09/* break if sda got high, check only when scl line is high */
+=09=09if (bri->get_sda && val)
+=09=09=09if (bri->get_sda(adap))
+=09=09=09=09break;
+=09}
+
+unprepare:
+=09if (bri->unprepare_recovery)
+=09=09bri->unprepare_recovery(bri);
+
+=09return ret;
+}
+
+int i2c_generic_scl_recovery(struct i2c_adapter *adap)
+{
+=09adap->bus_recovery_info->set_scl(adap, 1);
+=09return i2c_generic_recovery(adap);
+}
+
+int i2c_generic_gpio_recovery(struct i2c_adapter *adap)
+{
+=09int ret;
+
+=09ret =3D i2c_get_gpios_for_recovery(adap);
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D i2c_generic_recovery(adap);
+=09i2c_put_gpios_for_recovery(adap);
+
+=09return ret;
+}
+
+int i2c_recover_bus(struct i2c_adapter *adap)
+{
+=09if (!adap->bus_recovery_info)
+=09=09return -EOPNOTSUPP;
+
+=09dev_dbg(&adap->dev, "try i2c bus recovery\n");
+=09return adap->bus_recovery_info->recover_bus(adap);
+}
+
 static int i2c_device_probe(struct device *dev)
 {
 =09struct i2c_client=09*client =3D i2c_verify_client(dev);
@@ -902,6 +1025,38 @@ static int i2c_register_adapter(struct i2c_adapter *a=
dap)
 =09=09=09 "Failed to create compatibility class link\n");
 #endif
=20
+=09/* bus recovery specific initialization */
+=09if (adap->bus_recovery_info) {
+=09=09struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
+
+=09=09if (!bri->recover_bus) {
+=09=09=09dev_err(&adap->dev, "Invalid recover_bus(), skip recovery\n");
+=09=09=09adap->bus_recovery_info =3D NULL;
+=09=09=09goto exit_recovery;
+=09=09}
+
+=09=09/* GPIO recovery */
+=09=09if (bri->recover_bus =3D=3D i2c_generic_gpio_recovery) {
+=09=09=09if (!gpio_is_valid(bri->scl_gpio)) {
+=09=09=09=09dev_err(&adap->dev, "Invalid scl gpio, skip recovery\n");
+=09=09=09=09adap->bus_recovery_info =3D NULL;
+=09=09=09=09goto exit_recovery;
+=09=09=09}
+
+=09=09=09if (gpio_is_valid(bri->sda_gpio))
+=09=09=09=09bri->get_sda =3D get_sda_gpio_value;
+=09=09=09else
+=09=09=09=09bri->get_sda =3D NULL;
+
+=09=09=09bri->get_scl =3D get_scl_gpio_value;
+=09=09=09bri->set_scl =3D set_scl_gpio_value;
+=09=09} else if (!bri->set_scl) {
+=09=09=09dev_warn(&adap->dev,
+=09=09=09=09=09"set_scl() is must for scl recovery\n");
+=09=09}
+=09}
+
+exit_recovery:
 =09/* create pre-declared device nodes */
 =09if (adap->nr < __i2c_first_dynamic_bus_num)
 =09=09i2c_scan_static_board_info(adap);
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index d0c4db7..da9358b 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -370,6 +370,43 @@ struct i2c_algorithm {
 =09u32 (*functionality) (struct i2c_adapter *);
 };
=20
+/**
+ * struct i2c_bus_recovery_info - I2C bus recovery information
+ * @recover_bus: Recover routine. Either pass driver's recover_bus() routi=
ne, or
+ *=09i2c_generic_scl_recovery() or i2c_generic_gpio_recovery().
+ * @get_scl: This gets current value of scl line. Mandatory for generic SC=
L
+ *      recovery. Used internally for generic GPIO recovery.
+ * @set_scl: This sets/clears scl line. Mandatory for generic SCL recovery=
. Used
+ *      internally for generic GPIO recovery.
+ * @get_sda: This gets current value of sda line. Optional for generic SCL
+ *      recovery. Used internally, if sda_gpio !=3D -1, for generic GPIO r=
ecovery.
+ * @prepare_recovery: This will be called before starting recovery. Platfo=
rm may
+ *=09configure padmux here for sda/scl line or something else they want.
+ * @unprepare_recovery: This will be called after completing recovery. Pla=
tform
+ *=09may configure padmux here for sda/scl line or something else they wan=
t.
+ * @scl_gpio: gpio number of the scl line. Only required for GPIO recovery=
.
+ * @sda_gpio: gpio number of the sda line. Only required for GPIO recovery=
.
+ */
+struct i2c_bus_recovery_info {
+=09int (*recover_bus)(struct i2c_adapter *);
+
+=09int (*get_scl)(struct i2c_adapter *);
+=09void (*set_scl)(struct i2c_adapter *, int val);
+=09int (*get_sda)(struct i2c_adapter *);
+
+=09void (*prepare_recovery)(struct i2c_bus_recovery_info *bri);
+=09void (*unprepare_recovery)(struct i2c_bus_recovery_info *bri);
+
+=09/* gpio recovery */
+=09unsigned scl_gpio;
+=09unsigned sda_gpio;
+};
+
+/* Generic recovery routines */
+int i2c_generic_gpio_recovery(struct i2c_adapter *adap);
+int i2c_generic_scl_recovery(struct i2c_adapter *adap);
+int i2c_recover_bus(struct i2c_adapter *adap);
+
 /*
  * i2c_adapter is the structure used to identify a physical i2c bus along
  * with the access algorithms necessary to access it.
@@ -393,6 +430,8 @@ struct i2c_adapter {
=20
 =09struct mutex userspace_clients_lock;
 =09struct list_head userspace_clients;
+
+=09struct i2c_bus_recovery_info *bus_recovery_info;
 };
 #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
=20
--=20
1.7.12.rc2.18.g61b472e
