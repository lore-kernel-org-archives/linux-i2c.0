From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/6] i2c: add 'set_sda' to bus_recovery_info
Date: Tue, 5 Dec 2017 14:38:48 +0100
Message-ID: <20171205133848.nzrhysiz2twvlamx@ninjato>
References: <20171204123640.3382-1-wsa+renesas@sang-engineering.com>
 <20171204123640.3382-4-wsa+renesas@sang-engineering.com>
 <CACRpkdZzwo9UhT08VDHXg6=eXdK80Pt1omZ4Xda_HFwguyNpaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vddxjidrseoouwvo"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:48507 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753014AbdLENiu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 5 Dec 2017 08:38:50 -0500
Content-Disposition: inline
In-Reply-To: <CACRpkdZzwo9UhT08VDHXg6=eXdK80Pt1omZ4Xda_HFwguyNpaw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Phil Reid <preid@electromag.com.au>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Claudio Foellmi <claudio.foellmi@ergon.ch>, Andrzej Hajda <a.hajda@samsung.com>


--vddxjidrseoouwvo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +                       if (gpiod_get_direction(bri->sda_gpiod) =3D=3D =
GPIOF_DIR_OUT)
> > +                               bri->set_sda =3D set_sda_gpio_value;
>=20
> Just compare it to zero. if (!gpiod_get_direction())

So, this?

	if (!gpiod_get_direction())
		bri->set_sda =3D set_sda_gpio_value;

That looks like "if i couldn't the direction, then...", or?

Comparing to plain numbers feels like magic values?

Maybe this should be named 'gpiod_is_direction_input()'?

Or?


--vddxjidrseoouwvo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlomoWQACgkQFA3kzBSg
KbYakQ//f+aFWvPc941A5xL0CJxtco4PhXoENpjrlTkkvp9RIHGi0iCFTLxvNieo
MUvZmP01sFWJIQDHcyt+FNUeG9B/b4sCLtkBC6COqX89NJNZ81ME7cnlNxGXnRKO
qnrfjyHaJZ6ikdOnf++ygcHT1zVdmsYIfF8r+NP/TEf7JR+fbWzYCwqctPLmRTrg
dFCMz3OHwdhhazxS5vXK0xMHTHwYVUBc+6zmSnslcJSGerdagXb2/fQbf1Tc47lU
ROKO7eKAuFkl7oZ2mIcBrp0RQcPdBIIvtAC6mzZyepRJpo9QgRVUu2m4ZjzO+c07
rXuqQpLiC3n3NMTJ4wsvxa35auUePfEJAkW1hwb1E7PGf7YQ6cTc/ppU+CrULwc1
dysFMtl7SVFQu1ixdIAmz+lCDiuwglnYKyiaaiwXDdtcgXu85+fjfPQrSPobR32Q
pA3dvsU9qe/L/ZmuOlaqS7P/KvgBWjjjIJnrCCnx0dy0iOrrj4wj6tgC3cZ85Br1
UhOLBxzMY9SB0AF8T5aulq/YKd3lucXxLp+GRCZOq928bRgiV4d+2yYvXDol+Vis
z2dUW+O/1xo7q3r8gOpLJDvtLw8r/B1pblM4gwNxG4rJn7ieKaUq9L0rJMwS+4T9
bAmqRnqctA31mJS9KESA8p7u8XY3QmZbA+yI6sBZCdlguIFkvJE=
=VDpP
-----END PGP SIGNATURE-----

--vddxjidrseoouwvo--
