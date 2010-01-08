From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] i2c/imx: call ioremap only after request_mem_region
Date: Fri, 8 Jan 2010 22:26:03 +0100
Message-ID: <20100108212603.GC31747@pengutronix.de>
References: <1262967797-2001-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vOmOzSkFvhd7u8Ms"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754117Ab0AHV0M@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1262967797-2001-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Richard Zhao <linuxzsc@gmail.com>, Darius Augulis <augulis.darius@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--vOmOzSkFvhd7u8Ms
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 08, 2010 at 05:23:17PM +0100, Uwe Kleine-K=F6nig wrote:
> accordingly adapt order of release_mem_region and release_mem_region on
> remove.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--vOmOzSkFvhd7u8Ms
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktHousACgkQD27XaX1/VRtDXgCgqhrnhREBhUAVwKx/YXn9mDth
3/0AoKRceMzo3q9oK5P8oV7PxtIggdj6
=X4KS
-----END PGP SIGNATURE-----

--vOmOzSkFvhd7u8Ms--
