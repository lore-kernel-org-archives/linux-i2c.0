From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: Not all adapters have a parent
Date: Thu, 10 Oct 2013 09:35:29 +0200
Message-ID: <20131010073529.GA2638@katana>
References: <20131010080406.3e0fd78e@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131010080406.3e0fd78e-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2013 at 08:04:06AM +0200, Jean Delvare wrote:
> The code in acpi_i2c_register_devices() assumes that all i2c adapters
> have a parent. This is not necessarily the case, for example the
> i2c-stub driver instantiate a virtual i2c adapter without a parent.
> Check for this to avoid a NULL pointer deference.
>=20
> Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>

Applied to for-current with stable tag, thanks!


--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSVljBAAoJEBQN5MwUoCm2JosP/RBmXyy9BeBp8XlknCM8byvy
GhSZpNNi/IIlNyepumMmbQ0bUZrSQyRe/lSTN0ZPtVumquVeOQ/dcAHBcVbZ5hPr
N7wXEBCwVGY2emMDrc/SfowRny8fMsDVbescEgZmkAPr9Y7hRz+Gd2cRbUYTmRT9
JbEVoJsg+kb3G4SGUzdUpMPeu/GM6aVgM6P9ltZZ8c4xvPqegmcJM5cOBL3yLnNp
cs2VdhMo88+gnXaGQLPkfi6mco3f7+Pj+NwHURgf5z+s/MhmfCdhKA6171+nw/NK
3y2zl8uchJpezbEx1Q5/F5Jn3BuM9fhHxivRb7XxbdIppEDe068BTfnhMx4WsF8p
JzOM9D/JGWoTYCxVP8ou06qaDkfKekDSI1qeGGvzX75YR23doRT7Nhp10HhknIOE
ajkYtB6nSiyTFuKAihOg7gCtCiLToXf7OZqR0P7d3dI9C2QpaPegaJzqiYEMmCEQ
y7C11p1ndzEsMQ/w90sCTdNVuUJ31D8HC3MK937OnDm8XuZFbnKC4NqGFV/rtRly
lr+eIwz17FXNGxOmt8ycInuMqQWnRjHyrCIgBo7mAlZKC0GKqqtfC0ThUy2OFL3T
z6laYtbYEb/fmBmCHU1ZTfLVkqxWb5YCxUcnYYkczb2U2rzOF9EHuWaVyPRfjEdq
k5RMnC3hWpg/+tyRAp2I
=Ec7L
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
