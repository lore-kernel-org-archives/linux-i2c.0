From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [GIT PULL] i2c updates for 2.6.30
Date: Wed, 8 Apr 2009 10:03:56 +0200
Message-ID: <20090408080356.GA3072@pengutronix.de>
References: <20090328213950.1c788471@hyperion.delvare> <10f740e80904071320t2fdd073bs51f3a8abf0f60e36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <10f740e80904071320t2fdd073bs51f3a8abf0f60e36-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> drivers/i2c/algos/i2c-algo-pca.c:197: warning: 'state' is used
> uninitialized in this function

ACK. Will send a patch in a minute. Thanks for reporting!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkncWmwACgkQD27XaX1/VRvhCwCeObGNPu8Uoq0aA8+ST0qJYYy8
J/gAn24C55RytbxTtWYnEVZZztPpvXYN
=+hAI
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
