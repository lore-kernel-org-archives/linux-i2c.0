From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 3/3] i2c: at91: added slave mode support
Date: Tue, 15 Jan 2019 23:43:51 +0100
Message-ID: <20190115224351.rtbqaqro5pl3dvov@ninjato>
References: <20181227151311.20107-4-ludovic.desroches@microchip.com>
 <201901050345.JaEWLmjh%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k747szf62j7ndfj6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201901050345.JaEWLmjh%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, kbuild-all@01.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, me@jue.yt, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com, Juergen Fitschen <jfi@ssv-embedded.de>
List-Id: linux-i2c@vger.kernel.org


--k747szf62j7ndfj6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> All errors (new ones prefixed by >>):
>=20
> >> ERROR: "at91_init_twi_bus_slave" [drivers/i2c/busses/i2c-at91.ko] unde=
fined!
> >> ERROR: "at91_twi_probe_slave" [drivers/i2c/busses/i2c-at91.ko] undefin=
ed!

That needs to be fixed. Rest looks good to me!


--k747szf62j7ndfj6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlw+YicACgkQFA3kzBSg
KbbCRw/9GyKnSdo2hH8DwxrBSUXFUdteS1XqDLnIl1XxXov0X/hBo7cy8ahSyaH1
ZtoYoB8kaRpi2DzgJzXslSWvy4YOan5wFyYErgxEh03EXFDWns0JoBee8HVU8Bax
vMln99pOTSa1wujN1zKcrdp6S4m4dPxfe4Xedr0XC5W7waQlL1QOdak+q/ap7i1x
DkklfHKCwHN+Z4erOe6IxpDHrhUOKDladtdASn/Te1zZPLKQrGfYtwyHx+7+IXBj
qNzqo0u+q5depphDBMLJmWLMufkQMRTk+MUeULSE53rUOUFR5YsFIDlbywa0zdUb
OG5tLyDQjgU7YOMxpqD1/I3phTZyPdRegnDrfAI0uC/8a1oY89GAvvf+VHgZ5CEC
bIkZy9fymqfckw3v0CxPaMsObNyM1ac/DdYOKRcsC0HIpcI4vJnN48d4Cqp6+PCx
ujwQwgBU1FmlBakGxZoJVxSb327Qo7F7twqECvgYHOrTMkzeM3atgownEQxJuUrx
KGYUi1XyN8StZtzY7ywiU9qbQpEb2mbGcjhy3qo8OfbxdAR6sRmyLL1vVknCYN3P
NaOVK+OyPidbSJr5EEsYY1PoJxrU3tjl0xtDbb+GUEzUecjoAZlWkhil5LkRGylC
yThBrkrbqblwHD67UtiB6cDoOCtaoyTVHU5KytR04CQyJP5Qs7M=
=2yQK
-----END PGP SIGNATURE-----

--k747szf62j7ndfj6--
