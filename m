From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH RESEND] i2c: Add Device Tree support to versatile-i2c
 driver
Date: Thu, 23 Feb 2012 21:17:50 +0100
Message-ID: <20120223201750.GB1934@pengutronix.de>
References: <1330021041-29782-1-git-send-email-pawel.moll@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1330021041-29782-1-git-send-email-pawel.moll-5wv7dgnIgG8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2012 at 06:17:21PM +0000, Pawel Moll wrote:
> This patch adds Device Tree binding ("arm,versatile-i2c") and
> basic support (bus population) to versatile-i2c driver.
>=20
> Signed-off-by: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-versatile.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
>=20
> Ben, Wolfram,
>=20
> Could I just gently remind about this small patch?
>=20
> It's been a while since I posted it for 3.2, then 3.3,
> (http://thread.gmane.org/gmane.linux.drivers.i2c/9108)
> but nothing happened. Could we get it in for 3.4 then?

Thanks for resending. I'll check it.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk9Gnu4ACgkQD27XaX1/VRs3hgCfZWVfbew2LMfXvOrs8csIZ8oY
dx0AoKjI0NUQAWCbofyEpziORc0mX7Ab
=Cvf0
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
