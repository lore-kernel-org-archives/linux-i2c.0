From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: reorganize muxes to a standard pattern
Date: Sat, 7 Jan 2012 15:46:00 +0100
Message-ID: <20120107144559.GA2537@pengutronix.de>
References: <1321220474-11378-1-git-send-email-w.sang@pengutronix.de>
 <20111127214847.547542fb@endymion.delvare>
 <87sjl9gtcv.fsf@macbook.be.48ers.dk>
 <20111128092227.3d5d6a25@endymion.delvare>
 <20111128093835.GA4243@pengutronix.de>
 <874nxoh8l5.fsf@macbook.be.48ers.dk>
 <20111128125751.3d6a3ca7@endymion.delvare>
 <20120107153820.45ed4b37@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120107153820.45ed4b37-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 07, 2012 at 03:38:20PM +0100, Jean Delvare wrote:
> On Mon, 28 Nov 2011 12:57:51 +0100, Jean Delvare wrote:
> > On Mon, 28 Nov 2011 10:58:30 +0100, Peter Korsgaard wrote:
> > > >>>>> "Wolfram" =3D=3D Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> writes:
> > >=20
> > >  >> > http://thread.gmane.org/gmane.linux.drivers.i2c/7171/focus=3D72=
44
> > >  >>=20
> > >  >> Ah, yes, that's the discussion I was looking for, thanks for digg=
ing it
> > >  >> out. My point wasn't totally wrong back then, but Wolfram's is si=
mply
> > >  >> better, I admit.
> > >=20
> > >  Wolfram> I agree :) Okay, so I'll update the documentation as well. =
What about
> > >  Wolfram> include/linux/gpio-i2cmux.h and its users? I'd like consist=
ency, but
> > >  Wolfram> renaming header files is not too nice...
> > >=20
> > > Indeed. If we were to rename it we should also rename struct
> > > gpio_i2cmux_platform_data.
> > >=20
> > > I don't feel strongly about it - It will break for existing users, but
> > > there's probably not too many of those. Your call.
> >=20
> > I see exactly 1 user of <linux/gpio-i2cmux.h> in the upstream kernel
> > tree, and that is gpio-i2cmux itself. So I'd say no big deal renaming
> > it, and actually if we intend to rename header files and/or structures,
> > the sooner the better.
>=20
> Wolfram, Peter, any progress here? I think Wolfram was supposed to send
> an updated patch but I did not receive anything.

-EBUSY :(

It *is* on my todo-list, though...

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk8IWqcACgkQD27XaX1/VRuxCgCeLh2x53WKATEnDR1GF3iXGGUn
yrsAn0/gKXabSirrfK7/V86HiiCz63qA
=dZqO
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
