From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] power: Remove obsolete cleanup for clientdata
Date: Fri, 8 Jul 2011 15:40:50 +0200
Message-ID: <20110708134050.GJ2048@pengutronix.de>
References: <1308603674-19264-1-git-send-email-w.sang@pengutronix.de>
 <1308603674-19264-3-git-send-email-w.sang@pengutronix.de>
 <20110708131049.GD29056@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6iqOn7HZPWKXx18"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110708131049.GD29056-wnGakbxT3iijyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--d6iqOn7HZPWKXx18
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 08, 2011 at 05:10:49PM +0400, Anton Vorontsov wrote:
> On Mon, Jun 20, 2011 at 11:01:14PM +0200, Wolfram Sang wrote:
> > A few new i2c-drivers came into the kernel which clear the clientdata-p=
ointer
> > on exit or error. This is obsolete meanwhile, the core will do it.
> >=20
> > Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Cc: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > Cc: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Cc: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > ---
> >=20
> > This is more a cleanup than a bugfix. Still, would be happy to have this
> > obsolete programming style largely removed in 3.0 if possible.
>=20
> Applied for 3.1, sorry. This is not a regression fix.

3.1 is fine, too. Thanks!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--d6iqOn7HZPWKXx18
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk4XCOIACgkQD27XaX1/VRvj4QCgq5K0NZN8tQCH/ALSzKyYWyUW
n6EAnR2lWHAFLcrZ7Y7V6d8l0mm3LqYY
=MXue
-----END PGP SIGNATURE-----

--d6iqOn7HZPWKXx18--
