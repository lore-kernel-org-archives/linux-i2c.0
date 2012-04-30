From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/2] I2C: Implement DMA support into mxs-i2c
Date: Mon, 30 Apr 2012 21:52:21 +0200
Message-ID: <20120430195221.GB28226@pengutronix.de>
References: <1335738969-27445-1-git-send-email-marex@denx.de>
 <1335738969-27445-2-git-send-email-marex@denx.de>
 <20120430060554.GB7926@pengutronix.de>
 <201204301410.14393.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201204301410.14393.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > >  static int mxs_i2c_finish_read(struct mxs_i2c_dev *i2c, u8 *buf, int
> > >  len) {
> > >=20
> > > -	u32 data;
> > > +	u32 data =3D 0;
> >=20
> > Unrelated, useless change.
>=20
> Have you tried compiling the code with gcc 4.7?

What has the compiler version to do with the relevance? :) This has
nothing to do with adding DMA support. Plus, nobody so far could tell me
what path gcc is seeing there.

> > > +	i2c->dma_mode =3D 1;
> >=20
> > Have you measured the overhead of DMA? I'd still think that
> >=20
> > 	if (MX23 || msg->len > 24)
> > 		do_dma
> > 	else
> > 		do_pioqueue
> >=20
> > might be worth considered.
>=20
> It might, but in the 2.6.35.3 I have from FSL, it only does:
>=20
> WARN_ONCE(len > 24, "choose DMA mode if xfer len > 24 bytes\n");

Well, we are back to the "FSL code is just a reference" topic. I truly
hope that part was implemented because of laziness and not because of
hardware limitations.

> Also, I tried switching PIOQUEUE/DMA, but didn't get it working. We might=
 as=20
> well make this dma/pioqueue mode configurable as well as speed via platfo=
rm data=20
> until someone comes up with a patch that can mix pioqueue and dma?

User configuration is not an option here IMO, because PIOQUEUE would still
fail for bigger transfers. "Always DMA" might be better then. But I will
try to switch modes this week, that's just too tempting.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+e7XUACgkQD27XaX1/VRseXgCdFEAJryFQ9lPzFnb5dluzkJJe
ZqIAniAoMKJ1nHZZ5QruUry6TIA9OD7B
=HKxH
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
