From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-designware-platform: don't check resource with
 devm_ioremap_resource
Date: Tue, 11 Jun 2013 20:58:55 +0200
Message-ID: <20130611185854.GE3376@katana>
References: <1370613449-29719-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="idY8LE8SD6/8DnRI"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1370613449-29719-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--idY8LE8SD6/8DnRI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2013 at 04:57:29PM +0300, Andy Shevchenko wrote:
> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Thanks, yet I applied my original patch which removes this pattern from
the whole subsystem.


--idY8LE8SD6/8DnRI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRt3NuAAoJEBQN5MwUoCm2dMIP/09mOdXCoMGsC4mz7VyAm9xN
X6hOqQv/A54h2AVvI/pw3jcbHzXRs1WDw787+TduQCrZZNvPhpgfsBdG+TfIgZxt
9Ev7RudNl6+n0OtUaJR0EUV6fPSFc+AySL5pM1RDIksKxcBWHbXgJS//nQDZ9yL0
Km+8V6wlN9fB0EoRw0siRL8B714x2C1XHX47XmUbvk0PeQvLusYz6fjsjmI8K+dn
akLqFdXfN21HUVIHe2Nmh592EnuTeU/nWZyozBfl6QVQhiH1TKg62/NYuVQ5dMvy
TcKWziuOtvrMEU87ejrzNGCuZhuUZ6S3/OxYfJZD7fDnXgPjwSvOiYFzyMkES6xq
6OGvJx7yS6ew9YphveR7FSKNxKMB1u5foowFrBziiFgaYluu7QNS09QE5yVq35JF
f0b2N6jtZU8SK0sxYhdq//OEu/YdMLwhYA19nUWKRJ7Wy+7v90VQFQKB6zWXAy5V
bj9n7KIslsr4AWNFEFFA2uNI786RYGCHCQYvvIsgYmw8T20b7pbFtgfrdpAVnmP3
hdUZ/Y62iB8xJ6ZeKDJzx17jw3ftT1a4XMRZDL4hxyNUqy3UIgpHfGBwv9gpl2+6
YanPQmSOTBAiDpgOD3ACr2Zck5G0dYGpYp/whL7Sk2dJ3BSR7UQFW2PyQj/GEAej
HcRWdtM/LvErP06ZUG6M
=TNAW
-----END PGP SIGNATURE-----

--idY8LE8SD6/8DnRI--
