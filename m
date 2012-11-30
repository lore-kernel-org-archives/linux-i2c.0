From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V6 2/2] i2c/designware: Provide i2c bus recovery support
Date: Fri, 30 Nov 2012 15:15:07 +0100
Message-ID: <20121130141507.GH23231@pengutronix.de>
References: <9adb13c1a2e35dce401b0a50e455fe1be76285a7.1349348405.git.viresh.kumar@linaro.org>
 <6262d3a8e87858d938362c4aa44caf40938f2be9.1349348405.git.viresh.kumar@linaro.org>
 <20121124210314.GC3210@pengutronix.de>
 <CAKohpokdx91dkK3vBsjBMtc9iHypM_ZK2oJm5vcjkdiT-eW7vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IbVRjBtIbJdbeK1C"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKohpokdx91dkK3vBsjBMtc9iHypM_ZK2oJm5vcjkdiT-eW7vQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>, Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--IbVRjBtIbJdbeK1C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >> +             if (adap->bus_recovery_info &&
> >> +                             adap->bus_recovery_info->recover_bus) {
> >> +                     dev_dbg(dev->dev, "try i2c bus recovery\n");
> >> +                     adap->bus_recovery_info->recover_bus(adap);
> >> +             }
> >> +
> >
> > This should be in the core?
>=20
> Because wait_for_completion() would fail in controllers, so i kept this
> code here. How will we come to know about xfer failure in core?

Somehow true. We need the clarification of .timeout and .retries in the
i2c subsystem first, then we can think of returning a specific
-Esomething here which could indicate that a recovery might help. Might
require another thinking if that should be different from -ETIMEDOUT.
Still, we need the cleanup first, and because this may take a while, it
is not your problem.

So, we could start like above and fix users later.


Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--IbVRjBtIbJdbeK1C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlC4v2oACgkQD27XaX1/VRs9AwCgpZSz7CtcuJVxbmdcT45R+Wox
7sIAoIBLpmMyvQz+hcbyFdFEuUDyevtI
=RzZa
-----END PGP SIGNATURE-----

--IbVRjBtIbJdbeK1C--
