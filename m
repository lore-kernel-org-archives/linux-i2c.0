From: Michael Shych <michaelsh@mellanox.com>
Subject: RE: [PATCH] i2c: mux: rename files to not have superfluous prefixes
Date: Sun, 6 Aug 2017 09:37:18 +0000
Message-ID: <DB5PR05MB1432EEFEB2D0A53080E4D403D9B40@DB5PR05MB1432.eurprd05.prod.outlook.com>
References: <20170804090736.13404-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr00085.outbound.protection.outlook.com ([40.107.0.85]:39392
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751258AbdHFJhV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 6 Aug 2017 05:37:21 -0400
In-Reply-To: <20170804090736.13404-1-peda@axentia.se>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Peter Korsgaard <peter.korsgaard@barco.com>, Michael Hennerich <michael.hennerich@analog.com>, Guenter Roeck <linux@roeck-us.net>


> -----Original Message-----
> From: Peter Rosin [mailto:peda@axentia.se]
> Sent: Friday, August 04, 2017 12:08 PM
> To: linux-kernel@vger.kernel.org
> Cc: Peter Rosin <peda@axentia.se>; Wolfram Sang <wsa@the-dreams.de>;
> linux-i2c@vger.kernel.org; Peter Korsgaard <peter.korsgaard@barco.com>;
> Michael Hennerich <michael.hennerich@analog.com>; Michael Shych
> <michaelsh@mellanox.com>; Guenter Roeck <linux@roeck-us.net>
> Subject: [PATCH] i2c: mux: rename files to not have superfluous prefixes
>=20
> Keep the module names intact using extra lines in the Makefile.
>=20
> Signed-off-by: Peter Rosin <peda@axentia.se>

Acked-by: Michael Shych <michaelsh@mellanox.com>

> ---
>  MAINTAINERS                                                 |  8 ++++---=
-
>  drivers/i2c/muxes/Makefile                                  | 13 +++++++=
++++++
>  .../{i2c-arb-gpio-challenge.c =3D> arb-gpio-challenge.c}      |  0
>  drivers/i2c/muxes/{i2c-demux-pinctrl.c =3D> demux-pinctrl.c}  |  0
>  drivers/i2c/muxes/{i2c-mux-gpio.c =3D> gpio.c}                |  0
>  drivers/i2c/muxes/{i2c-mux-gpmux.c =3D> gpmux.c}              |  0
>  drivers/i2c/muxes/{i2c-mux-ltc4306.c =3D> ltc4306.c}          |  0
>  drivers/i2c/muxes/{i2c-mux-mlxcpld.c =3D> mlxcpld.c}          |  0
>  drivers/i2c/muxes/{i2c-mux-pca9541.c =3D> pca9541.c}          |  0
>  drivers/i2c/muxes/{i2c-mux-pca954x.c =3D> pca954x.c}          |  0
>  drivers/i2c/muxes/{i2c-mux-pinctrl.c =3D> pinctrl.c}          |  0
>  drivers/i2c/muxes/{i2c-mux-reg.c =3D> reg.c}                  |  0
>  12 files changed, 17 insertions(+), 4 deletions(-)  rename
> drivers/i2c/muxes/{i2c-arb-gpio-challenge.c =3D> arb-gpio-challenge.c} (1=
00%)
> rename drivers/i2c/muxes/{i2c-demux-pinctrl.c =3D> demux-pinctrl.c} (100%=
)
> rename drivers/i2c/muxes/{i2c-mux-gpio.c =3D> gpio.c} (100%)  rename
> drivers/i2c/muxes/{i2c-mux-gpmux.c =3D> gpmux.c} (100%)  rename
> drivers/i2c/muxes/{i2c-mux-ltc4306.c =3D> ltc4306.c} (100%)  rename
> drivers/i2c/muxes/{i2c-mux-mlxcpld.c =3D> mlxcpld.c} (100%)  rename
> drivers/i2c/muxes/{i2c-mux-pca9541.c =3D> pca9541.c} (100%)  rename
> drivers/i2c/muxes/{i2c-mux-pca954x.c =3D> pca954x.c} (100%)  rename
> drivers/i2c/muxes/{i2c-mux-pinctrl.c =3D> pinctrl.c} (100%)  rename
> drivers/i2c/muxes/{i2c-mux-reg.c =3D> reg.c} (100%)
>=20
> Hi Wolfram!
>=20
> In the light of the rant from Linus the other week [1], I thought this mi=
ght be
> a good idea?
>=20
> Cheers,
> peda
>=20
> [1]
> https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flk
> ml.org%2Flkml%2F2017%2F7%2F12%2F430&data=3D02%7C01%7Cmichaelsh%40
> mellanox.com%7C6cbbed292e99475e99d208d4db184a42%7Ca652971c7d2e4
> d9ba6a4d149256f461b%7C0%7C0%7C636374344761668884&sdata=3Dk2CK8RQq
> mWOEs3CULrPqOR1uddb1iIawqUTD7%2F4BLiU%3D&reserved=3D0
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 205d3977ac46..46356c87f0c9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5687,7 +5687,7 @@ GENERIC GPIO I2C MULTIPLEXER DRIVER
>  M:	Peter Korsgaard <peter.korsgaard@barco.com>
>  L:	linux-i2c@vger.kernel.org
>  S:	Supported
> -F:	drivers/i2c/muxes/i2c-mux-gpio.c
> +F:	drivers/i2c/muxes/gpio.c
>  F:	include/linux/i2c-mux-gpio.h
>  F:	Documentation/i2c/muxes/i2c-mux-gpio
>=20
> @@ -7998,7 +7998,7 @@ M:	Michael Hennerich
> <michael.hennerich@analog.com>
>  W:
> 	https://emea01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F
> %2Fez.analog.com%2Fcommunity%2Flinux-device-
> drivers&data=3D02%7C01%7Cmichaelsh%40mellanox.com%7C6cbbed292e9947
> 5e99d208d4db184a42%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7
> C636374344761668884&sdata=3DhehiWQXI5WY2oz1SCBV9TqjWQ3wYPzKuIKes
> K44Ar%2Fg%3D&reserved=3D0
>  L:	linux-i2c@vger.kernel.org
>  S:	Supported
> -F:	drivers/i2c/muxes/i2c-mux-ltc4306.c
> +F:	drivers/i2c/muxes/ltc4306.c
>  F:	Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
>=20
>  LTP (Linux Test Project)
> @@ -8558,7 +8558,7 @@ M:	Michael Shych <michaelsh@mellanox.com>
>  L:	linux-i2c@vger.kernel.org
>  S:	Supported
>  F:	drivers/i2c/busses/i2c-mlxcpld.c
> -F:	drivers/i2c/muxes/i2c-mux-mlxcpld.c
> +F:	drivers/i2c/muxes/mlxcpld.c
>  F:	Documentation/i2c/busses/i2c-mlxcpld
>=20
>  MELLANOX MLXCPLD LED DRIVER
> @@ -10018,7 +10018,7 @@ PCA9541 I2C BUS MASTER SELECTOR DRIVER
>  M:	Guenter Roeck <linux@roeck-us.net>
>  L:	linux-i2c@vger.kernel.org
>  S:	Maintained
> -F:	drivers/i2c/muxes/i2c-mux-pca9541.c
> +F:	drivers/i2c/muxes/pca9541.c
>=20
>  PCDP - PRIMARY CONSOLE AND DEBUG PORT
>  M:	Khalid Aziz <khalid@gonehiking.org>
> diff --git a/drivers/i2c/muxes/Makefile b/drivers/i2c/muxes/Makefile inde=
x
> 4a67d3199877..b9f7a78d7604 100644
> --- a/drivers/i2c/muxes/Makefile
> +++ b/drivers/i2c/muxes/Makefile
> @@ -1,6 +1,19 @@
>  #
>  # Makefile for multiplexer I2C chip drivers.
>=20
> +i2c-arb-gpio-challenge-objs	:=3D arb-gpio-challenge.o
> +
> +i2c-demux-pinctrl-objs		:=3D demux-pinctrl.o
> +
> +i2c-mux-gpio-objs		:=3D gpio.o
> +i2c-mux-gpmux-objs		:=3D gpmux.o
> +i2c-mux-ltc4306-objs		:=3D ltc4306.o
> +i2c-mux-mlxcpld-objs		:=3D mlxcpld.o
> +i2c-mux-pca9541-objs		:=3D pca9541.o
> +i2c-mux-pca954x-objs		:=3D pca954x.o
> +i2c-mux-pinctrl-objs		:=3D pinctrl.o
> +i2c-mux-reg-objs		:=3D reg.o
> +
>  obj-$(CONFIG_I2C_ARB_GPIO_CHALLENGE)	+=3D i2c-arb-gpio-challenge.o
>=20
>  obj-$(CONFIG_I2C_DEMUX_PINCTRL)		+=3D i2c-demux-pinctrl.o
> diff --git a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
> b/drivers/i2c/muxes/arb-gpio-challenge.c
> similarity index 100%
> rename from drivers/i2c/muxes/i2c-arb-gpio-challenge.c
> rename to drivers/i2c/muxes/arb-gpio-challenge.c
> diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c
> b/drivers/i2c/muxes/demux-pinctrl.c
> similarity index 100%
> rename from drivers/i2c/muxes/i2c-demux-pinctrl.c
> rename to drivers/i2c/muxes/demux-pinctrl.c diff --git
> a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/gpio.c similarity
> index 100% rename from drivers/i2c/muxes/i2c-mux-gpio.c rename to
> drivers/i2c/muxes/gpio.c diff --git a/drivers/i2c/muxes/i2c-mux-gpmux.c
> b/drivers/i2c/muxes/gpmux.c similarity index 100% rename from
> drivers/i2c/muxes/i2c-mux-gpmux.c rename to drivers/i2c/muxes/gpmux.c
> diff --git a/drivers/i2c/muxes/i2c-mux-ltc4306.c
> b/drivers/i2c/muxes/ltc4306.c similarity index 100% rename from
> drivers/i2c/muxes/i2c-mux-ltc4306.c
> rename to drivers/i2c/muxes/ltc4306.c
> diff --git a/drivers/i2c/muxes/i2c-mux-mlxcpld.c
> b/drivers/i2c/muxes/mlxcpld.c similarity index 100% rename from
> drivers/i2c/muxes/i2c-mux-mlxcpld.c
> rename to drivers/i2c/muxes/mlxcpld.c
> diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c
> b/drivers/i2c/muxes/pca9541.c similarity index 100% rename from
> drivers/i2c/muxes/i2c-mux-pca9541.c
> rename to drivers/i2c/muxes/pca9541.c
> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c
> b/drivers/i2c/muxes/pca954x.c similarity index 100% rename from
> drivers/i2c/muxes/i2c-mux-pca954x.c
> rename to drivers/i2c/muxes/pca954x.c
> diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/pinc=
trl.c
> similarity index 100% rename from drivers/i2c/muxes/i2c-mux-pinctrl.c
> rename to drivers/i2c/muxes/pinctrl.c
> diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/reg.c
> similarity index 100% rename from drivers/i2c/muxes/i2c-mux-reg.c rename
> to drivers/i2c/muxes/reg.c
> --
> 2.11.0
