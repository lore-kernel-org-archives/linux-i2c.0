From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/2] I2C: Implement DMA support into mxs-i2c
Date: Mon, 30 Apr 2012 23:01:08 +0200
Message-ID: <20120430210108.GE28226@pengutronix.de>
References: <1335738969-27445-1-git-send-email-marex@denx.de>
 <201204302207.39112.marex@denx.de>
 <20120430203016.GD28226@pengutronix.de>
 <201204302245.57958.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6e7ZaeXHKrTJCxdu"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201204302245.57958.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--6e7ZaeXHKrTJCxdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > It complains that data might be undefined, do you want it in a separa=
te
> > > patch then ?
> >=20
> > Yes, but only if you can prove that the compiler is right.
>=20
> It's not right, because that variable is always initialized, but this at =
least=20
> squashes the compile warning.

The compiler needs to be fixed, not the kernel.

> > Yes, send V2 with DMA by default, and I will give a try on the
> > mode-switching later, too.
>=20
> I'd prefer to have PIOQ by default, to avoid breaking some of the boards.=
 Or can=20
> you test on all of them?

? What kind of breakage do you expect? I think it is okay if we pull it
in during the merge window; we can fix issues then till the relase (and
maybe mode switching works, after all).

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--6e7ZaeXHKrTJCxdu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+e/ZQACgkQD27XaX1/VRu2nQCdGVB3+oRcujRJMTZ9xTrNX4nm
zEsAnRpXuE22eEANi0QREtr1g9ggeV4k
=gGBn
-----END PGP SIGNATURE-----

--6e7ZaeXHKrTJCxdu--
