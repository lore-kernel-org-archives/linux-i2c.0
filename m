From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/2] I2C: Set I2C timing registers for mxs-i2c
Date: Mon, 30 Apr 2012 22:27:42 +0200
Message-ID: <20120430202742.GC28226@pengutronix.de>
References: <1335738969-27445-1-git-send-email-marex@denx.de>
 <201204301405.42621.marex@denx.de>
 <20120430194313.GA28226@pengutronix.de>
 <201204302209.12482.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201204302209.12482.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--rQ2U398070+RC21q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > > > This sets the bus to run at 400kHz, prior to this,
> > > > > the bus frequency was undefined.
> > > >=20
> > > > Not exactly. The default values let it run at 100kHz.
> > >=20
> > > Have you tried dumping the default values and comparing it with the
> > > values for 100kHz in the manual?
> >=20
> > Yes, sure. Doesn't it work for you? I just rechecked and the values are
> > okay. That being said, if you make it configurable for 400kHz, it would
> > in deed be better to rewrite the values for 100kHz, too.
>=20
> They were different for me ... did you configure the i2c bus in your boot=
loader=20
> possibly? Those values might have been written there since then ... I did=
n't run=20
> i2c in u-boot before booting linux.

Nope, no I2C involved in the bootloader at all. Do you get the correct
values after soft-resetting the device?

It doesn't really matter, though. Just reinit them to the proper values
depending on the user setting.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--rQ2U398070+RC21q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+e9b4ACgkQD27XaX1/VRufmwCdFHjlxEVwv5Q7rCNih5ikxJAC
6dUAoJX6zHXXubj9xs4skRYAUJO08wXG
=tmb3
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--
