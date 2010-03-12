From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] misc/eeprom/at24: init dynamic bin_attribute structures
Date: Fri, 12 Mar 2010 01:12:38 +0100
Message-ID: <20100312001238.GA10684@pengutronix.de>
References: <1268268932-23447-1-git-send-email-w.sang@pengutronix.de> <1268331680.2272.0@antares>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1268331680.2272.0@antares>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Albrecht =?iso-8859-15?Q?Dre=DF?= <albrecht.dress-KvP5wT2u2U0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Eric W. Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Just an other dumb question:  as I mentioned, the driver is loaded even i=
f no
> chip is attached to the i2c bus.  Wouldn't it make sense to check if the =
chip
> is there (e.g. by reading the first byte), and eject with ENODEV if it is=
n't?

That would be part of a detect-callback. In probe() the device is already
considered to be present. But you can instantiate devices at runtime if you
want to add the eeprom dynamically (Documentation/i2c/instantiating-devices)

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuZhvYACgkQD27XaX1/VRuPrgCdGjm6t5pHL9cmVlOoaevfplfO
GcYAniChFIZtwGB+9FHK2vRBCB3suSy8
=iBtz
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
