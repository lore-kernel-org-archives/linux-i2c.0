From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 01/12] i2c: quirks: add zero length checks
Date: Mon, 23 Jul 2018 23:05:29 +0200
Message-ID: <20180723210529.kvuu57jpdgmsipop@katana>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
 <20180723202617.15230-2-wsa+renesas@sang-engineering.com>
 <20180723204418.GG1432@bigcity.dyn.berto.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zb5d6xp3oo53hkux"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180723204418.GG1432@bigcity.dyn.berto.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--zb5d6xp3oo53hkux
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Only build tested.
>=20
> Was this not tested when you also tested i2c-rcar and i2c-sh_mobile=20
> drivers? In any case I think this change make much sens.
>=20
> Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>

You are right, of course. This text was added by a script and I forgot to
remove it :( This code was tested!

Thanks for the review!


--zb5d6xp3oo53hkux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltWQxQACgkQFA3kzBSg
KbY2pQ//W7Fm+XWKAoXavMi9JC9SiqwNUN4+PF9X9wJfYWTWgXKuMim98ZInORhf
07EOEePR6CT+4gj07FVsaWckwK6JVVaoHi4xU0aFQf9eqh0kwkZmNUglPxPDshgi
yaBTdj7ILWGleVHYs0cxrs+dSJAFiaQiKgjxU153uDRQrp/3kGoB+9pgShlKDpNZ
tmIlugqwgfWB2kkSfBj5tYqk1YpzRMK7EsBhxZY2bCbIXGvgZKZKX84KcAKmkYMT
aMT+TQHMQ7FmIv+aiCrJ0bY8gsuBJRXxduzSMm0OO8llhtj3co/0Zuvy4YhGnK/5
P6/z2JTdwJOhno8mIjcK/NazvrZGEDYMDh1UZwaBJSjcoQJp6CJ8se8tqYgfmSf6
gHjsdZHEhZjuGkFFDYDMGRnapTohNQT+oY5cUM33RHO6G+ujNRSiNQgw9xaVpkWj
fzeeGOdycp+ju3LTG9aS//TtvYmgLv4LYhVJUlyOFqDbHhPoHULuQZj91cn+Il8f
iKkRK99w0BS5vsR3o+TENAFrRJYDPaFmbvp7uWNr1d7OHKS46PpEde+ZFqNws9W7
M9ife5K+rQBw2OWY3k7Di2skevsAr1fSikUygpwBTbeB1M33cAQur/L1tWIgNxK+
3oKUsb+h8nQnVDoDyCV7ML2dqrh8eKu/ILi2tD7BPv1HU3br/yw=
=WBf1
-----END PGP SIGNATURE-----

--zb5d6xp3oo53hkux--
