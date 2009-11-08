From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: at24 driver - a possible problem
Date: Sun, 8 Nov 2009 21:23:31 +0100
Message-ID: <20091108202331.GA6374@pengutronix.de>
References: <533f29860911050810w4d939b39x2ad11c189f13c977@mail.gmail.com> <20091106124905.GA3980@pengutronix.de> <533f29860911060457m70a1adfcr2dd11f0785748014@mail.gmail.com> <200911061258.52179.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200911061258.52179.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Aleksandar Ivanov <ivanov.aleks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > Correct me if I'm wrong but I would expect from a synchronous write()
> > call to NOT finish before the data has been "phisically written".
> > And in this case of course the read operation wouldn't need a waiting l=
oop.
> > What do you think?
>=20
> Makes sense to me.  Another bug to fix.  :)

I think the waiting loop in the read-path won't hurt and will be convenient=
 for
a number of users. I also think it would be nice if O_SYNC would be support=
ed,
so the write will only return after the EEPROM finished the write cycle.

Still, the latter one beats me right now. The sysfs-bin-write gets a kobject
and the O_SYNC is placed in the flags of a filp during open. Is there a some
connection between those? I'm not even sure if O_SYNC should be handled at =
the
sysfs-layer instead of inside the driver?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkr3KMMACgkQD27XaX1/VRsHBQCfQ0qxDb6U+p1miXLj07GR1f6R
wZoAoMYA520zJbxaxaZuVcGG4E+pLWno
=iVk+
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
