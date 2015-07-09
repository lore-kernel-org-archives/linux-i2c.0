From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: xgene-slimpro: Fix missing mbox_free_channel call
 in probe error path
Date: Thu, 9 Jul 2015 22:17:29 +0200
Message-ID: <20150709201729.GO4744@katana>
References: <1435633726.14315.1.camel@ingics.com>
 <20150709201422.GN4744@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ZQ/M1iA+qg8otEW"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150709201422.GN4744@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Cc: Feng Kan <fkan-qTEPVZfXA3Y@public.gmane.org>, Hieu Le <hnle-qTEPVZfXA3Y@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--4ZQ/M1iA+qg8otEW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2015 at 10:14:22PM +0200, Wolfram Sang wrote:
> On Tue, Jun 30, 2015 at 11:08:46AM +0800, Axel Lin wrote:
> > Free requested mailbox channel before return error.
> >=20
> > Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
>=20
> Applied to for-next, thanks!

for-current, I mean. Sorry for the noise.


--4ZQ/M1iA+qg8otEW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVntbZAAoJEBQN5MwUoCm20AAP/RRHRKHeOcLd2pvDJV07URsC
daWh6F5DczAF84ZVwXMPQyjNSr8DLgEMR+sENVK4qF8LkRo7ofkd+S5+DpeMMB4V
Y6SN4iqD4qXWYtmF1HH7lJztNUH8HXo2+z/Mt50ALEKJ2vm+ZNf4msdsVNNa+Z5I
to4H+6pWZjP297mmgS3khw+3ly/Nj9N9DrwKqPgkIDu2xjz7lsM6vX1l0yLKLMjL
YakujRr1Ff4DyRQxlVByEg5n2iKFRGNuoB427SPZxeNZIrtaln2mfDvWNzyir1ue
TnUaS2p2965pOUD0PR4kLq0gHb2o5GqodPC4lZxPm4RwziMyANU5/tSeOieX3l/N
E1IJeX5f6yHhGXsj47foMy+566q3n1YDiegslkT0/GYoTX8QhLQ1JG4XQIxgs18M
6DQ266nalkDaWcFHffzdr6j+4zZXnAeQwQYANOlw9KJokzIsQ4+c/eFoE5d4gvt3
QafKI9Dp0Vf3B+EkCygC8Gyk7cYh778j72ggE1T6+U63w5OACK7KN22Xr5RiPZ5Y
TWqO9OdAB0g5YSUiXl4ckY19itUriA8HU4NHKGH0d1eL5g6px8RP46NVElFRBTO7
raaYTJ7u90z7rYkXfhxdOghrzdGxyc+UYTnfb0rCYclCYYy4L0MBF3V1wwh+ABDr
iiCWY1p0Y9AWhQ32NOow
=+Tqv
-----END PGP SIGNATURE-----

--4ZQ/M1iA+qg8otEW--
