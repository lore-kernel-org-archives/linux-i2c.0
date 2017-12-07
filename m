From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/6] i2c: add 'set_sda' to bus_recovery_info
Date: Thu, 7 Dec 2017 12:25:35 +0100
Message-ID: <20171207112535.oqtnemvi4q5xnewh@ninjato>
References: <20171204123640.3382-1-wsa+renesas@sang-engineering.com>
 <20171204123640.3382-4-wsa+renesas@sang-engineering.com>
 <CACRpkdZzwo9UhT08VDHXg6=eXdK80Pt1omZ4Xda_HFwguyNpaw@mail.gmail.com>
 <20171205133848.nzrhysiz2twvlamx@ninjato>
 <CACRpkdYuHit1w1_d4h++vOuSWosf+iBdgimtCUbmic3mkbm1Wg@mail.gmail.com>
 <20171205164307.65htuotj3heglefj@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fduft7bcvmojdurz"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:55760 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752491AbdLGLZg (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 7 Dec 2017 06:25:36 -0500
Content-Disposition: inline
In-Reply-To: <20171205164307.65htuotj3heglefj@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Phil Reid <preid@electromag.com.au>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Claudio Foellmi <claudio.foellmi@ergon.ch>, Andrzej Hajda <a.hajda@samsung.com>


--fduft7bcvmojdurz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Two statice inlines in <linux/gpio/consumer.h>
> > named
> >=20
> > int gpiod_is output()
> > int gpiod_is_input()
> >=20
> > should conform to Rusty Russell's API hierarchy.
>=20
> Yes, sounds good!
>=20
> > Interested in fixing it, or should I?
>=20
> Please do. I don't want to add magic numbers to the kernel ;)

OK?


--fduft7bcvmojdurz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlopJSsACgkQFA3kzBSg
Kbb3+Q/+NL/cocupKxr/88KYYmVgkBij5ojsvYUdCX+BhshYHvMccOG9pz4vsQuJ
ORRyBi4jP/teC7Fi3Mw7Ob2Mh3H/iibi9p0Ax92N8pr7PmubiAHVN+x39SH0J5Mz
yVGcz+XQn1r+0jCEJVmgmn3R2Zket69KVoYwDBPxR0sJ8A6x+N1QDB7kAVQKVvtV
F0m3qvMIaEncjm59pL/I9n35GPiS/WsP2PCykbAMwIGgIojwKrYfLxbmJxY38tUE
mAeKzU1ybD4mQNrfRNVsLUyuSqlRC3aPLD/NhAB7DCRFCOIUYYLgg6j2lSCuUi28
rsaa53nmG7vraeYxQE6JjAAk9eyRFR0gN37ls6ls2uDPTgZvBb/ojOIyAAFQ+OlO
CVfJMP/fC8Mo44ngCtypUakIzfTvBW72Zkv2wDIcOvKjZebm5p4ZnyTEgOXJeSSa
L8yonCNFjdJlNtzsbqaFs4fWR0cxkqWLu3mAEhgwXrcwEC3BBYmSSKlW8Pg/wUOh
lA0NMdi//0qBzg05QNLrTD4+Lsz8ZSXlIqD0z8dYFrB/Q+0/OXZVGhBT4Hz/bFtA
3rMY+zMmTSdQaVHQHypEbQ7u3/PT7rUOA5efmF4z6g11uXaPpdLW9ejs6+3AWPfz
Nt2ND59xLglgvmHIHCya/BOvzvJYOWahD0NVctBoxWuUiuR6Gm8=
=rujJ
-----END PGP SIGNATURE-----

--fduft7bcvmojdurz--
