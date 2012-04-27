From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: possible MXS-i2c bug
Date: Fri, 27 Apr 2012 18:37:56 +0200
Message-ID: <20120427163756.GH16504@pengutronix.de>
References: <201204261326.29388.marex@denx.de>
 <201204271708.53467.marex@denx.de>
 <20120427154119.GF16504@pengutronix.de>
 <201204271753.39516.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6cMF9JLEeZkfJjkP"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201204271753.39516.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--6cMF9JLEeZkfJjkP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> But then you don't have the DMA chain linked. Which I wonder if the contr=
oller=20
> has any problem with or not. I tried yesterday, got wrotes working perfec=
tly,=20
> but still had issues with reads, which is exactly what needs to be chaine=
d.

Yes, the read needs chaining of two "DMA command blocks". That should be
the only chain needed, because of how the driver handles reads. It is
still one I2C message, though.

> I'll poke further eventually.

I really hope it works out! That would be great.

> > Regarding Figure 27-10, the first I2C write command could be sent
> > seperately (probably even via PIOQUEUE).
>=20
> I wonder if we want to combine pioqueue and DMA, that might create quite =
some=20
> franken-driver.

Might be true, yet I hope it won't. Most I2C transfers tend to be very
small, so PIOQEUE would have some advantage here (less overhead).

> > The only thing to be chained is the I2C read command and the actual
> > reading of the data.
> >=20
> > Just checked, the FSL driver does it basically this way, too.
>=20
> Which doesn't mean FSL driver does it correctly, but it probably
> worked for them and there was some bug in my DMA tinkering.

It's only a proof-of-concept. We both know that :) (If it works, that
is, AFAICT that one will fail for transfers bigger than PAGE_SIZE, too).

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--6cMF9JLEeZkfJjkP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+ay2QACgkQD27XaX1/VRtxXQCfWmCCLhhzGoyXqsIJUCMbUv9N
VCYAnj8Raa7FcMCJ+Wp9eaTk/oEa9hb6
=ft6j
-----END PGP SIGNATURE-----

--6cMF9JLEeZkfJjkP--
