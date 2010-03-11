From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] misc/eeprom/at24: init dynamic bin_attribute structures
Date: Thu, 11 Mar 2010 09:03:47 +0100
Message-ID: <20100311080347.GB16219@pengutronix.de>
References: <1268268932-23447-1-git-send-email-w.sang@pengutronix.de> <20100311085835.34c6cd51@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100311085835.34c6cd51-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Albrecht =?iso-8859-15?Q?Dre=DF?= <albrecht.dress-KvP5wT2u2U0@public.gmane.org>, "Eric W. Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jean,

> > diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> > index 88c20da..d2deea4 100644
> > --- a/drivers/misc/eeprom/at24.c
> > +++ b/drivers/misc/eeprom/at24.c
> > @@ -541,6 +541,7 @@ static int at24_probe(struct i2c_client *client, co=
nst struct i2c_device_id *id)
> >  	at24->bin.attr.mode =3D chip.flags & AT24_FLAG_IRUGO ? S_IRUGO : S_IR=
USR;
> >  	at24->bin.read =3D at24_bin_read;
> >  	at24->bin.size =3D chip.byte_len;
> > +	sysfs_bin_attr_init(&at24->bin);
>=20
> I think it would make more sense to move the initialization _before_
> manually setting other struct members. You don't know what
> sysfs_bin_attr_init does or will do in the future.

Okay.

> I presume the at25 driver needs the same fix?

Yes, sent it to the SPI-list sperately. I wasn't sure if a patch series wou=
ld
ease or complicate things.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuYo+MACgkQD27XaX1/VRsbpQCeIm1Nyj+U5/Zoy3iWv9EMiB3p
ajEAnR6l/aqV12KdE1dN5moOn4ymuqPB
=eh29
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
