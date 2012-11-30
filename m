From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V7 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Fri, 30 Nov 2012 15:05:14 +0100
Message-ID: <20121130140514.GF23231@pengutronix.de>
References: <71e27515a050a2c7d18272b84ff7ec3ec8b11cae.1353824555.git.viresh.kumar@linaro.org>
 <50B20670.5070509@pcserviceselectronics.co.uk>
 <CAKohpo=_2xwj+NCpZPB1EsWiGPLafc3XKVbRT+690AkHB76AWw@mail.gmail.com>
 <50B35642.7030104@pcserviceselectronics.co.uk>
 <CAKohpomNTKFJQCrZdC81OiQpjdtK85XXWfvvB=XYb85e49OBZA@mail.gmail.com>
 <20121126202003.GA3384@pengutronix.de>
 <CAKohpokgcvaSHNDoN2epnsxSmpKJ6GaWph0EW+rrkCfXjBrUyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GV0iVqYguTV4Q9ER"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKohpokgcvaSHNDoN2epnsxSmpKJ6GaWph0EW+rrkCfXjBrUyA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Paul Carpenter <paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--GV0iVqYguTV4Q9ER
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2012 at 11:19:09AM +0530, Viresh Kumar wrote:
> On 27 November 2012 01:50, Uwe Kleine-K=F6nig
> <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> > In reply to a more detailed problem report that should be addressed by
> > this series on spear-devel I asked a few questions to rule out 6/ and
> > 7/. I cannot find it in an public accessible archive though. It's about
> > a sta529 codec. When switching sample rates the codec then holds down
> > SDA. After an additional clock pulse the device and bus are OK again.
>=20
> Thanks for adding these here :)

Hmm, the points mentioned seem valid to me.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--GV0iVqYguTV4Q9ER
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlC4vRoACgkQD27XaX1/VRsEiQCgl4wCU5+LvcsafHjh95ItrroW
A3AAn0eAXjBgsY/VaVgnABtwGwh84yfb
=B/nq
-----END PGP SIGNATURE-----

--GV0iVqYguTV4Q9ER--
