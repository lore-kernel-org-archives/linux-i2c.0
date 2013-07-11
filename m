From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: MTD EEPROM support and driver integration
Date: Thu, 11 Jul 2013 19:05:06 +0200
Message-ID: <20130711170506.GZ11243@lukather>
References: <20130705201118.GM2959@lukather>
 <5811519.oHVuMujf0I@wuerfel>
 <20130706120112.GA11069@lukather>
 <8997501.Dchyii8uWX@wuerfel>
 <20130708083426.GO27646@sirena.org.uk>
 <20130708202538.GK11243@lukather>
 <20130709145510.GZ27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hEarWVD7htqb1VxP"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130709145510.GZ27646-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Artem Bityutskiy <dedekind1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--hEarWVD7htqb1VxP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Tue, Jul 09, 2013 at 03:55:10PM +0100, Mark Brown wrote:
> On Mon, Jul 08, 2013 at 10:25:38PM +0200, Maxime Ripard wrote:
> > On Mon, Jul 08, 2013 at 09:34:26AM +0100, Mark Brown wrote:
>=20
> > > I'd really like to see more discussion of this "DT parsing code for
> > > regmap" idea...  I've missed almost all the context here.
>=20
> > The context was that I found we lack a way to simply express the need
> > for one driver to get a value from an EEPROM-like device, for example to
> > get a MAC Address, or a serial number, in a generic way, without having
> > to poke directly with some custom function that would be exported by the
> > EEPROM driver.
>=20
> This sort of information is often stored in places like flash partitions
> too.  Are we sure that regmap is a good place to be hooking in here?
> The use case is sane, and being able to use regmap to do some of it
> seems sensible (I've seen people use OTP in PMICs for similar purposes)
> but perhaps an additional layer of abstraction on top makes sense.

Ah, I didn't thought it could be stored into a partition. Ok, so using
an intermediate abstraction for this makes sense (probably using regmap
for all the accesses that are relevant, like i2c, spi or mmio)

> > What we've been discussing so far is that:
> >   - To have a common framework we could base our work on, we could move
> >     the EEPROM drivers from drivers/misc/eeprom to MTD
> >   - To declare the ranges that needed to be used by a driver that was
> >     needing a value from one of those MTD drivers, we would use regmap
> >     with a MTD backend
> >   - And since we actually need to declare which ranges and in which
> >     device one driver would have to retrieve this value from, we were
> >     actually in need of DT bindings.
>=20
> > This is pretty much the only context involved, and we are at the early
> > stage of the discussion, so any comment is very welcome :)
>=20
> If this stuff is being represented in MTD doesn't MTD already have
> adequate abstractions for saying "this region in flash".  But otherwise
> this seems fine, it's not a generic regmap DT binding but instead rather
> more specific than that.

Yes, since we seem to be going to a point where regmap will be a
convenience in this case, we probably won't need a generic regmap
binding, but rather a generic way to define a range and offset into a
referenced device.

Arnd, the others, is this ok for you?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--hEarWVD7htqb1VxP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR3uXCAAoJEBx+YmzsjxAgMugP/28QkZ0Yz7D+Xrk8UsJFiLh9
jam5T1KOqga2lKB2N4uAnyQiWtuaZMX/ywELmxO7esx2055efI91r8oUj7PO0qJu
vgW/0d1zDTmRLZ/KdaDj/xvpkiotx6dSQghMXFdAiscIZJEF3XccLg+D8rQd5Vig
hagL31ateq28hM6GHeb6xE9HSX1uZRPFPrapWjwTAuWpYKNgt5TaEUpO9VIGk5LA
GEHJJL+wijJoeEF0/9w6Ub06BlUpjt6b86H591oyOQqnhLmABgi7CMPH4qtfrCDS
RAYahsSgkcKoVYCOD9YjULIgPS7Lh5EjbYoczkn9VDehN8YdSt0Jkhi5Z84ottuX
6YTbDwtf0o4ijOGbI4My97QuLJ19tYWL0/ACx/yrVYIn+7WEFSxrEsIYgbFthIdn
GyYjVmUixNFsB6JokjfmWDyak3LfvMfaH4PCZSuFrS+7u2XyEKQoc1hQBaDSCSTa
8e9jCuvCrB0UaLmasTwflsD/HChv/m8Q4q5uJp0s3ASsg5II+T5eujqdl7EEKcBS
fklMfHOhBLZ2HoXTRQenaNi/roVLtYqr2j55NHTwjFeZvZbRgMPi9VTPEZzKGM6N
JFenmvWnrjS0iNuwdn8oqmlg8FHNZmeBaTaZEKholDUkqZTrRS0GujJ5H0wfArrh
+U6CLMYZX1u3W26egsRW
=rUP+
-----END PGP SIGNATURE-----

--hEarWVD7htqb1VxP--
