From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/9] i2c: prepare runtime PM support for I2C client
 devices
Date: Tue, 17 Sep 2013 00:31:11 +0100
Message-ID: <20130916233111.GB21013@sirena.org.uk>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <5235BA9C.1090509@gmail.com>
 <20130916084708.GN7393@intel.com>
 <1861747.RtS0ZLgUUN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1861747.RtS0ZLgUUN-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 16, 2013 at 09:07:07PM +0200, Rafael J. Wysocki wrote:

> That may be left to the client driver altogether.  I mean, if the client wants
> the controller to be powered up, it should just call
> pm_runtime_get_sync(controller device) at a suitable place (and then do the
> corresponding _put when the controller is not necessary anu more) from its
> ->probe() callback.

It shouldn't even need to do that, it should just be able to rely on the
controller to power itself up when asked to do work.   This is how the
existing implementations are done - the controller power management is
totally transparent to the slave.

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSN5S8AAoJELSic+t+oim94uwP/jx69z1Q6v47hnnPe96VbjT3
EnKgxbDsp7+Kf746Wk/4N2NJFH8BjlmoURBIKCAEaBkvbjNpU1MMYj3R/hyr8KNY
Noc5qU1N0C+a+of3hrAN1mEPy8GF+fsRbcdVTKwvljaVW+dzDld9KJBoBhaQABms
LJK9cAmv+usvMHTRnqjbd66CR7pV1uu7yXOb+iMOAaypAIE7ws5vGlCf6risl5fW
1aaWEBLJCuoVNG6dY4tOMlWf0C/PWyqqFzwUWtRyHAnG99ZOoBqupMXtDe+OpU8Z
PK+qLKJfk+9vqIw3TnG3lIrDUmTCdKBE0TupAQETSxU6aHT9u6rnLvcaLqMEICRF
qpjG0gRe/XY28K1MwlZH+AWXYdh16OdkgDfEL72mJaznx06Z4oi4OR4Am0vFZSwt
jtSf8G9PnFbbjpFY5wMaSpXUQLHZShUkB2Hnjq25rvAAPeUr02Iv9WybbFyrHnJ3
XKFU7w5IsUlwIWvSEaMeTlqIwoG0zJqkcnVBGHaVQwqVTlHreq9GlF9dwRTpZcZl
J8btH2M1/nyezwPOoTDmQeJpiY/tvK4S++0Z9Xfg/Yxy8a/Km76PEQWf2FqhmcxB
PhAQz5iPvW0r8zVr/05R/Bwd4Zl0PwpBtzH9WxaSo/gbMpRsUiOPEZZm1w0y2q+G
aHTR4zk6jgEdn60R8zZQ
=CLGD
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
