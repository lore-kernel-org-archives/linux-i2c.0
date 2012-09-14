From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 12/19] i2c-nomadik: Register sub-devices when passed
 via Device Tree
Date: Fri, 14 Sep 2012 13:32:12 +0200
Message-ID: <20120914113212.GD2630@pengutronix.de>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-13-git-send-email-lee.jones@linaro.org>
 <CACRpkdaCrus9SOpxyK+kV2gKr3sEZJsHCn6ivn2gA3ri0rcvHw@mail.gmail.com>
 <20120912105202.GD2624@pengutronix.de>
 <20120914082754.GE3374@gmail.com>
 <20120914084141.GA2630@pengutronix.de>
 <20120914090228.GH3374@gmail.com>
 <20120914093945.GB2630@pengutronix.de>
 <20120914101542.GT3374@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5gxpn/Q6ypwruk0T"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120914101542.GT3374@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com, arnd@arndb.de, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > 	Documentation: Device Tree binding information for i2c-nomadik driver
> > 		(Documentation should go along with the code)
>=20
> I'm still not too sure about how this benefits anyone. You can ensure
> the documentation is placed in an adjacent patch, so it's just as easy
> to make reference to.

It makes reviewing a lot easier if the documentation what is supposed to
be coded and the actual code are in one place. It also prevents what
happened in this case where the documentation never showed up on the
i2c-list.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--5gxpn/Q6ypwruk0T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlBTFbwACgkQD27XaX1/VRvYpwCgo/5DPJAnUntcGkAMeHXQy34B
7pcAnRe5CifEukcAZY9165/IPzaIPxD6
=fCHt
-----END PGP SIGNATURE-----

--5gxpn/Q6ypwruk0T--
