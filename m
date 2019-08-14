From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/4] i2c/busses: Add i2c-icy for I2C on m68k/Amiga
Date: Wed, 14 Aug 2019 21:47:14 +0200
Message-ID: <20190814194714.GB9756@kunai>
References: <20190812235237.21797-1-max@enpas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190812235237.21797-1-max@enpas.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Max Staudt <max@enpas.org>
Cc: linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de
List-Id: linux-i2c@vger.kernel.org


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Thanks for the patch. It looks mostly good.

> +static int clock = 0x1c;
> +module_param(clock, int, 0444);

'clock' determines the bus speed?

> +	i2c->adapter.class = I2C_CLASS_DEPRECATED;

This is only needed for drivers which used to have a class and decided
to drop it. You can leave it empty.

> +	algo_data->data = (void *)i2c;

You don't need the cast, do you?

> +MODULE_LICENSE("GPL");

Your SPDX header says GPL 2.0 only.

Kind regards,

   Wolfram

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1UZUIACgkQFA3kzBSg
KbY8mxAAsWO7FshbNWxce6/Ayk6ygTA3Mk2nG3PbYUCIZAWV5pj//O8wuhX/DKSy
J+11DapytlncEORT/c/V9upMPb4ojyoJCaXNgAjfzTkUYywLSa3IAgAighJge5yb
B8N0MfTfw/zUKzw/HSXgZU7OWSO4HRgeGQ/QzUky4CC7J02jfqTkD5itJyu5te2k
d6R2g1b1o+Bby86zmk899QlELXqULx7g6hphljH/sbEFqwK4RpqWmyfkp+VBN49L
RDY1BtnqWeS9lwLmDerWrSgCy7MDMa9d84YH0L1S+rQzdITVSKx4NqFZ21Jzcar9
fvaqB4Oga4LKiBwfc6p2st7WTTKgxRoG1qfNY4am+8cxTIBWwfhECcbV/uRL88Qd
knbCilRYm0+MoXqHIlhpwhJI7CqwKsFoqw/Yx5zT6XCDV0iif1mQ6gzoNJ8PDNm9
9kyK7penhj558f9W56CIWVNMvmlBmoeQv4xL4j/pFRBZA09YNrcvPfhk7wWebHDx
lbcCyDqulyyV1/OHCQ+/UwCCbm2EUc5sAAISfaZflbtq1W208VoOPyxyhNV7RJXL
6mju5RemtxU8JtFTDF79Vtm4/TaPGscoYkKuRqpfgWDdb7jQ++7b5q7kOMJ9bJOg
d0a9Jk8tPOZV6jXlsYCmxUn7WlTyCOh6mrHwvbxhFjaEpSPGGdc=
=gqvS
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
