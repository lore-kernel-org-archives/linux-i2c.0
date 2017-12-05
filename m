From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/6] i2c: add 'set_sda' to bus_recovery_info
Date: Tue, 5 Dec 2017 17:43:07 +0100
Message-ID: <20171205164307.65htuotj3heglefj@ninjato>
References: <20171204123640.3382-1-wsa+renesas@sang-engineering.com>
 <20171204123640.3382-4-wsa+renesas@sang-engineering.com>
 <CACRpkdZzwo9UhT08VDHXg6=eXdK80Pt1omZ4Xda_HFwguyNpaw@mail.gmail.com>
 <20171205133848.nzrhysiz2twvlamx@ninjato>
 <CACRpkdYuHit1w1_d4h++vOuSWosf+iBdgimtCUbmic3mkbm1Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pne57ups5geiyx6s"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdYuHit1w1_d4h++vOuSWosf+iBdgimtCUbmic3mkbm1Wg@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Phil Reid <preid@electromag.com.au>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Claudio Foellmi <claudio.foellmi@ergon.ch>, Andrzej Hajda <a.hajda@samsung.com>
List-Id: linux-i2c@vger.kernel.org


--pne57ups5geiyx6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Two statice inlines in <linux/gpio/consumer.h>
> named
>=20
> int gpiod_is output()
> int gpiod_is_input()
>=20
> should conform to Rusty Russell's API hierarchy.

Yes, sounds good!

> Interested in fixing it, or should I?

Please do. I don't want to add magic numbers to the kernel ;)
Could you provide an immutable branch then that I could pick up, because
my series will depend on it.

> I can almost ACK it before you write the patch.

:)


--pne57ups5geiyx6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlomzJcACgkQFA3kzBSg
KbYWDw//d6AxLQ+JAy3olTWi2Q+wykiO7D23T37WungRyCiGSMMf9gFthy2u8bWL
fndDTzuJLPq/bD3RftEDTbFDZ8um/WQSh9jDv52Ex7xy/WgsbVQkbt/saaOkyWbN
H7eEYnkMn/PAYCWnPMH/M9gbgG0y8Mj7MHizvylH2Yjb8Urz/2Zn3H4FUmujANmx
S6MuOWdJZhKe4CWe3pQ56fEqRwtEiwz/Cdnk3RAw2YXYaAx03YAYDlkbgxhTs0NV
vf3yvDMJ/Zzo216bzUNcZ/WL0H7YZCEcDJAbhTuCtRlIZeZMlVcx4CodpBqDafvh
Sx32soNZ0GPE73WET7tJUvyUxC16CQ8DJok2UoTvQ03y91CHA1ixaWZn8vOVT1le
FOzx29BZVkrXZrpdmQhS6mEZqees5M6kvW2SzCIp7KM44WPG4ZhYi1ivgLfmcLEN
Ee561ThZBuq+gxet/WAKv+tdg0TZbYuA36ZvztEipxdBcjaA8GrpkbMNTFEli6ei
XWearWZph2XiiXJ/1PEqaXe+eKgGtbOTCr02U25yJ3caRH4nYUdMmf0JaW3fdIG6
67RYbTYncZN61/9+yuyMs1HBh9Nu1MquM75N7eYus6ma0n5JtcVkxvCwSgZuENE8
Sg+K6E1XbZWCiW089EyYmMq3tJ0nQlzZXVsoKcSM0lhuyRjtZis=
=5pwh
-----END PGP SIGNATURE-----

--pne57ups5geiyx6s--
