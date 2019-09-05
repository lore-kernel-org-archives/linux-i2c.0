From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: uniphier(-f): remove all dev_dbg()
Date: Thu, 5 Sep 2019 22:35:24 +0200
Message-ID: <20190905203523.GE8989@ninjato>
References: <20190905044648.7632-1-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wTWi5aaYRw9ix9vO"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190905044648.7632-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 01:46:48PM +0900, Masahiro Yamada wrote:
> I have fixed various bugs, and these drivers are (I hope) pretty
> stable now. Remove all dev_dbg() for code clean-up.
>=20
> If I end up with debugging the drivers again, I will locally revert
> this commit. I no longer need the debug code in upstream.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Yay, tasty one! Applied to for-next, thanks!


--wTWi5aaYRw9ix9vO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1xcYsACgkQFA3kzBSg
KbYw7g//QsSqP48+IcUw8OqlQKxp+IMdWVY20O7CfqNW2XGITbwPt5mAdOgqANxF
txCPnXhi/FZofE60fAZqBi18Y2C/LUQhxAfsjZfe2Vyk8g60qtgipgkRyx/DQxZb
SKeA0ikTsPt9g1mst9XxEgJtZZC0c02zuJOpo7LjWW04kSzZKjeUjCLmecKNedZL
MfXrCh4Dtejryjxn78/yZwSoL5DPGN2dpJDgOYtx8ZUMFkuuPoPNZmkm0GkKdqGn
8bJGz9VivsxUMfGfNhwt0cw3CgvH2ULJgUmt+Kh+yLRGHKiUobP44IobAOlofcHq
eshlOkhtKDCbtxP1ht8wckh/gU6hGAG511vfslr4+5UMAF/M+TWELMHvvJ+0gpeu
Hyq8u7QPC7xBZU+DZ6YU3SwJS7/oOlw5hFMYOCAe9uXiEXp8iSpICMG5s8woOQoh
07VgJ1QK6oqI/ND9gPD75XowvWqLxpUNKKUh5ZE7GxlQJigTpTcJRUHZSxFG0kQE
0wMYYc+bJp8kcKcyyaSdmOFWftzGJEPIa2rDIejICjIoqN9Lgs4xDug60HIk4p5i
Pap8jTntvMwKGKtMOFoUKPQlq64dFkyZLSw2nSjfTbR5bCR9KJ/rEI0gJJ1jGFCH
dbwxzfI/IxbFeGT0tEd42hWeHDzXf1q1cucl/tazp6VeXDrFpac=
=pLq7
-----END PGP SIGNATURE-----

--wTWi5aaYRw9ix9vO--
