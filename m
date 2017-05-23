From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] misc: apds990x: move header file out of I2C realm
Date: Tue, 23 May 2017 08:23:40 +0200
Message-ID: <20170523062340.GC1580@katana>
References: <20170521204233.6745-1-wsa@the-dreams.de>
 <20170521204233.6745-2-wsa@the-dreams.de>
 <CAK8P3a2CfOPNe5KnSWb=xf_0YTtN6aQRwNthQXEDb9YgOrLMaw@mail.gmail.com>
 <20170522155649.wuf2rcdtywa7e667@ninjato>
 <CAK8P3a2xU4R=hq5fjOyZN=+cS1KVfwP9sFuwEB+g2jnTwcE6gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a2xU4R=hq5fjOyZN=+cS1KVfwP9sFuwEB+g2jnTwcE6gw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-i2c@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-i2c@vger.kernel.org


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> The one reason I can think of for removing them is that we don't
> want ambient light sensor drivers in drivers/misc any more and
> instead of adding DT probing code would also expect new users to
> migrate to drivers/iio/light/, which already has drivers for
> apds9300 and apds9960 but not apds990x, as well as bh1750 and
> bh1780 but not bh1770.

Yes, I totally agree!


--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkj1WwACgkQFA3kzBSg
KbarwRAAqX4SZbKY1k04tdP8WRdHefFawkh94pnWDmJJLIEgBXNMlz2p6tSFlrU6
oUJ08rq2DIEHbvYda4beVgxuKiS/UWeWmxhT/9oVm8FiRFmi8SfMHs9B21ut0Tdw
VAUZEbfgCp4V5ed8da4aziEsFbaTHX6jaY2DnesAopESdJA1EVuayu1Q6003fteF
94JYhyKQW9S4yYbMrVt8Pm+dqEv+97EjOBO7NcDGPRvYqYW/uQHgX89JHzEg6H+q
ylAPUWSndAdk+ec+1XMe2ZKygxFAQDC8ZH3AMoAQBMHT0bOak3zEfvzhX8ycdShl
Hsy0YR+ngxxTw3IgbfR7kFvnLOj362f3H7mi9QhCkos/hEAagv4KKE/vWtFxTqF9
5pY8sgJDBf/C0g0PSRhsprBZKbW5l7/deRRTYzFEGFEiTvh+YpOkPPT1qimwgHbg
5GrabcmO7h3D72Hd8cEi6QT6ZwRUu4UxjiNbgzUreERsqP8S8nC468O6zmCo0tpo
PIti9VdhUCmQ8dRJm7lZe2vE3MA8tKF/4BVjSgfN/qEMLWNb3VMl392Tq3HpA4R0
4V9E3Z5gl2a8Kjs8SuAm8pnDe9rfHpLML4af2XeWc3qb1ZMK6NqxDoz7f40MkX9Z
K/dirf2kVY5YIfSzs8C7xcXhjdw5JPpVkTxbP9+v+8ZUgXNsO9U=
=+Nxb
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
