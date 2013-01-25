From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V8 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Fri, 25 Jan 2013 09:50:12 +0100
Message-ID: <20130125085012.GB5684@pengutronix.de>
References: <547205b4f54e6b48746efc7c22ccc0a59bd9b659.1354502924.git.viresh.kumar@linaro.org>
 <20130124072445.GA8364@nekote.pengutronix.de>
 <CAKohpo=HhdsVRqzGN87yUSz3rEn-3MHEh3rM0-XJJgcX19kXUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKohpo=HhdsVRqzGN87yUSz3rEn-3MHEh3rM0-XJJgcX19kXUg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> >> +/* 10^6/KHz for delay in ns */
> >> +unsigned long clk_delay =3D DIV_ROUND_UP(1000000, DEFAULT_CLK_RATE * =
2);
> >
> > no global variable. should go into the function needing it.
>=20
> I kept it to make sure we don't do this calculation every time... I would=
 like
> to keep it for better performance..

Please move it. It is a constant anyhow, and globals are best avoided.

> >> +                     /* work without sda polling */
> >> +                     dev_warn(dev, "can't get sda: %d. Skip sda polli=
ng\n",
> >> +                                     bri->sda_gpio);
> >> +                     bri->skip_sda_polling =3D true;
> >
> > * Instead of above line:
> >         bri->get_sda =3D get_sda_gpio_value;
>=20
> Hmm.. couldn't get this one...
> So, what i understood is, because we don't have skip_sda_polling now, we
> have to choose some other way to say, we don't support sda.. so we can
> mark get_sda as NULL. right?

Yup.

> The other point about getting gpios first and then calling prepare..
> I don't think that would be right thing to do. Suppose we call prepare
> first, which would
> update padmux on the board. At this time gpio may be in output mode and m=
y burn
> our boards. So, its better to get gpios in desired modes and then change =
muxing.

OK.

Now onto V9...

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlECR0QACgkQD27XaX1/VRsG3QCgpYVYWqufCfHrEfuQehZOqnJq
SRAAn1TPg1qsH6LKqAhuS/5k8/cFSi9t
=58xW
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
