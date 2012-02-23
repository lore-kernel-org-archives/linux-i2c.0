From: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH RESEND] i2c: Add Device Tree support to versatile-i2c driver
Date: Thu, 23 Feb 2012 18:17:21 +0000
Message-ID: <1330021041-29782-1-git-send-email-pawel.moll@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch adds Device Tree binding ("arm,versatile-i2c") and
basic support (bus population) to versatile-i2c driver.

Signed-off-by: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
---
 drivers/i2c/busses/i2c-versatile.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

Ben, Wolfram,

Could I just gently remind about this small patch?

It's been a while since I posted it for 3.2, then 3.3,
(http://thread.gmane.org/gmane.linux.drivers.i2c/9108)
but nothing happened. Could we get it in for 3.4 then?

Thanks!

Pawel

diff --git a/drivers/i2c/busses/i2c-versatile.c b/drivers/i2c/busses/i2c-ve=
rsatile.c
index 6055601..7bfdf40 100644
--- a/drivers/i2c/busses/i2c-versatile.c
+++ b/drivers/i2c/busses/i2c-versatile.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/io.h>
+#include <linux/of_i2c.h>
=20
 #define I2C_CONTROL=090x00
 #define I2C_CONTROLS=090x00
@@ -99,6 +100,7 @@ static int i2c_versatile_probe(struct platform_device *d=
ev)
 =09strlcpy(i2c->adap.name, "Versatile I2C adapter", sizeof(i2c->adap.name)=
);
 =09i2c->adap.algo_data =3D &i2c->algo;
 =09i2c->adap.dev.parent =3D &dev->dev;
+=09i2c->adap.dev.of_node =3D dev->dev.of_node;
 =09i2c->algo =3D i2c_versatile_algo;
 =09i2c->algo.data =3D i2c;
=20
@@ -111,6 +113,7 @@ static int i2c_versatile_probe(struct platform_device *=
dev)
 =09=09ret =3D i2c_bit_add_bus(&i2c->adap);
 =09if (ret >=3D 0) {
 =09=09platform_set_drvdata(dev, i2c);
+=09=09of_i2c_register_devices(&i2c->adap);
 =09=09return 0;
 =09}
=20
@@ -133,12 +136,19 @@ static int i2c_versatile_remove(struct platform_devic=
e *dev)
 =09return 0;
 }
=20
+static struct of_device_id i2c_versatile_match[] =3D {
+=09{ .compatible =3D "arm,versatile-i2c", },
+=09{},
+};
+MODULE_DEVICE_TABLE(of, i2c_versatile_match);
+
 static struct platform_driver i2c_versatile_driver =3D {
 =09.probe=09=09=3D i2c_versatile_probe,
 =09.remove=09=09=3D i2c_versatile_remove,
 =09.driver=09=09=3D {
 =09=09.name=09=3D "versatile-i2c",
 =09=09.owner=09=3D THIS_MODULE,
+=09=09.of_match_table =3D i2c_versatile_match,
 =09},
 };
=20
--=20
1.7.5.4
