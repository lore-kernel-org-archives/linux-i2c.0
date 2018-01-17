From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: rk3x: add proper kerneldoc header
Date: Thu, 18 Jan 2018 00:31:47 +0100
Message-ID: <20180117233147.ualmz5q2z5eygemx@ninjato>
References: <20180117231817.26955-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uyo6khwj3c6qpdy4"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:54125 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752791AbeAQXbt (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 17 Jan 2018 18:31:49 -0500
Content-Disposition: inline
In-Reply-To: <20180117231817.26955-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>


--uyo6khwj3c6qpdy4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 12:18:17AM +0100, Wolfram Sang wrote:
> gcc noticed the kerneldoc was wrongly formatted. Fix it!
>=20
> drivers/i2c/busses/i2c-rk3x.c:164: warning:
>   Cannot understand  * @grf_offset: ...
>   on line 164 - I thought it was a doc line
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Applied to for-next, thanks!


--uyo6khwj3c6qpdy4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpf3OMACgkQFA3kzBSg
Kba90g//dJVqPkmtiRwRbf7nAHiOPxlx+HLhzXOZjAv+txbJR5bnsE06T0m5GMwb
QVnaaJm/4WgsQ+1UosFgdmgWdgJMsNOCQBk7+YCeWOzevl+hGmSDGVxvpoWRaoW6
Pl8dtQ7gODCt1eK3BwmJNM8gHH+0UNbfbMe8TlT3/Igri6hOhCunh7nBvWIs/eEB
2WvjWVgZIIOw4za4uYSBaXysAAqsLAOA6APlOEw7n+RUjiNRRP8ufHbP1EHKWhgU
PKcWwSzAkzWl7Tg1zuCuS33IZ21ZM7mtjb6Qvmkln3Hh93l3zabBGzF2jo/cTKTx
iuZJB+IU6YmCG06MnJZhP3d4YHrVf+mYEXEIzOUYMYSWa2c6PYt3ayVtXYwF3Kx1
pBCjtwZaSRaB3O3foxVJCezMtUkxfL2uy3Av9LXZ2xfvXIggVBiS0U+pVypk/n5H
GWVnetiU3kEcHhgnFkdsjjBnyn4kfinXZK59nN9SP6gCD4h3mbrZvWwcppACmxqx
hmH3YS5UYCNOrwd0roxea9KN0yiHtMO4KpqdSK0T5l4/l+WtNGn829NamPrtlAmN
AH3b3wE4FmLP+xwAPH/h0LTqormgbJWpkKDKJK3Yg3XsaMleWAUDDjEZvfVwjkeI
UZHnG0bb1BMk/ZmeUK7SY3nRw6Jt0wNOFmMKz3TrFKZbU/zkNdQ=
=+lFi
-----END PGP SIGNATURE-----

--uyo6khwj3c6qpdy4--
