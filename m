From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: eg20t: include slab.h for memory allocations
Date: Wed, 23 Feb 2011 11:08:36 +0100
Message-ID: <20110223100836.GB2193@pengutronix.de>
References: <1296672461-22822-1-git-send-email-w.sang@pengutronix.de>
 <20110202222422.GX15795@trinity.fluff.org>
 <20110216122929.GA6210@pengutronix.de>
 <20110220234928.GO15795@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110220234928.GO15795-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 20, 2011 at 11:49:28PM +0000, Ben Dooks wrote:
> On Wed, Feb 16, 2011 at 01:29:29PM +0100, Wolfram Sang wrote:
> > On Wed, Feb 02, 2011 at 10:24:22PM +0000, Ben Dooks wrote:
> > > On Wed, Feb 02, 2011 at 07:47:41PM +0100, Wolfram Sang wrote:
> > > > Fixes (with v2.6.38-rc3/parisc/parisc-allmodconfig):
> > > >   src/drivers/i2c/busses/i2c-eg20t.c:720: error: implicit declarati=
on of function 'kzalloc'
> > > >   src/drivers/i2c/busses/i2c-eg20t.c:790: error: implicit declarati=
on of function 'kfree'
> > > >=20
> > > > Reported-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
> > > > Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > > > Cc: Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
> > >=20
> > > ok, will pick this one up.
> >=20
> > Please don't forget.
>=20
> I'll try and issue a new git tree tomorrow, had problems with old laptop
> and 'fun' moving to the new one.

Okay, resending seems to work better ;)

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1k3KQACgkQD27XaX1/VRtD4ACbByY+hTa0J+dyP5m8BnBiLKIp
LK8AoIWJARcGej6c4P0iNk1CWAD58+v3
=q48o
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
