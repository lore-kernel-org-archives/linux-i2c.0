From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] I2C: BCM2835: Linking platform nodes to adapter nodes
Date: Thu, 28 Nov 2013 17:13:38 +0000
Message-ID: <20131128171338.GM27568@sirena.org.uk>
References: <527CB3A1.7050808@koalo.de>
 <527D1870.8080302@wwwdotorg.org>
 <20131126130553.GF25130@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n1iI6MeELQa9IOaF"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131126130553.GF25130-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--n1iI6MeELQa9IOaF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2013 at 01:05:53PM +0000, Charles Keepax wrote:
> On Fri, Nov 08, 2013 at 09:59:28AM -0700, Stephen Warren wrote:

> > That all said, I wonder if the I2C core shouldn't do something like the
> > following inside i2c_add_adapter():
> >=20
> > if (!adap->dev.of_node && adap->dev.parent)
> > 	adap->dev.of_node =3D adap->dev.parent->of_node;

> Should this not also have an of_node_get to increment the ref
> count on the node?

Given that it's pointing to the device that registered the I2C adaptor
it should be able to assume that there's a reference already.

--n1iI6MeELQa9IOaF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSl3m/AAoJELSic+t+oim9CZUP+QGJxOZTzaimUshk2vxFILju
wcoa96eGjtNYFFQEk7/2zZBwuPy55WFbzqHos5B2Xg9KDkeKwaois2yy5MNDHEOF
xeTRM13Nh2Mqj2Z4ZImXkJAP465dMA3EylY2zwDxJAgRS8IuQLGJj+3euihDRMZI
gKWnXizFU3IqHxH1aUityIwaMzhoe0VPCtXlNG/0vWzUnV+jF4C+/Aa0Ov2NSlSi
yXd2C/QM/KEfWL5QUCVjAhTdNM1L0Lr592hldD5oS+nbG/zaLuftkOklVmMBvlGf
3wCHnpOnccKVqWNtBtE8pqo2n3beQR7DhIFRLMMkQUZPu2lWsn5zlRVrwFEvwJKo
8XRrkBGo1x3L7qZE/kk5PboRoiOkOBxKjRoKBAWnvHmtOQJejGDEjNHk25x8J5Yh
THx45cK4F01W2GikBDwFKSJtUfWSBZv+qClByzaU8uFBk7Xs0qRNsVuLPAT7k5fB
HUDF4Q6ZBvF82ytc7NThS8FEsYdHdbF7gfFGGDrZlL1JpqZiNqTfUijSbttPA1/5
z84UYOYUZ/22HhT0MeFHDqg0RrY7dZhL9NzL0tcoNt41vMqsK5dalrOe1woWjJxb
jVL5N0rnRX68FWBpU5vDV426Wo5rniyZq1lGe99GEVqywe//NjwcxSoGlqBHkBgJ
+tXOACe6PZR/qfA+uDFj
=yYHN
-----END PGP SIGNATURE-----

--n1iI6MeELQa9IOaF--
