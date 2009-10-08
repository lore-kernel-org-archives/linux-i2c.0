From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c/chips: move ds1682 to drivers/misc
Date: Thu, 8 Oct 2009 11:30:05 +0200
Message-ID: <20091008093005.GA6112@pengutronix.de>
References: <20091007115017.6941faa7@hyperion.delvare> <1254954710-18263-1-git-send-email-w.sang@pengutronix.de> <20091008084041.597e4c6d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20091008084041.597e4c6d-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jean,

> > +config DS1682
> > +	tristate "Dallas DS1682 Total Elapsed Time Recorder with Alarm"
> > +	depends on EXPERIMENTAL
>=20
> Depends on I2C too.

I've got this strange feeling of dejavu... One driver to go, we'll see if I=
 get
it right then :D

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrNsR0ACgkQD27XaX1/VRuOlACgzOoW6cGGexICWBB8DI6zRbj0
a24AoKFIJrSvjEVc2tMrW+g95ifVej4W
=qBeo
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
