From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 3/4] i2c: mv64xxx: Fix bus hang on A0 version of the
 Armada XP SoCs
Date: Wed, 8 Jan 2014 16:28:41 +0100
Message-ID: <20140108152841.GD15182@katana>
References: <1389193589-18485-1-git-send-email-gregory.clement@free-electrons.com>
 <1389193589-18485-4-git-send-email-gregory.clement@free-electrons.com>
 <20140108152139.GB15182@katana>
 <52CD6E1E.5040409@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52CD6E1E.5040409@free-electrons.com>
Sender: stable-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: linux-i2c@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >> +	{
> >> +		.compatible =3D "marvell,mv78230-a0-i2c",
> >> +		.data =3D &mv64xxx_i2c_regs_mv64xxx
> >> +	},
> >=20
> > I think a oneliner entry like the entries above is easier to read, but
> > that is very minor...
>=20
> By using one line we would break the 80 character rule,
> hat why I did in this way.

This rule is there to keep code readable. If it doesn't help
readability, it may/can/should be broken IMO. It's a mileage, though.


--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSzW6pAAoJEBQN5MwUoCm2V8wP/jVDvlUEheveApEPOPaVPGC+
/fFxFyAjl2JW9C2nNxoxADoUUFZovGyc5sQXzXYhI8Cr8mr+m0UUi6RtTTYyTVJP
Ud6byFDptoQ/WguG6ypq0jeCDxciMzmMRxCYsGXnDdpE0cda0MuqDD0HUHeJSBee
6TacHfAtwSthWxTANp/Rbgq4EmDTiIbVkCTJGYBTAcIKljJUMYDMgQ0/ey0d0gPB
rDUBwM438PZ7hlH8kigfknW0rPyQMEvb8iAvCAUUmnB2A3P219wy2jCYfkNUCB4n
ijNvFBSyA9KzrYlhzNrTJrAyxFvWHMOCU454arqzoGsAa7je7Cqa7Io5nFZN9Z3D
90PEH0FG/nqQsHx/0KuZLCfb4WViJoTppdP0+fyTegO+D1Qj+cV1tQlWf3uqsEXh
rEM+DYnBXlNiJOK1VQv5BM5WUoHMSSW/umcRp92bebr6SU8RRVV9sOfz6nKFOoH9
cVjPC/ihyvXnz6qZpu/vRoUXBjIp1e1DGHwWWiPE8wB1/83cwnYm+myTMJ+2p4iF
R11Du810Oq5SgMWTM9Z3rxHwd0GJsV9B+/plvYKBHY19ax6lgNnmjbGliY/sG3Xa
KdcoAIM15FQvnQE8fmVGJ90znty+oKCpY9QHlSY5aqqpX+3sBQcoR9LysmKPPCNi
3GUIs/VtrGFzZYhIfuhE
=S4Qw
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--
