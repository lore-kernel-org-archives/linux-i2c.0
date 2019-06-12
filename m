From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 2/8] i2c: i2c-qcom-geni: Signify successful driver probe
Date: Wed, 12 Jun 2019 16:54:45 +0200
Message-ID: <20190612145445.GB18153@localhost>
References: <20190604104455.8877-1-lee.jones@linaro.org>
 <20190604104455.8877-2-lee.jones@linaro.org>
 <20190605062020.GL22737@tuxbook-pro>
 <20190605071625.GK4797@dell>
 <20190605075656.GC29637@localhost>
 <20190605082047.GM4797@dell>
 <20190605083353.GD29637@localhost>
 <20190605084921.GQ4797@dell>
 <20190605085527.GE29637@localhost>
 <20190605141812.GA962@kunai>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190605141812.GA962@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Johan Hovold <johan@kernel.org>, Lee Jones <lee.jones@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, balbi@kernel.org, wsa+renesas@sang-engineering.com, gregkh@linuxfoundation.org, linus.walleij@linaro.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, david.brown@linaro.org, alokc@codeaurora.org, kramasub@codeaurora.org, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, andy.gross@linaro.org, jlhugo@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2019 at 04:18:12PM +0200, Wolfram Sang wrote:
>=20
> > To enable dynamic debugging in driver core you could use something like
> >=20
> > 	CONFIG_CMDLINE=3D"dyndbg=3D\"func really_probe =3Dp\""
> >=20
> > That gives you two printouts per successful probe, for example:
> >=20
> > 	bus: 'usb-serial': really_probe: probing driver edgeport_ti_1 with dev=
ice ttyUSB0
> > 	bus: 'usb-serial': really_probe: bound device ttyUSB0 to driver edgepo=
rt_ti_1
>=20
> I agree that this scales much better than adding strings to every
> driver. Also, the driver core will report failed probes other than
> -ENODEV, or?

Right, errors other than -EPROBE_DEFER, -ENODEV and -ENXIO are always
logged, and the previous three would also be logged with debugging
enabled.

Johan

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCXQESJgAKCRALxc3C7H1l
CP3ZAQCXRPAnR1biCp42ucqiyFiqTwNI2ivpwkFZxtse1SooNgD/f+BDGNZpuRH0
tiQ1iXCC4VjcExWVqH6isBuTFoPS2wU=
=yyFo
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
