From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V4 Resend 2/2] i2c/designware: Provide i2c bus recovery support
Date: Mon, 27 Aug 2012 10:41:27 +0530
Message-ID: <da3ba1a4488cfe1b0839d9245647e0452cdf84f9.1346044191.git.viresh.kumar@linaro.org>
References: <fce6ddd7e8061ed0f428d48973d73b75c9ae585c.1346044190.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <fce6ddd7e8061ed0f428d48973d73b75c9ae585c.1346044190.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <fce6ddd7e8061ed0f428d48973d73b75c9ae585c.1346044190.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <fce6ddd7e8061ed0f428d48973d73b75c9ae585c.1346044190.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>, Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>, Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>

Add bus recovery support for designware_i2c controller. It uses generic gpi=
o
based i2c_gpio_recover_bus() routine.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-core.c    |  7 ++++-
 drivers/i2c/busses/i2c-designware-platdrv.c | 24 ++++++++++++++
 include/linux/i2c/i2c-designware.h          | 49 +++++++++++++++++++++++++=
++++
 3 files changed, 79 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/i2c/i2c-designware.h

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/=
i2c-designware-core.c
index 1e48bec..f29f283 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -536,7 +536,12 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg m=
sgs[], int num)
 =09ret =3D wait_for_completion_interruptible_timeout(&dev->cmd_complete, H=
Z);
 =09if (ret =3D=3D 0) {
 =09=09dev_err(dev->dev, "controller timed out\n");
-=09=09i2c_dw_init(dev);
+=09=09if (adap->bus_recovery_info &&
+=09=09=09=09adap->bus_recovery_info->recover_bus) {
+=09=09=09dev_dbg(dev->dev, "try i2c bus recovery\n");
+=09=09=09adap->bus_recovery_info->recover_bus(adap);
+=09=09}
+
 =09=09ret =3D -ETIMEDOUT;
 =09=09goto done;
 =09} else if (ret < 0)
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/buss=
es/i2c-designware-platdrv.c
index 0506fef..3a7a4e8 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -29,6 +29,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/i2c/i2c-designware.h>
 #include <linux/clk.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
@@ -45,6 +46,11 @@ static struct i2c_algorithm i2c_dw_algo =3D {
 =09.master_xfer=09=3D i2c_dw_xfer,
 =09.functionality=09=3D i2c_dw_func,
 };
+
+static struct i2c_bus_recovery_info dw_recovery_info =3D {
+=09.is_gpio_recovery =3D true,
+};
+
 static u32 i2c_dw_get_clk_rate_khz(struct dw_i2c_dev *dev)
 {
 =09return clk_get_rate(dev->clk)/1000;
@@ -55,6 +61,7 @@ static int __devinit dw_i2c_probe(struct platform_device =
*pdev)
 =09struct dw_i2c_dev *dev;
 =09struct i2c_adapter *adap;
 =09struct resource *mem, *ioarea;
+=09struct i2c_dw_pdata *pdata;
 =09int irq, r;
=20
 =09/* NOTE: driver uses the static register mapping */
@@ -141,6 +148,23 @@ static int __devinit dw_i2c_probe(struct platform_devi=
ce *pdev)
 =09adap->dev.parent =3D &pdev->dev;
 =09adap->dev.of_node =3D pdev->dev.of_node;
=20
+=09/* Bus recovery support */
+=09pdata =3D dev_get_platdata(&pdev->dev);
+=09if (pdata) {
+=09=09dw_recovery_info.get_gpio =3D pdata->get_gpio;
+=09=09dw_recovery_info.put_gpio =3D pdata->put_gpio;
+=09=09dw_recovery_info.scl_gpio =3D pdata->scl_gpio;
+=09=09dw_recovery_info.scl_gpio_flags =3D pdata->scl_gpio_flags;
+=09=09dw_recovery_info.clock_rate_khz =3D clk_get_rate(dev->clk) / 1000;
+
+=09=09if (!pdata->skip_sda_polling) {
+=09=09=09dw_recovery_info.sda_gpio =3D pdata->sda_gpio;
+=09=09=09dw_recovery_info.sda_gpio_flags =3D pdata->sda_gpio_flags;
+=09=09}
+
+=09=09adap->bus_recovery_info =3D &dw_recovery_info;
+=09}
+
 =09adap->nr =3D pdev->id;
 =09r =3D i2c_add_numbered_adapter(adap);
 =09if (r) {
diff --git a/include/linux/i2c/i2c-designware.h b/include/linux/i2c/i2c-des=
ignware.h
new file mode 100644
index 0000000..341bd4c
--- /dev/null
+++ b/include/linux/i2c/i2c-designware.h
@@ -0,0 +1,49 @@
+/*
+ * Synopsys DesignWare I2C adapter driver's platform data
+ *
+ * Copyright (C) 2012 ST Microelectronics.
+ * Author: Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#ifndef I2C_DESIGNWARE_H
+#define I2C_DESIGNWARE_H
+
+#include <linux/platform_device.h>
+
+/*
+ * struct i2c_dw_pdata - Designware I2c platform data
+ * @scl_gpio: gpio number of the scl line.
+ * @scl_gpio_flags: flag for gpio_request_one of scl_gpio. 0 implies
+ *=09GPIOF_OUT_INIT_LOW.
+ * @get_gpio: called before recover_bus() to get padmux configured for scl=
 line
+ *=09as gpio. Only required if is_gpio_recovery =3D=3D true
+ * @put_gpio: called after recover_bus() to get padmux configured for scl =
line
+ *=09as scl. Only required if is_gpio_recovery =3D=3D true
+ * @skip_sda_polling: if true, bus recovery will not poll sda line to chec=
k if
+ *=09it became high or not. Below are required only if this is false.
+ * @sda_gpio: gpio number of the sda line.
+ * @sda_gpio_flags: flag for gpio_request_one of sda_gpio. 0 implies
+ *=09GPIOF_OUT_INIT_LOW.
+ */
+struct i2c_dw_pdata {
+=09int scl_gpio;
+=09int scl_gpio_flags;
+=09int (*get_gpio)(unsigned gpio);
+=09int (*put_gpio)(unsigned gpio);
+
+=09/* sda polling specific */
+=09bool skip_sda_polling;
+=09int sda_gpio;
+=09int sda_gpio_flags;
+};
+
+#endif /* I2C_DESIGNWARE_H */
--=20
1.7.12.rc2.18.g61b472e
