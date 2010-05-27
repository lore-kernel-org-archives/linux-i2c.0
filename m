From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: Controlling Driver Load Order
Date: Thu, 27 May 2010 23:01:12 +0200
Message-ID: <20100527210112.GA5636@pengutronix.de>
References: <AANLkTikzDvWakd7JW3DzTHinjS3dAlqzPx6K8V2qMDG7@mail.gmail.com> <AANLkTinkY8JYh44UOEPflBUDyQ2wat_AKShRjA3HPxrf@mail.gmail.com> <20100526235246.GA31068@pengutronix.de> <AANLkTikj8yGSK5Ovud_k8f6jWloojqDJmQ_H6pD_IFgM@mail.gmail.com> <20100527041358.GA14070@pengutronix.de> <AANLkTilKUfcYsPqr5kXlONJQAFCaE8D8U9ltQybIzCPu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTilKUfcYsPqr5kXlONJQAFCaE8D8U9ltQybIzCPu@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Emanuele <rob@emanuele.us>
Cc: Linus Walleij <linus.ml.walleij@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Anyway, I better understand the subsys_initcall now and applied that
> to the i2c-gpio and my i2c chip driver.  That worked perfectly for my

With chip-driver you mean the PMIC? Yes, that is probably needed there, too.
Which driver is it?

> issue.  I'd be happy to return a patch of this.  Would be this the
> sort of thing that would benefit from a config option?  Something

Nope, there is no bigger drawback to this and probably a number of useres
wouldn't know what to select here. Just patch the module_init() away.

Kind regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkv+3ZgACgkQD27XaX1/VRv77wCfUg+zBpv7AVSx1Qwyi/QOdv+n
sPoAn0EB/vt5dZk8V0z4FrwRZF+m+kgm
=2QOx
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
