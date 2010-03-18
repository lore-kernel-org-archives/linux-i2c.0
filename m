From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: PCA9564: "bus is not idle" issue
Date: Thu, 18 Mar 2010 10:19:17 +0100
Message-ID: <20100318091917.GA27165@pengutronix.de>
References: <f69abfc31003170559y3c0a5a6fi91c1ae7692700c66@mail.gmail.com> <20100317135223.GD4153@pengutronix.de> <f69abfc31003170826j18fa0fddq1c46b8bcebf75c57@mail.gmail.com> <f69abfc31003180201m5c5e167enf8256c4843e0c6ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f69abfc31003180201m5c5e167enf8256c4843e0c6ba-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> If I don't redirect syslog to a remote host I get i2c fail. So here you a=
re:

Thanks!

[...]

> As far as I can tell the last transaction lacks "=3D=3D=3D STOP" state.

Yes. The bus-status being 0x58 instead of 0xf8 says that, too. I wanted to
check if there is something flaky before. Will have a look, but will probab=
ly
be the weekend. You said it does not appear when you use 2.6.26, right?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuh8BUACgkQD27XaX1/VRvOsQCfZwW2qs/B2fFxGkF2VWtdZd09
AnAAn3HUYDo0rwWnbwHTF0lx5POusqPb
=kscI
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
