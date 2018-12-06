From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/4] UniPhier I2C fixes
Date: Thu, 6 Dec 2018 23:06:09 +0100
Message-ID: <20181206220609.GA1100@kunai>
References: <1544068528-27657-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1544068528-27657-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 06, 2018 at 12:55:24PM +0900, Masahiro Yamada wrote:
>=20
> Masahiro Yamada (4):
>   i2c: uniphier-f: fix timeout error after reading 8 bytes
>   i2c: uniphier-f: fill TX-FIFO only in IRQ handler for repeated START
>   i2c: uniphier: fix violation of tLOW requirement for Fast-mode
>   i2c: uniphier-f: fix violation of tLOW requirement for Fast-mode

They all look like bugfixes to me, so applied to for-current, thanks!


--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwJnUwACgkQFA3kzBSg
KbbVWg//SKoF8iqLVzVaLHhyaqytaaee2i2wicaihztkC0smv+LNc63fzMf4ozL3
AyqCa/1NKy2qfBW9bXl7Dd6T4RpXZmQAPQ67vVlk74Dn6S89pk1lZztG61/m+HsB
dBlzXxPoF87/cPbq9aU9GLEvsSJcy57h7Z03m24rtemdKDcNFEaxkZy26i5+Ccku
kdFVQm70SUyQyg6ScQLX9bl/X8JDOvhpv/xI49iTXYvdK+Xeu+dAgGNcjkUhMDYQ
ynLdb3F/XNfNmqXjgsABe3A0cYwuBqstqKBSUzWax/66rgSOFv2cUO7cI04bPg9C
5gNbaeoOGE8FGvaxptO+VmasGcF08rhw+KRoMKxEoag3vNdFTOtUf13UwbmVxGHi
0b+02hUbXEBSVSDVT0vrmeIFA3906R4gmyyNsTYMhlt4BM8r/w1cSsXAEAhuHrc8
hdNeyA58t8Fj3Si2/aoNd6rpKEKQbCsPtlIXaFbmmC3CedP4M565oGsIt2rL7jZ3
IU9W/6Mqe274W6ztifoaccJIn13x19Z04EUS5PrLWh++bnL4QOksQu/vEw+ZNl6+
6Tv4JKmLziiajhbAxGL2jfd9Hu8n457VSFu3esz1hO1qS5ZI3ucquQ8zOsCWyOrG
zYteCM5Oyx8ECP/m2uQikinXpBNYA8Ci4n5MGTzjYJnHmQuwXpE=
=MQIn
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
