From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2] i2c-mpc: avoid I2C abnormal after resuming from deep
 sleep
Date: Thu, 19 Apr 2012 13:07:10 +0200
Message-ID: <20120419110710.GD2206@pengutronix.de>
References: <1334829094-22048-1-git-send-email-chenhui.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C+ts3FVlLX8+P6JN"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1334829094-22048-1-git-send-email-chenhui.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhao Chenhui <chenhui.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, leoli-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--C+ts3FVlLX8+P6JN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2012 at 05:51:34PM +0800, Zhao Chenhui wrote:

> When entering deep sleep, the value in the registers I2CFDR and
> I2CDFSRR are lost. This causes I2C access to fail after resuming.
>=20
> Add suspend/resume routines to save/restore the registers
> I2CFDR and I2CDFSRR.
>=20
> Signed-off-by: Zhao Chenhui <chenhui.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Signed-off-by: Li Yang <leoli-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Applied to next. Thanks!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--C+ts3FVlLX8+P6JN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+P8d4ACgkQD27XaX1/VRsG8wCgs3R+gYTdS4A/rb13SgOSGHU8
2gIAoIXaq/jRSp5AhEvtNnhFDug6T4WE
=EOcj
-----END PGP SIGNATURE-----

--C+ts3FVlLX8+P6JN--
