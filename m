From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/2 V3] MXS: Implement DMA support into mxs-i2c
Date: Sat, 21 Jul 2012 17:41:53 +0200
Message-ID: <20120721154153.GA25874@pengutronix.de>
References: <1341850974-11977-1-git-send-email-marex@denx.de>
 <20120715081715.GA2429@S2100-06.ap.freescale.net>
 <20120721124406.GA9946@pengutronix.de>
 <201207211611.58956.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201207211611.58956.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Yet, if I know the compatible property for the mxs I2C driver, and also
> > know the CPU type (be it MX23 or MX28), I can deduce from that a lot of
> > information, including DMA channel. That is fix. Why encode it?
>=20
> You know the compatible and the "fallback compatible". From the later one=
, you=20
> can deduce nothing if that happens to kick in.

Even if the driver was matched because of an MX23-I2C "compatible"
binding, both devicetree and runtime could provide data that it actually
runs on MX28. That shouldn't be a problem.

> btw. the PIO discussion on DT discuss is completely ignored. How shall we=
=20
> proceed, this driver is stalled for too long.

IIRC I mentioned that a discussion about the bindings won't make the
next merge window. That's why I proposed either module_parameter or
dropping the binding entirely as possible inbetween options.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlAKzcEACgkQD27XaX1/VRvwrwCgqakdaYGW94rzeNSSilA43Ez6
PuYAn16zYtMTnr9g1d1yx+MLJudeity7
=0/j1
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
