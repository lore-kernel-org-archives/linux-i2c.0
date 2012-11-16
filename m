From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v6 0/2]  i2c: i2c-ocores: Add support for sparc, custom
 set and get functions, and the GRLIB port of the controller
Date: Fri, 16 Nov 2012 15:58:11 +0100
Message-ID: <20121116145811.GH7313@pengutronix.de>
References: <1352994659-22392-1-git-send-email-andreas@gaisler.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzX0AQGjRQPusK/O"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1352994659-22392-1-git-send-email-andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, software-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--NzX0AQGjRQPusK/O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2012 at 04:50:57PM +0100, Andreas Larsson wrote:
> On sparc, irqs are not present as an IORESOURCE in the struct platform_de=
vice
> representation. By using platform_get_irq instead of platform_get_resourc=
e the
> driver works for sparc.
>=20
> The GRLIB port of the ocores i2c controller needs custom getreg and setreg
> functions to allow for big endian register access and to deal with the fa=
ct that
> the PRELOW and PREHIGH registers have been merged into one register.
>=20
> Signed-off-by: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>

Thanks, applied to for-next. I like the outcome, so thanks to Peter as
well.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--NzX0AQGjRQPusK/O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCmVIMACgkQD27XaX1/VRsV8ACff9M6uurXdhW9BO7AN+OJCYXG
w7AAoJLil3f203jkUjMnMRpt75N5l9l7
=1/+0
-----END PGP SIGNATURE-----

--NzX0AQGjRQPusK/O--
