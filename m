From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 12/19] i2c-nomadik: Register sub-devices when passed
 via Device Tree
Date: Fri, 14 Sep 2012 11:39:45 +0200
Message-ID: <20120914093945.GB2630@pengutronix.de>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-13-git-send-email-lee.jones@linaro.org>
 <CACRpkdaCrus9SOpxyK+kV2gKr3sEZJsHCn6ivn2gA3ri0rcvHw@mail.gmail.com>
 <20120912105202.GD2624@pengutronix.de>
 <20120914082754.GE3374@gmail.com>
 <20120914084141.GA2630@pengutronix.de>
 <20120914090228.GH3374@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120914090228.GH3374@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com, arnd@arndb.de, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Ah, sorry. That's my fault for rushing though my ridiculously bloated pos=
t-
> vacation inbox.

:)

> > all the infos I got. Some more context would have been helpful. Is there
> > a branch somewhere with all the things collected?
>=20
> There will be. I'm currently just Ack collecting.=20
>=20
> In fact wait ...
>=20
> <3 mins pass>
>=20
> Now there is:
>   git://git.linaro.org/people/ljones/linux-3.0-ux500.git preview-for-next

OK from having a glimpse, I'd prefer to squash (or have squashed)

	i2c: nomadik: Add Device Tree support to the Nomadik I2C driver
	Documentation: Device Tree binding information for i2c-nomadik driver
		(Documentation should go along with the code)
	i2c-nomadik: Register sub-devices when passed via Device Tree

into one patch and take that via the I2C tree. This will allow me to
resolve the merge conflict in my tree on my own. I don't see a strong
reason to have those go via arm-soc (like prevented build-failures or
easier merges), if I missed such a reason, please let me know.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlBS+2EACgkQD27XaX1/VRtJ+QCggp2+0Dm+twmxqaBtQgraVDhM
w9IAn3V8y8ESJ1xAw8kN9Md37aTJX2VD
=/HGK
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
