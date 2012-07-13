From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/2 V3] MXS: Set I2C timing registers for mxs-i2c
Date: Fri, 13 Jul 2012 10:07:41 +0200
Message-ID: <20120713080741.GE32184@pengutronix.de>
References: <1341850974-11977-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RpqchZ26BWispMcB"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1341850974-11977-1-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--RpqchZ26BWispMcB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 09, 2012 at 06:22:53PM +0200, Marek Vasut wrote:
> This patch configures the I2C bus timing registers according
> to information passed via DT. Currently, 100kHz and 400kHz
> modes are supported.
>=20
> The TIMING2 register value is wrong in the documentation for
> i.MX28! This was found and fixed by:
>   Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>=20
> Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

Applied to next, thanks.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--RpqchZ26BWispMcB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk//100ACgkQD27XaX1/VRvCjgCglGBScaxA6bFy4cjsrDpeFcpY
ZlEAn3wP0FFo+oSfeWiOQmCAZ5ucReMU
=mLI/
-----END PGP SIGNATURE-----

--RpqchZ26BWispMcB--
