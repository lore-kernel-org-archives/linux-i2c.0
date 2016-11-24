From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [PATCH v2] i2c: i2c-mux-gpio: update mux with
 gpiod_set_array_value_cansleep
Date: Thu, 24 Nov 2016 16:14:21 +0100
Message-ID: <20161124151420.GF4271@katana>
References: <1479908035-18284-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tmoQ0UElFV5VgXgH"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1479908035-18284-1-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Peter Korsgaard <peter.korsgaard@barco.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--tmoQ0UElFV5VgXgH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peter,

> +	int values[mux->data.n_gpios];

Hmm, my code checkers complain about this line:

  CHECK   drivers/i2c/muxes/i2c-mux-gpio.c
    SPARSE
drivers/i2c/muxes/i2c-mux-gpio.c:29:29: warning: Variable length array is u=
sed.
    SMATCH
drivers/i2c/muxes/i2c-mux-gpio.c:29:29: warning: Variable length array is u=
sed.

Worth to fix it?

BTW (unrelated to your patch), the compiler complains about:

In file included from drivers/i2c/muxes/i2c-mux-gpio.c:18:0:
drivers/i2c/muxes/../../gpio/gpiolib.h:88:27: warning: =E2=80=98gpio_suffix=
es=E2=80=99 defined but not used [-Wunused-const-variable=3D]
 static const char * const gpio_suffixes[] =3D { "gpios", "gpio" };

which pointed out this line to me:

 18 #include "../../gpio/gpiolib.h"

which is probably worth fixing, too?

Thanks,

   Wolfram

--tmoQ0UElFV5VgXgH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYNwPMAAoJEBQN5MwUoCm2tvAP/3bBr3GCQoa7uHWv5WRAn717
XkRurCr1AU5ZpOF83IsvOag9mj76LChysIfKhNXwf29euZdZc6yURm/QjUQf8P/t
p/1l+LN6SdiPn2sBeCdNpTUH3Ug3XfzwT+ChoYNWY6/g7t8UoL/AZotqBgErb0ps
wemlZjI2usw7JLE0dwqR22gEkizp+lubIzwASnKNMdAvnFqdbT031a6kgfwMQ7ZA
r4W+2b9vZLWZWMSsqiVXDrZy0x+585XZzl2mB6ZuiKBVCd/92/llDQNwbe8/JEHC
LFZFmeFD1sbFR5kpO+p0GKUVW0G/Zwduj45Ie96V/xS8ZiIVjCp3z14WToZjKn7m
iPQBiXNvFbfRopEwVzUrOTWSvwfWaXwbNfLM2KmNEEV6BsFHsr3q/RNjxnID4PCw
ZaEUNCOT45GUh59H5XdacUU3ruF8lIZYVB/AMtHHli4hPPViBqpLzoNkecjwuSan
OVYpvpZW88pJtRZZwHkHcS+M6+NOJMhl7TBX8KCDx1HBbbmEgjR68ayEWnvWBrrN
yPpzahpJcOtP95GCHDsTHGAI1gv2qsnNKPdzoIKJK0DteEU1oLlLWXMOnoJydzqZ
VtB88OqiGBEuZSpZXMtgM9g4WmliApdWjKNtQPp1B95XQz01HeQvWpDXrv7j9ffh
aWZqqRUooGGtSK91Luva
=3UCg
-----END PGP SIGNATURE-----

--tmoQ0UElFV5VgXgH--
