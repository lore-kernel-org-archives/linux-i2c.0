From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFT] i2c: sh_mobile: avoid unnecessary register read
Date: Mon, 27 Nov 2017 18:56:55 +0100
Message-ID: <20171127175655.v2gss77fkzvouggg@ninjato>
References: <20171109222053.27093-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ham3l3hekkgh7vdr"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171109222053.27093-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Jacopo Mondi <jacopo@jmondi.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-i2c@vger.kernel.org


--ham3l3hekkgh7vdr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2017 at 11:20:53PM +0100, Wolfram Sang wrote:
> There is no data when the first WAIT interrupt arrives. No need to read
> something then.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--ham3l3hekkgh7vdr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlocUecACgkQFA3kzBSg
KbZVsg//aeuh8af6WELRuY92nU9nJ/CVOhL+trRFwWWXq1i1W5qxxOzKn3qrw8y5
1+h2SOnPPIOLEWTR1riRGwgl2IU/LjbNASqxHuwpmaYaTyA+knAWzp9owzRhz6zx
REQhwHevw/Qbi+RFNO+K1EnTs6hqDYW1bj7EUmLQXeJLLQlT8WUxyQYhWbU6L75O
tJ0LD8436b4UdAkP62mm4491EnLm3scFd6L3HarAacIU9rBz6c+r8v1Rk+8vnyzV
8onQd9+TKgWt59uf29VcaHpFDh/7GnteoN7McvsJU7dSblJPlZ5R3yw1b7zrljwc
bepequu4wxFZQ3tl44nnVj9OVLotATh6FgeH2S4OhYhGHRb/wg5s4WHP729rB2Qk
runIkQyDIuYAmWgqCNtXKiRJ5lCJN/5RwvwIDD6U1HJf8YZxyxvyJr8ud8L1MTm7
odC2hfu/uc3qTLZcYGjjf6HJ/X27lbJpX9aiK2PClODg3h2rES1RrXdHH77JIAYw
p7+YfXQGWKTUMrF9MYejr8wQm3jkdF79v1fTU/EcxaWT5lBHeWPmBVodHIQnxVp9
s8s3UnC6IZA2Z8hhSifrPIIOu8XMR0OEt4g5Yg9gLnwOSY4vA+9WOujQtjmw5lWX
g1weGXfttlOZ3U3GAU3c5ibPkG+C6AvEOJrHLXpMwjsWq/BNadM=
=Grli
-----END PGP SIGNATURE-----

--ham3l3hekkgh7vdr--
