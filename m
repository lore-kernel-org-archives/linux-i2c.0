From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/5] i2c: Drop the kind parameter from detect callbacks
Date: Thu, 10 Dec 2009 23:12:08 +0100
Message-ID: <20091210221208.GA18155@pengutronix.de>
References: <20091210185221.641bbaab@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20091210185221.641bbaab-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 10, 2009 at 06:52:21PM +0100, Jean Delvare wrote:
> The "kind" parameter always has value -1, and nobody is using it any
> longer, so we can remove it.
>=20
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

Yay, I am all for this series! Build tested all hwmon-modules on x86. Will =
try
to find a non-x86 board tomorrow which is actually using one of the hwmon
devices.

Tested-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkshcjgACgkQD27XaX1/VRvwzQCfQ6IAnOmLzFM5cKJt75lrKbfG
lucAn0PQBGVwgo80Qki721d0RjhOOgqp
=tPN3
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
