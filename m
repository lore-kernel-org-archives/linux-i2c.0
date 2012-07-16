From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/2 V3] MXS: Implement DMA support into mxs-i2c
Date: Mon, 16 Jul 2012 12:21:51 +0200
Message-ID: <20120716102151.GC17435@pengutronix.de>
References: <1341850974-11977-1-git-send-email-marex@denx.de>
 <201207131410.29469.marex@denx.de>
 <20120714112929.GB29529@pengutronix.de>
 <201207141409.38554.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E13BgyNx05feLLmH"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201207141409.38554.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--E13BgyNx05feLLmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Marek,

> > I am also still interested to check the runtime switching, but it might
> > take another month until I can really hack on it.
>=20
> Good, there is some bit that probably needs to be flipped to allow this=
=20
> switching. I managed to get this working with SPI, not with i2c though. W=
ith=20

Ah, hearing that it works with SPI is good news.

> i2c, if I restarted the controller inbetween each transaction, it worked =
=2E..=20
> which is not what I'd like to see there.

Agreed.

> > > No, it doesn't. See above about small transfers. Consider the easy
> > > situation where you have sensor on one bus (so you do PIO because you
> > > transfer small data) and you have EEPROM on other bus, where you use =
DMA
> > > because you transfer large data. And the mixed mode isn't there yet.
> >=20
> > I fully understand what you want to configure. I did before. Yet,
> > devicetree bindings are not platform_data and shouldn't be used like
> > them.
>=20
> But then, how would you configure this detail on a per-bus basis? Well al=
l=20

This is a question for devicetree-discuss.

> patch actually fixes a real issue, I'd like to have it in ASAP and it's b=
een=20
> aboue three months already, which sucks.

I am open to ideas improving the situation (which is: a lot more
patches, but not a lot more reviewers)

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--E13BgyNx05feLLmH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlAD6z8ACgkQD27XaX1/VRtrugCZAeJ0OseVZMeJHaXAW/iUDhV6
Y0MAoIKNisitB76lIucWMoblPrC9UYn8
=mTPu
-----END PGP SIGNATURE-----

--E13BgyNx05feLLmH--
