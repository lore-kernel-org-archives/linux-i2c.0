From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: Accessing EEPROM from Linux driver
Date: Tue, 24 Jan 2012 12:13:20 +0100
Message-ID: <20120124111320.GD2609@pengutronix.de>
References: <CAGm1_ku3N0ksJ4USt9Rae=Yo3xcTFX=dLVh6=YMkFjUaLABu-A@mail.gmail.com>
 <20120124100636.GB2609@pengutronix.de>
 <CAGm1_ksgrtyAmo73f-GCr_ZH=8i8LxbwFpMH81U2STQzmT9GYQ@mail.gmail.com>
 <CAGm1_kugwA-rWXmCNNcxRc4XZ5u-2N8Rwf+LBaoRrOgBWMTbDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d01dLTUuW90fS44H"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGm1_kugwA-rWXmCNNcxRc4XZ5u-2N8Rwf+LBaoRrOgBWMTbDg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--d01dLTUuW90fS44H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Wolfram, do you have any example how to access at24_macc_read()? My
> kernel is 2.6.37. Theres is a statement to export this code to the
> kernel via chip.setup(), which appears to be NULL. What headers do I
> need in the network driver?

I haven't used it myself, but using LXR [1] you can check current users
of at24_platform_data and find users (davinci) using this feature.

[1] http://lxr.linux.no/#linux+v3.2.1/include/linux/i2c/at24.h

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--d01dLTUuW90fS44H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk8eklAACgkQD27XaX1/VRsQ7ACgpukJx3QDFcEnPr7NrkxMklUL
dI8AnjvpLu0NRt8WUpKtMw21ovbCwe7U
=HgY3
-----END PGP SIGNATURE-----

--d01dLTUuW90fS44H--
