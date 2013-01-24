From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V9 2/2] i2c/designware: Provide i2c bus recovery support
Date: Thu, 24 Jan 2013 16:06:38 +0530
Message-ID: <59d21326020cdd28a624ed283b294ec65a175c92.1359023434.git.viresh.kumar@linaro.org>
References: <fe4fba74b7bac4fe56e26b2a947280390182c66c.1359023434.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <fe4fba74b7bac4fe56e26b2a947280390182c66c.1359023434.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <fe4fba74b7bac4fe56e26b2a947280390182c66c.1359023434.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <fe4fba74b7bac4fe56e26b2a947280390182c66c.1359023434.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>, Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add bus recovery support for designware_i2c controller. It uses generic gpi=
o
based i2c_gpio_recover_bus() routine. Platforms need to pass struct
i2c_bus_recovery_info as platform data to designware I2C controller.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
V8->V9:
- Use i2c_recover_bus()
- simplified dw_i2c_probe() for bus recovery code
- removed floating kfree()'s of adap->bus_recovery_info

 drivers/i2c/busses/i2c-designware-core.c    | 5 ++++-
 drivers/i2c/busses/i2c-designware-platdrv.c | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/=
i2c-designware-core.c
index f5258c2..d0423ef 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -539,7 +539,10 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg m=
sgs[], int num)
 =09ret =3D wait_for_completion_interruptible_timeout(&dev->cmd_complete, H=
Z);
 =09if (ret =3D=3D 0) {
 =09=09dev_err(dev->dev, "controller timed out\n");
-=09=09i2c_dw_init(dev);
+
+=09=09if (i2c_recover_bus(adap) < 0)
+=09=09=09i2c_dw_init(dev);
+
 =09=09ret =3D -ETIMEDOUT;
 =09=09goto done;
 =09} else if (ret < 0)
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/buss=
es/i2c-designware-platdrv.c
index 343357a..9142f0c 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -141,6 +141,12 @@ static int dw_i2c_probe(struct platform_device *pdev)
 =09adap->dev.parent =3D &pdev->dev;
 =09adap->dev.of_node =3D pdev->dev.of_node;
=20
+=09/* Bus recovery support */
+=09adap->bus_recovery_info =3D dev_get_platdata(&pdev->dev);
+=09if (adap->bus_recovery_info)
+=09=09adap->bus_recovery_info->recover_bus =3D
+=09=09=09i2c_generic_gpio_recovery;
+
 =09adap->nr =3D pdev->id;
 =09r =3D i2c_add_numbered_adapter(adap);
 =09if (r) {
--=20
1.7.12.rc2.18.g61b472e
