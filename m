From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv5 0/8] 2c: Relax mandatory I2C ID table passing
Date: Fri, 10 Jun 2016 15:32:00 +0200
Message-ID: <20160610133200.GB1624@katana>
References: <1462374888-22888-1-git-send-email-kieran@bingham.xyz>
 <20160609191513.GB23522@katana>
 <adcdbb75-41ae-774e-21cb-c039e2f0686f@osg.samsung.com>
 <20160609200405.GE23522@katana>
 <575A9082.9060804@bingham.xyz>
 <20160610110027.GA1626@katana>
 <575AAD67.5070804@bingham.xyz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <575AAD67.5070804@bingham.xyz>
Sender: linux-kernel-owner@vger.kernel.org
To: Kieran Bingham <kieran@ksquared.org.uk>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Lee Jones <lee.jones@linaro.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> When I reported :
>=20
> > * new_device (built-in, and external module)
> > echo ds1307 0x68 > /sys/bus/i2c/devices/i2c-2/new_device
> > cat /sys/class/rtc/rtc0/date
> >=20
> > - Both of those worked fine.
>=20
> That was *without* Javier's patch, but hopefully obviously *with* Lee's
> patchset.
>=20
> Do you need this testing *with* Javiers patch as well?

Without Javiers patch. But with a modified rtc driver which will only
use proper compatibles, no i2c_device_ids, and probe_new. And this one
should be able to instantiate via userspace with the driver builtin.

We have documented ways of instantiating. All I ask for is to make sure
the old style and new style work with them. Check the attached sketch
for an example (only compile-tested and conversion to probe_new is
missing). Can you instantiate the "maxim,ds1307" (with the additional
printout) and "dallas,ds1307" via userspace?

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 821d9c089cdb48..10a4e5bc923e07 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -31,6 +31,7 @@
  */
 enum ds_type {
 	ds_1307,
+	maxim_1307,
 	ds_1337,
 	ds_1338,
 	ds_1339,
@@ -144,6 +145,10 @@ static struct chip_desc chips[last_ds_type] =3D {
 		.nvram_offset	=3D 8,
 		.nvram_size	=3D 56,
 	},
+	[maxim_1307] =3D {
+		.nvram_offset	=3D 8,
+		.nvram_size	=3D 56,
+	},
 	[ds_1337] =3D {
 		.alarm		=3D 1,
 	},
@@ -173,23 +178,6 @@ static struct chip_desc chips[last_ds_type] =3D {
 	},
 };
=20
-static const struct i2c_device_id ds1307_id[] =3D {
-	{ "ds1307", ds_1307 },
-	{ "ds1337", ds_1337 },
-	{ "ds1338", ds_1338 },
-	{ "ds1339", ds_1339 },
-	{ "ds1388", ds_1388 },
-	{ "ds1340", ds_1340 },
-	{ "ds3231", ds_3231 },
-	{ "m41t00", m41t00 },
-	{ "mcp7940x", mcp794xx },
-	{ "mcp7941x", mcp794xx },
-	{ "pt7c4338", ds_1307 },
-	{ "rx8025", rx_8025 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, ds1307_id);
-
 /*----------------------------------------------------------------------*/
=20
 #define BLOCK_DATA_MAX_TRIES 10
@@ -1435,6 +1423,9 @@ read_rtc:
 	 */
 	tmp =3D ds1307->regs[DS1307_REG_SECS];
 	switch (ds1307->type) {
+	case maxim_1307:
+		dev_info(&client->dev, "I'm a Maxim\n");
+		/* fallthrough */
 	case ds_1307:
 	case m41t00:
 		/* clock halted?  turn it on, so clock can tick. */
@@ -1610,13 +1601,22 @@ static int ds1307_remove(struct i2c_client *client)
 	return 0;
 }
=20
+#ifdef CONFIG_OF
+static const struct of_device_id ds1307_dt_ids[] =3D {
+	{ .compatible =3D "dallas,ds1307", .data =3D (void *)ds_1307 },
+	{ .compatible =3D "maxim,ds1307", .data =3D (void *)maxim_1307 },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ds1302_dt_ids);
+#endif
+
 static struct i2c_driver ds1307_driver =3D {
 	.driver =3D {
 		.name	=3D "rtc-ds1307",
+		.of_match_table =3D of_match_ptr(ds1307_dt_ids),
 	},
 	.probe		=3D ds1307_probe,
 	.remove		=3D ds1307_remove,
-	.id_table	=3D ds1307_id,
 };
=20
 module_i2c_driver(ds1307_driver);



--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXWsFPAAoJEBQN5MwUoCm20H4P/25BTocrYG5642RU/ojWWMgd
IDHIlUe01zftPil4li4MqOFPCzDlClCNNGkWIfC3ftLLs2plhkLKTqfdhDvs1Uyj
gk3v4D6wXd1RjtKPBHOprdg7Mjsu80er8onMQr5DAQ5HJQ00Gw9UQCzpdRL+k/l9
BH48ZG4s1HQ7aynXDGewDbhAznGGdRDsev/knT4k0ucyjE8d84kRfZAGQVUBe3gZ
Qy8tqKqbxdHZZ7W2b455f5Cl1WDxuxsXBJyaQyI0kj/AelRalCpqhKAFxoL0aTm4
LAYtAccx4bPYO4n9dkNtCK8ucWXVyMOLNYJN3INHVWs23w3SFBN4fv4xQ0YK45dS
tu23KnOm6DrbPqW4wS0dNNXZfNuxUQjjr/J5YkpvoNiWAHFYA1JbbOK8GjiuAmgi
V/N++9F25KDcWCd1hX0n4fieJdc6WImrNNKEWWKc3ZvN6ocgInCWWkF76S7lG5S4
CgBCAMuPe9g8WNXzZ0w3nIx6nqfIlncqBHf/NTILL/uRp0SPc9yFS4ylG0Ulk7uK
bUSHdh/Inww8icA4XONnnikEQt9b/VOmvACSp5CobXIKrqPQRpkwDFsvcOGQv19M
lvmlCcAaZ7tG0fXe+qOyuOYltnQ+uzV7EiVwlNa0Lhj1fck8U1rhthCkXuLe+Sdu
6vvXIRggBUmmUm2A7qdC
=FdQ0
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--
