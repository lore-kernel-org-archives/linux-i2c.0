From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V8 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Wed, 19 Dec 2012 01:00:00 +0100
Message-ID: <20121219000000.GC19157@pengutronix.de>
References: <547205b4f54e6b48746efc7c22ccc0a59bd9b659.1354502924.git.viresh.kumar@linaro.org>
 <CAKohpokjxh0DDZVFy1uN7ejdd_=jkbyVvYCy73jJChMy5dKeGA@mail.gmail.com>
 <50C1005B.7@pcserviceselectronics.co.uk>
 <CAKohpo=4xDOQMcbraq9Hj1Gq1xOgSoDj9xoYLHcosTyUJkD6fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+xNpyl7Qekk2NvDX"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKohpo=4xDOQMcbraq9Hj1Gq1xOgSoDj9xoYLHcosTyUJkD6fg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Paul Carpenter <paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org>, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2012 at 10:22:37AM +0530, Viresh Kumar wrote:
> On 7 December 2012 02:00, Paul Carpenter
> <paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org> wrote:
> > OK by me
> >
> > Reviewed-by: Paul Carpenter <paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org>
>=20
> Are you taking it for 3.8 now?

Since I missed the things Paul luckily spotted, I think it might make
sense to actually use the framework myself to get me a better feeling
that I have not missed anything else. So, I am going to add support for
another I2C master controller to your framework and see what will happen
when I actually use it. It will be probably the mxs controller, I
collected the hardware for that already...

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--+xNpyl7Qekk2NvDX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlDRA4AACgkQD27XaX1/VRu9igCePaafmxrzfGuSOCBwSqelpYRd
nHkAnimXpaqU6F3PrvgwlHbBCfVU67B6
=eWP5
-----END PGP SIGNATURE-----

--+xNpyl7Qekk2NvDX--
