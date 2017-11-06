From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH RFT 3/5] i2c: sh_mobile: manually "inline" two short
 functions
Date: Mon, 6 Nov 2017 09:54:21 +0100
Message-ID: <20171106085421.zgwz4dn5pmpjpodu@ninjato>
References: <20171102124731.10484-1-wsa+renesas@sang-engineering.com>
 <20171102124731.10484-4-wsa+renesas@sang-engineering.com>
 <CAMuHMdXoSyauV1ikYzVBq85Qwm=iPBWvEWNCwd-JNUt32NYUOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2pjkuecogt7npvat"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXoSyauV1ikYzVBq85Qwm=iPBWvEWNCwd-JNUt32NYUOw@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Jacopo Mondi <jacopo@jmondi.org>
List-Id: linux-i2c@vger.kernel.org


--2pjkuecogt7npvat
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > -       activate_ch(pd);
> > +       /* Wake up device and enable clock */
> > +       pm_runtime_get_sync(pd->dev);
> > +       clk_prepare_enable(pd->clk);
>=20
> Suggestion for further cleanup: the call to clk_prepare_enable() should
> not be needed, due to Runtime PM taking care of that.
> This is also the case on SH, which uses the legacy clock domain
> (drivers/sh/pm_runtime.c).

Ah, I didn't know that about SH. Thanks for the heads up!


--2pjkuecogt7npvat
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloAIzkACgkQFA3kzBSg
KbbPXA/+Nr55ViplnwX/Uo+aDNw6SP/cCXd75uVEKVQJjOabQwhHlbKp3EACZrZT
VlYezNGFqPzSUc68CqsVWiwkBlghL3DerBr1nn8aORDnVJNW3MUsd1ej3yqYAKus
Q9gzKFM0pJucMHlqJgC07c2tMa+wlyXw9tMukVjOYZ2bXoWhXdvtVqSxRDKQTQ7o
IOVZgGvpOW1dYmS9ay1AYZtyO0V5lKaMryUktWNGOF469MUyDWTGzYbexiupUvau
TPuWXIlF09wM1zAvsyhKGlDCpHjKzdOcdkqWNgIemfmq1NiaorjIii4mtnZKpdVN
3skdR1KXOyj2e0alLHpLb+yCBM8fQdCB37AWCgIEut24yIQZJ6smGhAEUdIudWqE
Ajj/nKHsLClmKIB9/05bsaRQaM6qwmEycW0TH91EC7qustcoTZtf/WOgQop6JBok
3tcIl5tuvYxFJh6Z/KE1FguOsLDV8G9jbIWK7Wu0pypO5HHAabalMYvgiPwTwled
pkIOteroLJjBluCwZe5kuqHzSgskkJLnqO5KQUCGWGJhdeMiF0vE4Ke8oNGn0hZ/
FcW4I6cXcEFdxAEzxOsiPyvicBRBAwvPHUGLPWd+wFuWPkcO++z7o6QSvsbVYnJn
aX2NyKSNomKcSkzwX2j0pimgyTFYBMjb1mbnEC+blp4ZQ66VcCA=
=pUT3
-----END PGP SIGNATURE-----

--2pjkuecogt7npvat--
