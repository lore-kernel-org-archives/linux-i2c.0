From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/2] I2C: Implement DMA support into mxs-i2c
Date: Mon, 30 Apr 2012 22:30:16 +0200
Message-ID: <20120430203016.GD28226@pengutronix.de>
References: <1335738969-27445-1-git-send-email-marex@denx.de>
 <201204301410.14393.marex@denx.de>
 <20120430195221.GB28226@pengutronix.de>
 <201204302207.39112.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LTeJQqWS0MN7I/qa"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201204302207.39112.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--LTeJQqWS0MN7I/qa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > What has the compiler version to do with the relevance? :) This has
> > nothing to do with adding DMA support. Plus, nobody so far could tell me
> > what path gcc is seeing there.
>=20
> It complains that data might be undefined, do you want it in a separate p=
atch=20
> then ?

Yes, but only if you can prove that the compiler is right.

> I still havent figured out how to flip between pioqueue mode and dma mode=
=20
> without the controller getting confused, so I prefer to postpone it into=
=20
> subsequent patch. Eventually, I agree it'd be cool to be able to do this=
=20
> switching.

Yes, send V2 with DMA by default, and I will give a try on the
mode-switching later, too.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--LTeJQqWS0MN7I/qa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+e9lgACgkQD27XaX1/VRtd8gCdE9LCawSS1XqzD8NVyym0OMZz
2HgAoKwFiwOZYajShHpzeCa/Lcf1naX2
=wVyk
-----END PGP SIGNATURE-----

--LTeJQqWS0MN7I/qa--
