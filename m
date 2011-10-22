From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2] i2c: mxs: Let i2c-mxs be built for MX23
Date: Sat, 22 Oct 2011 16:57:15 +0200
Message-ID: <20111022145715.GA10469@pengutronix.de>
References: <1319221664-3018-1-git-send-email-fabio.estevam@freescale.com>
 <20111021184822.GJ15299@pengutronix.de>
 <4EA1C128.106@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4EA1C128.106-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> MX23 and MX28 share the same I2C block, so let i2c-mxs be built for MX=
23 too.
> >>
> >> Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > arch/arm/mach-mxs/devices/platform-mxs-i2c.c doesn't support i.MX23 yet,
> > but still I think the change is correct.
>=20
> Yes, I know. I plan to submit the I2C arch/arm/mach-mxs related patches n=
ext week.=20
> =20
> > Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Still NACK (unless somebody can explain to me how PIOQUEUE could work on MX=
23).

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk6i2csACgkQD27XaX1/VRvCXwCfaC4NiO/EHtznPT+Yr0ANTfeA
pawAnipYYYox/P29+5tiFrs+YNEKKl8n
=pXh9
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
