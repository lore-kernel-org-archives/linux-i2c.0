From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: imx: check busy bit when START/STOP
Date: Tue, 29 Sep 2009 15:09:06 +0200
Message-ID: <20090929130906.GA24212@pengutronix.de>
References: <4e090d470909290441i7016c4f4g9a929d78838f9b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4e090d470909290441i7016c4f4g9a929d78838f9b7-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On Tue, Sep 29, 2009 at 07:41:44PM +0800, Richard Zhao wrote:
> After START, wait busy bit to be set and
> after STOP, wait busy bit to be clear.
>=20
> Disable clock when it's possible to save power.

As those are two different issues, could you make two patches out of it? Al=
so,
I think it will make reviewing easier if you'd drop the debug print-outs.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrCBvIACgkQD27XaX1/VRvMngCfW5J2C8a2K+pDHHOzRzoCsreA
kScAoKpd1ekC/Wha0yD85U4NaKxz4Z1D
=FxRM
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
