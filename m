From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: I2C dummy adapter driver ?
Date: Wed, 5 Mar 2014 09:15:30 +0800
Message-ID: <20140305011530.GN13126@sirena.org.uk>
References: <5305382E.9050902@gmail.com>
 <CAJe_ZhcMMVRTErH3ctbnZyn30_cp9XXjEfUZXdWaVWUHqs4CRw@mail.gmail.com>
 <53073C51.5010401@samsung.com>
 <20140228060728.GB29849@sirena.org.uk>
 <5315BB34.8080803@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6yHiY5vv/BiPjcMt"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5315BB34.8080803-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--6yHiY5vv/BiPjcMt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04, 2014 at 12:38:28PM +0100, Sylwester Nawrocki wrote:
> On 28/02/14 07:07, Mark Brown wrote:
> > On Fri, Feb 21, 2014 at 12:45:21PM +0100, Sylwester Nawrocki wrote:

> >> The I2C bus driver with empty i2c_algorithm.master_xfer() helps WRT to
> >> using standard DT binding and v4l2_subdev interface.

> > Wouldn't a platform device do just as well here if there's no actual
> > control?

> Then the I2C client devices would have to be instantiated manually,=20
> I think it's more trouble.

I2C is not that much more enumerable than platform bus, I don't see the
difference here?  To the extent I2C is enumerable a dummy adaptor isn't
going to support that.

> I could as well create custom I2C client drivers per ISP, but then the=20
> I2C devices would have to be represented somehow in DT, to pass stuff=20
> like voltage regulators and GPIOs. Anyway, it's not something could be=20
> done in mainline.

Why not?

> Even if there is no actual I2C communication on the host CPU side, the=20
> power up/down sequence is handled there. The intention is to keep this=20
> common per an I2C client, regardless of whether I2C communication is=20
> done by firmware or the host the CPU.

The way you're talking it sounds like your code is very hard coded to
use I2C here.  What happens if someone uses SPI or some other bus to
control an ISP?

--6yHiY5vv/BiPjcMt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFnqrAAoJELSic+t+oim9P2wP/R3XbXD1/WLl4d0MSbfpj82M
vdHhtNyPMXBxSxXcZ0Vl8mctcHHfSOElTC/HMgOKNLpykxSc1v0JV31lbnDAf+Ze
x1RQjPNkAvdjd9PKdE3kefqyhOCv64cfNV3VZfOSCm6Wpt+YbtddC5Ey8Z5MvLz9
Z+2w5n1lLEt+t0gig9PVIJ43Vy4fjuS12ufwwXzGseM/mt9tldH0cEsl8w5FmAIQ
ZI3Q/vB0qVx3jip8wXeNkxRsTOOJ+p2ApzFdJC52AxzMWHZ4APl8oDc4nnefbQir
d/js9Zgmsk/dybFq/TREy/b1cs/gsqdOCQuCNhfBu3hSPUAlo6XzPT27Y7nQVyMZ
4I1Gd170iKwU/PVsL3VS4ggFGjMn0ERkfhtTsfb5SechSrznD5LUb+p82GEXZyXC
T1qQTY/ZZwcE4I8scmCljYE0WgvRFwppDQmKFQFOUvZtipvZ1BUkUcBEa0Nb1gWv
2mbQc2e/urMEnDlPl5Gf8U0DBCA+sAEkjSuB/xeiInJaqrH6tJAIpCdjcyvJA/KB
FJ1crDxTlgMnbyDq0VaoBmzGGDVdzCZ7hqcyh96Y4UR79vShXwhExfQ6PzgqFNp2
vVxG8aDuQeid6Om3x4/xNDhXknllz8dvrDXb4JqkWrmHc3GQ1VHqz/cuCVy39OIH
tz+nNIkbOrFkyTNZMRmr
=48oO
-----END PGP SIGNATURE-----

--6yHiY5vv/BiPjcMt--
