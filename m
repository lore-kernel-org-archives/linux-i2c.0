From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/2] I2C: Set I2C timing registers for mxs-i2c
Date: Mon, 30 Apr 2012 21:43:13 +0200
Message-ID: <20120430194313.GA28226@pengutronix.de>
References: <1335738969-27445-1-git-send-email-marex@denx.de>
 <20120430055825.GA7926@pengutronix.de>
 <201204301405.42621.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201204301405.42621.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > This sets the bus to run at 400kHz, prior to this,
> > > the bus frequency was undefined.
> >=20
> > Not exactly. The default values let it run at 100kHz.
>=20
> Have you tried dumping the default values and comparing it with the value=
s for=20
> 100kHz in the manual?

Yes, sure. Doesn't it work for you? I just rechecked and the values are
okay. That being said, if you make it configurable for 400kHz, it would
in deed be better to rewrite the values for 100kHz, too.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+e61EACgkQD27XaX1/VRvDIwCgw0ehObrCpvZhH8ABecnRDoNZ
nIIAnRryiK4TLnSUM8ZMqPoSNeUBzgXo
=mJ/N
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
