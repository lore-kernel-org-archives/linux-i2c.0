From: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Add MAX17042 Fuel Gauge Driver - Initial Release
Date: Fri, 14 Jan 2011 18:15:07 +0300
Message-ID: <20110114151507.GA30831@oksana.dev.rtsoft.ru>
References: <1294983971-17140-1-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1294983971-17140-1-git-send-email-myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, myungjoo.ham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Jan 14, 2011 at 02:46:11PM +0900, MyungJoo Ham wrote:
> The MAX17042 is a fuel gauge with an I2C interface for lithium-ion
> betteries. Unlike its predecessor MAX17040, MAX17042 uses 16bit
> registers. Besides, MAX17042 has much more features than MAX17040; e.=
g.,
> a thermistor, current and current accumulation measurement, battery
> internal resistance estimate, average values of measurement, and othe=
rs.
>=20
> This patch implements a driver for MAX17042.
> In this initial release, we have implemented the most basic features =
of
> a fuel gauge: measure the battery capacity and voltage.
>=20
> Signed-off-by: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Thanks for the patch!

Applied to battery-2.6.git, with some changes.

[...]
> +static const struct i2c_device_id max17042_id[] =3D {
> +	{ "max17042", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max17040_id);

Should be max17042_id, otherwise build breaks when enabled as a module:

drivers/power/max17042_battery.c:214: error: =E2=80=98__mod_i2c_device_=
table=E2=80=99 aliased to undefined symbol =E2=80=98max17040_id=E2=80=99

Also a few small cosmetic changes were made. Here is the whole
diff:

diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_=
battery.c
index 6e6eeab..c5c8805 100644
--- a/drivers/power/max17042_battery.c
+++ b/drivers/power/max17042_battery.c
@@ -1,5 +1,5 @@
 /*
- * max17042_battery.c - Fuel gauge driver for Maxim 17042 / 8966 / 899=
7
+ * Fuel gauge driver for Maxim 17042 / 8966 / 8997
  *  Note that Maxim 8966 and 8997 are mfd and this is its subdevice.
  *
  * Copyright (C) 2011 Samsung Electronics
@@ -22,8 +22,10 @@
  * This driver is based on max17040_battery.c
  */
=20
+#include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
 #include <linux/power_supply.h>
 #include <linux/power/max17042_battery.h>
=20
@@ -209,8 +211,7 @@ static const struct i2c_device_id max17042_id[] =3D=
 {
 	{ "max17042", 0 },
 	{ }
 };
-MODULE_DEVICE_TABLE(i2c, max17040_id);
-
+MODULE_DEVICE_TABLE(i2c, max17042_id);
=20
 static struct i2c_driver max17042_i2c_driver =3D {
 	.driver	=3D {
diff --git a/include/linux/power/max17042_battery.h b/include/linux/pow=
er/max17042_battery.h
index 4cc533f..7995deb 100644
--- a/include/linux/power/max17042_battery.h
+++ b/include/linux/power/max17042_battery.h
@@ -1,5 +1,5 @@
 /*
- * max17042_battery.h - Fuel gauge driver for Maxim 17042 / 8966 / 899=
7
+ * Fuel gauge driver for Maxim 17042 / 8966 / 8997
  *  Note that Maxim 8966 and 8997 are mfd and this is its subdevice.
  *
  * Copyright (C) 2011 Samsung Electronics
