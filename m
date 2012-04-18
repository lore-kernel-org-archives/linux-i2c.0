From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v3] i2c: designware: Add support for 16bit register access
Date: Wed, 18 Apr 2012 16:00:11 +0200
Message-ID: <20120418140011.GC19220@pengutronix.de>
References: <1334754101-25802-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1334754101-25802-1-git-send-email-sr-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18, 2012 at 03:01:41PM +0200, Stefan Roese wrote:
> The STM SPEAr platform can only access the i2c controller register
> via 16bit read/write functions. This patch adds support to
> automatically detect this 16bit access mode.
>=20
> Signed-off-by: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>

Even on second thought, I still think checking the upper 16 bits would
not have hurt much, but I am taking it as is. Applied.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+OyOsACgkQD27XaX1/VRskvACgoLr4WOj/HPQrOx6S7j6XUrAT
TWoAn3hBf2inEfOh45WXwn6t2yQtamIJ
=+Zvq
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--
