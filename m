From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: mux: create proper topology in sysfs
Date: Mon, 3 Nov 2014 22:02:00 +0100
Message-ID: <20141103210200.GA6242@katana>
References: <1414960809-16860-1-git-send-email-wsa@the-dreams.de>
 <20141103205534.GA18937@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141103205534.GA18937-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > +	WARN(sysfs_create_link(&parent->dev.kobj, &priv->adap.dev.kobj, priv-=
>adap.dev.kobj.name),
> > +				"can't create compatibility link for old mux name scheme\n");
> > +
> Something seems to be wrong with the linking.
>=20
> I get lots of messages such as
>=20
> sysfs: cannot create duplicate filename
> '/devices/fff70a000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:09.=
0/0000:10:00.0/i2c-sam.16/i2c-88/i2c-89'
>=20
> followed by "can't create compatibility link for old mux name scheme".

What is your muxing setup?

Thanks for testing BTW!


--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUV+1IAAoJEBQN5MwUoCm2Kc0P/ieUz4J0F/GpZ6JRwwSVJxSD
rkbSog8YMw1To2w3okUJx3/TZrstyHoBGiI/Cm0vmfGz4b4FcFvHj1h2eKrZi6TU
CGeBUlSPwKPhUMVPI5bf13MscTPwZYiqxmM8r5hlNrcYzznzxOPSlSq1cztWWzeZ
gc32uRGMUD8LkdbLkA5rSVjPVu0pQsYPZCgNGfeLGNwO209+7T5CA6jGvJrEa0YF
yu6349Fflo4KpJKUJon8ak9chGvxYNnXNQ4KC2hekBZqvTRegqSmgM86WNwdIfc7
t93STs4ucuyiGFzN9t5t1LTX1ZjWj64rNl6FVlhRK2E185A5Tin/5JqbCKIHkPlt
AwzTaKY7Atj/PIueumVZCqjWz8xCl83rHJPOjJUCQTjczxsAsjVw3aOdONmKB+q6
FISQQhjrxDD5u42mF4CEF6CUEMyDCJjjjbYqnFxTpvpA1/GCgh5kyajVXuc04RUW
HCacon1Ytp+BGLiCPE8ZX3dhEYmyldgI0HtovyYIig6or8sZEKozwPQ1sPbeVOkt
muPeCAcv1Xsp5h30mw9jZGhX6BGccOnEU0qQ44FcGLKX2HxyT23wYz/4K2q2doHw
C9LuON+r9uQWHjlz2nHH8XUsHUYScEq5L8AZLMks7P6HK4gsBpmCnwj8X7ofujXM
3tmDyUClL01vOaxe7Ns6
=kHFf
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
