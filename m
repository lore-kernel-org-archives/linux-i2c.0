From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1 8/8] pwm-pca9685: enable ACPI device found on Galileo
 Gen2
Date: Wed, 23 Sep 2015 14:48:00 +0200
Message-ID: <20150923124800.GA11187@ulmo.nvidia.com>
References: <1442916619-140607-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1442916619-140607-9-git-send-email-andriy.shevchenko@linux.intel.com>
 <20150922143714.GA9235@ulmo.nvidia.com>
 <1442997686.8361.161.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442997686.8361.161.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2015 at 11:41:26AM +0300, Andy Shevchenko wrote:
> On Tue, 2015-09-22 at 16:37 +0200, Thierry Reding wrote:
> > On Tue, Sep 22, 2015 at 01:10:19PM +0300, Andy Shevchenko wrote:
>=20
> > > --- a/drivers/pwm/pwm-pca9685.c
> > > +++ b/drivers/pwm/pwm-pca9685.c
> > > @@ -26,6 +26,8 @@
> > >  #include <linux/regmap.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/delay.h>
> > > +#include <linux/acpi.h>
> > > +#include <linux/property.h>
> >=20
> > These should be kept sorted. I know that delay.h isn't properly=20
> > ordered
> > either, I missed that during patch review. Please keep new ones=20
> > ordered
> > alphabetically and I'll sort out the delay.h via a separate patch.
>=20
> Will do in next version.
>=20
> > @@ -363,6 +364,12 @@ static const struct i2c_device_id pca9685_id[]
> > > =3D {
> > >  };
> > >  MODULE_DEVICE_TABLE(i2c, pca9685_id);
> > > =20
> > > +static const struct acpi_device_id pca9685_acpi_ids[] =3D {
> > > +	{ "INT3492", 0 },
> > > +	{ /* sentinel */ },
> > > +};
> > > +MODULE_DEVICE_TABLE(acpi, pca9685_acpi_ids);
> > > +
> > >  static const struct of_device_id pca9685_dt_ids[] =3D {
> > >  	{ .compatible =3D "nxp,pca9685-pwm", },
> > >  	{ /* sentinel */ }
> > > @@ -372,6 +379,7 @@ MODULE_DEVICE_TABLE(of, pca9685_dt_ids);
> > >  static struct i2c_driver pca9685_i2c_driver =3D {
> > >  	.driver =3D {
> > >  		.name =3D "pca9685-pwm",
> > > +		.acpi_match_table =3D ACPI_PTR(pca9685_acpi_ids),
> >=20
> > I think you now need #ifdef protection for the ACPI ID table,=20
> > otherwise
> > the compiler will warn that the table is unused for !ACPI.
>=20
> No, there is no warning, just checked a build with CONFIG_ACPI=3Dn.
>=20
> Tried even with C=3D1 W=3D2, and driver compiled in and a module.
> In all variants no warning regarding the topic is issued.
>=20
> $ gcc --version
> gcc (Debian 5.2.1-17) 5.2.1 20150911
>=20
> Perhaps this would explain what is happening there.
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D28901
>=20
> So, I will add #ifdef in the code as well, though I'm not a big fan of
> conditional compilation.

I'm pretty sure I've seen warnings for this with 5.2.0, but I'll put
this in my tree to check. Irrespective I think it should have the #ifdef
protection because I'm very certain that the warning is there with some
versions of GCC that people might still be using. And I don't much like
conditional compilation either, but anything producing a warning will
cause someone to write a patch to fix it, so I just want to be proactive
in avoiding that kind of churn.

> >=20
> > >  		.of_match_table =3D pca9685_dt_ids,
> >=20
> > Similarly to the above, this should use of_match_ptr(), which in turn
> > will require #ifdef protection for the table to avoid warnings.
>=20
> Hmm... my patch do not touches that part. Perhaps another patch for
> this?

Your patch does touch that part by removing the dependency on OF. That
makes it possible to build this code with !OF, which in turn would make
the OF match table unused.

Thierry

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWAp99AAoJEN0jrNd/PrOh6VgP/jrzM2VpT/mydiQedQVuj9ln
4O4BUkTqxDEgclLfNnk2m4vLEnUGFtMgiSS4cgnctB33Ln7jDFarP6rcdq4LI9ou
z0pKst5FslXVl1YuCqtYptNKiiVf4eopA+fwCZdKTY/OfL9mNcRei6C6HV5sKkU8
a+z40Yd6t6GWzKS5AF7bGK3JeOG3YaqsAxCypfPykV24S+81p9DE8iRlrPKtB5Q2
+EWGIEFt9JDIHrrYyYmyty/qMtdCGU4Y2jJr7jOeP4FHEkOCi3Gma0zcvLQOv6aQ
IJpk7FPCjH29hWhFqqHfR/FzYrNMwDt/Cy3DUzoNQFm8rDdTTpbepSTKdw88tipH
131KnM5EwDGyE1jmeZbT/obc8oYPgjZDeZbCVHQISmtsN36BKQn3Ek2Gxd9rHoSb
wCWuxdhfikqUXIZivwKoWDYUIt2kD/37btTpEZocM9UTJ3xDe+BCcmqBcmxW5CnU
kem4uPiUOSvvfx5boBr8ZfthJCoXZ18bPJ7qsw3c6OW+zek8lZ+VkgMe4DTsIoCN
o6f9Y9AKH4Y4T20vaDLVrVyDBSZBGicJU4gA4mqVACQmYBNzgtJuW9nChpdIpax+
OvptRjHKFCaHLZLHOhC95jLjVI++G8XBdnAfqImUG0j+JJzEdGMZaujb8KVQ0sps
bQIfuTn9qEF/Nfst58k4
=RAQs
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
