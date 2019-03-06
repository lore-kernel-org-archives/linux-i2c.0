From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 3/5] i2c: mux: pca9541: prepare for PCA9641 support
Date: Wed, 6 Mar 2019 23:15:45 +0000
Message-ID: <20190306231521.29367-4-peda@axentia.se>
References: <20190306231521.29367-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190306231521.29367-1-peda@axentia.se>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Guenter Roeck <linux@roeck-us.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ken Chen <chen.kenyy@inventec.com>, Pradeep Srinivasan <pradeeps@cumulusnetworks.com>
List-Id: linux-i2c@vger.kernel.org

Make the arbitrate and release_bus implementation chip specific.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-pca9541.c | 62 +++++++++++++++++++++++++++------=
----
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mu=
x-pca9541.c
index 28f46450f4b4..5eb36e3223d5 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -23,6 +23,7 @@
 #include <linux/i2c-mux.h>
 #include <linux/jiffies.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_data/pca954x.h>
 #include <linux/slab.h>
=20
@@ -70,26 +71,22 @@
 #define SELECT_DELAY_SHORT	50
 #define SELECT_DELAY_LONG	1000
=20
-struct pca9541 {
-	struct i2c_client *client;
-	unsigned long select_timeout;
-	unsigned long arb_timeout;
+enum chip_name {
+	pca9541,
 };
=20
-static const struct i2c_device_id pca9541_id[] =3D {
-	{"pca9541", 0},
-	{}
+struct chip_desc {
+	int (*arbitrate)(struct i2c_client *client);
+	void (*release_bus)(struct i2c_client *client);
 };
=20
-MODULE_DEVICE_TABLE(i2c, pca9541_id);
+struct pca9541 {
+	const struct chip_desc *chip;
=20
-#ifdef CONFIG_OF
-static const struct of_device_id pca9541_of_match[] =3D {
-	{ .compatible =3D "nxp,pca9541" },
-	{}
+	struct i2c_client *client;
+	unsigned long select_timeout;
+	unsigned long arb_timeout;
 };
-MODULE_DEVICE_TABLE(of, pca9541_of_match);
-#endif
=20
 static bool pca9541_mybus(int ctl)
 {
@@ -271,7 +268,7 @@ static int pca9541_select_chan(struct i2c_mux_core *mux=
c, u32 chan)
 		/* force bus ownership after this time */
=20
 	do {
-		ret =3D pca9541_arbitrate(client);
+		ret =3D data->chip->arbitrate(client);
 		if (ret)
 			return ret < 0 ? ret : 0;
=20
@@ -289,10 +286,32 @@ static int pca9541_release_chan(struct i2c_mux_core *=
muxc, u32 chan)
 	struct pca9541 *data =3D i2c_mux_priv(muxc);
 	struct i2c_client *client =3D data->client;
=20
-	pca9541_release_bus(client);
+	data->chip->release_bus(client);
 	return 0;
 }
=20
+static const struct chip_desc chips[] =3D {
+	[pca9541] =3D {
+		.arbitrate =3D pca9541_arbitrate,
+		.release_bus =3D pca9541_release_bus,
+	},
+};
+
+static const struct i2c_device_id pca9541_id[] =3D {
+	{ "pca9541", pca9541 },
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, pca9541_id);
+
+#ifdef CONFIG_OF
+static const struct of_device_id pca9541_of_match[] =3D {
+	{ .compatible =3D "nxp,pca9541", .data =3D &chips[pca9541] },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pca9541_of_match);
+#endif
+
 /*
  * I2C init/probing/exit functions
  */
@@ -301,6 +320,8 @@ static int pca9541_probe(struct i2c_client *client,
 {
 	struct i2c_adapter *adap =3D client->adapter;
 	struct pca954x_platform_data *pdata =3D dev_get_platdata(&client->dev);
+	const struct of_device_id *match;
+	const struct chip_desc *chip;
 	struct i2c_mux_core *muxc;
 	struct pca9541 *data;
 	int force;
@@ -309,12 +330,18 @@ static int pca9541_probe(struct i2c_client *client,
 	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
=20
+	match =3D of_match_device(of_match_ptr(pca9541_of_match), &client->dev);
+	if (match)
+		chip =3D of_device_get_match_data(&client->dev);
+	else
+		chip =3D &chips[id->driver_data];
+
 	/*
 	 * I2C accesses are unprotected here.
 	 * We have to lock the I2C segment before releasing the bus.
 	 */
 	i2c_lock_bus(adap, I2C_LOCK_SEGMENT);
-	pca9541_release_bus(client);
+	chip->release_bus(client);
 	i2c_unlock_bus(adap, I2C_LOCK_SEGMENT);
=20
 	/* Create mux adapter */
@@ -329,6 +356,7 @@ static int pca9541_probe(struct i2c_client *client,
 		return -ENOMEM;
=20
 	data =3D i2c_mux_priv(muxc);
+	data->chip =3D chip;
 	data->client =3D client;
=20
 	i2c_set_clientdata(client, muxc);
--=20
2.11.0
