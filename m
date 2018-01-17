From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] [v2] i2c: acorn: add MODULE_LICENSE tag
Date: Thu, 18 Jan 2018 00:07:39 +0100
Message-ID: <20180117230739.omogtvl4bev4zwjk@ninjato>
References: <20180115202942.1858432-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hk2kmikknukfc6k3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180115202942.1858432-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--hk2kmikknukfc6k3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2018 at 09:28:39PM +0100, Arnd Bergmann wrote:
> As of v4.15, Kbuild warns about missing MODULE_LICENSE tags:
>=20
> WARNING: modpost: missing MODULE_LICENSE() in drivers/i2c/busses/i2c-acor=
n.o
>=20
> This adds a license, author and description tag, matching the
> comment at the start of the acorn i2c driver.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Since you addressed Russell's comment from V1: applied to for-next,
thanks!


--hk2kmikknukfc6k3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpf1zcACgkQFA3kzBSg
KbYQoA/8CJbB53Ch4TNbgdO0lyqbhbCiorz81O0RkinvBusGLzN8FYKz4lFWDwfH
UyY7ot3Z4cEkWAalWvhp5RV2VjXlKB6WvFf14VDA4PenHBhuMD19si77QyZFrlhR
ZZjbpY+1cdv0+mdk3diV6NZDzdyLCTsa+2hFyAXrvjQSsRP/i5HW1fjncXCXx2fh
iRV0o29NRi0NQZAVrmUzUo9a/YqZF4iSAE9GQu0XW/BaBTIWcvoudappEwYSGBs6
K0FRy1x21bF5iByIYUs2mlzfeCYFXtY5unnrB8l8kcwvHOS7xv0n5EDDd1Ikj7AW
vdqN+5vEhAAMd7ODpdgzaPeyQEGW0HVZ5twW3yRKkKN/IFmFJ/oFG9YQBAo4LBEA
cHk1962ez2BZfan72Bql+dCCyiwXFbH8N0T0SuY+5GZiLY3kKxw6ZTYoY9oSNRyJ
KWf82ZVx4V6lfdpmwbBzYJitKhjyNCVLECQSElH4MYpAKeEBrGxwhlO2YPoNa6PA
hdBKbLkEqKES8Dph9gVXdDk1iVrWqbENmzERCr7yHwqe+mTvq+mOUxQfERz/yUYC
RWOqESSpElukUPmWFLLYRzG+vFir1VM6QbeWTGZtYZshaFNB5F4EFs8sMK2ejL0x
m4B/SWiX5qvZzw7G2Ode+oaO/ockQA8mr8Bvp8hAMy82NCg30nE=
=CjEj
-----END PGP SIGNATURE-----

--hk2kmikknukfc6k3--
