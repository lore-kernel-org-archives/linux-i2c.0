From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v6 2/4] i2c-mpc: rename "setclock" initialization
	functions to "setup"
Date: Wed, 10 Feb 2010 11:21:30 +0100
Message-ID: <20100210102130.GB5239@pengutronix.de>
References: <1265796330-15976-1-git-send-email-wg@grandegger.com> <1265796330-15976-2-git-send-email-wg@grandegger.com> <1265796330-15976-3-git-send-email-wg@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1265796330-15976-3-git-send-email-wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Cc: Linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 10, 2010 at 11:05:28AM +0100, Wolfgang Grandegger wrote:
> From: Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>
>=20
> To prepare  support for the MPC512x processors from Freescale the
> "setclock" initialization functions have been renamed to "setup"
> because I2C interrupts must be enabled for the MPC512x by this
> function as well.
>=20
> Signed-off-by: Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>

Acked-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktyiKoACgkQD27XaX1/VRvbLACeOfNnwxjSG7CFOIRKM7wFwx0A
bn4An2166t2pNPhSaRwgr1ixS2YKI6jX
=qsek
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
