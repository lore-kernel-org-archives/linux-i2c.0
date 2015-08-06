From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v1 02/10] i2c: core: Have clients point to their firmware
 nodes
Date: Thu, 6 Aug 2015 23:06:17 +0200
Message-ID: <20150806210617.GA1523@katana>
References: <1435676108-20590-1-git-send-email-tomeu.vizoso@collabora.com>
 <1435676108-20590-3-git-send-email-tomeu.vizoso@collabora.com>
 <20150731103624.GB1522@katana>
 <CAAObsKD557c5ssAYUqa=azCs05=o5CA++-sFOBx=063Zwev2dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAAObsKD557c5ssAYUqa=azCs05=o5CA++-sFOBx=063Zwev2dQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2015 at 04:17:28PM +0200, Tomeu Vizoso wrote:
> On 31 July 2015 at 12:36, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> > On Tue, Jun 30, 2015 at 04:55:00PM +0200, Tomeu Vizoso wrote:
> >> This is needed by platform-independent code that needs to do something
> >> with devices based on the data provided by the firmware.
> >>
> >> Signed-off-by: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> >
> > Dunno the status of this series, but the i2c change is trivial enough.
> > So in case, the rest is accepted:
> >
> > Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
>=20
> Currently my series is moving away from fwnode because the current
> approach is very much dependent on the firmware, but I think this fix
> is worth in its own because someone else will find this problem sooner
> or later.

If you think it is a bugfix, then please resend this individually. If
not, we will just wait until someone needs it.


--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVw8xJAAoJEBQN5MwUoCm29fgP/jHOSH7F5lOCzdEXz/720IT2
PFGS6byPnWBeKt/qnFiu7i9XQKk48azV4slh7WyhPIKhQN4wE7gouXJOfnLzOMkX
g7a5S/nfo+gB+r2pvOAUfUhy+zxXS1bJZmYASOCkcjUqfW7/7P9vJG8UirOEyIv+
b5mYXVkpNoZq14GQcN0x72OxzqFPPTnZQPx6tYPM6rYNOA+GXbw378gf7yco5z7Q
f2lEZfpGWOlPIl89qlXcgPwT2nM7lVmn/LVYQgns5ZFBOXEXhDQGko1miP0c1m2g
SDv67EskYf6tOJsukxtfFgUQfHfjBNTQa1gmUwu1s6BTUGLYDdNWV7dxUJ1YiKxs
fBA3Ti6PVIzUeCg9z5nPHAfLGTXu2xCuz9vJ/nXlacHeiSizvfz9tcmhFe6dpjUO
9I0ACQV6Im5EaneVpNswVA2mmjHRYrTvYKkNuUlEQcbgqLLdzuVggrJpYIwhKLkd
QPnCxGieA37cR30rLiCS4eylIixq1kke1k8MKTK07BEJB8xXjx8v8AGQerkxUSgA
8+ByPyohrmMGjBf9LusYXUOke0FFOA+PmgdhmwNCvYRJZptR8H9BXmuzfsILJwkN
fXxDEma7U2cgBzX2bV1Egx0bF9mmyGugunRxIODJi9gRNO43NmQj6QQVkyBXVxcH
5N3wNb28jEjDjO4F7px9
=Va98
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
