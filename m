From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: at24 driver - a possible problem
Date: Mon, 9 Nov 2009 10:10:45 +0100
Message-ID: <20091109091045.GA3983@pengutronix.de>
References: <533f29860911050810w4d939b39x2ad11c189f13c977@mail.gmail.com> <20091106124905.GA3980@pengutronix.de> <533f29860911060457m70a1adfcr2dd11f0785748014@mail.gmail.com> <200911061258.52179.david-b@pacbell.net> <20091108202331.GA6374@pengutronix.de> <20091109094638.2f05b29f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20091109094638.2f05b29f-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Aleksandar Ivanov <ivanov.aleks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Still, the latter one beats me right now. The sysfs-bin-write gets a ko=
bject
> > and the O_SYNC is placed in the flags of a filp during open. Is there a=
 some
> > connection between those? I'm not even sure if O_SYNC should be handled=
 at the
> > sysfs-layer instead of inside the driver?
>=20
> I'm not sure how sysfs could handle it. What backs up the sysfs file is
> driver-specific, so only the driver knows how to ensure that the data
> has been written. In the at24 driver case, the only way AFAICS is to
> try to read one byte back from the EEPROM and only return when the read
> is successful.

ACK. Sorry, I was not specific here. I also imagined that a solution must l=
ook
like:

	if (flag_however_I_get_it =3D=3D O_SYNC)
		at24_eeprom_read(...)

most probably in at24_write().

What I meant with "handled at sysfs-layer" was that it felt wrong to look f=
or
some complicated way from the kobject to the O_SYNC flag. It appeared to me
that it might be more suitable to let the sysfs-layer recognize the flag du=
ring
open and then, maybe, set another flag in a struct which is easier to reach=
 for
a bin-file. Then again, I wondered how many sysfs-bin files would really ne=
ed
that and that the "eeprom"-bin file might be a gray area (because of really
acessing a media).

> is entirely possible that sysfs simply has no support for O flags. This
> would have to be discussed at a higher level.

Most probably.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkr33JUACgkQD27XaX1/VRuNZACgtsi5ORcR4PrmxNWNXs8IU4z5
6f8AnA6i5IhWuwg5OaX/RafoTfm3xi+/
=4vXM
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
