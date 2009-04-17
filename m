From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] assign a default class to MPC adapter
Date: Fri, 17 Apr 2009 09:46:45 +0200
Message-ID: <20090417074645.GA3058@pengutronix.de>
References: <49E6F4F9.3060705@gmx.de> <20090416092012.GB3052@pengutronix.de> <49E7101E.6070806@gmx.de> <20090416114701.GD3052@pengutronix.de> <49E7344C.2060704@gmx.de> <20090416155555.1c8c0a34@hyperion.delvare> <49E82270.4030509@gmx.de> <20090417093356.79f38e40@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090417093356.79f38e40-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Because we have 2 different boards with same main processor but
> > different on-board peripherals. They should run with same binary kernel
> > to avoid duplicate production tests. On boot the system checks on which

This is what the device-tree is mainly made for.

> > The question was: does dts work for drivers that are loaded on runtime.

Its use would be quite limited if it couldn't do that, right? ;)

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknoM+UACgkQD27XaX1/VRuRugCcDj3jKEI9PT+GfoPhfUaxj/wz
aP8AoJ70Xh+GGpJ+nSvM7JmLDGTxV96W
=s/5f
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
