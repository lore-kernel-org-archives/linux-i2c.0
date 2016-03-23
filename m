From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: Prevent endless uevent loop with dev_dbg
Date: Wed, 23 Mar 2016 17:50:33 +0100
Message-ID: <20160323165033.GB1385@katana>
References: <1458748247-9219-1-git-send-email-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:47199 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752878AbcCWQup (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 23 Mar 2016 12:50:45 -0400
Content-Disposition: inline
In-Reply-To: <1458748247-9219-1-git-send-email-jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 23, 2016 at 04:50:47PM +0100, Jan Glauber wrote:
> After enabling CONFIG_I2C_DEBUG_CORE my system was broken
> (no network, console login not possible). System log was
> flooded with the this message:
>=20
>  ...
> [  608.052077] rtc-ds1307 0-0068: uevent
> [  608.052500] rtc-ds1307 0-0068: uevent
> [  608.052925] rtc-ds1307 0-0068: uevent
>  ...
>=20
> The culprit is the dev_dbg printk in the i2c uevent handler.
> If this is activated (for instance by CONFIG_I2C_DEBUG_CORE)
> it results in an endless loop with systemd-journald.
>=20
> This happens if user-space scans the system log and reads the uevent
> file to get information about a newly created device, which seems fair
> use to me. Unfortunately reading the "uevent" file uses the same
> function that runs for creating the uevent for a new device,
> generating the next syslog entry.
>=20
> Ideally user-space would implement a recursion detection and
> after reading the same device file for the 1000th time call it a
> day, but nevertheless I think we should avoid this problem by
> removing the debug print completly or using another print variant.

Thanks for pointing out this problem. I think this debug can go. I also
think the function can be cleaned up some more. Can you test this patch?

Thanks,

   Wolfram

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 0f2f8484e8ec1f..e584d88ee337f6 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -525,22 +525,16 @@ static int i2c_device_match(struct device *dev, struc=
t device_driver *drv)
 	return 0;
 }
=20
-
-/* uevent helps with hotplug: modprobe -q $(MODALIAS) */
 static int i2c_device_uevent(struct device *dev, struct kobj_uevent_env *e=
nv)
 {
-	struct i2c_client	*client =3D to_i2c_client(dev);
+	struct i2c_client *client =3D to_i2c_client(dev);
 	int rc;
=20
 	rc =3D acpi_device_uevent_modalias(dev, env);
 	if (rc !=3D -ENODEV)
 		return rc;
=20
-	if (add_uevent_var(env, "MODALIAS=3D%s%s",
-			   I2C_MODULE_PREFIX, client->name))
-		return -ENOMEM;
-	dev_dbg(dev, "uevent\n");
-	return 0;
+	return add_uevent_var(env, "MODALIAS=3D%s%s", I2C_MODULE_PREFIX, client->=
name);
 }
=20
 /* i2c bus recovery routines */


--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW8slZAAoJEBQN5MwUoCm29qAQALEWmsyaQ/v2WYzKO2h4bdh+
U8pIN0+je3qPqyr2Ty5iFDRgOhDzoDtZuh21RrdbT9EkO+pQ6/3zcchH73JWw1O7
6Onar7COV7iHbK9//iGtEKYGd+gNXHovBGslTtcA9JcaK46mo/4viccuNHUy5nUY
cEURU+OvWUAhCRCFGQ/hLOmFMzb8Y0jFpmUP7ZqHNzTi7I7rYI+EydlVt9Sly1iY
pZ2BsNZal1ieywVRpIpoFMTdwtpBu56oUpEF90Kt2vOAoDIkBYV6LrJdI2glvntD
BYzxbt5fhRdEHngvCLyCE8NYyHbYFTBI4/GIRMItKoS1q3AS4WrUwul9HshVzGk1
prvPETnAsMnfJyhz+LSjvHn2DBQa1AhkuRLII8PKuEH+5kosM1HaTWObU3t1xTjq
FjhjQ7VpHQ4mCe1yXQgRdwQjZttBDuCJ7Qe9jO943AUoA1iUPXuIO4P8Q4IkWH3w
y1V6EqYAqHTrBaw922nLrzB6HW3kJ06ilChFUxPEyMOabSLCnleMK2t79xoRur/g
x2Ynozg4krp1Ksd7lptWX4JoYQjuw9yJz/8neSOHByWlMWiKeoe+hy44mCH9234i
UUjCqu2qvzRaBluewzgFHVrA6U6dzm4weRuEsCCZrAad9GvxO3iMUsxRsNhSEupn
a7E3Qh+bo9M4CENcaG/n
=chhI
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
