From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: PMBus support in Linux
Date: Sat, 29 May 2010 17:47:41 +0200
Message-ID: <20100529154741.GB7572@pengutronix.de>
References: <1275063391.2631.137.camel@groeck-laptop> <20100529023401.GB12507@pengutronix.de> <20100529044239.GA19155@ericsson.com> <20100529085301.GA14982@pengutronix.de> <20100529153312.GA20814@ericsson.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100529153312.GA20814-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Yes. PMBus uses i2c as transport, so it can use the existing i2c/smbus in=
frastructure.=20
> Data reported is voltage, temperature, current, power, and fan data as av=
ailable
> from the individual chip. Chips support a chip dependent number of channe=
ls.
> Values reported are typically in the form of X =3D Y * 2^N, ie there is a=
 mantissa
> and an exponent.
>=20
> So I would say it maps pretty well; I don't really see a substantial diff=
erence
> to other HW monitoring chips in that respect. Key difference may be that =
PMBus devices=20
> typically also have a control component, but I don't have plans to implem=
ent that,
> at least not for now.

I just had a glimpse, but I came to a similar conclusion. As I further
understood, PMBus devices support a standard range of commands with the
possibility of manufacturer extenstions.

So, the approach I see (unless I miss something) would be writing an
hwmon-I2C-driver named pmbus-devices.c or so which covers the generic
functionality and provides some hooks for manufacturer extensions, if those=
 are
necessary? (Altough I'd hope a number of devices would be covered by the
generic driver) Makes sense?

Kind regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkwBNx0ACgkQD27XaX1/VRvs1QCcCNvW8rEftyRi63vPdTzwDFws
yh4An07eRImVsAryXls5mLinTerQbFuq
=X9uq
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
