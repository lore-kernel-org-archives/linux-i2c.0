From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v6 2/4] i2c-mv64xxx: Fix timing issue on Armada XP
 (errata FE-8471889)
Date: Thu, 22 Aug 2013 18:17:31 +0200
Message-ID: <20130822161730.GB31704@katana>
References: <1377181146-17341-1-git-send-email-gregory.clement@free-electrons.com>
 <1377181146-17341-2-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1377181146-17341-2-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Eran Ben-Avi <benavi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ike Pan <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Chris Van Hoof <vanhoof-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Dan Frazier <dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Leif Lindholm <leif.lindholm-5wv7dgnIgG8@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Marlin <dmarlin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Zbigniew Bodek <zbb-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2013 at 04:19:06PM +0200, Gregory CLEMENT wrote:
> All the Armada XP (mv78230, mv78260 and mv78460) have a silicon issue
> in the I2C controller which violate the i2c repeated start
> timing. The I2C standard requires a minimum of 4.7us for the repeated
> start condition whereas the I2C controller of the Armada XP this time
> is 2.9us.
>=20
> So this patch adds a 5us delay for the start case only if the
> the compatible i2c-mv78230 is set.
>=20
> Based on the initals patches from Zbigniew Bodek
>=20
> Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Signed-off-by: Zbigniew Bodek <zbb-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>

Applied to for-next, thanks!


--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSFjmaAAoJEBQN5MwUoCm2TZMP/ianJ99IBEK2x3kmRPXE07OQ
AHP1RKqQ+TwBRkKev9QhIHZ4klX2tQpPASq2fk4CaTtCDV1z0oJWoMTzG9jyBPc+
klePbjYIlahMth1q9NQQrUzeY1DfQDYEy+MjzGi2c+ly5tOCVdsjxbBiBuDMdOXi
8HPP2yAeqaLux3w3GEOJVQPexRZfIwZShte8GytZnKxo+tMyEeBAdL7OELNBxtoq
KXvdLyRdT8uqq+k73XNYaEnX5sAPZBucx/eXZyk2ilb7A+mCBgN82g2S6J7UlVli
+yTVZqQmgP+bz4DDQDjD9BdM529Pc4Ji9XJwQ+IStc7K1XY7ShkcvJ6Drzc8eFb8
d3syZipfNML7JTM6FLry6eaxizgSVQ069Ff+jFPSkA+xQGm07AreoR/ERd/4Rb4v
02GQjQ4FyiCpcSITzjJ/jCGM1QFSBM69HvgWfWn+6FFKiqU1yZK6w7ya5C2N6KHZ
D3fbY38EZHVEaQ7HcPi7v4eP2KM6jRz/5SfJmtNABNabKG6yW9ryzLor3soAF9rj
la5OACH5t6bdL9clT5zDe+2BP9hdLHahyIghtj1DvoI/8fZ7ezlVLeN9x44wDSpL
w857rINUBRW5xsggoJGi7LiZGPACOmibXsf4rKyouMb6GvQnk1Fu+2Lp3FTyZHVi
mKBYIP/kfDFgujKSjTk5
=HzmD
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
