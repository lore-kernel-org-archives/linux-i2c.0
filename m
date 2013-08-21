From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: passing two interrupts two an I2C driver
Date: Wed, 21 Aug 2013 18:54:46 +0100
Message-ID: <20130821175446.GI26118@sirena.org.uk>
References: <520E3B8F.9010800@samsung.com>
 <520E7417.3090606@wwwdotorg.org>
 <20130819084227.GC3719@e106331-lin.cambridge.arm.com>
 <5214AA52.2060209@samsung.com>
 <1377088624.10707.23.camel@hornet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8jNwmpfkpox/fiJK"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1377088624.10707.23.camel@hornet>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org" <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org" <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, "l.czerwinski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <l.czerwinski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org" <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, "s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--8jNwmpfkpox/fiJK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 21, 2013 at 01:37:04PM +0100, Pawel Moll wrote:

> So let me ask such question... If Device Tree didn't exist, how would
> you make drive such device? I guess it would require some custom code,

It's always done using platform data, same for SPI - if we update one we
should probably update both.

--8jNwmpfkpox/fiJK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSFP7jAAoJELSic+t+oim9OJwP/j+jGqBR9P5yVIbWS1qfHx8q
4nErg1/sUNwOm9SsbWgK1o0xQZ9t6lmFEhqlqHbcn9r18bU75GjDjEUdRZBuUDqO
oEfb0DRl3wPG7uHbPCSDI+Wzo/RcbRi8dpegtWWrs+xSSZlRn1VDnKSNLtyd+wfV
NkaAPiDUVfeMJXb8fyT+5hUNAU0O9OCB7sYV5nRyFPPQVxUlsgMIHHjYXali50IT
vWYGzo0UTpfxuiVWsnRkfEnEsqxt6yCq12zWqN/WBgrPHim7ft0XHwLtDb185HDe
9uda3dGZfV9dzGNjc6wCl2d5qcRyJEZ/u7PQEz/R4UKTA+mtnwk4A6X/4JorQ63E
Yh82XGdzLuTQkUlErhMek1LfrsQCGN7SjeJtUtcZnb8k6hNus/6XedyQ9hN92Y0+
kcIctoTH05CwZCbnD+EF3cfWw5V+KeTRCdzTEjzJ3tqhGeFJrcxYNZ61/af7x2iu
pEl+E1TCLSOrMYGonoMqqvLJ8Kba/BeKc1vz7l1BGCztkFdH0TTJ9OdiuSQdK7If
FckS+QZhYT79SF9W0lMFsGsbzJhtzDptjnNxVQOsz2yRIjpBL0PJ6MZ8pdM+2MSz
bcHKmlQwOafDSHFCkJQebw/JPf8I2nStIMUI4Xefss7oVM+1nmwSlzgGZ4DVyBlV
a4n2UEhTQMMbdNN+YhMf
=FIw4
-----END PGP SIGNATURE-----

--8jNwmpfkpox/fiJK--
