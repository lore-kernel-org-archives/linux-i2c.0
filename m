From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: trouble with PCA9555 driver on AIMB 210
Date: Tue, 11 Dec 2012 15:07:07 +0100
Message-ID: <20121211140707.GA4117@pengutronix.de>
References: <CABkKHSZQqaegLW4Kg8OSh4d30qd5V98JBHtPn7M=Luz1qeTMFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CABkKHSZQqaegLW4Kg8OSh4d30qd5V98JBHtPn7M=Luz1qeTMFA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aleksander Dutkowski <aleek998-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> There is lack of gpio folder, where I could read/write gpio values. So

I can't see that you actually exported a GPIO? Check
Documentation/gpio.txt for further assistance.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlDHPgsACgkQD27XaX1/VRtBmgCZAUkgFq6zgAHV6X4dM62Y4NG3
2rkAnA3c0f2Rp4z4PIDmKumoaYIN92pR
=Z7fd
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
