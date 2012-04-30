From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/2] I2C: Set I2C timing registers for mxs-i2c
Date: Mon, 30 Apr 2012 23:02:22 +0200
Message-ID: <20120430210222.GF28226@pengutronix.de>
References: <1335738969-27445-1-git-send-email-marex@denx.de>
 <201204302209.12482.marex@denx.de>
 <20120430202742.GC28226@pengutronix.de>
 <201204302247.17242.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="924gEkU1VlJlwnwX"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201204302247.17242.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--924gEkU1VlJlwnwX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Indeed. Default to 100kHz might be a good idea too, in case user entered =
some=20
> weird value. Eventually, it'd be nice if we could calculate the timing va=
lues=20
> for all possible frequencies, but I didn't got to deriving such formula .=
=2E.=20
> dunno if it's worth it either, doubt so.

Would be awesome to have it; but we can leave it for later when it is
actually needed.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--924gEkU1VlJlwnwX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+e/d4ACgkQD27XaX1/VRua/QCfVXTTkPZ56rXnNRuJ9pRFdp3P
Cp0AoL7Zb08ECoPzIN9k46Efts+9iz0a
=ByPy
-----END PGP SIGNATURE-----

--924gEkU1VlJlwnwX--
