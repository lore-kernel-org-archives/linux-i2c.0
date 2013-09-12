From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 8/9] spi: prepare runtime PM support for SPI devices
Date: Thu, 12 Sep 2013 10:31:45 +0100
Message-ID: <20130912093145.GA29403@sirena.org.uk>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <1378913560-2752-9-git-send-email-mika.westerberg@linux.intel.com>
 <20130911155120.GW29403@sirena.org.uk>
 <20130912092743.GK7393@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+W0ZOZq7uBvmp/5T"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130912092743.GK7393-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--+W0ZOZq7uBvmp/5T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 12, 2013 at 12:27:43PM +0300, Mika Westerberg wrote:
> On Wed, Sep 11, 2013 at 04:51:20PM +0100, Mark Brown wrote:

> > I would be able to have this and the other patch in the SPI tree in case
> > it overlaps with other work - I'm not sure what the plan will be for
> > merging this stuff but if there were a branch which I could merge into
> > the SPI tree that'd be good.

> I think these two can go via your SPI tree as they shouldn't have
> dependencies to the I2C tree.

There's all the driver changes though - it seems best to push the whole
series through one branch so there's fewer bisection problems.

--+W0ZOZq7uBvmp/5T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSMYn+AAoJELSic+t+oim9D4IP/3Oe6epbIeARC39Vkzr26jN0
rxjxcFbCzualc1nLbwtzPyp25JcGRKmXOu3FZ3OnM9yAE/NYY7MZp0u/EYdUZeWv
6NUNa9ktaih/7NCI940Oku6jCVJ0I+wWSzoqmS7zd8HGKPmDzTLDpOkAoPPGtvLf
ZM0nlI1KZgMbvnSWnwKsJam9e7sbI+XBIN8SANSQMQuJ8NNNqcwhcyHIKhv7hwl0
1a20bHjGoAVnJd/vAmZMqn9Dt0ho3iu/u19c78m1Ouyh5pUH7Pj3pzrdb0CJ36cr
67SeNjnIciVQoRg30MKWPNF77uDMpeRcis0acPNawJIh8nv/4VLScicv5kpfUUA+
V9f8R8hWFtNMlY0Xr7UA169xqq6H35hKKsiJyDKhpxFwU1ofCH4yK1dEY6TA0apP
sFujdVA3pYZM/02ll0bqiBdGsaDj/p0intiTbef0+51tXGDMsGGOBQmbScQ0j26k
aU3MdId3iwbzOu2z0mU5fT/RM/b4x1MghS4mdr+DCZacpyL0JuK/VK6v5t88vR9S
EdmEeqeCA5gysgv3fii1OT+v7gn1e7D8SZoYZZZlUlrp6NpvaRGBFeRGAkiTh67G
N2NhB+5OyDelknQZFYJ0ke2FIddkYz56MdTjUi9PMhmf5TjQ+KA0uiabTUCFc4Fr
gKFN+NzG5GC7Q+b07Yed
=/6T0
-----END PGP SIGNATURE-----

--+W0ZOZq7uBvmp/5T--
