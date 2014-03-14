From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 1/2] i2c: sunxi: Change i2c compatibles
Date: Fri, 14 Mar 2014 10:13:53 +0100
Message-ID: <20140314091353.GK2815@lukather>
References: <1394710643-3411-1-git-send-email-maxime.ripard@free-electrons.com>
 <1394710643-3411-2-git-send-email-maxime.ripard@free-electrons.com>
 <20140313173128.GC25870@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q7oacCJraRPxsh4K"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140313173128.GC25870-NuALmloUBlrZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--q7oacCJraRPxsh4K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2014 at 05:31:28PM +0000, Mark Rutland wrote:
> On Thu, Mar 13, 2014 at 11:37:22AM +0000, Maxime Ripard wrote:
> > The Allwinner A10 compatibles were following a slightly different compa=
tible
> > patterns than the rest of the SoCs for historical reasons. Move to the =
other
> > pattern for consistency across all Allwinner Socs.
>=20
> Dropping support for the existing string breaks existing DTBs. Is
> this really necessary?

I added new ones at first, and Rob said it wasn't worth it since we
were a "work-in-progress" platform.

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/229438.=
html

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--q7oacCJraRPxsh4K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTIshRAAoJEBx+YmzsjxAgSL8QALxiS6tl1AYtyS/AboidzrC7
KuNHDTuipA0y38XaT6hb+4RIegW1jkyJCwcHeIBUF6WZl0lZ2L6z2XmbyHZOAC/x
trb9vDFOI6IBZkoL/i0RzxOQsIF5L9n9WKlWGuOsy0JeZ7kSDEfOZ3krkEFk70U5
8SJSO+C2EcugAi/GDzQDqwyc8EXW6q/jQeMXpHTuQfnEmFXSPnr5XSvl4g6WL/VB
S9C9spEPcihp+QOvdd1kgiTKi+z1g7d1gJhwhctuuyljZA4fhvTo1+jiL+UDsrs7
7seXEuClCXEEI/Ix5p/vGCF9Li7S6RLl1xivY8jayIMPcESNo+qst+vphdhNbOyZ
ArfLocvAugSnoM3dhxJHF8wsirk9s99iLAjc/wwWK/lksYTeJsaozfW2pC9toJ+u
TTgX9jtNxTak4zywF4Ri8rK7xxTHC1fvXriXczuheTjEqJp3ltTKumHVorCYPJz4
QPLGueovjxhZEoaualwbqZju0ZZL0QR5rxYR9EFJT9Wo7FZB9OCpJVXZpg1mD3TG
bDJqt6Kyn6E9hHcGEYU4FvchgM3FGo6LFMloliZUxyYPUarTI9E6RNzW/OQWMFNM
gwbE4xzgukmzmYSCH3z7gEQYPFfadz7ts5NTyYLpZ0Q8ywZo85LrlErBFwGK3Re7
f5X/DwSv5XcKhxXxJp7i
=9Up9
-----END PGP SIGNATURE-----

--q7oacCJraRPxsh4K--
