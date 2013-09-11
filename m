From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 8/9] spi: prepare runtime PM support for SPI devices
Date: Wed, 11 Sep 2013 16:51:20 +0100
Message-ID: <20130911155120.GW29403@sirena.org.uk>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <1378913560-2752-9-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="I+QmG5g5EzYJzIBt"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1378913560-2752-9-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--I+QmG5g5EzYJzIBt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 11, 2013 at 06:32:39PM +0300, Mika Westerberg wrote:
> This patch adds runtime PM support for the SPI bus analogous to what has
> been done for the I2C bus. This means that the SPI core prepares runtime PM
> for a client device just before a driver is about to be bound to it.
> Devices that are not bound to any driver are not prepared for runtime PM.

Acked-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

I would be able to have this and the other patch in the SPI tree in case
it overlaps with other work - I'm not sure what the plan will be for
merging this stuff but if there were a branch which I could merge into
the SPI tree that'd be good.

--I+QmG5g5EzYJzIBt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSMJF1AAoJELSic+t+oim9xkMP/3dswSEliXhfalyn0oJ8Sofd
PE9LqIgWMrB/J054BQAV+lF/UBftlZU9NMM8gxchtrz8qum12jtzj8ny4absmm1N
w3SwUfpg+Mq+k7guO+gDeKI8OrAkXkWZyT0tBq7uXgrvPibI6OIt4pwaBPK9uIh/
z23lH/IJc9MAy7VZg1HfjKs93xFZzeMYa7+ZPza/kMmZ3wNfhkedF+nsAlO76Cff
PTZ5KB6vtRKf7Ndtg/4ynJw0q4PFT3gIg+QdHSWeZuYB+N6nujwKp3RYamKRqM9p
SJC2iYBI3wl3RJ6W2tAXFiQxHgs1pDQIJm8cAFyy0wbE/xBaQDo9q0sqZ3qICTse
35a1pPDl7voHSGetkKvIvWblBXTzjSW8z2OezRmSFS22OtIS68bvT+taEDxZfnbt
XIBkpAxhXeqn4kl5yh357T+GVF/IhMWXrknpKSxUGb6HKKHL6bCI/CKdqazEA9K1
ICfEbt760rLoHuxqHRermIIWwEdZbYMD6m5h2bbYasZk9ht1KJH5pkBP5DvtGJwX
zevseIDJo6Cw6KNNuOEjZnv5eynqmA5vWQ9kr4E64T4iauIEMEok0twBiJGie9mA
aWaMr+HeuJDGo298FGrE0b3bkVuaEvOyK3GXIYGscejrtWFC5LpwmGxQooN1gexR
Ju09K/1Rc2SCl24bfGQu
=jCxP
-----END PGP SIGNATURE-----

--I+QmG5g5EzYJzIBt--
