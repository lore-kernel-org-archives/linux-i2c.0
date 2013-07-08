From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: MTD EEPROM support and driver integration
Date: Mon, 8 Jul 2013 09:34:26 +0100
Message-ID: <20130708083426.GO27646@sirena.org.uk>
References: <20130705201118.GM2959@lukather>
 <5811519.oHVuMujf0I@wuerfel>
 <20130706120112.GA11069@lukather>
 <8997501.Dchyii8uWX@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="soiQS7xIQzTpkbBM"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8997501.Dchyii8uWX@wuerfel>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Artem Bityutskiy <dedekind1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--soiQS7xIQzTpkbBM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 06, 2013 at 09:06:49PM +0200, Arnd Bergmann wrote:
> On Saturday 06 July 2013 14:01:12 Maxime Ripard wrote:

> > > > > a) like interrupts, regs, dmas, clocks, pinctrl, reset, pwm: fixe=
d property names

> > > > >       regmap =3D <&at25 0xstart 0xlen>;
> > > > >       regmap-names =3D "mac-address";

> > > > > b) like gpio, regulator: variable property names

> > > > >       mac-storage =3D <&at25 0xstart 0xlen>;

> > > > > It's unfortunate that we already have examples of both. They are =
largely
> > > > > equivalent, but the tendency is towards the first.

> > > > I don't have a strong feeling for one against another, so whatever =
works
> > > > best. Both solutions will be a huge improvement anyway=20

> > > > Just out of curiosity, is there any advantages besides having a fix=
ed
> > > > property name to the first solution?

> > > I think it's mostly for consistency: trying to get most subsystems to
> > > do it the same way to make it easier for people to write dts files.

> > > A lesser point is that it simplifies the driver code if you don't
> > > have to pass a name.

On the other hand something with human readable names is much more
legible if humans ever have to read or write the DT bindings.  This
mostly applies when there are many instances of the property (for
example, many devices have lots of power supplies) or when some
instances of the property are optional (for example, many devices can
use GPIOs for many different functions but usually not all of them are
connected and there's no particular order in which they might get
connected).

> > So that leave us with mainly one path to achieve this goal:
> >   - Add a regmap-mtd backend
> >   - Add DT parsing code for regmap
> >   - Move the EEPROM drivers from misc to mtd

> Yes, I think that would be good. For the last step, we definitely need
> buy-in from Wolfgand and Jean, as they are maintaining the current eeprom
> drivers.

I'd really like to see more discussion of this "DT parsing code for
regmap" idea...  I've missed almost all the context here.

> We also have a bunch of OTP drivers spread around the kernel, it probably
> makes sense to consolidate them at the same time, at least on the DT bind=
ing
> side if not the device drivers.

I'm not sure how viable this is, the OTP interfaces aren't that
consistent and are frequently embedded in random PMICs or whatever.

--soiQS7xIQzTpkbBM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR2nmPAAoJELSic+t+oim9HGsP/2YDpBPCN8Y8VqMdYfhR53kB
S1tdT+Lbj2Ml1eQT1L5gwbggvCz7lnaKDprvylhJCGu8zGihxKzsSeRrrVNgJi8O
Wb9Dh4QV7OhdHJpgXco25jtCeElvnEU7Besyl2wn0uHgIlNsAaBexee663sNj3fT
YsDVUqAIKQ1/yyTGjWlJJCTnUFut1tatUbHrYZpC237dOBbF3jEdDm+dEwgrUm/n
yXPcix3KpJGD9HH/0+1OjqHsKVi7HKs5TfezIAnjwPKl5IMdyXQPxieyEd5J0G8x
gIlu/ZEuEbA/GktSfUwgC56FMYROXQ6G2NYvTe+3Tzvo3jL9HtBjD9StIJFuzkgL
HMJfRzr1ITD5ngnmZS9D0gFxCZmbkhNDC1K5j29Pkw+GRriYMSA+9JgogQipKncb
7zUhmD3XbFOLTUqhLcOwlzFd8MwOnWtffQvLJo60xsZRZoKsQ6VdSOTynyCHbeDf
rb220of9ZPUX+qb1gav0o3ql77j2k2qfqm7GX3QjPqnC0RkjLWK2KWhAEZ4OPTDr
YRhe8Ea6imQnGLk1GbDDfHWwN5Ai39pDz2yp7GTW89mh+fMB2SWN2VODnIyz2Fbw
bApL+Kbkxy0eERNjPIH/Of4HjQFRzP8GMSH9EU1a0Kor3Tv9r9RFE6BVDpil0oyA
nZVTXqn+sVP+98fyOsLf
=3+Js
-----END PGP SIGNATURE-----

--soiQS7xIQzTpkbBM--
