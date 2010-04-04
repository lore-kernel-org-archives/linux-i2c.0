From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: PCA9564: "bus is not idle" issue
Date: Sun, 4 Apr 2010 05:29:29 +0200
Message-ID: <20100404032929.GA12800@pengutronix.de>
References: <f69abfc31003170559y3c0a5a6fi91c1ae7692700c66@mail.gmail.com> <20100403162939.GA2190@pengutronix.de> <20100403202329.3bdb407c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100403202329.3bdb407c-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > > I'm using PCA9564 attached to a ks8695 SoC. During my efforts to get
> > > 2.6.33/34 running on my system I noticed sporadic problems with RTC:
> >=20
> > [...]
> >=20
> > > static struct i2c_pca9564_pf_platform_data  __initdata pca_data =3D{
> > > 	    .gpio =3D -1,
> > > 	    .i2c_clock_speed =3D 59000,
> > > 	    .timeout =3D 1,
> > > };
> >=20
> > Commit 8e99ada8deaa9033600cd2c7d0a9366b0e99ab68 changed the timeout set=
tings to
> > jiffies. So, one jiffy as timeout will not work. Try 'HZ' here.
>=20
> So this means the bug isn't in the mainline kernel tree and I can
> ignore it?

A confirmation from Yegor would be nice, but his logs let me believe that
this is really the cause.

> As a side note, arch/blackfin/mach-bf561/boards/acvilon.c sets timeout
> to 10000, so the actual timeout depends on the value of HZ, which is
> probably not desirable. Not to mention that a timeout of over one
> minute (worst case) doesn't seem too smart ;)

There is also an i2c-gpio-user using non-HZ value. Will prepare patches.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAku4B5gACgkQD27XaX1/VRsORQCfQ8j7DAovJGN3ilbFlW/s5Msg
GyQAniMOb9URXrO/DNe0uI7wy4gVD81O
=KfpR
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
